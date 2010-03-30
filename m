From: <gregkh@suse.de>
Subject: patch s3cmci-initialize-default-platform-data-no_wprotect-and-no_detect-with-1.patch added to 2.6.32-stable tree
Date: Tue, 30 Mar 2010 14:57:15 -0700
Message-ID: <12699862352011@site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:33602 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754937Ab0C3WAe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Mar 2010 18:00:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: lars@metafoo.de, akpm@linux-foundation.org, ben-linux@fluff.org, gregkh@suse.de, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: s3cmci: initialize default platform data no_wprotect and no_detect with 1

to the 2.6.32-stable tree.  Its filename is

    s3cmci-initialize-default-platform-data-no_wprotect-and-no_detect-with-1.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From e1dcbab5755d0ffa32f8f6cbeb562c769872bd7c Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 5 Mar 2010 13:43:35 -0800
Subject: s3cmci: initialize default platform data no_wprotect and no_detect with 1

commit c212808a1ba6bfba489006399b8152a047305acf upstream.

If no platform_data was givin to the device it's going to use it's default
platform data struct which has all fields initialized to zero.  As a
result the driver is going to try to request gpio0 both as write protect
and card detect pin.  Which of course will fail and makes the driver
unusable

Previously to the introduction of no_wprotect and no_detect the behavior
was to assume that if no platform data was given there is no write protect
or card detect pin.  This patch restores that behavior.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/mmc/host/s3cmci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1361,6 +1361,8 @@ static struct mmc_host_ops s3cmci_ops =
 static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
 	/* This is currently here to avoid a number of if (host->pdata)
 	 * checks. Any zero fields to ensure reaonable defaults are picked. */
+	.no_wprotect = 1,
+	.no_detect = 1,
 };
 
 #ifdef CONFIG_CPU_FREQ


Patches currently in stable-queue which might be from lars@metafoo.de are

