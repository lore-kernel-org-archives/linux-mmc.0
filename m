From: <gregkh@suse.de>
Subject: Patch "tmio_mmc: don't clear unhandled pending interrupts" has been added to the 2.6.35-stable tree
Date: Wed, 15 Sep 2010 15:15:15 -0700
Message-ID: <12845889153845@site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58644 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673Ab0IOWSO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Sep 2010 18:18:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yusuke.goda.sx@renesas.com, akpm@linux-foundation.org, arnd@arndnet.de, damm@opensource.se, gregkh@suse.de, ian@mnementh.co.uk, lethal@linux-sh.org, linux-mmc@vger.kernel.org, matt@co
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    tmio_mmc: don't clear unhandled pending interrupts

to the 2.6.35-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     tmio_mmc-don-t-clear-unhandled-pending-interrupts.patch
and it can be found in the queue-2.6.35 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@kernel.org> know about it.


>From b78d6c5f51935ba89df8db33a57bacb547aa7325 Mon Sep 17 00:00:00 2001
From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Thu, 9 Sep 2010 16:37:39 -0700
Subject: tmio_mmc: don't clear unhandled pending interrupts

From: Yusuke Goda <yusuke.goda.sx@renesas.com>

commit b78d6c5f51935ba89df8db33a57bacb547aa7325 upstream.

Previously, it was possible for ack_mmc_irqs() to clear pending interrupt
bits in the CTL_STATUS register, even though the interrupt handler had not
been called.  This was because of a race that existed when doing a
read-modify-write sequence on CTL_STATUS.  After the read step in this
sequence, if an interrupt occurred (causing one of the bits in CTL_STATUS
to be set) the write step would inadvertently clear it.

Observed with the TMIO_STAT_RXRDY bit together with CMD53 on AR6002 and
BCM4318 SDIO cards in polled mode.

This patch eliminates this race by only writing to CTL_STATUS and clearing
the interrupts that were passed as an argument to ack_mmc_irqs()."

[matt@console-pimps.org: rewrote changelog]
Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>"
Tested-by: Arnd Hannemann <arnd@arndnet.de>"
Acked-by: Ian Molton <ian@mnementh.co.uk>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/host/tmio_mmc.h |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -82,10 +82,7 @@
 
 #define ack_mmc_irqs(host, i) \
 	do { \
-		u32 mask;\
-		mask  = sd_ctrl_read32((host), CTL_STATUS); \
-		mask &= ~((i) & TMIO_MASK_IRQ); \
-		sd_ctrl_write32((host), CTL_STATUS, mask); \
+		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
 	} while (0)
 
 


Patches currently in stable-queue which might be from yusuke.goda.sx@renesas.com are

queue-2.6.35/tmio_mmc-don-t-clear-unhandled-pending-interrupts.patch
