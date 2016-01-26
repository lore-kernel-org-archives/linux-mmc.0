From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH v3 03/25] mmc: block: shut up "retrying because a re-tune was
 needed" message
Date: Tue, 26 Jan 2016 13:39:23 +0000
Message-ID: <E1aO3q7-0005hn-PG@rmk-PC.arm.linux.org.uk>
References: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36817 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965129AbcAZNj3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2016 08:39:29 -0500
In-Reply-To: <20160126133840.GA32588@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Re-tuning is part of standard requirements for the higher speed SD
card protocols, and is not an error when this occurs.  When we retry
a command due to a retune, we should not print a message to the
kernel log.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/card/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 5914263090fc..52c6346fc8c2 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1363,8 +1363,8 @@ static int mmc_blk_err_check(struct mmc_card *card,
 
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

