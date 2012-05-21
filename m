From: Marek Vasut <marex@denx.de>
Subject: [PATCH] mmc: mxs-mmc: Add wp-inverted property
Date: Mon, 21 May 2012 23:01:11 +0200
Message-ID: <1337634071-8531-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:48703 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758652Ab2EUVB1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 17:01:27 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@karo-electronics.de>

The write-protect GPIO is inverted on some boards. Handle such case.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>
Cc: Lothar Wa=C3=9Fmann <LW@karo-electronics.de>
---
 drivers/mmc/host/mxs-mmc.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 277161d..9bfd08e 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -164,16 +164,23 @@ struct mxs_mmc_host {
 	spinlock_t			lock;
 	int				sdio_irq_en;
 	int				wp_gpio;
+	int				wp_inverted:1;
 };
=20
 static int mxs_mmc_get_ro(struct mmc_host *mmc)
 {
 	struct mxs_mmc_host *host =3D mmc_priv(mmc);
+	int ret;
=20
 	if (!gpio_is_valid(host->wp_gpio))
 		return -EINVAL;
=20
-	return gpio_get_value(host->wp_gpio);
+	ret =3D gpio_get_value(host->wp_gpio);
+
+	if (host->wp_inverted)
+		ret =3D !ret;
+
+	return ret;
 }
=20
 static int mxs_mmc_get_cd(struct mmc_host *mmc)
@@ -707,6 +714,7 @@ static int mxs_mmc_probe(struct platform_device *pd=
ev)
 	struct pinctrl *pinctrl;
 	int ret =3D 0, irq_err, irq_dma;
 	dma_cap_mask_t mask;
+	enum of_gpio_flags flags;
=20
 	iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dmares =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -785,7 +793,10 @@ static int mxs_mmc_probe(struct platform_device *p=
dev)
 			mmc->caps |=3D MMC_CAP_4_BIT_DATA;
 		else if (bus_width =3D=3D 8)
 			mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
-		host->wp_gpio =3D of_get_named_gpio(np, "wp-gpios", 0);
+		host->wp_gpio =3D of_get_named_gpio_flags(np, "wp-gpios", 0,
+							&flags);
+		if (flags & OF_GPIO_ACTIVE_LOW)
+			host->wp_inverted =3D 1;
 	} else {
 		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
 			mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
--=20
1.7.10

