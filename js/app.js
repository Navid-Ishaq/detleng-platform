(() => {
  'use strict';

  const body = document.body;
  const currentPage = body.dataset.page;
  const navToggle = document.querySelector('.nav-toggle');
  const navMenu = document.querySelector('.nav-menu');

  document.querySelector(`[data-nav="${currentPage}"]`)?.classList.add('active');
  document.querySelector(`[data-nav="${currentPage}"]`)?.setAttribute('aria-current', 'page');

  const closeMenu = () => {
    navMenu?.classList.remove('open');
    navToggle?.setAttribute('aria-expanded', 'false');
    navToggle?.setAttribute('aria-label', 'Open navigation menu');
    body.classList.remove('menu-open');
  };

  navToggle?.addEventListener('click', () => {
    const isOpen = navToggle.getAttribute('aria-expanded') === 'true';
    navToggle.setAttribute('aria-expanded', String(!isOpen));
    navToggle.setAttribute('aria-label', isOpen ? 'Open navigation menu' : 'Close navigation menu');
    navMenu?.classList.toggle('open', !isOpen);
    body.classList.toggle('menu-open', !isOpen);
  });

  navMenu?.addEventListener('click', (event) => {
    if (event.target.closest('a')) closeMenu();
  });

  window.addEventListener('resize', () => {
    if (window.innerWidth > 680) closeMenu();
  });

  document.querySelectorAll('[data-current-year]').forEach((element) => {
    element.textContent = new Date().getFullYear();
  });

  const supportTemplate = [
    'Name:',
    '',
    'Project Type:',
    '',
    'Project Description:',
    '',
    'Data Source:',
    '',
    'Expected Outcome:',
    '',
    'Deadline:',
    '',
    'Additional Requirements:'
  ].join('\n');

  document.querySelectorAll('[data-support-link]').forEach((link) => {
    link.href = `mailto:?subject=${encodeURIComponent('DeTLeng Platform Support Request')}&body=${encodeURIComponent(supportTemplate)}`;
  });

  const toast = document.querySelector('[data-toast]');
  let toastTimer;
  document.querySelectorAll('[data-placeholder="true"]').forEach((action) => {
    action.addEventListener('click', (event) => {
      event.preventDefault();
      const moduleName = action.closest('[data-module]')?.dataset.module || 'Module';
      if (!toast) return;
      toast.querySelector('[data-toast-title]').textContent = moduleName;
      toast.classList.add('show');
      toast.setAttribute('aria-hidden', 'false');
      window.clearTimeout(toastTimer);
      toastTimer = window.setTimeout(() => {
        toast.classList.remove('show');
        toast.setAttribute('aria-hidden', 'true');
      }, 3200);
    });
  });
})();
