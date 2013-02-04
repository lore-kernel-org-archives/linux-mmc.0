From: Roger Tseng <rogerable@realtek.com>
Subject: [PATCH 1/3] MMC: rtsx: remove driving adjustment
Date: Mon, 4 Feb 2013 15:45:57 +0800
Message-ID: <1359963959-2305-2-git-send-email-rogerable@realtek.com>
References: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, wei_wang@realsil.com.cn, Roger Tseng <rogerable@realtek.com>
List-Id: linux-mmc@vger.kernel.org

Several new models of readers use different way to select driving
capability(a necessary adjustment along with voltage change). Removing this
from device-independent rtsx_pci_sdmmc module. It will be implemented in
device-depend calls encapsulated by rtsx_pci_switch_output_voltage().

Signed-off-by: Roger Tseng <rogerable@realtek.com>
Reviewed-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index f74b5ad..f93f100 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1083,11 +1083,6 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 		voltage = OUTPUT_1V8;
 
 	if (voltage == OUTPUT_1V8) {
-		err = rtsx_pci_write_register(pcr,
-				SD30_DRIVE_SEL, 0x07, DRIVER_TYPE_B);
-		if (err < 0)
-			goto out;
-
 		err = sd_wait_voltage_stable_1(host);
 		if (err < 0)
 			goto out;
-- 
1.7.12.1
