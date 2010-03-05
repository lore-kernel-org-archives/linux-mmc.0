From: akpm@linux-foundation.org
Subject: [patch 113/160] mmc: at91_mci: Enable MMC_CAP_SDIO_IRQ only when it actually works.
Date: Fri, 05 Mar 2010 13:43:43 -0800
Message-ID: <201003052143.o25LhhWP029850@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53923 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755607Ab0CEVnw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, avictor.za@gmail.com, linux-mmc@vger.kernel.org, wolfgang.mues@auerswald.de

From: Nicolas Ferre <nicolas.ferre@atmel.com>

According to the datasheets AT91SAM9261 does not support SDIO interrupts,
and AT91SAM9260/9263 have an erratum requiring 4bit mode while using slot
B for the interrupt to work.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Wolfgang Muees <wolfgang.mues@auerswald.de>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/at91_mci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/host/at91_mci.c~mmc-at91_mci-enable-mmc_cap_sdio_irq-only-when-it-actually-works drivers/mmc/host/at91_mci.c
--- a/drivers/mmc/host/at91_mci.c~mmc-at91_mci-enable-mmc_cap_sdio_irq-only-when-it-actually-works
+++ a/drivers/mmc/host/at91_mci.c
@@ -929,7 +929,7 @@ static int __init at91_mci_probe(struct 
 	mmc->f_min = 375000;
 	mmc->f_max = 25000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	mmc->caps = MMC_CAP_SDIO_IRQ;
+	mmc->caps = 0;
 
 	mmc->max_blk_size  = MCI_MAXBLKSIZE;
 	mmc->max_blk_count = MCI_BLKATONCE;
@@ -958,6 +958,13 @@ static int __init at91_mci_probe(struct 
 		goto fail5;
 	}
 
+	/* Add SDIO capability when available */
+	if (cpu_is_at91sam9260() || cpu_is_at91sam9263()) {
+		/* AT91SAM9260/9263 erratum */
+		if (host->board->wire4 || !host->board->slot_b)
+			mmc->caps |= MMC_CAP_SDIO_IRQ;
+	}
+
 	/*
 	 * Reserve GPIOs ... board init code makes sure these pins are set
 	 * up as GPIOs with the right direction (input, except for vcc)
_
