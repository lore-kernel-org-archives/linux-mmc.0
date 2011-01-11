From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] MMCI: don't read command response when invalid
Date: Tue, 11 Jan 2011 16:35:56 +0000
Message-ID: <20110111163556.GA18746@n2100.arm.linux.org.uk>
References: <20110111163502.GJ11039@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37360 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428Ab1AKQgD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2011 11:36:03 -0500
Content-Disposition: inline
In-Reply-To: <20110111163502.GJ11039@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Don't read the command response from the registers when either the
command timed out (because there was no response from the card) or
the checksum on the response was invalid.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/mmci.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5630228..040de4f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -394,15 +394,15 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 
 	host->cmd = NULL;
 
-	cmd->resp[0] = readl(base + MMCIRESPONSE0);
-	cmd->resp[1] = readl(base + MMCIRESPONSE1);
-	cmd->resp[2] = readl(base + MMCIRESPONSE2);
-	cmd->resp[3] = readl(base + MMCIRESPONSE3);
-
 	if (status & MCI_CMDTIMEOUT) {
 		cmd->error = -ETIMEDOUT;
 	} else if (status & MCI_CMDCRCFAIL && cmd->flags & MMC_RSP_CRC) {
 		cmd->error = -EILSEQ;
+	} else {
+		cmd->resp[0] = readl(base + MMCIRESPONSE0);
+		cmd->resp[1] = readl(base + MMCIRESPONSE1);
+		cmd->resp[2] = readl(base + MMCIRESPONSE2);
+		cmd->resp[3] = readl(base + MMCIRESPONSE3);
 	}
 
 	if (!cmd->data || cmd->error) {
