From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 13/15] mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status
Date: Thu, 27 Aug 2015 14:44:05 +0530
Message-ID: <1440666847-12594-14-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Use regulator_is_enabled of pbias regulator to find pbias regulator
status instead of maintaining a custom bookkeeping
pbias_enabled variable.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 5a5946a..4cd7a58 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -182,7 +182,6 @@ struct omap_hsmmc_host {
 	struct	clk		*fclk;
 	struct	clk		*dbclk;
 	struct	regulator	*pbias;
-	bool			pbias_enabled;
 	void	__iomem		*base;
 	int			vqmmc_enabled;
 	resource_size_t		mapbase;
@@ -330,22 +329,20 @@ static int omap_hsmmc_set_pbias(struct omap_hsmmc_host *host, bool power_on,
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
 
@@ -2081,7 +2078,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->base	= base + pdata->reg_offset;
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
-	host->pbias_enabled = 0;
 	host->vqmmc_enabled = 0;
 
 	ret = omap_hsmmc_gpio_init(mmc, host, pdata);
-- 
1.7.9.5
