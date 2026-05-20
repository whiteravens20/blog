(function () {
  'use strict';

  // Theme toggle
  var toggle = document.querySelector('.theme-toggle');
  var themeMeta = document.querySelector('meta[name="theme-color"]');
  var themeColors = { dark: '#0b0c10', light: '#fafafa' };

  function applyMeta(theme) {
    if (themeMeta) { themeMeta.setAttribute('content', themeColors[theme] || themeColors.dark); }
  }
  applyMeta(document.documentElement.getAttribute('data-theme'));

  if (toggle) {
    toggle.addEventListener('click', function () {
      var current = document.documentElement.getAttribute('data-theme') === 'light' ? 'light' : 'dark';
      var next = current === 'light' ? 'dark' : 'light';
      document.documentElement.setAttribute('data-theme', next);
      applyMeta(next);
      try { localStorage.setItem('theme', next); } catch (e) { /* ignore */ }
    });
  }

  // Copy-code buttons on highlighted blocks
  if (navigator.clipboard) {
    var blocks = document.querySelectorAll('.post-content .highlight');
    blocks.forEach(function (block) {
      var code = block.querySelector('pre');
      if (!code) { return; }
      var btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'copy-btn';
      btn.textContent = 'Copy';
      btn.setAttribute('aria-label', 'Copy code to clipboard');
      block.appendChild(btn);
      btn.addEventListener('click', function () {
        navigator.clipboard.writeText(code.innerText).then(function () {
          btn.textContent = 'Copied';
          btn.classList.add('copied');
          setTimeout(function () {
            btn.textContent = 'Copy';
            btn.classList.remove('copied');
          }, 1600);
        }).catch(function () {
          btn.textContent = 'Failed';
          setTimeout(function () { btn.textContent = 'Copy'; }, 1600);
        });
      });
    });
  }

  // Scroll-triggered fade-ins (only if user hasn't asked to reduce motion)
  var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (!reduceMotion && 'IntersectionObserver' in window) {
    var targets = document.querySelectorAll('.post-list li, .post-content > *');
    targets.forEach(function (el) { el.classList.add('fade-in'); });
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('is-visible');
          io.unobserve(entry.target);
        }
      });
    }, { rootMargin: '0px 0px -10% 0px', threshold: 0.05 });
    targets.forEach(function (el) { io.observe(el); });
  }
})();
