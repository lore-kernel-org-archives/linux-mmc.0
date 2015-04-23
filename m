From: <grygorii.strashko@linaro.org>
Subject: [PATCH] mmc: core: add missing pm event in mmc_pm_notify to fix hib restore
Date: Thu, 23 Apr 2015 13:43:43 +0300
Message-ID: <1429785823-16939-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, Sumit Semwal <sumit.semwal@linaro.org>, linux-mmc@vger.kernel.org
Cc: khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grygorii Strashko <Grygorii.Strashko@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

The PM_RESTORE_PREPARE is not handled now in mmc_pm_notify(),
as result mmc_rescan() could be scheduled and executed at
late hibernation restore stages when MMC device is suspended
already - which, in turn, will lead to system crash on TI dra7-evm board:

WARNING: CPU: 0 PID: 3188 at drivers/bus/omap_l3_noc.c:148 l3_interrupt_handler+0x258/0x374()
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER1_P3 (Idle): Data Access in User mode during Functional access

Hence, add missed PM_RESTORE_PREPARE PM event in mmc_pm_notify().

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/mmc/core/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c296bc0..92e7671 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2651,6 +2651,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
 		spin_lock_irqsave(&host->lock, flags);
 		host->rescan_disable = 1;
 		spin_unlock_irqrestore(&host->lock, flags);
-- 
1.9.1

