From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 07/25] mmc: sdhci: command response CRC error handling
Date: Tue, 26 Jan 2016 13:39:45 +0000
Message-ID: <E1aO3qT-0005iB-CJ@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36841 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965736AbcAZNjz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:39:55 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

When we get a response CRC error on a command, it means that the
response we received back from the card was not correct.  It does not
mean that the card did not receive the command correctly.  If the
command is one which initiates a data transfer, the card can enter the
data transfer state, and start sending data.

Moreover, if the request contained a data phase, we do not clean this
up, and this results in the driver triggering DMA API debug warnings,
and also creates a race condition in the driver, between running the
finish_tasklet and the data transfer interrupts, which can trigger a
"Got data interrupt" state dump.

Fix this by handing a response CRC error slightly differently: record
the failure of the data initiating command, but allow the remainder of
the request to be processed normally.  This is safe as core MMC checks
the status of all commands and data transfer phases of the request.

If the card does not initiate a data transfer, then we should time out
according to the data transfer parameters.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ada227da39a6..cbc4145daaf8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2330,6 +2330,23 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 		else
 			host->cmd->error = -EILSEQ;
 
+		/*
+		 * If this command initiates a data phase and a response
+		 * CRC error is signalled, the card can start transferring
+		 * data - the card may have received the command without
+		 * error.  We must not terminate the mmc_request early.
+		 *
+		 * If the card did not receive the command or returned an
+		 * error which prevented it sending data, the data phase
+		 * will time out.
+		 */
+		if (host->cmd->data &&
+		    intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT) ==
+		     SDHCI_INT_CRC) {
+			host->cmd = NULL;
+			return;
+		}
+
 		tasklet_schedule(&host->finish_tasklet);
 		return;
 	}
-- 
2.1.0

