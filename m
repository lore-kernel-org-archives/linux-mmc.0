From: Ziyuan Xu <xzy.xu@rock-chips.com>
Subject: [PATCH v2] mmc: dw_mmc: revise the reset path in runtime resume
Date: Wed,  4 Jan 2017 20:51:33 +0800
Message-ID: <1483534293-6192-1-git-send-email-xzy.xu@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:59509 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbdADMxs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2017 07:53:48 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, jh80.chung@samsung.com, shawn.lin@rock-chips.com
Cc: linux-mmc@vger.kernel.org, randy.li@rock-chips.com, linux-rockchip@lists.infradead.org, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-kernel@vger.kernel.org

Immediately after reset, issue the command which sets
update_clock_register_only bit, the card clock will restart. Revise
dw_mci_ctrl_reset to dw_mci_reset, which has wrapped this sequence.

The patch fixes commit e9ed8835e990 ("mmc: dw_mmc: add runtime PM
callback"). MMC_PM_KEEP_POWEP is disabled for SD card and eMMC slots, so
that they have no chance to invoke dw_mci_setup_bus for update clock
behaviour. Let's consummate it.

Reported-by: Randy Li <randy.li@rock-chips.com>
Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>

---

Changes in v2:
- update the commit message
- use dw_mci_reset instead of dw_mci_ctrl_reset

 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b44306b..ed63237 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3324,7 +3324,7 @@ int dw_mci_runtime_resume(struct device *dev)
 	if (ret)
 		goto err;
 
-	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
+	if (!dw_mci_reset(host)) {
 		clk_disable_unprepare(host->ciu_clk);
 		ret = -ENODEV;
 		goto err;
-- 
2.7.4


