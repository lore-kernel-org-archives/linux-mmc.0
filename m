From: Azhar Shaikh <azhar.shaikh@intel.com>
Subject: [PATCH v2 1/2] mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel controllers
Date: Wed, 29 Mar 2017 11:16:32 -0700
Message-ID: <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com>
References: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, azhar.shaikh@intel.com
List-Id: linux-mmc@vger.kernel.org

Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel SD card
controllers.

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
Changes in v2:
  - Rebased the patch on top of 'next' branch.
  - No code change.

 drivers/mmc/host/sdhci-acpi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 665c5f3..c6a9a1b 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -263,10 +263,8 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 
 	/* Platform specific code during sd probe slot goes here */
 
-	if (hid && !strcmp(hid, "80865ACA")) {
+	if (hid && !strcmp(hid, "80865ACA"))
 		host->mmc_host_ops.get_cd = bxt_get_cd;
-		host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
-	}
 
 	return 0;
 }
@@ -302,7 +300,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		   SDHCI_QUIRK2_STOP_WITH_TC,
-	.caps    = MMC_CAP_WAIT_WHILE_BUSY,
+	.caps    = MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_AGGRESSIVE_PM,
 	.probe_slot	= sdhci_acpi_sd_probe_slot,
 };
 
-- 
1.9.1
