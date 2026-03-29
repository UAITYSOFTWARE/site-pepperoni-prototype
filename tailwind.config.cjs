/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./src/**/*.{astro,html,js,jsx,ts,tsx}'],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        // All tokens reference CSS variables — light/dark swap happens in global.css
        'primary':                  'var(--color-primary)',
        'on-primary':               'var(--color-on-primary)',
        'primary-container':        'var(--color-primary-container)',
        'on-primary-container':     'var(--color-on-primary-container)',
        'primary-fixed':            'var(--color-primary-fixed)',
        'primary-fixed-dim':        'var(--color-primary-fixed-dim)',

        'secondary':                'var(--color-secondary)',
        'on-secondary':             'var(--color-on-secondary)',
        'secondary-container':      'var(--color-secondary-container)',
        'on-secondary-container':   'var(--color-on-secondary-container)',

        'tertiary':                 'var(--color-tertiary)',
        'on-tertiary':              'var(--color-on-tertiary)',
        'tertiary-container':       'var(--color-tertiary-container)',
        'on-tertiary-container':    'var(--color-on-tertiary-container)',

        'surface':                  'var(--color-surface)',
        'surface-dim':              'var(--color-surface-dim)',
        'surface-bright':           'var(--color-surface-bright)',
        'surface-container-lowest': 'var(--color-surface-container-lowest)',
        'surface-container-low':    'var(--color-surface-container-low)',
        'surface-container':        'var(--color-surface-container)',
        'surface-container-high':   'var(--color-surface-container-high)',
        'surface-container-highest':'var(--color-surface-container-highest)',
        'surface-variant':          'var(--color-surface-variant)',
        'surface-tint':             'var(--color-surface-tint)',

        'on-surface':               'var(--color-on-surface)',
        'on-surface-variant':       'var(--color-on-surface-variant)',

        'background':               'var(--color-background)',
        'on-background':            'var(--color-on-background)',

        'outline':                  'var(--color-outline)',
        'outline-variant':          'var(--color-outline-variant)',

        'inverse-surface':          'var(--color-inverse-surface)',
        'inverse-on-surface':       'var(--color-inverse-on-surface)',
        'inverse-primary':          'var(--color-inverse-primary)',

        'error':                    'var(--color-error)',
        'on-error':                 'var(--color-on-error)',
        'error-container':          'var(--color-error-container)',
        'on-error-container':       'var(--color-on-error-container)',
      },
      fontFamily: {
        headline: ['Epilogue', 'sans-serif'],
        body: ['Plus Jakarta Sans', 'sans-serif'],
        label: ['Plus Jakarta Sans', 'sans-serif'],
      },
      borderRadius: {
        DEFAULT: '0.125rem',
        lg: '0.25rem',
        xl: '0.5rem',
        full: '0.75rem',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
  ],
};
