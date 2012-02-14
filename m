From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: shift with slot-id for CLKENA register
Date: Tue, 14 Feb 2012 17:33:03 +0900
Message-ID: <4F3A1C3F.4060109@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32799 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab2BNIdF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2012 03:33:05 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZD00H9GJR4WXU0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 17:33:04 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZD00E6CJR4XDW0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 14 Feb 2012 17:33:04 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

In CLKENA register, can support 16-SD card clocks.
If support correctly, must shift with slot-id.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7d6ad6c..f9457e5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -652,8 +652,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);
 
 		/* enable clock */
-		mci_writel(host, CLKENA, SDMMC_CLKEN_ENABLE |
-			   SDMMC_CLKEN_LOW_PWR);
+		mci_writel(host, CLKENA, ((SDMMC_CLKEN_ENABLE |
+			   SDMMC_CLKEN_LOW_PWR) << slot->id));
 
 		/* inform CIU */
 		mci_send_cmd(slot,
