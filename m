From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v2 05/24] mmc: sdhci: move initialisation of command error
 member
Date: Mon, 21 Dec 2015 11:40:46 +0000
Message-ID: <E1aAypa-00016F-VU@rmk-PC.arm.linux.org.uk>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39686 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbLULk7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 06:40:59 -0500
In-Reply-To: <20151221113956.GA3712@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

When a command is started, logically it has no error.  Initialise the
command's error member to zero whenever we start a command.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/sdhci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b48565ed5616..86e0e847fcc8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1002,6 +1002,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	WARN_ON(host->cmd);
 
+	/* Initially, a command has no error */
+	cmd->error = 0;
+
 	/* Wait max 10 ms */
 	timeout = 10;
 
@@ -1096,8 +1099,6 @@ static void sdhci_finish_command(struct sdhci_host *host)
 		}
 	}
 
-	host->cmd->error = 0;
-
 	/* Finished CMD23, now send actual command. */
 	if (host->cmd == host->mrq->sbc) {
 		host->cmd = NULL;
-- 
2.1.0

