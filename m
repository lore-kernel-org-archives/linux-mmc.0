From: akpm@linux-foundation.org
Subject: [patch 22/42] s3cmci: fix direct write to interrupt mask
Date: Thu, 01 Oct 2009 15:44:16 -0700
Message-ID: <200910012244.n91MiGxF008818@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47205 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772AbZJAWoR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Oct 2009 18:44:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ben@simtec.co.uk, linux-mmc@vger.kernel.org

From: Ben Dooks <ben@simtec.co.uk>

The clear_imask() call should be used to clear the interrupt mask
register, as it may end up clearing the SDIO interrupt bit if this is
enabled.

Change all writes of zero to SDIIMSK register to use clear_imask() ready
for the SDIO updates.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/s3cmci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/host/s3cmci.c~s3cmci-fix-direct-write-to-interrupt-mask drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c~s3cmci-fix-direct-write-to-interrupt-mask
+++ a/drivers/mmc/host/s3cmci.c
@@ -681,9 +681,9 @@ out:
 fail_request:
 	host->mrq->data->error = -EINVAL;
 	host->complete_what = COMPLETION_FINALIZE;
-	writel(0, host->base + host->sdiimsk);
-	goto out;
+	clear_imask(host);
 
+	goto out;
 }
 
 static void finalize_request(struct s3cmci_host *host)
@@ -726,7 +726,7 @@ static void finalize_request(struct s3cm
 	writel(0, host->base + S3C2410_SDICMDARG);
 	writel(S3C2410_SDIDCON_STOP, host->base + S3C2410_SDIDCON);
 	writel(0, host->base + S3C2410_SDICMDCON);
-	writel(0, host->base + host->sdiimsk);
+	clear_imask(host);
 
 	if (cmd->data && cmd->error)
 		cmd->data->error = cmd->error;
_
