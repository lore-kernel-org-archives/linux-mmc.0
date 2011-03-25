From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH 0/1] dw_mmc: checking card busy with Status register
Date: Fri, 25 Mar 2011 15:00:34 +0900
Message-ID: <4D8C2F82.2040504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59402 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab1CYGBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 02:01:36 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LIL00A2CNEJM870@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Mar 2011 15:01:31 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LIL005M9NEJDT@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Mar 2011 15:01:31 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This RFC patch is applied checking card busy with status register.

In Status register, bit[9] indicate the card busy or not.
So, if we use this bit in status register, we can check the card busy or not.

Maybe, didn't increased the performance, but i think this approach is decreased
the CPU usage.

Anyone, let me know how think about this patch.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 87e1f57..882d004 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -647,9 +647,26 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
+	unsigned int timeout = 0x100;
 
 	WARN_ON(slot->mrq);
 
+	while (timeout) {
+		if ((mrq->data && (mrq->data->flags == MMC_DATA_READ)) ||
+			!(mci_readl(host, STATUS) & (1 << 9)))
+			break;
+
+		if (timeout == 0) {
+			dev_err(&host->pdev->dev, "Card is busy!!\n");
+			return;
+		}
+
+		if (!need_resched())
+			usleep_range(10, 50);
+
+		timeout--;
+	}
+
 	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
 		mrq->cmd->error = -ENOMEDIUM;
 		mmc_request_done(mmc, mrq);
