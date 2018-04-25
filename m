From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 07/12] mmc: sdhci: Factor out target_timeout calculation
Date: Wed, 25 Apr 2018 17:39:32 +0530
Message-ID: <20180425120937.29867-8-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out the target_timeout calculation so it can be re-used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 48 +++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b91163de4da4..c432ec3644aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,6 +709,35 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
+static unsigned int sdhci_target_timeout(struct sdhci_host *host,
+					 struct mmc_command *cmd,
+					 struct mmc_data *data)
+{
+	unsigned int target_timeout;
+
+	/* timeout in us */
+	if (!data) {
+		target_timeout = cmd->busy_timeout * 1000;
+	} else {
+		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
+		if (host->clock && data->timeout_clks) {
+			unsigned long long val;
+
+			/*
+			 * data->timeout_clks is in units of clock cycles.
+			 * host->clock is in Hz.  target_timeout is in us.
+			 * Hence, us = 1000000 * cycles / Hz.  Round up.
+			 */
+			val = 1000000ULL * data->timeout_clks;
+			if (do_div(val, host->clock))
+				target_timeout++;
+			target_timeout += val;
+		}
+	}
+
+	return target_timeout;
+}
+
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 			     bool *too_big)
 {
@@ -732,24 +761,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 		return 0xE;
 
 	/* timeout in us */
-	if (!data)
-		target_timeout = cmd->busy_timeout * 1000;
-	else {
-		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
-		if (host->clock && data->timeout_clks) {
-			unsigned long long val;
-
-			/*
-			 * data->timeout_clks is in units of clock cycles.
-			 * host->clock is in Hz.  target_timeout is in us.
-			 * Hence, us = 1000000 * cycles / Hz.  Round up.
-			 */
-			val = 1000000ULL * data->timeout_clks;
-			if (do_div(val, host->clock))
-				target_timeout++;
-			target_timeout += val;
-		}
-	}
+	target_timeout = sdhci_target_timeout(host, cmd, data);
 
 	/*
 	 * Figure out needed cycles.
-- 
2.17.0
