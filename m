From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] mxcmmc: fix error path in mxcmci_probe
Date: Thu, 24 Sep 2009 09:44:14 +0200
Message-ID: <1253778254-6881-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39887 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZIXHos (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2009 03:44:48 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Pierre Ossman <pierre@ossman.eu>, Martin Fuzzey <mfuzzey@gmail.com>, Pierre Ossman <drzeus@drzeus.cx>

After a failing allocation of mmc or a failed ioremap in mxcmci_probe h=
ost was
used uninitialized.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Martin Fuzzey <mfuzzey@gmail.com>
Cc: Pierre Ossman <drzeus@drzeus.cx>
---
 drivers/mmc/host/mxcmmc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index bc14bb1..bec4605 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -679,17 +679,17 @@ static int mxcmci_probe(struct platform_device *p=
dev)
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
--=20
1.6.4.3
