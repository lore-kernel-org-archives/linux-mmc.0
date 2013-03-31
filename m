From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 5/5] mmc: mxcmmc: fix race conditions for host->req and host->data access
Date: Mon,  1 Apr 2013 00:23:05 +0200
Message-ID: <1364768585-5177-6-git-send-email-agust@denx.de>
References: <1364768585-5177-1-git-send-email-agust@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54159 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836Ab3CaWX1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Mar 2013 18:23:27 -0400
In-Reply-To: <1364768585-5177-1-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org, Anatolij Gustschin <agust@denx.de>

mxcmci_dma_callback() is invoked by DMA drivers in soft-irq
context and can be interrupted by the mxcmci_irq() interrupt
which can finish the mmc request or data transfer and set
host->req or host->data pointers to NULL. Then mxcmci_data_done()
crashes with a null pointer dereferences. Protect all accesses
to host->req and host->data by spin locks.

Also check host->data pointer in mxcmci_watchdog() before
dereferencing it.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v2:
 - only rebased

 drivers/mmc/host/mxcmmc.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 2861e0d..23deb2a 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -694,24 +694,40 @@ static void mxcmci_datawork(struct work_struct *work)
 
 static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 {
-	struct mmc_data *data = host->data;
+	struct mmc_request *req;
 	int data_error;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
 
-	if (!data)
+	if (!host->data) {
+		spin_unlock_irqrestore(&host->lock, flags);
 		return;
+	}
+
+	if (!host->req) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
+	req = host->req;
+	if (!req->stop)
+		host->req = NULL; /* we will handle finish req below */
 
 	data_error = mxcmci_finish_data(host, stat);
 
+	spin_unlock_irqrestore(&host->lock, flags);
+
 	mxcmci_read_response(host, stat);
 	host->cmd = NULL;
 
-	if (host->req->stop) {
-		if (mxcmci_start_cmd(host, host->req->stop, 0)) {
-			mxcmci_finish_request(host, host->req);
+	if (req->stop) {
+		if (mxcmci_start_cmd(host, req->stop, 0)) {
+			mxcmci_finish_request(host, req);
 			return;
 		}
 	} else {
-		mxcmci_finish_request(host, host->req);
+		mxcmci_finish_request(host, req);
 	}
 }
 
@@ -1005,7 +1021,8 @@ static void mxcmci_watchdog(unsigned long data)
 
 	/* Mark transfer as erroneus and inform the upper layers */
 
-	host->data->error = -ETIMEDOUT;
+	if (host->data)
+		host->data->error = -ETIMEDOUT;
 	host->req = NULL;
 	host->cmd = NULL;
 	host->data = NULL;
-- 
1.7.5.4

