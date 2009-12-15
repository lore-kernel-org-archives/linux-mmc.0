From: akpm@linux-foundation.org
Subject: [patch 170/196] drivers/mmc: Move dereference after NULL test
Date: Mon, 14 Dec 2009 18:01:20 -0800
Message-ID: <200912150201.nBF21LTn022442@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51114 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758242AbZLOCJT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 21:09:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, julia@diku.dk, linux-mmc@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

If the NULL test on mrq is needed, then the derefernce should be after the
NULL test.

A simplified version of the semantic match that detects this problem is as
follows (http://coccinelle.lip6.fr/):

// <smpl>
@match exists@
expression x, E;
identifier fld;
@@

* x->fld
  ... when != \(x = E\|&x\)
* x == NULL
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/s3cmci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/s3cmci.c~drivers-mmc-move-dereference-after-null-test drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c~drivers-mmc-move-dereference-after-null-test
+++ a/drivers/mmc/host/s3cmci.c
@@ -820,7 +820,7 @@ fail_request:
 static void finalize_request(struct s3cmci_host *host)
 {
 	struct mmc_request *mrq = host->mrq;
-	struct mmc_command *cmd = host->cmd_is_stop ? mrq->stop : mrq->cmd;
+	struct mmc_command *cmd;
 	int debug_as_failure = 0;
 
 	if (host->complete_what != COMPLETION_FINALIZE)
@@ -828,6 +828,7 @@ static void finalize_request(struct s3cm
 
 	if (!mrq)
 		return;
+	cmd = host->cmd_is_stop ? mrq->stop : mrq->cmd;
 
 	if (cmd->data && (cmd->error == 0) &&
 	    (cmd->data->error == 0)) {
_
