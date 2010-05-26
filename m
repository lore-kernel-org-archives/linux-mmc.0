From: akpm@linux-foundation.org
Subject: [patch 008/203] mmc: sd: clean up redundant memset
Date: Wed, 26 May 2010 14:41:58 -0700
Message-ID: <201005262141.o4QLfwB6015332@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39386 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754323Ab0EZVyD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 17:54:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, asselsm@gmail.com, linux-mmc@vger.kernel.org

From: Mark Asselstine <asselsm@gmail.com>

The clearing of mrq via a memset at the top of the for loop in
mmc_wait_for_app_cmd() is not required as mrq is not used and there is
another clearing of mrq just below.  We remove the first memset since if
the initial tests in the for loop fail the memset is not required.

Signed-off-by: Mark Asselstine <asselsm@gmail.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sd_ops.c |    2 --
 1 file changed, 2 deletions(-)

diff -puN drivers/mmc/core/sd_ops.c~mmc-sd-clean-up-redundant-memset drivers/mmc/core/sd_ops.c
--- a/drivers/mmc/core/sd_ops.c~mmc-sd-clean-up-redundant-memset
+++ a/drivers/mmc/core/sd_ops.c
@@ -79,8 +79,6 @@ int mmc_wait_for_app_cmd(struct mmc_host
 	 * we cannot use the retries field in mmc_command.
 	 */
 	for (i = 0;i <= retries;i++) {
-		memset(&mrq, 0, sizeof(struct mmc_request));
-
 		err = mmc_app_cmd(host, card);
 		if (err) {
 			/* no point in retrying; no APP commands allowed */
_
