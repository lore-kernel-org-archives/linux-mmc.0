From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom init-call
Date: Fri, 15 Oct 2010 12:21:02 +0200
Message-ID: <1287138064-21385-5-git-send-email-w.sang@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58918 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab0JOKVU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Oct 2010 06:21:20 -0400
In-Reply-To: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

The custom init call may need more data to perform its job, so we pass
it a pointer to pdata, too. Also, always use the platform_id specific
data even if platform_data is present. Doing that, platform_data can
additionally be parsed by init() for board-specific information (via
sdhci->mmc->parent).

(Note: the old behaviour was that you could override the platform_id
specific data with your own. However, one can still do this by using th=
e
"sdhci" id instead of "sdhci-<something>".)

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by : Eric B=C3=A9nard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci-pltfm.c  |    8 +++++---
 include/linux/mmc/sdhci-pltfm.h |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pl=
tfm.c
index 685202b..00e8a8a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -52,15 +52,17 @@ static struct sdhci_ops sdhci_pltfm_ops =3D {
=20
 static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 {
-	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
 	const struct platform_device_id *platid =3D platform_get_device_id(pd=
ev);
+	struct sdhci_pltfm_data *pdata;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
=20
-	if (!pdata && platid && platid->driver_data)
+	if (platid && platid->driver_data)
 		pdata =3D (void *)platid->driver_data;
+	else
+		pdata =3D pdev->dev.platform_data;
=20
 	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
@@ -109,7 +111,7 @@ static int __devinit sdhci_pltfm_probe(struct platf=
orm_device *pdev)
 	}
=20
 	if (pdata && pdata->init) {
-		ret =3D pdata->init(host);
+		ret =3D pdata->init(host, pdata);
 		if (ret)
 			goto err_plat_init;
 	}
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-=
pltfm.h
index 0239bd7..548d59d 100644
--- a/include/linux/mmc/sdhci-pltfm.h
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -28,7 +28,7 @@ struct sdhci_host;
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
-	int (*init)(struct sdhci_host *host);
+	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata);
 	void (*exit)(struct sdhci_host *host);
 };
=20
--=20
1.7.1

