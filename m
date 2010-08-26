From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 26 Aug 2010 15:16:40 -0700
Message-ID: <20100826151640.04d11be0.akpm@linux-foundation.org>
References: <20100708144626.2091f6c1.akpm@linux-foundation.org>
	<4C3BBE77.8080000@renesas.com>
	<20100715132552.fcb5791b.akpm@linux-foundation.org>
	<20100825231107.45227d6a@linux-g6p1.site>
	<20100825160722.9c9c38c8.akpm@linux-foundation.org>
	<4C75BB0D.2030202@renesas.com>
	<20100826075320.0538043b@linux-g6p1.site>
	<AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
	<20100826072642.GB19339@console-pimps.org>
	<20100826141237.c31bc1ed.akpm@linux-foundation.org>
	<20100826221024.GA11300@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56631 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753836Ab0HZWRJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 18:17:09 -0400
In-Reply-To: <20100826221024.GA11300@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, 26 Aug 2010 23:10:24 +0100
Matt Fleming <matt@console-pimps.org> wrote:

> I've stuck my oar in and confused everybody now, it seems.

I've just unconfused myself my dropping the patch ;) Please send new
one(s) when the dust has settled?

The only tmio_mmc patch in my tree at present is
tmio_mmc-dont-clear-unhandled-pending-interrupts:




From: Yusuke Goda <yusuke.goda.sx@renesas.com>

Previously, it was possible for ack_mmc_irqs() to clear pending interrupt
bits in the CTL_STATUS register, even though the interrupt handler had not
been called.  This was because of a race that existed when doing a
read-modify-write sequence on CTL_STATUS.  After the read step in this
sequence, if an interrupt occurred (causing one of the bits in CTL_STATUS
to be set) the write step would inadvertently clear it.

This patch eliminates this race by only writing to CTL_STATUS and clearing
the interrupts that were passed as an argument to ack_mmc_irqs()."

[matt@console-pimps.org: rewrote changelog]
Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>
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

