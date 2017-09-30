From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH] mmc: dw_mmc: Increase the timeout in mci_send_cmd to 5 sec
Date: Sat, 30 Sep 2017 15:38:49 +0000
Message-ID: <AM5PR0701MB2657301FD402EEAA4B83917CE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oln040092067068.outbound.protection.outlook.com ([40.92.67.68]:12716
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751099AbdI3Piv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 30 Sep 2017 11:38:51 -0400
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>


Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 80bc4f3..0489707 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -285,7 +285,7 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 
 	if (readl_poll_timeout_atomic(host->regs + SDMMC_CMD, cmd_status,
 				      !(cmd_status & SDMMC_CMD_START),
-				      1, 500 * USEC_PER_MSEC))
+				      1, 5000 * USEC_PER_MSEC))
 		dev_err(&slot->mmc->class_dev,
 			"Timeout sending command (cmd %#x arg %#x status %#x)\n",
 			cmd, arg, cmd_status);
-- 
2.7.4
