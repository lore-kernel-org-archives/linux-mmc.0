From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 15/15] mmc: host: omap_hsmmc: remove CONFIG_REGULATOR check
Date: Thu, 27 Aug 2015 14:44:07 +0530
Message-ID: <1440666847-12594-16-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Now that support for platforms which have optional regulator is added,
remove CONFIG_REGULATOR check in omap_hsmmc.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58683b3..781e4db3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -244,8 +244,6 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 	return mmc_gpio_get_cd(host->mmc);
 }
 
-#ifdef CONFIG_REGULATOR
-
 static int omap_hsmmc_enable_supply(struct mmc_host *mmc)
 {
 	int ret;
@@ -520,30 +518,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	return 0;
 }
 
-static inline int omap_hsmmc_have_reg(void)
-{
-	return 1;
-}
-
-#else
-
-static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
-{
-	return 0;
-}
-
-static inline int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
-{
-	return -EINVAL;
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
@@ -2204,11 +2178,9 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	if (omap_hsmmc_have_reg()) {
-		ret = omap_hsmmc_reg_get(host);
-		if (ret)
-			goto err_irq;
-	}
+	ret = omap_hsmmc_reg_get(host);
+	if (ret)
+		goto err_irq;
 
 	mmc->ocr_avail = mmc_pdata(host)->ocr_mask;
 
-- 
1.7.9.5
