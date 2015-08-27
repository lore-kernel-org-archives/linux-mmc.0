From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 12/15] mmc: host: omap_hsmmc: enable/disable vmmc_aux regulator based on previous state
Date: Thu, 27 Aug 2015 14:44:04 +0530
Message-ID: <1440666847-12594-13-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

enable vmmc_aux regulator only if it is in disabled state and disable
vmmc_aux regulator only if it is in enabled state.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index cd4bd6d..5a5946a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -184,6 +184,7 @@ struct omap_hsmmc_host {
 	struct	regulator	*pbias;
 	bool			pbias_enabled;
 	void	__iomem		*base;
+	int			vqmmc_enabled;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
 	unsigned int		dma_len;
@@ -249,6 +250,7 @@ static int omap_hsmmc_get_cover_state(struct device *dev)
 static int omap_hsmmc_enable_supply(struct mmc_host *mmc, int vdd)
 {
 	int ret;
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
 	if (mmc->supply.vmmc) {
 		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
@@ -257,12 +259,13 @@ static int omap_hsmmc_enable_supply(struct mmc_host *mmc, int vdd)
 	}
 
 	/* Enable interface voltage rail, if needed */
-	if (mmc->supply.vqmmc) {
+	if (mmc->supply.vqmmc && !host->vqmmc_enabled) {
 		ret = regulator_enable(mmc->supply.vqmmc);
 		if (ret) {
 			dev_err(mmc_dev(mmc), "vmmc_aux reg enable failed\n");
 			goto err_vqmmc;
 		}
+		host->vqmmc_enabled = 1;
 	}
 
 	return 0;
@@ -278,13 +281,15 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
 {
 	int ret;
 	int status;
+	struct omap_hsmmc_host *host = mmc_priv(mmc);
 
-	if (mmc->supply.vqmmc) {
+	if (mmc->supply.vqmmc && host->vqmmc_enabled) {
 		ret = regulator_disable(mmc->supply.vqmmc);
 		if (ret) {
 			dev_err(mmc_dev(mmc), "vmmc_aux reg disable failed\n");
 			return ret;
 		}
+		host->vqmmc_enabled = 0;
 	}
 
 	if (mmc->supply.vmmc) {
@@ -2077,6 +2082,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	host->power_mode = MMC_POWER_OFF;
 	host->next_data.cookie = 1;
 	host->pbias_enabled = 0;
+	host->vqmmc_enabled = 0;
 
 	ret = omap_hsmmc_gpio_init(mmc, host, pdata);
 	if (ret)
-- 
1.7.9.5
