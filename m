From: akpm@linux-foundation.org
Subject: [patch 104/160] sdio: kick the interrupt thread upon a resume
Date: Fri, 05 Mar 2010 13:43:34 -0800
Message-ID: <201003052143.o25LhYhN029788@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41171 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755582Ab0CEVni (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nico@fluxnic.net, linux-mmc@vger.kernel.org, nico@marvell.com

From: Nicolas Pitre <nico@fluxnic.net>

Some SDIO cards may suspend while keeping function interrupts active
especially in the powered suspend case.  Upon resume we need to kick the
SDIO interrupt thread to check for pending interrupts and to restart card
IRQ detection at the host controller level.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/mmc/core/sdio.c~sdio-kick-the-interrupt-thread-upon-a-resume drivers/mmc/core/sdio.c
--- a/drivers/mmc/core/sdio.c~sdio-kick-the-interrupt-thread-upon-a-resume
+++ a/drivers/mmc/core/sdio.c
@@ -441,6 +441,8 @@ static int mmc_sdio_resume(struct mmc_ho
 	mmc_claim_host(host);
 	err = mmc_sdio_init_card(host, host->ocr, host->card,
 				 (host->pm_flags & MMC_PM_KEEP_POWER));
+	if (!err && host->sdio_irqs)
+		mmc_signal_sdio_irq(host);
 	mmc_release_host(host);
 
 	/*
_
