From: akpm@linux-foundation.org
Subject: [patch 172/196] mmc: davinci: modify data types of EDMA related variables
Date: Mon, 14 Dec 2009 18:01:22 -0800
Message-ID: <200912150201.nBF21Mam022547@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58582 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758650AbZLOCMt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 21:12:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, sudhakar.raj@ti.com, dbrownell@users.sourceforge.net, linux-mmc@vger.kernel.org, purushotam@ti.com, vipin.bhandari@ti.com

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Currently DaVinci EDMA driver supports multiple EDMA channel controller
instances.  edma_alloc_channel() api returns a 32 bit value which has the
channel controller number in MSB and the EDMA channel number in LSB.  The
variables which store the value returned by edma_alloc_channel() have to
be 32 bit wide now.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Acked-by: Vipin Bhandari <vipin.bhandari@ti.com>
Cc: Purshotam Kumar <purushotam@ti.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/davinci_mmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/davinci_mmc.c~davinci-mmc-modify-data-types-of-edma-related-variables drivers/mmc/host/davinci_mmc.c
--- a/drivers/mmc/host/davinci_mmc.c~davinci-mmc-modify-data-types-of-edma-related-variables
+++ a/drivers/mmc/host/davinci_mmc.c
@@ -178,7 +178,7 @@ struct mmc_davinci_host {
 	u32 buffer_bytes_left;
 	u32 bytes_left;
 
-	u8 rxdma, txdma;
+	u32 rxdma, txdma;
 	bool use_dma;
 	bool do_dma;
 
@@ -190,7 +190,7 @@ struct mmc_davinci_host {
 	struct edmacc_param	tx_template;
 	struct edmacc_param	rx_template;
 	unsigned		n_link;
-	u8			links[NR_SG - 1];
+	u32			links[NR_SG - 1];
 
 	/* For PIO we walk scatterlists one segment at a time. */
 	unsigned int		sg_len;
_
