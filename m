From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: [PATCH] mmc: dw_mmc: hide clock message when card is resuming
Date: Wed, 19 Apr 2017 17:55:56 +0300
Message-ID: <1492613756-16740-1-git-send-email-al.kochet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexander Kochetkov <al.kochet@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Commit e9748e0364fe ("mmc: dw_mmc: force setup bus if active slots exist")
made a change resulted in clock message appears every time the card is
resuming (every 5 second in average). Add condition that previously used to
print the message.

Fixes: e9748e0364fe ("mmc: dw_mmc: force setup bus if active slots exist")
Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/mmc/host/dw_mmc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 73db085..faaf2c1 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1178,7 +1178,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 
 		if ((clock != slot->__clk_old &&
 			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
-			force_clkinit) {
+		    (force_clkinit &&
+			(slot->mmc->pm_flags & MMC_PM_KEEP_POWER))) {
 			dev_info(&slot->mmc->class_dev,
 				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
 				 slot->id, host->bus_hz, clock,
-- 
1.7.9.5
