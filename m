From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v4 06/25] mmc: sdhci: clean up command error handling
Date: Fri, 29 Jan 2016 09:44:16 +0000
Message-ID: <E1aP5bE-0001p7-1h@rmk-PC.arm.linux.org.uk>
References: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44206 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbcA2Jo1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jan 2016 04:44:27 -0500
In-Reply-To: <20160129094324.GA20025@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Avoid multiple tests while handling a command error; simplify the code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index eaa217f6e628..ada227da39a6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2323,13 +2323,13 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 		return;
 	}
 
-	if (intmask & SDHCI_INT_TIMEOUT)
-		host->cmd->error = -ETIMEDOUT;
-	else if (intmask & (SDHCI_INT_CRC | SDHCI_INT_END_BIT |
-			SDHCI_INT_INDEX))
-		host->cmd->error = -EILSEQ;
+	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
+		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
+		if (intmask & SDHCI_INT_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+		else
+			host->cmd->error = -EILSEQ;
 
-	if (host->cmd->error) {
 		tasklet_schedule(&host->finish_tasklet);
 		return;
 	}
-- 
2.1.0

