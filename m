From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 14/17] mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status
Date: Wed, 29 Jul 2015 16:39:44 +0530
Message-ID: <1438168187-1614-15-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use regulator_is_enabled of pbias regulator to find pbias regulator
status instead of maintaining a custom bookkeeping
pbias_enabled variable.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 001f8a0..a50edbc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -182,7 +182,6 @@ struct omap_hsmmc_host {
 	struct	clk		*fclk;
 	struct	clk		*dbclk;
 	struct	regulator	*pbias;
-	bool			pbias_enabled;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
@@ -326,22 +325,20 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
 			return ret;
 		}
 
-		if (host->pbias_enabled == 0) {
+		if (!regulator_is_enabled(host->pbias)) {
 			ret = regulator_enable(host->pbias);
 			if (ret) {
 				dev_err(host->dev, "pbias reg enable fail\n");
 				return ret;
 			}
-			host->pbias_enabled = 1;
 		}
 	} else {
-		if (host->pbias_enabled == 1) {
+		if (regulator_is_enabled(host->pbias)) {
 			ret = regulator_disable(host->pbias);
 			if (ret) {
 				dev_err(host->dev, "pbias reg disable fail\n");
 				return ret;
 			}
-			host->pbias_enabled = 0;
 		}
 	}
 
@@ -2073,7 +2070,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
-	host->pbias_enabled = 0;
 
 	ret = omap_hsmmc_gpio_init(mmc, host, pdata);
 	if (ret)
-- 
1.7.9.5
