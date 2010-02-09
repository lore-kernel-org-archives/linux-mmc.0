From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 4/5] SDIO: kick the interrupt thread upon a resume
Date: Tue, 09 Feb 2010 15:29:25 -0500
Message-ID: <1265747366-6676-5-git-send-email-nico@fluxnic.net>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:12186 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab0BIU3w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2010 15:29:52 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXL00I4TCXNVXE0@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 09 Feb 2010 15:29:49 -0500 (EST)
In-reply-to: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

Some SDIO cards may suspend while keeping function interrupts active
especially in the powered suspend case.  Upon resume we need to kick
the SDIO interrupt thread to check for pending interrupts and to restart
card IRQ detection at the host controller level.

Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 drivers/mmc/core/sdio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 7d8ba64..5840de1 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -441,6 +441,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	mmc_claim_host(host);
 	err = mmc_sdio_init_card(host, host->ocr, host->card,
 				 (host->pm_flags & MMC_PM_KEEP_POWER));
+	if (!err && host->sdio_irqs)
+		mmc_signal_sdio_irq(host);
 	mmc_release_host(host);
 
 	/*
-- 
1.7.0.rc2.1.g694b5

