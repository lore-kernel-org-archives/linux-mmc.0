From: akpm@linux-foundation.org
Subject: [patch 168/196] mxcmmc: fix error path in mxcmci_probe
Date: Mon, 14 Dec 2009 18:01:17 -0800
Message-ID: <200912150201.nBF21HAY022270@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37959 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758433AbZLOCMr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 21:12:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, u.kleine-koenig@pengutronix.de, drzeus@drzeus.cx, linux-mmc@vger.kernel.org, mfuzzey@gmail.com, pierre@ossman.eu, s.hauer@pengutronix.de

=46rom: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

After a failing allocation of mmc or a failed ioremap in mxcmci_probe h=
ost was
used uninitialized.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Martin Fuzzey <mfuzzey@gmail.com>
Cc: Pierre Ossman <drzeus@drzeus.cx>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/mxcmmc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/mmc/host/mxcmmc.c~mxcmmc-fix-error-path-in-mxcmci_pro=
be drivers/mmc/host/mxcmmc.c
--- a/drivers/mmc/host/mxcmmc.c~mxcmmc-fix-error-path-in-mxcmci_probe
+++ a/drivers/mmc/host/mxcmmc.c
@@ -679,17 +679,17 @@ static int mxcmci_probe(struct platform_
 {
 	struct mmc_host *mmc;
 	struct mxcmci_host *host =3D NULL;
-	struct resource *r;
+	struct resource *iores, *r;
 	int ret =3D 0, irq;
=20
 	printk(KERN_INFO "i.MX SDHC driver\n");
=20
-	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq =3D platform_get_irq(pdev, 0);
-	if (!r || irq < 0)
+	if (!iores || irq < 0)
 		return -EINVAL;
=20
-	r =3D request_mem_region(r->start, resource_size(r), pdev->name);
+	r =3D request_mem_region(iores->start, resource_size(iores), pdev->na=
me);
 	if (!r)
 		return -EBUSY;
=20
@@ -809,7 +809,7 @@ out_iounmap:
 out_free:
 	mmc_free_host(mmc);
 out_release_mem:
-	release_mem_region(host->res->start, resource_size(host->res));
+	release_mem_region(iores->start, resource_size(iores));
 	return ret;
 }
=20
_
