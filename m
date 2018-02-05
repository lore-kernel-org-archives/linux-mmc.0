From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 07/16] mmc: sdhci_omap: Fix sdhci-omap quirks
Date: Mon, 5 Feb 2018 18:20:20 +0530
Message-ID: <20180205125029.21570-8-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add SDHCI_QUIRK2_PRESET_VALUE_BROKEN quirk as setting preset values loads
incorrect CLKD values (for UHS modes).

Remove SDHCI_QUIRK2_NO_1_8_V quirk as sdhci-omap now supports UHS modes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8b6170cd689b..d5a9e688dc1b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -710,8 +710,8 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
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
