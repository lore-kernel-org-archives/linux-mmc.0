From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 08/12] mmc: sh_mmcif: Remove .set_pwr() callback from platform data
Date: Fri, 26 Jul 2013 01:26:44 +0200
Message-ID: <1374794808-21890-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34839 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab3GYX0C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Jul 2013 19:26:02 -0400
In-Reply-To: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>

The .set_pwr() callback isn't used anymore as all platforms register
GPIO-controlled regulators. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/sh_mmcif.c  | 3 ---
 include/linux/mmc/sh_mmcif.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 6706b5e..b827c58 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -956,11 +956,8 @@ static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
 
 static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
 {
-	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
 	struct mmc_host *mmc = host->mmc;
 
-	if (pd && pd->set_pwr)
-		pd->set_pwr(host->pd, ios->power_mode != MMC_POWER_OFF);
 	if (!IS_ERR(mmc->supply.vmmc))
 		/* Errors ignored... */
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 39011eb..767fac5 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -33,7 +33,6 @@
  */
 
 struct sh_mmcif_plat_data {
-	void (*set_pwr)(struct platform_device *pdev, int state);
 	int (*get_cd)(struct platform_device *pdef);
 	unsigned int		slave_id_tx;	/* embedded slave_id_[tr]x */
 	unsigned int		slave_id_rx;
-- 
1.8.1.5

