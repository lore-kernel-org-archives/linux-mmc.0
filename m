From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 5/7] mmc: sdhci-omap: Add DISABLE_DTO_FOR_ERASE Quirk
Date: Fri, 11 Jan 2019 16:38:49 +0530
Message-ID: <20190111110851.6805-6-faiz_abbas@ti.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111110851.6805-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: zhang.chunyan@linaro.org, kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a Quirk to disable DTO during an erase command.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8a05e94fe612..ae9701d198d5 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -852,6 +852,7 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_RSP_136_HAS_CRC |
+		   SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE |
 		   SDHCI_QUIRK2_DISABLE_HW_TIMEOUT,
 	.ops = &sdhci_omap_ops,
 };
-- 
2.19.2
