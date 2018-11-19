From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 3/4] mmc: sdhci-omap: Add platform specific reset callback
Date: Mon, 19 Nov 2018 16:46:17 +0530
Message-ID: <20181119111618.2745-4-faiz_abbas@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119111618.2745-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The TRM (SPRUIC2C - January 2017 - Revised May 2018 [1]) forbids
assertion of data reset while tuning is happening. Implement a
platform specific callback that takes care of this condition.

[1] http://www.ti.com/lit/pdf/spruic2 Section 25.5.1.2.4

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index cfffcf58be3f..bf268b38ddc8 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -688,6 +688,18 @@ static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_omap_start_clock(omap_host);
 }
 
+void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	/* Don't reset data lines during tuning operation */
+	if (omap_host->is_tuning)
+		mask &= ~SDHCI_RESET_DATA;
+
+	sdhci_reset(host, mask);
+}
+
 static struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
@@ -696,7 +708,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.get_min_clock = sdhci_omap_get_min_clock,
 	.set_bus_width = sdhci_omap_set_bus_width,
 	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
-	.reset = sdhci_reset,
+	.reset = sdhci_omap_reset,
 	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 };
 
-- 
2.19.1
