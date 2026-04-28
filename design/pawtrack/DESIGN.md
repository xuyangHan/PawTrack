---
name: PawTrack
colors:
  surface: '#faf9f7'
  surface-dim: '#dadad8'
  surface-bright: '#faf9f7'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f4f3f1'
  surface-container: '#efeeec'
  surface-container-high: '#e9e8e6'
  surface-container-highest: '#e3e2e0'
  on-surface: '#1a1c1b'
  on-surface-variant: '#3f4943'
  inverse-surface: '#2f3130'
  inverse-on-surface: '#f1f1ef'
  outline: '#6f7a73'
  outline-variant: '#bec9c2'
  surface-tint: '#146b4f'
  primary: '#146b4f'
  on-primary: '#ffffff'
  primary-container: '#6dbb9a'
  on-primary-container: '#004a34'
  inverse-primary: '#88d6b4'
  secondary: '#34618d'
  on-secondary: '#ffffff'
  secondary-container: '#a2cdff'
  on-secondary-container: '#295783'
  tertiary: '#8e4e14'
  on-tertiary: '#ffffff'
  tertiary-container: '#ea9959'
  on-tertiary-container: '#653200'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#a3f3cf'
  primary-fixed-dim: '#88d6b4'
  on-primary-fixed: '#002115'
  on-primary-fixed-variant: '#00513a'
  secondary-fixed: '#d0e4ff'
  secondary-fixed-dim: '#9fcafc'
  on-secondary-fixed: '#001d35'
  on-secondary-fixed-variant: '#174974'
  tertiary-fixed: '#ffdcc4'
  tertiary-fixed-dim: '#ffb780'
  on-tertiary-fixed: '#2f1400'
  on-tertiary-fixed-variant: '#6f3800'
  background: '#faf9f7'
  on-background: '#1a1c1b'
  surface-variant: '#e3e2e0'
typography:
  display-lg:
    fontFamily: Manrope
    fontSize: 34px
    fontWeight: '700'
    lineHeight: 41px
    letterSpacing: -0.5px
  headline-md:
    fontFamily: Manrope
    fontSize: 22px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: 0px
  body-lg:
    fontFamily: Manrope
    fontSize: 17px
    fontWeight: '400'
    lineHeight: 24px
    letterSpacing: -0.4px
  body-sm:
    fontFamily: Manrope
    fontSize: 15px
    fontWeight: '400'
    lineHeight: 20px
    letterSpacing: -0.2px
  label-caps:
    fontFamily: Manrope
    fontSize: 13px
    fontWeight: '600'
    lineHeight: 18px
    letterSpacing: 0.5px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  margin-page: 1rem
  gutter-card: 0.75rem
  stack-gap: 1.25rem
  padding-card: 1rem
---

## Brand & Style
The design system is centered on a "Warm iOS-Native" aesthetic. It prioritizes the emotional well-being of pet owners by blending the structured, data-driven layouts of Apple Health with a softer, more approachable personality. The visual language is deeply rooted in minimalism to reduce cognitive load during daily journaling, utilizing heavy whitespace and a clear hierarchy.

The brand personality is empathetic and professional—avoiding the cold, clinical feel of traditional medical apps in favor of a nurturing, pet-friendly environment. By utilizing soft edges and a nature-inspired palette, the interface encourages a sense of calm and consistency, turning pet care into a meditative ritual rather than a chore.

## Colors
The palette is built on a foundation of "Warm Neutrals." The background uses a soft off-white to reduce eye strain and provide a less sterile environment than pure white. 

*   **Primary (Mint Green):** Used for "Success" states, active tracking, and health-positive indicators. It represents vitality and growth.
*   **Secondary (Soft Blue):** Reserved for information, educational tips, and general navigation prompts.
*   **Tertiary (Soft Orange):** A gentle warning color for reminders or missed logs, designed to be noticeable without inducing anxiety.
*   **Neutrals:** High-contrast dark grey is used for primary text to ensure accessibility, while a softer grey is used for secondary metadata and icons.

## Typography
This design system utilizes **Manrope** to bridge the gap between the geometric precision of SF Pro and a more organic, rounded character. The typographic scale follows iOS standards closely to ensure native-feeling legibility.

Large headlines are bold and grounded, providing clear entry points for each screen. Body text is optimized for readability with generous line heights. Small labels and captions use a slightly tighter letter spacing or uppercase styling to differentiate them from interactive text elements.

## Layout & Spacing
The layout follows a fluid grid model optimized for mobile viewport constraints. A standard 16px (1rem) margin is applied to the left and right of the screen to provide breathing room for the rounded cards.

Spacing rhythm is strictly incremental. Vertical stacks between distinct sections use a 20px (1.25rem) gap to clearly separate journal entries or pet profiles. Internal card padding is kept at 16px to maintain a compact but clear internal structure. The layout relies on "safe areas" and dynamic padding rather than rigid column widths, allowing content to breathe and flow naturally.

## Elevation & Depth
Depth is conveyed through subtle tonal layering and ambient shadows rather than harsh borders. 

*   **Background Layer:** The soft beige background acts as the lowest surface.
*   **Card Layer:** White cards sit on top, utilizing a very diffused, low-opacity shadow (Y: 4, Blur: 12, Opacity: 4%) to create a "lifted" effect that makes them feel touchable.
*   **Interactive Layer:** Primary buttons and active states may use a slightly more pronounced shadow to indicate priority.
*   **Translucency:** For navigation bars and headers, a backdrop blur effect (frosted glass) is used to maintain context of the content scrolling beneath, adhering to iOS design patterns.

## Shapes
The shape language is defined by the 16px (1rem) corner radius. This "rounded" approach removes sharp "clinical" corners, reinforcing the friendly and safe vibe of the application. 

Smaller elements like buttons and chips follow this radius proportionally, while larger container cards maintain the signature 16px curve. Progress bars and input fields utilize fully rounded "pill" ends to contrast with the more structured rectangular cards.

## Components
Consistent execution of components ensures the design system remains cohesive across the pet wellness experience:

*   **Buttons:** Primary buttons are pill-shaped with the Mint Green background and white text. Secondary buttons are ghost-style with a soft grey border or subtle blue tint.
*   **Cards:** These are the primary containers. Every card must have a 16px radius, a white background, and the defined ambient shadow. Use cards to group related data like "Daily Nutrition" or "Vaccination Records."
*   **Chips/Tags:** Used for filtering categories (e.g., "Meds," "Activity," "Vet"). These use the Soft Blue or Mint palette with low-opacity backgrounds (10-15%) and high-opacity text.
*   **Input Fields:** Minimalist design with a soft grey background and no border until focused. When focused, the border transitions to Mint Green.
*   **Progress Rings:** Heavily inspired by Apple Watch activity rings, used for tracking daily goals like water intake or exercise, utilizing the Mint and Blue accents.
*   **List Items:** Clean, full-bleed items within cards, separated by a 0.5px subtle grey divider, consistent with HIG.