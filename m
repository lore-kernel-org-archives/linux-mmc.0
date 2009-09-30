From: <gregkh@suse.de>
Subject: patch mmc_spi-fail-gracefully-if-host-or-card-do-not-support-the-switch-command.patch added to 2.6.31-stable tree
Date: Wed, 30 Sep 2009 15:36:59 -0700
Message-ID: <20090930223838.EC68E48A48@coco.kroah.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:49590 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbZI3Wie (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2009 18:38:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wolfgang.mues@auerswald.de, akpm@linux-foundation.org, gregkh@suse.de, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: mmc_spi: fail gracefully if host or card do not support the switch command

to the 2.6.31-stable tree.  Its filename is

    mmc_spi-fail-gracefully-if-host-or-card-do-not-support-the-switch-command.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From d08ebeddfb3293fa4bdfca9c610daf1e8ec8b233 Mon Sep 17 00:00:00 2001
From: Wolfgang Muees <wolfgang.mues@auerswald.de>
Date: Tue, 22 Sep 2009 16:45:26 -0700
Subject: mmc_spi: fail gracefully if host or card do not support the switch command

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

commit d08ebeddfb3293fa4bdfca9c610daf1e8ec8b233 upstream.

Some time ago, I have send a patch to the mmc_spi subsystem changing the
error codes.  This was after a discussion with Pierre about using EINVAL
only for non-recoverable errors.  This patch was accepted as

http://git.kernel.org/linus/fdd858db7113ca64132de390188d7ca00701013d

Unfortunately, several weeks later, I realized that this patch has opened
a little can of worms because there are SD cards on the market which

a) claim that they support the switch command
AND
b) refuse to execute this command if operating in SPI mode.

So, such a card would get unusuable in an embedded linux system in SPI
mode, because the init sequence terminates with an error.

This patch adds the missing error codes to the caller of the switch
command and restores the old behaviour to fail gracefully if these
commands can not execute.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/core/mmc.c |   10 +++++-----
 drivers/mmc/core/sd.c  |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -180,11 +180,11 @@ static int mmc_read_ext_csd(struct mmc_c
 
 	err = mmc_send_ext_csd(card, ext_csd);
 	if (err) {
-		/*
-		 * We all hosts that cannot perform the command
-		 * to fail more gracefully
-		 */
-		if (err != -EINVAL)
+		/* If the host or the card can't do the switch,
+		 * fail more gracefully. */
+		if ((err != -EINVAL)
+		 && (err != -ENOSYS)
+		 && (err != -EFAULT))
 			goto out;
 
 		/*
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -210,11 +210,11 @@ static int mmc_read_switch(struct mmc_ca
 
 	err = mmc_sd_switch(card, 0, 0, 1, status);
 	if (err) {
-		/*
-		 * We all hosts that cannot perform the command
-		 * to fail more gracefully
-		 */
-		if (err != -EINVAL)
+		/* If the host or the card can't do the switch,
+		 * fail more gracefully. */
+		if ((err != -EINVAL)
+		 && (err != -ENOSYS)
+		 && (err != -EFAULT))
 			goto out;
 
 		printk(KERN_WARNING "%s: problem reading switch "


Patches currently in stable-queue which might be from wolfgang.mues@auerswald.de are

queue-2.6.31/mmc_spi-fail-gracefully-if-host-or-card-do-not-support-the-switch-command.patch
