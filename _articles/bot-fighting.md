---
id: bot-fighting
title: Fighting bots
author: stub
---

If you have a database with many dynamically generated pages, you may face an issue with bots scraping your data (probably in an attempt to train machine learning algorithms).  This traffic can overwhelm your webserver and make it unusable by humans.

If you are using [cloud hosting](/a/hosting), it will provide tools for dealing with bots (for example, [Google cloud armor](https://cloud.google.com/security/products/armor?hl=en) or [recaptcha](https://cloud.google.com/security/products/recaptcha?hl=en)).

If you are hosting on your own server, you may need to set up a firewall, such as [Modsecurity](https://modsecurity.org/).