From: akpm@linux-foundation.org
Subject: [patch 112/160] mmc: at91_mci: enable large data blocks
Date: Fri, 05 Mar 2010 13:43:42 -0800
Message-ID: <201003052143.o25Lhgkx029844@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48165 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755614Ab0CEVny (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, wolfgang.mues@auerswald.de, avictor.za@gmail.com, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

This patch is setting some max_ variables for the IO elevator, so the
elevator will put requests for large data blocks to the driver.  This is
critical for

a) speed

and

b) wear leveling of the flash chip controller: Otherwise the controller
   will treat the SD card badly with millions of single 4 KByte write
   commands.  This will lead to a shorter life time for the SD cards.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/at91_mci.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/mmc/host/at91_mci.c~mmc-at91_mci-enable-large-data-blocks drivers/mmc/host/at91_mci.c
--- a/drivers/mmc/host/at91_mci.c~mmc-at91_mci-enable-large-data-blocks
+++ a/drivers/mmc/host/at91_mci.c
@@ -934,6 +934,9 @@ static int __init at91_mci_probe(struct 
 	mmc->max_blk_size  = MCI_MAXBLKSIZE;
 	mmc->max_blk_count = MCI_BLKATONCE;
 	mmc->max_req_size  = MCI_BUFSIZE;
+	mmc->max_phys_segs = MCI_BLKATONCE;
+	mmc->max_hw_segs   = MCI_BLKATONCE;
+	mmc->max_seg_size  = MCI_BUFSIZE;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
_
