---
id: hosting
title: Hosting options
author: stub
---

There are many reasonable options for hosting your data.

 * For small datasets, a personal homepage on a department website can be a good option.  Note that this option often only supports static websites without any server-side scripts.  You should also [make plans](/a/archiving) for preserving the data if you move institutions or retire.
 * [Github](/a/github) provides hosting both for code repositories and for static webpages through Github Pages.  There are tons of other web hosting options out there; many companies that offer [DNS records](/a/name-and-url) offer free or cheap static hosting to go with it. If you use GitHub for hosting, you should include a [`CITATION.cff`](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-citation-files) file.
 * If you have a project that needs [server-side scripts](/a/backend), Google Cloud or Amazon Web Services offer the access to servers for a monthly fee without having to purchase your own.  Cloud hosting often provides higher uptime than running on your own server and will likely save you time on system administration.  In addition, it makes it easier to scale if you end up needing more resources.
 * Alternatively, you can buy a server, install everything you need on it and have complete control.  This has a higher upfront cost and requires ongoing maintenance (security updates, dealing with service interruptions, managing backups), but can be less expensive in the long run if you have substantial resource requirements for your project.
 * If your data is included in a computer algebra system or an existing database, they will often provide hosting.
 * If you plan to only make your data available for download without a web interface, [Zenodo](https://zenodo.org) offers free long-term hosting of scientific data: up to 100 files, each up to 50GB.