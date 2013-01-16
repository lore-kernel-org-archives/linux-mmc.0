From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 08/11] mmc: sh_mobile_sdhi: remove unused .pdata field
Date: Wed, 16 Jan 2013 17:54:43 +0100
Message-ID: <1358355286-26029-9-git-send-email-g.liakhovetski@gmx.de>
References: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62631 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757953Ab3APQyu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 11:54:50 -0500
In-Reply-To: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

The struct sh_mobile_sdhi_info::pdata field was only used for platform-
based card detection and isn't used anymore since the migration to GPIO-
based MMC slot functions. Remove it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c  |    4 ----
 include/linux/mmc/sh_mobile_sdhi.h |    2 --
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index fa71b01..f8f6fc7 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -135,7 +135,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data = &priv->mmc_data;
 
 	if (p) {
-		p->pdata = mmc_data;
 		if (p->init) {
 			ret = p->init(pdev, &sdhi_ops);
 			if (ret)
@@ -284,9 +283,6 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	int i = 0, irq;
 
-	if (p)
-		p->pdata = NULL;
-
 	tmio_mmc_host_remove(host);
 
 	while (1) {
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index b65679f..b76bcf0 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -4,7 +4,6 @@
 #include <linux/types.h>
 
 struct platform_device;
-struct tmio_mmc_data;
 
 #define SH_MOBILE_SDHI_IRQ_CARD_DETECT	"card_detect"
 #define SH_MOBILE_SDHI_IRQ_SDCARD	"sdcard"
@@ -26,7 +25,6 @@ struct sh_mobile_sdhi_info {
 	unsigned long tmio_caps2;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
 	unsigned int cd_gpio;
-	struct tmio_mmc_data *pdata;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	int (*get_cd)(struct platform_device *pdev);
 
-- 
1.7.2.5

