From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 4/6] omap_hsmmc: remove unused get_context_loss_count callback
Date: Mon, 22 Sep 2014 13:55:09 +0200
Message-ID: <1411386911-8158-5-git-send-email-afenkart@gmail.com>
References: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:59885 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbaIVLzd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Sep 2014 07:55:33 -0400
In-Reply-To: <1411386911-8158-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c              | 12 ------------
 include/linux/platform_data/hsmmc-omap.h |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 2f202bf..9ed9f70 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -32,17 +32,6 @@ static u16 control_devconf1_offset;
 
 #define HSMMC_NAME_LEN	9
 
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
-
-static int hsmmc_get_context_loss(struct device *dev)
-{
-	return omap_pm_get_dev_context_loss_count(dev);
-}
-
-#else
-#define hsmmc_get_context_loss NULL
-#endif
-
 static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
@@ -259,7 +248,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].internal_clock = !c->ext_clock;
 	mmc->max_freq = c->max_freq;
 	mmc->reg_offset = 0;
-	mmc->get_context_loss_count = hsmmc_get_context_loss;
 
 	mmc->slots[0].switch_pin = c->gpio_cd;
 	mmc->slots[0].gpio_wp = c->gpio_wp;
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index b80460d..28b8cff 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -57,9 +57,6 @@ struct omap_hsmmc_platform_data {
 	int (*suspend)(struct device *dev, int slot);
 	int (*resume)(struct device *dev, int slot);
 
-	/* Return context loss count due to PM states changing */
-	int (*get_context_loss_count)(struct device *dev);
-
 	/* Integrating attributes from the omap_hwmod layer */
 	u8 controller_flags;
 
-- 
2.1.0

