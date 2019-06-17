From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v2 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning
Date: Mon, 17 Jun 2019 14:10:12 -0600
Message-ID: <20190617201014.84503-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, djkurtz@chromium.org, Raul E Rangel <rrangel@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The O2Micro controller only supports tuning at 4-bits. So the host driver
needs to change the bus width while tuning and then set it back when done.

There was a bug in the original implementation in that mmc->ios.bus_width
also wasn't updated. Thus setting the incorrect blocksize in
sdhci_send_tuning which results in a tuning failure.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Fixes: 0086fc217d5d7 ("mmc: sdhci: Add support for O2 hardware tuning")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

 drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index b29bf4e7dcb48..dd21315922c87 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
 		current_bus_width = mmc->ios.bus_width;
+		mmc->ios.bus_width = MMC_BUS_WIDTH_4;
 		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
 	}
 
@@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	sdhci_end_tuning(host);
 
-	if (current_bus_width == MMC_BUS_WIDTH_8)
+	if (current_bus_width == MMC_BUS_WIDTH_8) {
+		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
 		sdhci_set_bus_width(host, current_bus_width);
+	}
 
 	host->flags &= ~SDHCI_HS400_TUNING;
 	return 0;
-- 
2.22.0.410.gd8fdbe21b5-goog
