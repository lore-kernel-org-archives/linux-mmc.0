From: <gregkh@suse.de>
Subject: patch mmc-atmel-mci-remove-data-error-interrupt-after-xfer.patch added to 2.6.33-stable tree
Date: Wed, 12 May 2010 16:20:23 -0700
Message-ID: <1273706423727@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45780 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758514Ab0ELXUk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 May 2010 19:20:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nicolas.ferre@atmel.com, akpm@linux-foundation.org, gregkh@suse.de, hskinnemoen@atmel.com, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mmc: atmel-mci: remove data error interrupt after xfer

to the 2.6.33-stable tree.  Its filename is

    mmc-atmel-mci-remove-data-error-interrupt-after-xfer.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From abc2c9fdf636c4335a8d72ac3c5ae152bca44b68 Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 11 May 2010 14:06:50 -0700
Subject: mmc: atmel-mci: remove data error interrupt after xfer

From: Nicolas Ferre <nicolas.ferre@atmel.com>

commit abc2c9fdf636c4335a8d72ac3c5ae152bca44b68 upstream.

Disable data error interrupts while we are actually recording that there
is not such errors.  This will prevent, in some cases, the warning message
printed at new request queuing (in atmci_start_request()).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/host/atmel-mci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1293,6 +1293,7 @@ static void atmci_tasklet_func(unsigned
 			} else {
 				data->bytes_xfered = data->blocks * data->blksz;
 				data->error = 0;
+				mci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS);
 			}
 
 			if (!data->stop) {


Patches currently in stable-queue which might be from nicolas.ferre@atmel.com are

queue-2.6.33/mmc-atmel-mci-remove-data-error-interrupt-after-xfer.patch
queue-2.6.33/mmc-atmel-mci-prevent-kernel-oops-while-removing-card.patch
queue-2.6.33/mmc-atmel-mci-fix-two-parameters-swapped.patch
