From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 1/2] mmc: dw_mmc: silent verbose log when calling from PM context
Date: Fri, 13 Jan 2017 10:59:21 +0800
Message-ID: <1484276362-44984-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:52791 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdAMDBF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 22:01:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>, sgilles@math.umd.edu, Randy Li <randy.li@rock-chips.com>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

When deploying runtime PM, it's quite verbose to print the
log of ios setting. Also it's useless to print it from system
PM as it should be the same with booting time. We also have
sysfs to get all these information from ios attribute, so let's
skip this print from PM context.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3d213e7..dc58ec3 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1153,7 +1153,8 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 		cmd, arg, cmd_status);
 }
 
-static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
+static void dw_mci_setup_bus(struct dw_mci_slot *slot,
+			     bool force_clkinit, bool pm_context)
 {
 	struct dw_mci *host = slot->host;
 	unsigned int clock = slot->clock;
@@ -1182,11 +1183,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		if ((clock != slot->__clk_old &&
 			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
 			force_clkinit) {
-			dev_info(&slot->mmc->class_dev,
-				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
-				 slot->id, host->bus_hz, clock,
-				 div ? ((host->bus_hz / div) >> 1) :
-				 host->bus_hz, div);
+			/* Silent the verbose log if calling from PM context */
+			if (!pm_context)
+				dev_info(&slot->mmc->class_dev,
+					 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+					 slot->id, host->bus_hz, clock,
+					 div ? ((host->bus_hz / div) >> 1) :
+					 host->bus_hz, div);
 
 			/*
 			 * If card is polling, display the message only
@@ -1434,12 +1437,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 
 		/* Adjust clock / bus width after power is up */
-		dw_mci_setup_bus(slot, false);
+		dw_mci_setup_bus(slot, false, false);
 
 		break;
 	case MMC_POWER_OFF:
 		/* Turn clock off before power goes down */
-		dw_mci_setup_bus(slot, false);
+		dw_mci_setup_bus(slot, false, false);
 
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
@@ -3366,7 +3369,7 @@ int dw_mci_runtime_resume(struct device *dev)
 			continue;
 		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
 			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
-			dw_mci_setup_bus(slot, true);
+			dw_mci_setup_bus(slot, true, true);
 		}
 	}
 
-- 
1.9.1


