From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Date: Tue, 27 Feb 2018 13:55:31 +0000
Message-ID: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Michal Simek <michal.simek@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Since the controller does not support the end-of-busy IRQ, don't use it.
Otherwise, on older SD cards you will get lots of these messages:
"mmc0: Got data interrupt 0x00000002 even though no data operation was in progress"

This has been reported on Xilinx devices that also use the Arasan IP.
See https://patchwork.kernel.org/patch/8062871/

This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index c33a5f7..ab66e32 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
-- 
2.7.4
