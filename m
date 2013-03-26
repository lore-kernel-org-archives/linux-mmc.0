From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw-mmc: control the power-enable register
Date: Tue, 26 Mar 2013 21:36:14 +0900
Message-ID: <5151963E.2020101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:27793 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759255Ab3CZMgO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Mar 2013 08:36:14 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MK9007GKPODTH00@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Mar 2013 21:36:13 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@gmail.com>, James Hogan <james.hogan@imgtec.com>

When card is power-on/off, need to control the power-enable register.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a443820..a32aab5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -821,11 +821,17 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		/* Power up slot */
 		if (slot->host->pdata->setpower)
 			slot->host->pdata->setpower(slot->id, mmc->ocr_avail);
+		regs = mci_readl(slot->host, PWREN);
+		regs |= (1 << slot->id);
+		mci_writel(slot->host, PWREN, regs);
 		break;
 	case MMC_POWER_OFF:
 		/* Power down slot */
 		if (slot->host->pdata->setpower)
 			slot->host->pdata->setpower(slot->id, 0);
+		regs = mci_readl(slot->host, PWREN);
+		regs &= ~(1 << slot->id);
+		mci_writel(slot->host, PWREN, regs);
 		break;
 	default:
 		break;
-- 
1.7.9.5
