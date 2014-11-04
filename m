From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v2 1/4] mmc: core: use mmc_send_status to check hw_reset
Date: Tue,  4 Nov 2014 16:07:03 +0100
Message-ID: <1415113626-30187-2-git-send-email-johanru@axis.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:44116 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbaKDPHW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 10:07:22 -0500
In-Reply-To: <1415113626-30187-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/core.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dc0c85..5d215ee 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2265,15 +2265,9 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 
 	/* If the reset has happened, then a status command will fail */
 	if (check) {
-		struct mmc_command cmd = {0};
-		int err;
+		u32 status;
 
-		cmd.opcode = MMC_SEND_STATUS;
-		if (!mmc_host_is_spi(card->host))
-			cmd.arg = card->rca << 16;
-		cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
-		err = mmc_wait_for_cmd(card->host, &cmd, 0);
-		if (!err) {
+		if (!mmc_send_status(card, &status)) {
 			mmc_host_clk_release(host);
 			return -ENOSYS;
 		}
-- 
1.7.2.5

