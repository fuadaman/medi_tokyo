# Insurance Guide — UX Reduction Design
**Date:** 2026-04-21
**File:** `app/views/pages/insurance_guide.html.erb`
**Route:** `/insurance-guide`

## Problem

The page renders all 14 sections fully expanded on load, overwhelming first-time users with a wall of text before they can identify which section is relevant to them.

## Goal

Reduce visual noise on first paint while preserving all content, using accordion and progressive disclosure patterns consistent with the existing iOS 26 Liquid Glass UI.

---

## User Moments

Three distinct intents guide what is visible by default:

| Moment | Intent | Required on first paint |
|---|---|---|
| Just arrived in Japan | "What insurance do I have / need?" | Alerts + Insurance Types |
| Going to the hospital today | "What do I bring / pay?" | What to Bring + co-pay badge |
| Researching / edge case | Costs, enrollment, family, job change | Progressive disclosure |

---

## Section Visibility Decisions

| Section | Default state | Teaser (collapsed) |
|---|---|---|
| Hero | Always visible | — |
| My Number Card Alert | Always visible | — |
| Visa Renewal Warning | Always visible | — |
| Insurance Types (3 items) | **Accordion — collapsed** | Title + subtitle + badge + first sentence |
| Real Cost Examples | **Collapsed** | "How much you actually pay — ¥19,820/mo example" |
| Co-pay by Age | **Collapsed** | "Most residents pay 30% · ages 6–69" |
| Enrollment Steps | **Collapsed** | "5 steps · visit your ward office within 14 days" |
| High-Cost Cap | **Collapsed** | "Monthly out-of-pocket is legally capped" |
| Between Jobs | **Collapsed** | "3 options when switching employers" |
| Family Coverage | **Collapsed** | "Add dependents free (Shakai Hoken)" |
| Maternity Allowance | **Collapsed** | "¥500,000 lump-sum grant for childbirth" |
| What to Bring | Always visible | — |
| Find Hospitals CTA | Always visible | — |
| Disclaimer | Always visible | — |

---

## Insurance Types Accordion Behaviour

- Each of the 3 DB-backed guide cards becomes an accordion item
- **Collapsed state:** title, subtitle, coverage badge, first ~120 chars of body (`truncate(locale_field(guide, :body), length: 120)`)
- **Expanded state:** full body + tip callout (existing blue callout block)
- Exclusive: opening one item closes the others
- Chevron icon (`#4A7FC1`) rotates 90° → 180° via CSS `transform`
- Travel Insurance item retains amber badge/styling in both states

## Collapsible Secondary Sections Behaviour

- Section label row becomes the full-width tap target (48px min)
- Teaser text sits inline in the label row (right-aligned, muted)
- Panel uses `max-height: 0 → 800px` CSS transition, `ease-in-out 200ms`
- `overflow: hidden` on the panel div — no JS height calculation
- Inner glass card content is **unchanged**

---

## Components Required

### `disclosure_controller.js` (Stimulus)
- Targets: `panel`, `chevron`
- Actions: `toggle` — flips `data-open`, CSS handles animation
- Option: `exclusive` (boolean) — when true, dispatches close event to siblings

### `_insurance_accordion_item.html.erb`
- Accepts: `guide` object (ActiveRecord)
- Renders collapsed header row wired to disclosure controller
- Renders expandable panel with full body + tip callout
- Replaces the existing inline `@insurance_guides.each` loop

### `_collapsible_section.html.erb`
- Accepts: `label:` (String), `teaser:` (String), content block
- Renders label row as Stimulus toggle button
- Wraps yielded content in the hideable panel div
- Used for all 7 secondary sections

### No changes to:
- Hero, both alert banners, What to Bring, Find Hospitals CTA, Disclaimer
- Controller, model, or i18n key structure
- Visual styling inside any panel (glass cards, grids, step numbers — all unchanged)

---

## Animation & Liquid Glass Consistency

- Glass pill header: `backdrop-filter: blur(40px)`, `rgba(255,255,255,0.7)` background — matches existing card style
- Transition: `max-height ease-in-out 200ms`
- Chevron: inline SVG, `#4A7FC1` stroke, CSS rotation on `[data-open]`
- Touch targets: full-width rows (no icon-only taps)
- Both `:en` and `:ja` locales must be spot-checked for teaser line length

---

## Implementation Order

1. `disclosure_controller.js` — generic controller that drives all disclosure
2. `_collapsible_section.html.erb` — wire 7 secondary sections
3. `_insurance_accordion_item.html.erb` — exclusive accordion for Insurance Types
4. Locale spot-check (`:en` and `:ja`) for teaser text wrapping
