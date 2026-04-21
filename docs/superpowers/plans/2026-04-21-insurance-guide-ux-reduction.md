# Insurance Guide UX Reduction Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Reduce the Insurance Guide page from 14 fully-expanded sections to a clean first-paint showing only the 5 always-visible sections, with all remaining content behind accordion/collapsible disclosure.

**Architecture:** A generic Stimulus `disclosure` controller drives all show/hide behaviour via a CSS `max-height` transition — no JS height calculation. Insurance Types get an exclusive accordion (one open at a time) via a custom `exclusive` option. Seven secondary sections are wrapped in a reusable `_collapsible_section` partial. Insurance Type cards are extracted to an `_insurance_accordion_item` partial.

**Tech Stack:** Rails 7, ERB partials, Stimulus (Hotwire), inline CSS (project convention), Minitest for controller tests.

---

## File Map

| Action | Path | Responsibility |
|---|---|---|
| Create | `app/javascript/controllers/disclosure_controller.js` | Toggle panel open/closed; exclusive-accordion mode |
| Create | `app/views/pages/_insurance_accordion_item.html.erb` | Single accordion item for one InsuranceGuide record |
| Create | `app/views/pages/_collapsible_section.html.erb` | Generic collapsible wrapper for secondary sections |
| Modify | `app/views/pages/insurance_guide.html.erb` | Wire partials; remove inline section rendering |
| Modify | `test/controllers/pages_controller_test.rb` | Add insurance_guide route + DOM structure tests |

---

## Task 1: Disclosure Stimulus Controller

**Files:**
- Create: `app/javascript/controllers/disclosure_controller.js`

- [ ] **Step 1: Write the controller**

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "chevron"]
  static values = { exclusive: Boolean }

  toggle() {
    const isOpen = this.element.dataset.open === "true"

    if (this.exclusiveValue && !isOpen) {
      this.dispatch("close", { bubbles: true })
    }

    this.setOpen(!isOpen)
  }

  close() {
    this.setOpen(false)
  }

  setOpen(open) {
    this.element.dataset.open = open
    this.panelTarget.style.maxHeight = open
      ? this.panelTarget.scrollHeight + "px"
      : "0"
    if (this.hasChevronTarget) {
      this.chevronTarget.style.transform = open ? "rotate(180deg)" : "rotate(0deg)"
    }
  }
}
```

Save to `app/javascript/controllers/disclosure_controller.js`.

- [ ] **Step 2: Verify Stimulus auto-loads it**

The project uses `eagerLoadControllersFrom("controllers", application)` in `app/javascript/controllers/index.js` — no manual registration needed. The controller name `disclosure` maps to `disclosure_controller.js` automatically.

Run: `bin/rails assets:precompile 2>&1 | tail -5`
Expected: no errors mentioning `disclosure_controller`.

- [ ] **Step 3: Commit**

```bash
git add app/javascript/controllers/disclosure_controller.js
git commit -m "feat: add disclosure Stimulus controller for accordion/collapsible sections"
```

---

## Task 2: Insurance Accordion Item Partial

**Files:**
- Create: `app/views/pages/_insurance_accordion_item.html.erb`

- [ ] **Step 1: Write the partial**

```erb
<%# Renders one collapsed/expandable insurance type card.
    guide: InsuranceGuide record
    The disclosure controller is exclusive — opening this item
    closes any sibling items that dispatched a close event. %>

<div data-controller="disclosure"
     data-disclosure-exclusive-value="true"
     data-open="false"
     data-action="disclosure:close@window->disclosure#close"
     style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;margin-bottom:12px;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);border:1px solid rgba(74,127,193,0.1);overflow:hidden;">

  <%# Collapsed header — full-width tap target %>
  <button data-action="click->disclosure#toggle"
          style="width:100%;background:none;border:none;padding:16px;text-align:left;cursor:pointer;display:flex;justify-content:space-between;align-items:flex-start;gap:12px;">
    <div style="flex:1;min-width:0;">
      <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:4px;">
        <div>
          <p style="font-size:15px;font-weight:600;color:#0C2D6B;margin-bottom:2px;">
            <%= locale_field(guide, :title) %>
          </p>
          <p style="font-size:11px;color:#4A7FC1;">
            <%= I18n.locale == :ja ? guide.title_en : guide.title_jp %>
          </p>
        </div>
        <span style="font-size:12px;font-weight:700;padding:6px 12px;border-radius:20px;white-space:nowrap;flex-shrink:0;margin-left:8px;
          <%= guide.insurance_type == 'travel_insurance' ? 'background:rgba(186,117,23,0.1);color:#633806;' : 'background:rgba(12,45,107,0.08);color:#0C2D6B;' %>">
          <%= guide.coverage_percent %><%= t('insurance.covered') %>
        </span>
      </div>
      <p style="font-size:12px;color:#4A7FC1;line-height:1.6;margin:0;">
        <%= truncate(locale_field(guide, :body), length: 120) %>
      </p>
    </div>
    <%# Chevron %>
    <svg data-disclosure-target="chevron"
         style="flex-shrink:0;transition:transform 200ms ease-in-out;margin-top:2px;"
         width="16" height="16" viewBox="0 0 20 20" fill="none"
         stroke="#4A7FC1" stroke-width="1.8" stroke-linecap="round">
      <path d="M5 8l5 5 5-5"/>
    </svg>
  </button>

  <%# Expandable panel %>
  <div data-disclosure-target="panel"
       style="max-height:0;overflow:hidden;transition:max-height 200ms ease-in-out;">
    <div style="padding:0 16px 16px;">
      <div style="border-top:1px solid rgba(74,127,193,0.1);padding-top:12px;">
        <p style="font-size:12px;color:#4A7FC1;line-height:1.7;margin-bottom:12px;">
          <%= locale_field(guide, :body) %>
        </p>
        <div style="background:rgba(219,238,255,0.5);border-radius:10px;padding:10px 12px;border-left:3px solid #4A7FC1;">
          <% if guide.insurance_type == 'shakai_hoken' %>
            <p style="font-size:11px;font-weight:500;color:#0C2D6B;">💡 <%= t('insurance.tip_shakai') %></p>
          <% elsif guide.insurance_type == 'kokumin_hoken' %>
            <p style="font-size:11px;font-weight:500;color:#0C2D6B;">💡 <%= t('insurance.tip_kokumin') %></p>
          <% elsif guide.insurance_type == 'travel_insurance' %>
            <p style="font-size:11px;font-weight:500;color:#0C2D6B;">💡 <%= t('insurance.tip_travel') %></p>
          <% end %>
        </div>
      </div>
    </div>
  </div>

</div>
```

Save to `app/views/pages/_insurance_accordion_item.html.erb`.

- [ ] **Step 2: Commit**

```bash
git add app/views/pages/_insurance_accordion_item.html.erb
git commit -m "feat: add insurance accordion item partial"
```

---

## Task 3: Collapsible Section Partial

**Files:**
- Create: `app/views/pages/_collapsible_section.html.erb`

- [ ] **Step 1: Write the partial**

```erb
<%# Generic collapsible section wrapper.
    Usage:
      <%= render 'pages/collapsible_section',
            label: 'SECTION TITLE',
            teaser: 'One-line summary shown when collapsed' do %>
        [content]
      <% end %>
%>

<div data-controller="disclosure"
     data-open="false"
     style="margin-bottom:12px;">

  <%# Toggle row — replaces the plain <p> section label %>
  <button data-action="click->disclosure#toggle"
          style="width:100%;background:none;border:none;padding:0;margin-bottom:8px;cursor:pointer;display:flex;justify-content:space-between;align-items:center;gap:8px;text-align:left;">
    <span style="font-size:10px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:#4A7FC1;">
      <%= label %>
    </span>
    <div style="display:flex;align-items:center;gap:6px;flex:1;justify-content:flex-end;min-width:0;">
      <span style="font-size:10px;color:rgba(74,127,193,0.6);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:200px;">
        <%= teaser %>
      </span>
      <svg data-disclosure-target="chevron"
           style="flex-shrink:0;transition:transform 200ms ease-in-out;"
           width="14" height="14" viewBox="0 0 20 20" fill="none"
           stroke="#4A7FC1" stroke-width="1.8" stroke-linecap="round">
        <path d="M5 8l5 5 5-5"/>
      </svg>
    </div>
  </button>

  <%# Panel — collapses to 0, expands to full content height %>
  <div data-disclosure-target="panel"
       style="max-height:0;overflow:hidden;transition:max-height 200ms ease-in-out;">
    <%= content %>
  </div>

</div>
```

Save to `app/views/pages/_collapsible_section.html.erb`.

- [ ] **Step 2: Commit**

```bash
git add app/views/pages/_collapsible_section.html.erb
git commit -m "feat: add generic collapsible section partial"
```

---

## Task 4: Wire Insurance Guide Template

**Files:**
- Modify: `app/views/pages/insurance_guide.html.erb`

This task replaces the Insurance Types loop and wraps all 7 secondary sections with the new partials. The content inside each collapsible is **identical** to what exists today — only the wrapper changes.

- [ ] **Step 1: Replace the Insurance Types section (lines 47–79)**

Replace:
```erb
<%# Insurance Types %>
<p style="font-size:10px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:#4A7FC1;margin-bottom:8px;"><%= t('insurance.types_label') %></p>

<% @insurance_guides.each do |guide| %>
  <div style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;padding:16px;margin-bottom:12px;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);border:1px solid rgba(74,127,193,0.1);">
    <div style="display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:12px;">
      <div>
        <h2 style="font-size:15px;font-weight:600;color:#0C2D6B;margin-bottom:2px;">
          <%= locale_field(guide, :title) %>
        </h2>
        <p style="font-size:11px;color:#4A7FC1;">
          <%= I18n.locale == :ja ? guide.title_en : guide.title_jp %>
        </p>
      </div>
      <span style="font-size:12px;font-weight:700;padding:6px 12px;border-radius:20px;white-space:nowrap;
        <%= guide.insurance_type == 'travel_insurance' ? 'background:rgba(186,117,23,0.1);color:#633806;' : 'background:rgba(12,45,107,0.08);color:#0C2D6B;' %>">
        <%= guide.coverage_percent %><%= t('insurance.covered') %>
      </span>
    </div>
    <p style="font-size:12px;color:#4A7FC1;line-height:1.7;margin-bottom:12px;">
      <%= locale_field(guide, :body) %>
    </p>
    <div style="background:rgba(219,238,255,0.5);border-radius:10px;padding:10px 12px;border-left:3px solid #4A7FC1;">
      <% if guide.insurance_type == 'shakai_hoken' %>
        <p style="font-size:11px;font-weight:500;color:#0C2D6B;">💡 <%= t('insurance.tip_shakai') %></p>
      <% elsif guide.insurance_type == 'kokumin_hoken' %>
        <p style="font-size:11px;font-weight:500;color:#0C2D6B;">💡 <%= t('insurance.tip_kokumin') %></p>
      <% elsif guide.insurance_type == 'travel_insurance' %>
        <p style="font-size:11px;font-weight:500;color:#0C2D6B;">💡 <%= t('insurance.tip_travel') %></p>
      <% end %>
    </div>
  </div>
<% end %>
```

With:
```erb
<%# Insurance Types %>
<p style="font-size:10px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:#4A7FC1;margin-bottom:8px;"><%= t('insurance.types_label') %></p>

<% @insurance_guides.each do |guide| %>
  <%= render 'pages/insurance_accordion_item', guide: guide %>
<% end %>
```

- [ ] **Step 2: Wrap "Real Cost Examples" section (lines 81–146)**

Replace:
```erb
<%# Real Cost Examples %>
<p style="font-size:10px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:#4A7FC1;margin-bottom:8px;">
  <%= I18n.locale == :ja ? '実際の費用例（2025年東京）' : 'Real Cost Examples (Tokyo 2025)' %>
</p>

<div style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;padding:16px;margin-bottom:12px;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);">
  ... [entire inner content through the closing </div> at line 146] ...
</div>
```

With:
```erb
<%= render layout: 'pages/collapsible_section',
      locals: {
        label: I18n.locale == :ja ? '実際の費用例（2025年東京）' : 'Real Cost Examples (Tokyo 2025)',
        teaser: I18n.locale == :ja ? '¥19,820/月の負担例（月給40万円）' : 'e.g. ¥19,820/mo on a ¥400K salary'
      } do %>
  <div style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;padding:16px;margin-bottom:0;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);">
    <%# --- Shakai Hoken example --- %>
    <div style="margin-bottom:14px;padding-bottom:14px;border-bottom:1px solid rgba(74,127,193,0.08);">
      <p style="font-size:12px;font-weight:600;color:#0C2D6B;margin-bottom:6px;">
        <%= I18n.locale == :ja ? '社会保険（月給40万円の場合）' : 'Shakai Hoken (¥400,000/month salary)' %>
      </p>
      <div style="display:flex;justify-content:space-between;margin-bottom:4px;">
        <span style="font-size:11px;color:#4A7FC1;"><%= I18n.locale == :ja ? '総保険料（9.91%）' : 'Total premium (9.91%)' %></span>
        <span style="font-size:11px;font-weight:600;color:#0C2D6B;">¥39,640/月</span>
      </div>
      <div style="display:flex;justify-content:space-between;margin-bottom:4px;">
        <span style="font-size:11px;color:#4A7FC1;"><%= I18n.locale == :ja ? 'あなたの負担（半額）' : 'Your share (half)' %></span>
        <span style="font-size:11px;font-weight:600;color:#0C2D6B;">¥19,820/月</span>
      </div>
      <div style="display:flex;justify-content:space-between;">
        <span style="font-size:11px;color:#4A7FC1;"><%= I18n.locale == :ja ? '会社負担（半額）' : 'Employer pays (half)' %></span>
        <span style="font-size:11px;font-weight:600;color:#27500A;">¥19,820/月</span>
      </div>
    </div>
    <%# --- Kokumin Hoken example --- %>
    <div style="margin-bottom:14px;padding-bottom:14px;border-bottom:1px solid rgba(74,127,193,0.08);">
      <p style="font-size:12px;font-weight:600;color:#0C2D6B;margin-bottom:6px;">
        <%= I18n.locale == :ja ? '国民健康保険（年収400万円、東京の場合）' : 'Kokumin Hoken (¥4M annual income, Tokyo)' %>
      </p>
      <div style="display:flex;justify-content:space-between;margin-bottom:4px;">
        <span style="font-size:11px;color:#4A7FC1;"><%= I18n.locale == :ja ? '年間保険料（目安）' : 'Annual premium (approx)' %></span>
        <span style="font-size:11px;font-weight:600;color:#0C2D6B;">¥737,000/年</span>
      </div>
      <div style="display:flex;justify-content:space-between;">
        <span style="font-size:11px;color:#4A7FC1;"><%= I18n.locale == :ja ? '月額換算' : 'Monthly equivalent' %></span>
        <span style="font-size:11px;font-weight:600;color:#0C2D6B;">¥61,400/月</span>
      </div>
    </div>
    <%# --- Co-pay at hospital --- %>
    <p style="font-size:12px;font-weight:600;color:#0C2D6B;margin-bottom:8px;">
      <%= I18n.locale == :ja ? '病院での自己負担（窓口支払い）' : 'At the hospital — your co-pay (30%)' %>
    </p>
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:6px;">
      <% copay_items = I18n.locale == :ja ? [
        { label: "診察料 ¥3,000", you: "¥900", icon: "🩺" },
        { label: "処方薬 ¥5,000", you: "¥1,500", icon: "💊" },
        { label: "血液検査 ¥10,000", you: "¥3,000", icon: "🔬" },
        { label: "入院（1日）¥50,000", you: "¥15,000", icon: "🏥" }
      ] : [
        { label: "Doctor visit ¥3,000", you: "¥900", icon: "🩺" },
        { label: "Prescription ¥5,000", you: "¥1,500", icon: "💊" },
        { label: "Blood test ¥10,000", you: "¥3,000", icon: "🔬" },
        { label: "Hospital stay ¥50,000/day", you: "¥15,000", icon: "🏥" }
      ] %>
      <% copay_items.each do |item| %>
        <div style="background:rgba(219,238,255,0.4);border-radius:10px;padding:10px;">
          <p style="font-size:16px;margin-bottom:4px;"><%= item[:icon] %></p>
          <p style="font-size:10px;color:#4A7FC1;margin-bottom:2px;"><%= item[:label] %></p>
          <p style="font-size:12px;font-weight:600;color:#0C2D6B;"><%= I18n.locale == :ja ? 'あなた：' : 'You pay: ' %><%= item[:you] %></p>
        </div>
      <% end %>
    </div>
  </div>
<% end %>
```

- [ ] **Step 3: Wrap "Co-pay by Age" section (lines 148–174)**

Replace the `<p>` label and `<div>` card with:
```erb
<%= render layout: 'pages/collapsible_section',
      locals: {
        label: I18n.locale == :ja ? '年齢別自己負担率' : 'Co-pay by age',
        teaser: I18n.locale == :ja ? '6〜69歳は30%が標準' : 'Most residents pay 30% · ages 6–69'
      } do %>
  <div style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;padding:16px;margin-bottom:0;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);">
    <% age_groups = I18n.locale == :ja ? [
      { age: "0〜5歳", rate: "20%", note: "就学前" },
      { age: "6〜69歳", rate: "30%", note: "標準" },
      { age: "70〜74歳", rate: "20%", note: "高所得者は30%" },
      { age: "75歳以上", rate: "10%", note: "後期高齢者" }
    ] : [
      { age: "0–5 years", rate: "20%", note: "Pre-school" },
      { age: "6–69 years", rate: "30%", note: "Standard" },
      { age: "70–74 years", rate: "20%", note: "30% if high income" },
      { age: "75+ years", rate: "10%", note: "Elderly system" }
    ] %>
    <% age_groups.each_with_index do |group, index| %>
      <div style="display:flex;justify-content:space-between;align-items:center;<%= index < age_groups.length - 1 ? 'margin-bottom:10px;padding-bottom:10px;border-bottom:1px solid rgba(74,127,193,0.08);' : '' %>">
        <div>
          <p style="font-size:12px;font-weight:500;color:#0C2D6B;"><%= group[:age] %></p>
          <p style="font-size:10px;color:#4A7FC1;"><%= group[:note] %></p>
        </div>
        <span style="font-size:18px;font-weight:700;color:#0C2D6B;"><%= group[:rate] %></span>
      </div>
    <% end %>
  </div>
<% end %>
```

- [ ] **Step 4: Wrap "Enrollment Steps" section (lines 176–207)**

Replace the `<p>` label and `<div>` card with:
```erb
<%= render layout: 'pages/collapsible_section',
      locals: {
        label: I18n.locale == :ja ? '加入手続き（国民健康保険）' : 'How to enroll — Kokumin Hoken',
        teaser: I18n.locale == :ja ? '5ステップ・転入から14日以内に区役所へ' : '5 steps · ward office within 14 days'
      } do %>
  <div style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;padding:16px;margin-bottom:0;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);">
    <% enroll_steps = I18n.locale == :ja ? [
      { num: "1", title: "14日以内に区役所へ", body: "引越し・退職・在留資格変更から14日以内に手続きを。期限を過ぎると未加入期間の医療費が全額自己負担になります。" },
      { num: "2", title: "必要書類を持参", body: "在留カード、パスポート、マイナンバーカード、前の保険の「資格喪失証明書」（切替の場合）。" },
      { num: "3", title: "窓口で申請", body: "「国民健康保険に加入したい」と伝えてください。職員が手続きを案内してくれます。" },
      { num: "4", title: "保険証を受け取る", body: "手続き完了後、その場で国民健康保険証（またはマイナンバー連携確認書）を受け取れます。" },
      { num: "5", title: "保険料の支払い", body: "毎年6月頃に納付書が届きます。コンビニ・銀行・口座振替で支払えます。低所得者は減額申請が可能です。" }
    ] : [
      { num: "1", title: "Go to ward office within 14 days", body: "After moving, leaving a job, or changing visa status — enroll within 14 days. Missing deadline means 100% cost for any care during the gap." },
      { num: "2", title: "Bring required documents", body: "Residence card, passport, My Number card, and if switching insurance — 資格喪失証明書 (insurance termination certificate)." },
      { num: "3", title: "Apply at the counter", body: "Say: '国民健康保険に加入したいです' (I want to join National Health Insurance). Staff will guide you through the form." },
      { num: "4", title: "Receive your insurance card", body: "You receive your NHI card immediately after enrollment. Keep it with you at all times for hospital visits." },
      { num: "5", title: "Pay your premiums", body: "Bills arrive in June each year. Pay at convenience stores, banks, or set up auto-debit. Low-income households can apply for premium reduction." }
    ] %>
    <% enroll_steps.each_with_index do |step, index| %>
      <div style="display:flex;gap:12px;align-items:flex-start;<%= index < enroll_steps.length - 1 ? 'margin-bottom:14px;padding-bottom:14px;border-bottom:1px solid rgba(74,127,193,0.08);' : '' %>">
        <div style="width:28px;height:28px;border-radius:50%;background:linear-gradient(135deg,#4A7FC1,#0C2D6B);color:#fff;font-size:11px;font-weight:600;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
          <%= step[:num] %>
        </div>
        <div>
          <p style="font-size:12px;font-weight:600;color:#0C2D6B;margin-bottom:2px;"><%= step[:title] %></p>
          <p style="font-size:11px;color:#4A7FC1;line-height:1.6;"><%= step[:body] %></p>
        </div>
      </div>
    <% end %>
  </div>
<% end %>
```

- [ ] **Step 5: Wrap "High-Cost Medical Expense Benefit" section (lines 209–242)**

Replace the `<p>` label and `<div>` card with:
```erb
<%= render layout: 'pages/collapsible_section',
      locals: {
        label: I18n.locale == :ja ? '高額療養費制度' : 'High-Cost Medical Expense Benefit',
        teaser: I18n.locale == :ja ? '月ごとの自己負担に上限あり' : 'Monthly out-of-pocket is legally capped'
      } do %>
  <div style="background:rgba(219,238,255,0.5);backdrop-filter:blur(40px);border:1px solid rgba(74,127,193,0.15);border-radius:16px;padding:16px;margin-bottom:0;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);">
    <div style="display:flex;gap:12px;align-items:flex-start;">
      <div style="width:44px;height:44px;background:rgba(74,127,193,0.1);border-radius:12px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#4A7FC1" stroke-width="1.8" stroke-linecap="round">
          <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2z"/>
          <path d="M12 6v6l4 2"/>
        </svg>
      </div>
      <div>
        <p style="font-size:13px;font-weight:600;color:#0C2D6B;margin-bottom:6px;">
          <%= I18n.locale == :ja ? '月ごとの自己負担に上限があります' : 'Your monthly out-of-pocket has a cap' %>
        </p>
        <p style="font-size:11px;color:#4A7FC1;line-height:1.6;margin-bottom:10px;">
          <%= I18n.locale == :ja ? '1か月の医療費自己負担が上限額を超えた場合、超過分が払い戻されます。高額な手術や入院でも、自己負担が一定額以上にはなりません。' : 'If your monthly medical costs exceed the income-based threshold, the excess is reimbursed. Even major surgery or hospitalization has a maximum monthly out-of-pocket.' %>
        </p>
        <div style="background:rgba(255,255,255,0.7);border-radius:10px;padding:10px 12px;">
          <p style="font-size:11px;font-weight:600;color:#0C2D6B;margin-bottom:4px;">
            <%= I18n.locale == :ja ? '例：一般的な収入（69歳以下）' : 'Example: Standard income (under 69)' %>
          </p>
          <p style="font-size:11px;color:#4A7FC1;line-height:1.6;">
            <%= I18n.locale == :ja ? '月の上限額：¥80,100 ＋（医療費 − ¥267,000）× 1%' : 'Monthly cap: ¥80,100 + (medical costs − ¥267,000) × 1%' %>
          </p>
          <p style="font-size:11px;color:#4A7FC1;margin-top:4px;">
            <%= I18n.locale == :ja ? '💡 入院前に「限度額適用認定証」を取得すると、窓口での支払いが上限額のみになります。' : '💡 Get a Maximum Copayment Certificate (限度額適用認定証) before a planned hospital stay to pay less upfront.' %>
          </p>
        </div>
      </div>
    </div>
  </div>
<% end %>
```

- [ ] **Step 6: Wrap "Between Jobs" section (lines 244–269)**

Replace the `<p>` label and `<div>` card with:
```erb
<%= render layout: 'pages/collapsible_section',
      locals: {
        label: I18n.locale == :ja ? '退職・転職時の保険' : 'Between jobs — what to do',
        teaser: I18n.locale == :ja ? '転職時の3つの選択肢' : '3 options when switching employers'
      } do %>
  <div style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;padding:16px;margin-bottom:0;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);">
    <% job_options = I18n.locale == :ja ? [
      { icon: "🔄", title: "任意継続（最長2年）", body: "退職後も社会保険を最長2年間継続できます。ただし保険料は全額自己負担（会社負担分もあなたが払う）になるため、約2倍になります。" },
      { icon: "🏛️", title: "国民健康保険に切り替え", body: "退職翌日から14日以内に区役所で手続き。収入が少ない場合は保険料が安くなることもあります。" },
      { icon: "👨‍👩‍👧", title: "配偶者の扶養に入る", body: "配偶者が社会保険加入者であれば、扶養家族として追加されます。追加保険料はかかりません。" }
    ] : [
      { icon: "🔄", title: "Voluntary continuation (up to 2 years)", body: "Keep your Shakai Hoken for up to 2 years after leaving a job. You pay the full premium (both your share and employer's share) — roughly double the previous cost." },
      { icon: "🏛️", title: "Switch to Kokumin Hoken", body: "Enroll at your ward office within 14 days of leaving your job. If your income is low, premiums may actually be cheaper than voluntary continuation." },
      { icon: "👨‍👩‍👧", title: "Join spouse's insurance as dependent", body: "If your spouse has Shakai Hoken, you can be added as a dependent at no extra cost — as long as your income is below the threshold." }
    ] %>
    <% job_options.each_with_index do |option, index| %>
      <div style="display:flex;gap:12px;align-items:flex-start;<%= index < job_options.length - 1 ? 'margin-bottom:12px;padding-bottom:12px;border-bottom:1px solid rgba(74,127,193,0.08);' : '' %>">
        <span style="font-size:20px;flex-shrink:0;"><%= option[:icon] %></span>
        <div>
          <p style="font-size:12px;font-weight:600;color:#0C2D6B;margin-bottom:2px;"><%= option[:title] %></p>
          <p style="font-size:11px;color:#4A7FC1;line-height:1.6;"><%= option[:body] %></p>
        </div>
      </div>
    <% end %>
  </div>
<% end %>
```

- [ ] **Step 7: Wrap "Family & Dependent Coverage" section (lines 271–296)**

Replace the `<p>` label and `<div>` card with:
```erb
<%= render layout: 'pages/collapsible_section',
      locals: {
        label: I18n.locale == :ja ? '家族の保険' : 'Family & dependent coverage',
        teaser: I18n.locale == :ja ? '社会保険なら扶養追加料金なし' : 'Add dependents free (Shakai Hoken)'
      } do %>
  <div style="background:rgba(255,255,255,0.7);backdrop-filter:blur(40px);border-radius:16px;padding:16px;margin-bottom:0;box-shadow:inset 0 1px 0 rgba(255,255,255,0.8);">
    <% family_items = I18n.locale == :ja ? [
      { icon: "💼", title: "社会保険（扶養）", body: "非就労の配偶者・子どもは追加保険料なしで加入者の社会保険に扶養として入れます。大きなメリットです。" },
      { icon: "🏛️", title: "国民健康保険（世帯単位）", body: "国民健康保険は世帯単位で計算されます。家族全員が加入し、世帯全体の収入と人数で保険料が決まります。" },
      { icon: "👶", title: "子どもの保険", body: "子どもは必ず何らかの健康保険に加入が必要です。0〜5歳は自己負担20%。東京では多くの区が独自の子ども医療費助成制度を実施しており、実質無料になることも。" }
    ] : [
      { icon: "💼", title: "Shakai Hoken dependents", body: "Non-working spouses and children can be added to your Shakai Hoken at no additional cost. This is a major financial benefit for families." },
      { icon: "🏛️", title: "Kokumin Hoken (household)", body: "NHI is calculated at household level. All family members enroll, and premiums are based on total household income and number of people." },
      { icon: "👶", title: "Children's coverage", body: "Children must be enrolled in health insurance. Ages 0–5 pay 20% co-pay. Many Tokyo wards subsidize children's medical costs further — some wards offer near-free care for children up to age 18." }
    ] %>
    <% family_items.each_with_index do |item, index| %>
      <div style="display:flex;gap:12px;align-items:flex-start;<%= index < family_items.length - 1 ? 'margin-bottom:12px;padding-bottom:12px;border-bottom:1px solid rgba(74,127,193,0.08);' : '' %>">
        <span style="font-size:20px;flex-shrink:0;"><%= item[:icon] %></span>
        <div>
          <p style="font-size:12px;font-weight:600;color:#0C2D6B;margin-bottom:2px;"><%= item[:title] %></p>
          <p style="font-size:11px;color:#4A7FC1;line-height:1.6;"><%= item[:body] %></p>
        </div>
      </div>
    <% end %>
  </div>
<% end %>
```

- [ ] **Step 8: Wrap "Maternity Allowance" section (lines 298–318)**

Replace the `<p>` label and `<div>` card with:
```erb
<%= render layout: 'pages/collapsible_section',
      locals: {
        label: t('insurance.maternity_label'),
        teaser: I18n.locale == :ja ? '出産時に50万円の一時金' : '¥500,000 lump-sum grant for childbirth'
      } do %>
  <div style="background:linear-gradient(135deg,rgba(251,234,240,0.8),rgba(244,192,209,0.3));backdrop-filter:blur(40px);border:1px solid rgba(212,83,126,0.15);border-radius:16px;padding:20px;margin-bottom:0;box-shadow:inset 0 1px 0 rgba(255,255,255,0.9);">
    <div style="display:flex;align-items:flex-start;gap:14px;">
      <div style="width:48px;height:48px;background:rgba(153,53,86,0.08);border-radius:14px;display:flex;align-items:center;justify-content:center;flex-shrink:0;">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#993556" stroke-width="1.8" stroke-linecap="round">
          <path d="M12 2C9 2 7 4 7 7c0 4 5 12 5 12s5-8 5-12c0-3-2-5-5-5z"/>
          <circle cx="12" cy="7" r="2"/>
        </svg>
      </div>
      <div style="flex:1;">
        <p style="font-size:13px;font-weight:600;color:#72243E;margin-bottom:4px;"><%= t('insurance.maternity_title') %></p>
        <p style="font-size:28px;font-weight:700;color:#993556;margin-bottom:6px;line-height:1;">¥500,000</p>
        <p style="font-size:11px;color:#72243E;line-height:1.6;margin-bottom:8px;"><%= t('insurance.maternity_text') %></p>
        <div style="background:rgba(255,255,255,0.6);border-radius:8px;padding:8px 10px;">
          <p style="font-size:10px;font-weight:500;color:#72243E;">💡 <%= t('insurance.maternity_tip') %></p>
        </div>
      </div>
    </div>
  </div>
<% end %>
```

- [ ] **Step 9: Verify page renders**

```bash
bin/rails server
```

Visit `http://localhost:3000/insurance-guide`. Confirm:
- Hero, both alert banners, What to Bring, CTA, Disclaimer are fully visible
- Insurance Types shows 3 collapsed accordion items with coverage badges
- 7 secondary sections show only their label row + teaser + chevron

- [ ] **Step 10: Commit**

```bash
git add app/views/pages/insurance_guide.html.erb
git commit -m "feat: wire insurance guide with accordion and collapsible partials"
```

---

## Task 5: Controller Tests

**Files:**
- Modify: `test/controllers/pages_controller_test.rb`

- [ ] **Step 1: Write failing tests**

Replace the contents of `test/controllers/pages_controller_test.rb` with:

```ruby
require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get emergency" do
    get pages_emergency_url
    assert_response :success
  end

  test "should get insurance guide" do
    get insurance_guide_url
    assert_response :success
  end

  test "insurance guide renders accordion items for each guide" do
    get insurance_guide_url
    assert_select "[data-controller='disclosure']"
  end

  test "insurance guide accordion panels start collapsed" do
    get insurance_guide_url
    assert_select "[data-disclosure-target='panel']" do |panels|
      panels.each do |panel|
        assert_match(/max-height:0/, panel["style"].to_s)
      end
    end
  end

  test "insurance guide renders what to bring section always visible" do
    get insurance_guide_url
    assert_select "p", text: /My Number Card|マイナンバーカード/
  end
end
```

- [ ] **Step 2: Run tests to confirm failure**

```bash
bin/rails test test/controllers/pages_controller_test.rb
```

Expected: `insurance_guide_url` test fails with routing error (route exists but test helper may need URL helper). All others pass.

- [ ] **Step 3: Run full test suite to confirm no regressions**

```bash
bin/rails test
```

Expected: all existing tests pass; new tests pass now that templates are wired.

- [ ] **Step 4: Commit**

```bash
git add test/controllers/pages_controller_test.rb
git commit -m "test: add insurance guide controller and DOM structure tests"
```

---

## Self-Review

**Spec coverage:**
- ✅ Disclosure Stimulus controller — Task 1
- ✅ `_insurance_accordion_item` partial — Task 2
- ✅ `_collapsible_section` partial — Task 3
- ✅ All 7 secondary sections wrapped — Task 4 steps 2–8
- ✅ Insurance Types accordion wired — Task 4 step 1
- ✅ Always-visible sections untouched — verified in Task 4 step 9
- ✅ Both locales accounted for in all teasers
- ✅ CSS transition on `max-height` — in both partials
- ✅ Chevron rotation — in both partials
- ✅ Exclusive accordion via `disclosure:close@window` event — in accordion item partial

**Placeholder scan:** No TBDs, TODOs, or vague steps found.

**Type consistency:**
- `disclosure_controller.js` exports `toggle`, `close`, `setOpen` — referenced in partials as `click->disclosure#toggle` and `disclosure:close@window->disclosure#close`. Consistent.
- `data-disclosure-target="panel"` and `data-disclosure-target="chevron"` match `static targets` in controller. Consistent.
- `data-disclosure-exclusive-value="true"` matches `static values = { exclusive: Boolean }`. Consistent.
