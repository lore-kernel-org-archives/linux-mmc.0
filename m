From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 14/14] mmc: sdhci-omap: Get IODelay values for 3.3v DDR mode
Date: Fri, 27 Apr 2018 17:17:23 +0530
Message-ID: <20180427114723.2687-15-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

commit 8d20b2eae6c47b095523 ("mmc: sdhci_omap: Add support to set
IODELAY values") stored IODelay values for all MM/SD modes
in pinctrl_state structure member of sdhci_omap_host. However for
DDR mode it gets IODelay values only for 1.8v DDR mode. Since some of
the platforms which uses sdhci-omap has IO lines connected to 3.3v,
get IODelay values for 3.3v DDR mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index bd5e03d177e0..f3a7c8ece4be 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -842,8 +842,15 @@ static int sdhci_omap_config_iodelay_pinctrl_state(struct sdhci_omap_host
 
 	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "ddr_1_8v", caps,
 						 MMC_CAP_1_8V_DDR);
-	if (!IS_ERR(state))
+	if (!IS_ERR(state)) {
 		pinctrl_state[MMC_TIMING_MMC_DDR52] = state;
+	} else {
+		state = sdhci_omap_iodelay_pinctrl_state(omap_host, "ddr_3_3v",
+							 caps,
+							 MMC_CAP_3_3V_DDR);
+		if (!IS_ERR(state))
+			pinctrl_state[MMC_TIMING_MMC_DDR52] = state;
+	}
 
 	state = sdhci_omap_iodelay_pinctrl_state(omap_host, "hs", caps,
 						 MMC_CAP_SD_HIGHSPEED);
-- 
2.17.0
