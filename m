From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 04/10] mmc: dw_mmc: use the hold register when send stop
 command
Date: Tue, 15 Nov 2016 19:12:26 +0900
Message-ID: <20161115101232.3854-5-jh80.chung@samsung.com>
References: <20161115101232.3854-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51235 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941462AbcKOKMp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2016 05:12:45 -0500
In-reply-to: <20161115101232.3854-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, shawn.lin@rock-chips.com, robh+dt@kernel.org, Jaehoon Chung <jh80.chung@samsung.com>

If DW_MMC_CARD_NO_USE_HOLD isn't set, it's usesd by default.
Enve if SDMMC_CMD_USB_HOLD_REG is set in prepare_command(), but it
doesn't set in pre_stop_abort().

To maintain the consistency, add the checking condition for this.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mmc/host/dw_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index be36f48..3cda68c 100644
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

