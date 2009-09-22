From: akpm@linux-foundation.org
Subject: [patch 090/232] mmc_spi: fail gracefully if host or card do not support the switch command
Date: Tue, 22 Sep 2009 16:45:26 -0700
Message-ID: <200909222345.n8MNjQuA014339@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54226 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753381AbZIVXrL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:47:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, wolfgang.mues@auerswald.de, linux-mmc@vger.kernel.org, stable@kernel.org

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

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
Cc: <stable@kernel.org>		[2.6.31.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/mmc.c |   10 +++++-----
 drivers/mmc/core/sd.c  |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff -puN drivers/mmc/core/mmc.c~mmc_spi-fail-gracefully-if-host-or-card-do-not-support-the-switch-command drivers/mmc/core/mmc.c
--- a/drivers/mmc/core/mmc.c~mmc_spi-fail-gracefully-if-host-or-card-do-not-support-the-switch-command
+++ a/drivers/mmc/core/mmc.c
@@ -179,11 +179,11 @@ static int mmc_read_ext_csd(struct mmc_c
 
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
diff -puN drivers/mmc/core/sd.c~mmc_spi-fail-gracefully-if-host-or-card-do-not-support-the-switch-command drivers/mmc/core/sd.c
--- a/drivers/mmc/core/sd.c~mmc_spi-fail-gracefully-if-host-or-card-do-not-support-the-switch-command
+++ a/drivers/mmc/core/sd.c
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
_
