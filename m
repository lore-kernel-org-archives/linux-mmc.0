From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 2/6] mmc: omap_hsmmc: use slot-gpio functions to manage read-only pin directly
Date: Tue,  3 Mar 2015 13:28:14 +0100
Message-ID: <1425385698-6588-3-git-send-email-afenkart@gmail.com>
References: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1425385698-6588-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, NeilBrown <neilb@suse.de>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The indirection via omap_hsmmc_get_ro and omap_hsmmc_get_wp is
redundant. Also dropped setting gpio_wp to EINVAL since platform date
is read-only
Untested: no device with ro pin was available, but change is fairly
simple

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2276d58..77ad471 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -234,8 +234,6 @@ struct omap_hsmmc_host {
 	int card_detect_irq;
 
 	int (*card_detect)(struct device *dev);
-	int (*get_ro)(struct device *dev);
-
 };
 
 struct omap_mmc_of_data {
@@ -252,13 +250,6 @@ static int omap_hsmmc_card_detect(struct device *dev)
 	return mmc_gpio_get_cd(host->mmc);
 }
 
-static int omap_hsmmc_get_wp(struct device *dev)
-{
-	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-
-	return mmc_gpio_get_ro(host->mmc);
-}
-
 static int omap_hsmmc_get_cover_state(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -455,12 +446,9 @@ static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
 	}
 
 	if (gpio_is_valid(pdata->gpio_wp)) {
-		host->get_ro = omap_hsmmc_get_wp;
 		ret = mmc_gpio_request_ro(mmc, pdata->gpio_wp);
 		if (ret)
 			return ret;
-	} else {
-		pdata->gpio_wp = -EINVAL;
 	}
 
 	return 0;
@@ -1637,15 +1625,6 @@ static int omap_hsmmc_get_cd(struct mmc_host *mmc)
 	return host->card_detect(host->dev);
 }
 
-static int omap_hsmmc_get_ro(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	if (!host->get_ro)
-		return -ENOSYS;
-	return host->get_ro(host->dev);
-}
-
 static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1811,7 +1790,7 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 	.request = omap_hsmmc_request,
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
-	.get_ro = omap_hsmmc_get_ro,
+	.get_ro = mmc_gpio_get_ro,
 	.init_card = omap_hsmmc_init_card,
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
-- 
2.1.4

