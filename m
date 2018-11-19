From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/4] mmc: sdhci-omap: Add variable to indicate host is tuning
Date: Mon, 19 Nov 2018 16:46:16 +0530
Message-ID: <20181119111618.2745-3-faiz_abbas@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119111618.2745-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a variable in sdhc_omap_host to indicate whether a tuning
operation is ongoing.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 87138067e334..cfffcf58be3f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -115,6 +115,7 @@ struct sdhci_omap_host {
 
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	**pinctrl_state;
+	bool			is_tuning;
 };
 
 static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
@@ -318,6 +319,8 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	host->ier &= ~SDHCI_INT_DATA_CRC;
 
+	omap_host->is_tuning = true;
+
 	while (phase_delay <= MAX_PHASE_DELAY) {
 		sdhci_omap_set_dll(omap_host, phase_delay);
 
@@ -355,9 +358,12 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	phase_delay = max_window + 4 * (max_len >> 1);
 	sdhci_omap_set_dll(omap_host, phase_delay);
 
+	omap_host->is_tuning = false;
+
 	goto ret;
 
 tuning_error:
+	omap_host->is_tuning = false;
 	dev_err(dev, "Tuning failed\n");
 	sdhci_omap_disable_tuning(omap_host);
 
-- 
2.19.1
