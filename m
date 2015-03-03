From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 6/6] mmc: omap_hsmmc: use generic slot-gpio isr to manage card detect pin
Date: Tue,  3 Mar 2015 13:28:18 +0100
Message-ID: <1425385698-6588-7-git-send-email-afenkart@gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4f6fbe5..0c3368e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -418,7 +418,6 @@ static inline int omap_hsmmc_have_reg(void)
 
 #endif
 
-static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id);
 static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id);
 
 static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
@@ -440,7 +439,6 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 			return ret;
 
 		host->card_detect = omap_hsmmc_card_detect;
-		mmc_gpio_set_cd_isr(mmc, omap_hsmmc_detect);
 	}
 
 	if (gpio_is_valid(pdata->gpio_wp)) {
@@ -1247,17 +1245,6 @@ static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * irq handler to notify the core about card insertion/removal
- */
-static irqreturn_t omap_hsmmc_detect(int irq, void *dev_id)
-{
-	struct omap_hsmmc_host *host = dev_id;
-
-	mmc_detect_change(host->mmc, (HZ * 200) / 1000);
-	return IRQ_HANDLED;
-}
-
 static void omap_hsmmc_dma_callback(void *param)
 {
 	struct omap_hsmmc_host *host = param;
-- 
2.1.4

