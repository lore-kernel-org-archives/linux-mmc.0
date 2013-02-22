From: Hyeonsu Kim <hyeonsu.kim@samsung.com>
Subject: [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
Date: Fri, 22 Feb 2013 09:32:46 +0900
Message-ID: <1361493166-12251-1-git-send-email-hyeonsu.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16383 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154Ab3BVAcy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 19:32:54 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIL00B6JIS98WA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 09:32:53 +0900 (KST)
Received: from localhost.localdomain ([165.213.71.253])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MIL00AU1IUP7C10@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 09:32:52 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kyungmin.park@samsung.com, jh80.chung@samsung.com, Hyeonsu Kim <hyeonsu.kim@samsung.com>

Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 323c502..390c15c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -789,9 +789,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* DDR mode set */
 	if (ios->timing == MMC_TIMING_UHS_DDR50)
-		regs |= (0x1 << slot->id) << 16;
+		regs |= ((0x1 << slot->id) << 16);
 	else
-		regs &= ~(0x1 << slot->id) << 16;
+		regs &= ~((0x1 << slot->id) << 16);
 
 	mci_writel(slot->host, UHS_REG, regs);
 
-- 
1.7.5.4

