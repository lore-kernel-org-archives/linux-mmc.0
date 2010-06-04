From: akpm@linux-foundation.org
Subject: [patch 21/21] omap: remove BUG_ON for disabled interrupts
Date: Fri, 04 Jun 2010 14:15:07 -0700
Message-ID: <201006042115.o54LF7OF018313@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36592 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751410Ab0FDVPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jun 2010 17:15:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, darkstar6262@gmail.com, linux-mmc@vger.kernel.org, tony@atomide.com

From: Cory Maccarrone <darkstar6262@gmail.com>

Remove a BUG_ON for when interrupts are disabled during an MMC request.

During boot, interrupts can be disabled when a request is made, causing
this bug to be triggered.  In reality, there's no reason this should halt
the kernel, as the driver has proved reliable in spite of disabled
interrupts, and additionally, there's nothing in this code that would
require interrupts to be enabled.

The only setup I've managed to make it trigger on is on the HTC Herald
during bootup when the driver is built into the kernel (mostly because
that's all I have).  I believe it's related to the fact that on bootup I
get many timeout errors on "CMD5" while initializing the card.  Each CMD5
timeout triggers that bug (I changed it to a WARN_ON to get it to boot in)
due to the fact that part of the timeout code involves sending the request
again.  With interrupts turned off, that BUG would be triggered.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap.c |    1 -
 1 file changed, 1 deletion(-)

diff -puN drivers/mmc/host/omap.c~omap-remove-bug_on-for-disabled-interrupts drivers/mmc/host/omap.c
--- a/drivers/mmc/host/omap.c~omap-remove-bug_on-for-disabled-interrupts
+++ a/drivers/mmc/host/omap.c
@@ -1157,7 +1157,6 @@ static void mmc_omap_start_request(struc
 	mmc_omap_start_command(host, req->cmd);
 	if (host->dma_in_use)
 		omap_start_dma(host->dma_ch);
-	BUG_ON(irqs_disabled());
 }
 
 static void mmc_omap_request(struct mmc_host *mmc, struct mmc_request *req)
_
