From: <gregkh@suse.de>
Subject: patch mmc-atmel-mci-fix-two-parameters-swapped.patch added to 2.6.32-stable tree
Date: Wed, 12 May 2010 16:19:48 -0700
Message-ID: <1273706388133@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:45680 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758313Ab0ELXT7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 May 2010 19:19:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: nicolas.ferre@atmel.com, akpm@linux-foundation.org, anders.grahn@hd-wireless.se, gregkh@suse.de, hskinnemoen@atmel.com, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mmc: atmel-mci: fix two parameters swapped

to the 2.6.32-stable tree.  Its filename is

    mmc-atmel-mci-fix-two-parameters-swapped.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From ebb1fea9b3adf25d7e2f643c614163af4f93a17f Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 11 May 2010 14:06:48 -0700
Subject: mmc: atmel-mci: fix two parameters swapped

From: Nicolas Ferre <nicolas.ferre@atmel.com>

commit ebb1fea9b3adf25d7e2f643c614163af4f93a17f upstream.

Two parameters were swapped in the calls to atmci_init_slot().

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Reported-by: Anders Grahn <anders.grahn@hd-wireless.se>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1669,13 +1669,13 @@ static int __init atmci_probe(struct pla
 	ret = -ENODEV;
 	if (pdata->slot[0].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[0],
-				MCI_SDCSEL_SLOT_A, 0);
+				0, MCI_SDCSEL_SLOT_A);
 		if (!ret)
 			nr_slots++;
 	}
 	if (pdata->slot[1].bus_width) {
 		ret = atmci_init_slot(host, &pdata->slot[1],
-				MCI_SDCSEL_SLOT_B, 1);
+				1, MCI_SDCSEL_SLOT_B);
 		if (!ret)
 			nr_slots++;
 	}


Patches currently in stable-queue which might be from nicolas.ferre@atmel.com are

queue-2.6.32/mmc-atmel-mci-remove-data-error-interrupt-after-xfer.patch
queue-2.6.32/mmc-atmel-mci-prevent-kernel-oops-while-removing-card.patch
queue-2.6.32/mmc-atmel-mci-fix-two-parameters-swapped.patch
