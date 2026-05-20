{{flutter_js}}
{{flutter_build_config}}

const swResetKey = 'sonnenkompass-sw-reset-v1';

async function clearStaleFlutterServiceWorkers() {
  if (!('serviceWorker' in navigator)) return false;

  const registrations = await navigator.serviceWorker.getRegistrations();
  await Promise.all(registrations.map((registration) => registration.unregister()));

  if ('caches' in window) {
    const cacheNames = await caches.keys();
    await Promise.all(
      cacheNames
        .filter((cacheName) => {
          const normalized = cacheName.toLowerCase();
          return normalized.includes('flutter') || normalized.includes('sonnenkompass');
        })
        .map((cacheName) => caches.delete(cacheName)),
    );
  }

  return Boolean(navigator.serviceWorker.controller);
}

async function bootSonnenkompass() {
  try {
    const wasControlled = await clearStaleFlutterServiceWorkers();
    if (wasControlled && sessionStorage.getItem(swResetKey) !== 'done') {
      sessionStorage.setItem(swResetKey, 'done');
      window.location.reload();
      return;
    }
  } catch (error) {
    console.warn('Could not clear stale Flutter service workers.', error);
  }

  sessionStorage.removeItem(swResetKey);
  _flutter.loader.load();
}

bootSonnenkompass();
