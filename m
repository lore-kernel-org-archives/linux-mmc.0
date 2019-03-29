From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/2] mmc: sdhci_am654: Add QUIRK2_TI_HISPD_BIT
Date: Fri, 29 Mar 2019 19:52:02 +0530
Message-ID: <20190329142202.15000-3-faiz_abbas@ti.com>
References: <20190329142202.15000-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329142202.15000-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

According to the AM654x Data Manual[1], the setup timing in lower speed
modes can only be met if the controller uses a falling edge data launch.

To ensure this, the HIGH_SPEED_ENA (HOST_CONTROL[2]) bit should be
cleared in default speed, SD high speed, MMC high speed, SDR12 and SDR25
speed modes.

Enable the SDHCI_QUIRK2_TI_HISPD_BIT quirk to facilitate this.

[1] http://www.ti.com/lit/gpn/am6546 Section 5.10.5.16.1

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index eea183e90f1b..739a91767d5a 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -172,7 +172,8 @@ static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 	.ops = &sdhci_am654_ops,
 	.quirks = SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
 		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_TI_HISPD_BIT,
 };
 
 static int sdhci_am654_init(struct sdhci_host *host)
-- 
2.19.2
