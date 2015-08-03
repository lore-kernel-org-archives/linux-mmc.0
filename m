From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 15/16] mmc: host: omap_hsmmc: remove CONFIG_REGULATOR check
Date: Mon, 3 Aug 2015 17:56:40 +0530
Message-ID: <1438604801-11823-16-git-send-email-kishon@ti.com>
References: <1438604801-11823-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438604801-11823-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Now that support for platforms which have optional regulator is added,
remove CONFIG_REGULATOR check in omap_hsmmc.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9a28719..15973f1 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -204,7 +204,6 @@ struct omap_hsmmc_host {
 	int			context_loss;
 	int			protect_card;
 	int			reqs_blocked;
-	int			use_reg;
 	int			req_in_progress;
 	unsigned long		clk_rate;
 	unsigned int		flags;
@@ -245,8 +244,6 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 	return mmc_gpio_get_cd(host->mmc);
 }
 
-#ifdef CONFIG_REGULATOR
-
 static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
 {
 	int ret;
@@ -521,29 +518,6 @@ static void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
 	mmc_pdata(host)->set_power = NULL;
 }
 
-static inline int omap_hsmmc_have_reg(void)
-{
-	return 1;
-}
-
-#else
-
-static inline int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
-{
-	return -EINVAL;
-}
-
-static inline void omap_hsmmc_reg_put(struct omap_hsmmc_host *host)
-{
-}
-
-static inline int omap_hsmmc_have_reg(void)
-{
-	return 0;
-}
-
-#endif
-
 static irqreturn_t omap_hsmmc_cover_irq(int irq, void *dev_id);
 
 static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
@@ -2204,11 +2178,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	if (omap_hsmmc_have_reg() && !mmc_pdata(host)->set_power) {
+	if (!mmc_pdata(host)->set_power) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
 			goto err_irq;
-		host->use_reg = 1;
 	}
 
 	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
@@ -2251,8 +2224,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 err_slot_name:
 	mmc_remove_host(mmc);
-	if (host->use_reg)
-		omap_hsmmc_reg_put(host);
+	omap_hsmmc_reg_put(host);
 err_irq:
 	device_init_wakeup(&pdev->dev, false);
 	if (host->tx_chan)
@@ -2276,8 +2248,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(host->dev);
 	mmc_remove_host(host->mmc);
-	if (host->use_reg)
-		omap_hsmmc_reg_put(host);
+	omap_hsmmc_reg_put(host);
 
 	if (host->tx_chan)
 		dma_release_channel(host->tx_chan);
-- 
1.7.9.5
