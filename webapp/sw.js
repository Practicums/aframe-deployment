self.addEventListener("install", e => {
    console.log("Install!");
    e.waitUntil(
        caches.open('static').then( cache => {
            return cache.addAll(['./sw.js','./images/logo512.png','./images/logo192.png','./js/aframe.min.js','./css/styles.css'])
        })
    )
})
self.addEventListener("fetch", e => {
    e.respondWith(
        caches.match(e.request).then( response => {
            return response || fetch(e.request);
        })
    )
})