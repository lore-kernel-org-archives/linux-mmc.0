From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 07/12] mmc: sdhci_omap: Fix sdhci-omap quirks
Date: Thu, 14 Dec 2017 18:39:36 +0530
Message-ID: <20171214130941.26666-8-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Remove SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk as gpio card detection
is supported in sdhci-omap.

Add SDHCI_QUIRK2_PRESET_VALUE_BROKEN quirk as setting preset values loads
incorrect CLKD values (for UHS modes).

Remove SDHCI_QUIRK2_NO_1_8_V quirk as sdhci-omap now supports UHS modes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 594e41200d8a..6dee275b2e57 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -755,13 +755,12 @@ static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
 }
 
 static const struct sdhci_pltfm_data sdhci_omap_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
-	.quirks2 = SDHCI_QUIRK2_NO_1_8_V |
-		   SDHCI_QUIRK2_ACMD23_BROKEN |
+	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_RSP_136_HAS_CRC,
 	.ops = &sdhci_omap_ops,
 };
-- 
2.11.0
