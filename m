From: Greg KH <gregkh@suse.de>
Subject: [049/123] tmio_mmc: dont clear unhandled pending interrupts
Date: Sat, 18 Sep 2010 11:58:13 -0700
Message-ID: <20100918185957.010472560@clark.site>
References: <20100918185724.290702750@clark.site>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=tmio_mmc-don-t-clear-unhandled-pending-interrupts.patch
In-Reply-To: <20100918190024.GA14388@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Matt Fleming <matt@console-pimps.org>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

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
Acked-by: Magnus Damm <damm@opensource.se>
Tested-by: Arnd Hannemann <arnd@arndnet.de>
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
@@ -102,10 +102,7 @@
 
 #define ack_mmc_irqs(host, i) \
 	do { \
-		u32 mask;\
-		mask  = sd_ctrl_read32((host), CTL_STATUS); \
-		mask &= ~((i) & TMIO_MASK_IRQ); \
-		sd_ctrl_write32((host), CTL_STATUS, mask); \
+		sd_ctrl_write32((host), CTL_STATUS, ~(i)); \
 	} while (0)
 
 
