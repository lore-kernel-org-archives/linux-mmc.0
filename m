From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 1/2] mmc: dw_mmc: silent verbose log when calling from PM context
Date: Tue, 17 Jan 2017 09:22:55 +0800
Message-ID: <1484616176-1005-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:56194 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdAQBYr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 20:24:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>, Shawn Lin <shawn.lin@rock-chips.com>

When deploying runtime PM, it's quite verbose to print the
log of ios setting. Also it's useless to print it from system
PM as it should be the same with booting time. We also have
sysfs to get all these information from ios attribute, so let's
skip this print from PM context.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6:
- reuse force_clkinit to skip the log

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3d213e7..972c779 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1182,11 +1182,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 		if ((clock != slot->__clk_old &&
 			!test_bit(DW_MMC_CARD_NEEDS_POLL, &slot->flags)) ||
 			force_clkinit) {
-			dev_info(&slot->mmc->class_dev,
-				 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
-				 slot->id, host->bus_hz, clock,
-				 div ? ((host->bus_hz / div) >> 1) :
-				 host->bus_hz, div);
+			/* Silent the verbose log if calling from PM context */
+			if (!force_clkinit)
+				dev_info(&slot->mmc->class_dev,
+					 "Bus speed (slot %d) = %dHz (slot req %dHz, actual %dHZ div = %d)\n",
+					 slot->id, host->bus_hz, clock,
+					 div ? ((host->bus_hz / div) >> 1) :
+					 host->bus_hz, div);
 
 			/*
 			 * If card is polling, display the message only
-- 
1.9.1


