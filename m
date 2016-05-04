From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: prevent to set the wrong value
Date: Wed, 04 May 2016 16:14:34 +0900
Message-ID: <1462346074-19113-2-git-send-email-jh80.chung@samsung.com>
References: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58309 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbcEDHOi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 03:14:38 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6N035ZD5GC6S20@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 04 May 2016 16:14:36 +0900 (KST)
In-reply-to: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

If there is no vqmmc, real voltage should not change.
Then it needs to maintain the previous status for UHS_REG register.
It means that it doesn't need to set any bit.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 28602cc..6bd8018 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1418,7 +1418,19 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 					 ret, uhs & v18 ? "1.8" : "3.3");
 			return -EAGAIN;
 		}
+	} else {
+		/*
+		 * If there isn't vqmmc, it should fail to switch voltage.
+		 * Then it needs to maintain the previous status.
+		 * If ios->signal_voltage is 3.3v, it means that previous
+		 * voltages was 1.8v.
+		 */
+		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+			uhs |= v18;
+		else
+			uhs &= ~v18;
 	}
+
 	mci_writel(host, UHS_REG, uhs);
 
 	return 0;
-- 
1.9.1

