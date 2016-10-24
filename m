From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 25/25] mmc: sdhci-acpi: Enable Software Command Queuing for some Intel controllers
Date: Mon, 24 Oct 2016 11:37:40 +0300
Message-ID: <1477298260-5064-26-git-send-email-adrian.hunter@intel.com>
References: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6637 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934865AbcJXIod (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 04:44:33 -0400
In-Reply-To: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

Set MMC_CAP_SWCMDQ for Intel BYT and related eMMC host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 81d4dc034793..95fc4de05c54 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -274,7 +274,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.chip    = &sdhci_acpi_chip_int,
 	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
-		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR |
+		   MMC_CAP_HW_RESET | MMC_CAP_1_8V_DDR | MMC_CAP_SWCMDQ |
 		   MMC_CAP_CMD_DURING_TFR | MMC_CAP_WAIT_WHILE_BUSY,
 	.caps2   = MMC_CAP2_HC_ERASE_SZ,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
-- 
1.9.1

