From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [RFC PATCH] mmc: dw_mmc: mark card as removed if error occurs and
 status is busy
Date: Mon, 16 Feb 2015 17:07:41 +0100
Message-ID: <1424102861-30064-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63928 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbbBPQIi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Feb 2015 11:08:38 -0500
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NJV00FL3H14RM80@mailout3.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 Feb 2015 16:12:40 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, addy.ke@rock-chips.com, alim.akhtar@gmail.com, javier@dowhile0.org

On some boards with broken card detection if eMMC card is not present system
hangs during mmc_rescan. The sequence is as below:
mmc_rescan_try_freq:sdio_reset:
  > send CMD52
  < irq with SDMMC_INT_RESP_ERR and SDMMC_STATUS_BUSY
  < irq with SDMMC_INT_CMD_DONE and SDMMC_STATUS_BUSY
  > dw_mci_wait_busy:dw_mci_ctrl_reset
  < irq with SDMMC_INT_RESP_ERR | SDMMC_INT_CMD_DONE and status not busy
  > send CMD52
  ... mmc_rescan waits infinitely for irq in mmc_wait_for_req

It seems hardware enters into some strange state after issuing CMD52 to
non-existing card. It stops signaling IRQs and it can even hang on accessing
some registers, for example UHS_REG or CTYPE.
The patch tries to solve it by resetting the controller and marking card
as removed, as a result no further commands will be issued until next rescan.

The issue has been observed on Odroid-XU3 boards (Exynos5422 with dw_mmc 250A).

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi,

I am not familiar with MMC internals so please verify patch (in-)sanity.
Especially I am not sure if (SDMMC_INT_RESP_ERR | SDMMC_INT_CMD_DONE with
status busy) occurs only in this situation, if no, more precise check should
be added, I guess. Or maybe it should be a quirk???

The patch is based on Addy's 'about data busy' patchset [1].
Alim's advice about stabilization of host voltage has been tested also,
without success [2].

[1]: http://permalink.gmane.org/gmane.linux.kernel/1888161
[2]: http://permalink.gmane.org/gmane.linux.kernel.mmc/31202

Regards
Andrzej
---
 drivers/mmc/host/dw_mmc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 692d97a..3cba1eb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2182,8 +2182,19 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & SDMMC_INT_CMD_DONE) {
+			u32 err = (pending | host->cmd_status) &
+				SDMMC_INT_RESP_ERR;
+			struct dw_mci_slot *slot = host->cur_slot;
+
 			mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
-			dw_mci_cmd_interrupt(host, pending);
+			if (err && dw_mci_card_busy(slot->mmc)) {
+				u32 ctrl = mci_readl(host, CTRL);
+
+				ctrl |= SDMMC_CTRL_ALL_RESET_FLAGS;
+				mci_writel(host, CTRL, ctrl);
+				clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+			} else
+				dw_mci_cmd_interrupt(host, pending);
 		}
 
 		if (pending & SDMMC_INT_CD) {
-- 
1.9.1

