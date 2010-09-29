From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific data
Date: Wed, 29 Sep 2010 22:07:59 +0200
Message-ID: <1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34108 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab0I2UIW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 16:08:22 -0400
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Anton Vorontsov <cbouatmailru@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, =?UTF-8?q?Richard=20R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>

We need to carry some information per host, e.g. the clock. Add a
structure for it and initialize it in the generic part. Also do not use
the parent of the platform_device (if it is available), this breaks the
clock-matching on ARM.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard R=C3=B6jfors <richard.rojfors.ext@mocean-labs.com>
---

Changes since last version:

* added types.h
* removed usage of pdev->dev.parent to ensure clk-matching
  Please speak up if this has a use case I failed to see!

 drivers/mmc/host/sdhci-pltfm.c |    8 ++++----
 drivers/mmc/host/sdhci-pltfm.h |    7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pl=
tfm.c
index e045e3c..095ca9d 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platfor=
m_device *pdev)
 	struct sdhci_pltfm_data *pdata =3D pdev->dev.platform_data;
 	const struct platform_device_id *platid =3D platform_get_device_id(pd=
ev);
 	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
=20
@@ -71,16 +72,15 @@ static int __devinit sdhci_pltfm_probe(struct platf=
orm_device *pdev)
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");
=20
-	if (pdev->dev.parent)
-		host =3D sdhci_alloc_host(pdev->dev.parent, 0);
-	else
-		host =3D sdhci_alloc_host(&pdev->dev, 0);
+	host =3D sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
=20
 	if (IS_ERR(host)) {
 		ret =3D PTR_ERR(host);
 		goto err;
 	}
=20
+	pltfm_host =3D sdhci_priv(host);
+
 	host->hw_name =3D "platform";
 	if (pdata && pdata->ops)
 		host->ops =3D pdata->ops;
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pl=
tfm.h
index 900f329..93a0319 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -11,8 +11,15 @@
 #ifndef _DRIVERS_MMC_SDHCI_PLTFM_H
 #define _DRIVERS_MMC_SDHCI_PLTFM_H
=20
+#include <linux/clk.h>
+#include <linux/types.h>
 #include <linux/sdhci-pltfm.h>
=20
+struct sdhci_pltfm_host {
+	struct clk *clk;
+	u32 scratchpad; /* to handle quirks across io-accessor calls */
+};
+
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
=20
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
--=20
1.7.1

