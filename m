From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Fixup handling of MCI_STARTBITERR
Date: Thu, 10 Nov 2011 16:33:19 +0100
Message-ID: <1320939199-30363-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:55248 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751465Ab1KJPdm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2011 10:33:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>

The interrupt was previously enabled and then correctly cleared.
Now we also handle it correctly.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50b5f99..8265981 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -675,7 +675,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
 	/* First check for errors */
-	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
+	if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
+		      MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
@@ -955,8 +956,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
 
 		data = host->data;
-		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|
-			      MCI_RXOVERRUN|MCI_DATAEND|MCI_DATABLOCKEND) && data)
+		if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
+			      MCI_TXUNDERRUN|MCI_RXOVERRUN|MCI_DATAEND|
+			      MCI_DATABLOCKEND) && data)
 			mmci_data_irq(host, data, status);
 
 		cmd = host->cmd;
-- 
1.7.5.4

