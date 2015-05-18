From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: [PATCH 1/1] dw_mmc: insmod followed by rmmod will hung for eMMC
Date: Mon, 18 May 2015 14:23:16 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE245182CD0@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35905 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753072AbbEROXV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2015 10:23:21 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "prabu.t@synopsys.com" <prabu.t@synopsys.com>

Removing dw_mmc driver immediately after inserting the dw_mmc driver is 
getting hung for eMMC device. Root cause for this issue is, dw_mci_remove
will disable all the interrupts then it will call dw_mci_cleanup_slot.
dw_mci_cleanup_slot is issuing CMD6 to disable boot partition access and
it's waiting for command complete interrupt. Since INTMASK was already
cleared by dw_mci_remove, command complete interrupt is not reaching 
the system. This leads to process hung.

Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
---
 drivers/mmc/host/dw_mmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 5f5adaf..f0a0aff 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2941,15 +2941,15 @@ void dw_mci_remove(struct dw_mci *host)
 {
 	int i;
 
-	mci_writel(host, RINTSTS, 0xFFFFFFFF);
-	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
-
 	for (i = 0; i < host->num_slots; i++) {
 		dev_dbg(host->dev, "remove slot %d\n", i);
 		if (host->slot[i])
 			dw_mci_cleanup_slot(host->slot[i], i);
 	}
 
+	mci_writel(host, RINTSTS, 0xFFFFFFFF);
+	mci_writel(host, INTMASK, 0); /* disable all mmc interrupt first */
+
 	/* disable clock to CIU */
 	mci_writel(host, CLKENA, 0);
 	mci_writel(host, CLKSRC, 0);
-- 
1.7.6.5
