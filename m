From: Hyeonsu Kim <hyeonsu.kim@samsung.com>
Subject: [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
Date: Fri, 22 Feb 2013 10:27:30 +0900
Message-ID: <1361496450-12647-1-git-send-email-hyeonsu.kim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:25260 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab3BVB1i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 20:27:38 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MIL00M35LCPFP60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 10:27:37 +0900 (KST)
Received: from localhost.localdomain ([165.213.71.253])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MIL003F9LDYW690@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Feb 2013 10:27:36 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: kyungmin.park@samsung.com, jh80.chung@samsung.com, tgih.jun@samsung.com, Hyeonsu Kim <hyeonsu.kim@samsung.com>

In the legacy code, driver clear not only UHS_REG 16 bit also 0-15bit.
If we use UHS-1 mode spec card like SDR50, SDR104. UHS_REG 0-15 should be set by
1 according to slot id. In this case, legacy code can make problem.

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

