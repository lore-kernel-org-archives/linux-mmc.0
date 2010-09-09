From: akpm@linux-foundation.org
Subject: [patch 12/41] tmio_mmc: don't clear unhandled pending interrupts
Date: Thu, 09 Sep 2010 16:37:39 -0700
Message-ID: <201009092337.o89NbdVt014197@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33081 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208Ab0IIXih (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 19:38:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, yusuke.goda.sx@renesas.com, arnd@arndnet.de, damm@opensource.se, ian@mnementh.co.uk, lethal@linux-sh.org, linux-mmc@vger.kernel.org, matt@console-pimps.org, sameo@linux.intel.com, stable@kernel.org

From: Yusuke Goda <yusuke.goda.sx@renesas.com>

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
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/tmio_mmc.h |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff -puN drivers/mmc/host/tmio_mmc.h~tmio_mmc-dont-clear-unhandled-pending-interrupts drivers/mmc/host/tmio_mmc.h
--- a/drivers/mmc/host/tmio_mmc.h~tmio_mmc-dont-clear-unhandled-pending-interrupts
+++ a/drivers/mmc/host/tmio_mmc.h
@@ -82,10 +82,7 @@
 
 #define ack_mmc_irqs(host, i) \
 	do { \
-		u32 mask;\
-		mask  = sd_ctrl_read32((host), CTL_STATUS); \
-		mask &= ~((i) & TMIO_MASK_IRQ); \
-		sd_ctrl_write32((host), CTL_STATUS, mask); \
+		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
 	} while (0)
 
 
_
