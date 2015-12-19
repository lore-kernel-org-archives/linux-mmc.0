From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 06/17] mmc: sdhci: command response CRC error handling
Date: Sat, 19 Dec 2015 20:30:34 +0000
Message-ID: <E1aAO9C-0007y5-9S@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36133 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbLSUar (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:30:47 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

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
index 86310b162304..3e718e465a1b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2340,6 +2340,23 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 		else
 			host->cmd->error = -EILSEQ;
 
+		/*
+		 * If this command initiates a data phase and a response
+		 * CRC error is signalled, the card can start transferring
+		 * data - the card may have received the command without
+		 * error.  We must not terminate the request early.
+		 *
+		 * If the card did not receive the command, the data phase
+		 * will time out.
+		 *
+		 * FIXME: we also need to clean up the data phase if any
+		 * command fails, not just the data initiating command.
+		 */
+		if (host->cmd->data && intmask & SDHCI_INT_CRC) {
+			host->cmd = NULL;
+			return;
+		}
+
 		tasklet_schedule(&host->finish_tasklet);
 		return;
 	}
-- 
2.1.0

