From: Mark Asselstine <asselsm@gmail.com>
Subject: [PATCH] mmc: sd: Cleanup redundant memset
Date: Thu,  8 Apr 2010 23:15:15 -0400
Message-ID: <1270782915-25089-1-git-send-email-asselsm@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:42599 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab0DIDPY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Apr 2010 23:15:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kernel-janitors@vger.kernel.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: asselsm@gmail.com

The clearing of mrq via a memset at the top of the for loop in
mmc_wait_for_app_cmd() is not required as mrq is not used and
there is another clearing of mrq just below. We remove the first
memset since if the initial tests in the for loop fail the memset
is not required.

Signed-off-by: Mark Asselstine <asselsm@gmail.com>
---
Resending to linux-mmc@vger.kernel.org and akpm@linux-foundation.org
since MMC/SD is an orphan so hopefully including these folks will allow
someone to pick this patch up.

 drivers/mmc/core/sd_ops.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 0d96080..63772e7 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -79,8 +79,6 @@ int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
 	 * we cannot use the retries field in mmc_command.
 	 */
 	for (i = 0;i <= retries;i++) {
-		memset(&mrq, 0, sizeof(struct mmc_request));
-
 		err = mmc_app_cmd(host, card);
 		if (err) {
 			/* no point in retrying; no APP commands allowed */
-- 
1.7.0

