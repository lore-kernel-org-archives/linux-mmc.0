From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 05/17] mmc: sdhci: clean up command error handling
Date: Sat, 19 Dec 2015 20:30:29 +0000
Message-ID: <E1aAO97-0007xz-3B@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36127 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbLSUak (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:30:40 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Avoid multiple tests while handling a command error; simplify the code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 86e0e847fcc8..86310b162304 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2333,13 +2333,13 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
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

