From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v3 10/14] mmc: sh_mmcif: Remove .set_pwr() callback from platform data
Date: Thu,  8 Aug 2013 12:38:40 +0200
Message-ID: <1375958324-29683-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

The .set_pwr() callback isn't used anymore as all platforms register
GPIO-controlled regulators. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c  | 3 ---
 include/linux/mmc/sh_mmcif.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 35f61cc..ac8e109 100644
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

