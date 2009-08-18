From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 5/9] s3cmci: Fix direct write to interrupt mask
Date: Tue, 18 Aug 2009 12:56:09 +0100
Message-ID: <20090818115659.358942858@fluff.org>
References: <20090818115604.056816271@fluff.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:55699 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758692AbZHRL45 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 07:56:57 -0400
Content-Disposition: inline; filename=s3cmci-fix-clear-imask.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

The clear_imask() call should be used to clear the interrupt mask
register, as it may end up clearing the SDIO interrupt bit if this
is enabled.

Change all writes of zero to SDIIMSK register to use clear_imask()
ready for the SDIO updates.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---

Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-07-22 14:55:13.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-07-22 14:57:07.000000000 +0100
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

-- 
