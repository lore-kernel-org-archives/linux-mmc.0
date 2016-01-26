From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 05/25] mmc: sdhci: move initialisation of command error
 member
Date: Tue, 26 Jan 2016 13:39:34 +0000
Message-ID: <E1aO3qI-0005hz-Dv@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36828 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965911AbcAZNjl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:39:41 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

When a command is started, logically it has no error.  Initialise the
command's error member to zero whenever we start a command.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d622435d1bcc..eaa217f6e628 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1003,6 +1003,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	WARN_ON(host->cmd);
 
+	/* Initially, a command has no error */
+	cmd->error = 0;
+
 	/* Wait max 10 ms */
 	timeout = 10;
 
@@ -1097,8 +1100,6 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		}
 	}
 
-	host->cmd->error = 0;
-
 	/* Finished CMD23, now send actual command. */
 	if (host->cmd == host->mrq->sbc) {
 		host->cmd = NULL;
-- 
2.1.0

