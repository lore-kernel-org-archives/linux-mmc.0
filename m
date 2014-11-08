From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v4 06/10] omap_hsmmc: remove unused get_context_loss_count callback
Date: Sat,  8 Nov 2014 15:33:13 +0100
Message-ID: <1415457197-14294-7-git-send-email-afenkart@gmail.com>
References: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33018 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbaKHOdl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Nov 2014 09:33:41 -0500
In-Reply-To: <1415457197-14294-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, pascal.huerst@gmail.com, Andreas Fenkart <afenkart@gmail.com>

trigger of this callback has been removed in 0a82e06e6183

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 arch/arm/mach-omap2/hsmmc.c              | 12 ------------
 include/linux/platform_data/hsmmc-omap.h |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 75b75b9..c65efc3 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -33,17 +33,6 @@ static u16 control_devconf1_offset;
 
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
@@ -265,7 +254,6 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].caps = c->caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
 	mmc->reg_offset = 0;
-	mmc->get_context_loss_count = hsmmc_get_context_loss;
 
 	mmc->slots[0].switch_pin = c->gpio_cd;
 	mmc->slots[0].gpio_wp = c->gpio_wp;
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index 7e70e15..35d494f 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -51,9 +51,6 @@ struct omap_hsmmc_platform_data {
 	int (*suspend)(struct device *dev, int slot);
 	int (*resume)(struct device *dev, int slot);
 
-	/* Return context loss count due to PM states changing */
-	int (*get_context_loss_count)(struct device *dev);
-
 	/* Integrating attributes from the omap_hwmod layer */
 	u8 controller_flags;
 
-- 
2.1.1

