From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mmc: host: dw_mmc: Fix possible null-pointer dereferences in dw_mci_runtime_resume()
Date: Fri, 26 Jul 2019 22:22:52 +0800
Message-ID: <20190726142252.9654-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-mmc@vger.kernel.org

In dw_mci_runtime_resume(), there is an if statement on line 3420 
to check whether host->slot is NULL:
    if (host->slot && ...)

When host->slot is NULL, it is used on line 3458:
    if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
and on line 3462:
    dw_mci_setup_bus(host->slot, true);
        struct dw_mci *host = slot->host;

Thus, possible null-pointer dereferences may occur.

To fix these bugs, host->slot is checked before being used.

These bugs are found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mmc/host/dw_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index faaaf52a46d2..91bd6c3ccf50 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3455,11 +3455,12 @@ int dw_mci_runtime_resume(struct device *dev)
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 
-	if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
+	if (host->slot && (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER))
 		dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
 
 	/* Force setup bus to guarantee available clock output */
-	dw_mci_setup_bus(host->slot, true);
+	if (host->slot)
+		dw_mci_setup_bus(host->slot, true);
 
 	/* Now that slots are all setup, we can enable card detect */
 	dw_mci_enable_cd(host);
-- 
2.17.0
