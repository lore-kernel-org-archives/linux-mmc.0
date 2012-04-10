From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mmc: sdhci: Log what timeout was set if the timeout is too large
Date: Tue, 10 Apr 2012 11:36:03 +0100
Message-ID: <1334054163-25459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53792 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753807Ab2DJKgH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Apr 2012 06:36:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Rather than just logging that we came up with an excessively large timeout
say what the timeout was, this may provide some clues as to what the issue
is.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

I'm seeing reams of these from my s3c64xx based system, looks like it's
always coming out with a timeout of 0xf which is only just out of range.

 drivers/mmc/host/sdhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9aa77f3..8407a0b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -680,8 +680,8 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (count >= 0xF) {
-		pr_warning("%s: Too large timeout requested for CMD%d!\n",
-		       mmc_hostname(host->mmc), cmd->opcode);
+		pr_warning("%s: Too large timeout %x requested for CMD%d!\n",
+			   mmc_hostname(host->mmc), count, cmd->opcode);
 		count = 0xE;
 	}
 
-- 
1.7.9.1

