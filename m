From: Ziyuan Xu <xzy.xu@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: update clock after ctrl reset in runtime resume
Date: Tue,  3 Jan 2017 14:46:27 +0800
Message-ID: <1483425987-21805-1-git-send-email-xzy.xu@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:59286 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbdACGrJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jan 2017 01:47:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, jh80.chung@samsung.com, shawn.lin@rock-chips.com
Cc: linux-mmc@vger.kernel.org, randy.li@rock-chips.com, linux-rockchip@lists.infradead.org, Ziyuan Xu <xzy.xu@rock-chips.com>

Immediately after reset, issue the command which sets
update_clock_register_only bit, the card clock will restart.

MMC_PM_KEEP_POWER is disabled for SD card and eMMC slots, so that they
have no chance to invoke dw_mci_setup_bus for update clock behaviour.
Let's consummate it.

Fixes: e9ed883 ("mmc: dw_mmc: add runtime PM callback")
Reported-by: Randy Li <randy.li@rock-chips.com>
Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b44306b..71715b4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3357,6 +3357,8 @@ int dw_mci_runtime_resume(struct device *dev)
 		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
 			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
 			dw_mci_setup_bus(slot, true);
+		} else {
+			mci_send_cmd(slot, SDMMC_CMD_UPD_CLK, 0);
 		}
 	}
 
-- 
2.7.4


