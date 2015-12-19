From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 02/17] mmc: block: shut up "retrying because a re-tune was
 needed" message
Date: Sat, 19 Dec 2015 20:30:13 +0000
Message-ID: <E1aAO8r-0007xh-8W@rmk-PC.arm.linux.org.uk>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36109 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbbLSUaU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 19 Dec 2015 15:30:20 -0500
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

Re-tuning is part of standard requirements for the higher speed SD
card protocols, and is not an error when this occurs.  When we retry
a command due to a retune, we should not print a message to the
kernel log.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/card/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index d8486168415a..16c8d977228e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1367,8 +1367,8 @@ static int mmc_blk_err_check(struct mmc_card *card,
 
 	if (brq->data.error) {
 		if (need_retune && !brq->retune_retry_done) {
-			pr_info("%s: retrying because a re-tune was needed\n",
-				req->rq_disk->disk_name);
+			pr_debug("%s: retrying because a re-tune was needed\n",
+				 req->rq_disk->disk_name);
 			brq->retune_retry_done = 1;
 			return MMC_BLK_RETRY;
 		}
-- 
2.1.0

