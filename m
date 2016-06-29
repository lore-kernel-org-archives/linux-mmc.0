From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 30/54] mmc: sdhci-acpi: Set MMC_CAP_CMD_DURING_TFR for Intel eMMC controllers
Date: Wed, 29 Jun 2016 16:24:43 +0300
Message-ID: <1467206707-30185-31-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48813 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbcF2Nch (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:32:37 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Set MMC_CAP_CMD_DURING_TFR for Intel BYT and related eMMC host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 458ffb7637e5..ec1b99f89d4a 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -274,7 +274,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.chip    = &sdhci_acpi_chip_int,
 	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
 		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
-		   MMC_CAP_WAIT_WHILE_BUSY,
+		   MMC_CAP_CMD_DURING_TFR | MMC_CAP_WAIT_WHILE_BUSY,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
-- 
1.9.1

