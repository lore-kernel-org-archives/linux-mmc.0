From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] mmc: dw_mmc: remove repetitive clear interrupt
Date: Tue, 26 Jan 2016 08:43:36 +0800
Message-ID: <1453769016-4854-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:52416 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932615AbcAZAsR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2016 19:48:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

dw_mci_probe clear interrupts and disable all interrupts firstly.
While it clear interrupt again before enable some interrupts. We
can't see any reason to clear it twice here, so remove the second one.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- elaborate more in commit-msg

 drivers/mmc/host/dw_mmc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7128351..1991872 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3117,7 +3117,6 @@ int dw_mci_probe(struct dw_mci *host)
 	 * Enable interrupts for command done, data over, data empty,
 	 * receive ready and error such as transmit, receive timeout, crc error
 	 */
-	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
 		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
 		   DW_MCI_ERROR_FLAGS);
-- 
2.3.7


