From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command errors
Date: Tue, 10 Mar 2015 08:48:10 -0700
Message-ID: <1426002490-2014-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33564 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbCJPsV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2015 11:48:21 -0400
Received: by iecvj10 with SMTP id vj10so19739924iec.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2015 08:48:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The dw_mmc driver enables HLE errors as part of DW_MCI_ERROR_FLAGS but
nothing in the interrupt handler actually handles them and ACKs them.
That means that if we ever get an HLE error we'll just keep getting
interrupts and we'll wedge things.

We really don't expect HLE errors but if we ever get them we shouldn't
silently ignore them.

Note that I have seen HLE errors while constantly ejecting and
inserting cards (ejecting while inserting, etc).

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Note that this works together with the patch I sent up yesterday (the
CMD 11 timer).  I would have sent the two together except that I had
local printouts (and ACKing of HLE) and didn't realize that this was
also required for a full solution.

 drivers/mmc/host/dw_mmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 47dfd0e..294edc9c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -44,11 +44,11 @@
 /* Common flag combinations */
 #define DW_MCI_DATA_ERROR_FLAGS	(SDMMC_INT_DRTO | SDMMC_INT_DCRC | \
 				 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
-				 SDMMC_INT_EBE)
+				 SDMMC_INT_EBE | SDMMC_INT_HLE)
 #define DW_MCI_CMD_ERROR_FLAGS	(SDMMC_INT_RTO | SDMMC_INT_RCRC | \
-				 SDMMC_INT_RESP_ERR)
+				 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
 #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
-				 DW_MCI_CMD_ERROR_FLAGS  | SDMMC_INT_HLE)
+				 DW_MCI_CMD_ERROR_FLAGS)
 #define DW_MCI_SEND_STATUS	1
 #define DW_MCI_RECV_STATUS	2
 #define DW_MCI_DMA_THRESHOLD	16
-- 
2.2.0.rc0.207.ga3a616c

