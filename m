From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 11/21] mmc: sdhci-acpi: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:08:11 +0800
Message-ID: <1453871291-3765-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

sdhci-acpi already add MMC_CAP_NONREMOVABLE for caps, so
there is no need to add SDHCI_QUIRK_BROKEN_CARD_DETECTION.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f6047fc..cb43098 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -214,8 +214,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
-	.quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		   SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD |
 		   MMC_CAP_BUS_WIDTH_TEST | MMC_CAP_WAIT_WHILE_BUSY,
-- 
2.3.7
