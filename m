From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 04/13] mmc: dw_mmc: use the hold register when send stop command
Date: Thu, 03 Nov 2016 15:21:26 +0900
Message-ID: <20161103062135.10697-5-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38216 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753959AbcKCGVs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 02:21:48 -0400
In-reply-to: <20161103062135.10697-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

If DW_MMC_CARD_NO_USE_HOLD isn't set, it's usesd by default.
Enve if SDMMC_CMD_USB_HOLD_REG is set in prepare_command(), but it
doesn't set in pre_stop_abort().

To maintain the consistency, add the checking condition for this.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 6ccb817..23fc505 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -337,6 +337,9 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
 	cmdr = stop->opcode | SDMMC_CMD_STOP |
 		SDMMC_CMD_RESP_CRC | SDMMC_CMD_RESP_EXP;
 
+	if (!test_bit(DW_MMC_CARD_NO_USE_HOLD, &host->cur_slot->flags))
+		cmdr |= SDMMC_CMD_USE_HOLD_REG;
+
 	return cmdr;
 }
 
-- 
2.10.1

