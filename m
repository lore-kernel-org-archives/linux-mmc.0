From: akpm@linux-foundation.org
Subject: [patch 06/17] mmc: atmel-mci: remove data error interrupt after xfer
Date: Tue, 11 May 2010 14:06:50 -0700
Message-ID: <201005112106.o4BL6orD023081@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40720 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750796Ab0EKVG4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2010 17:06:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, hskinnemoen@atmel.com, linux-mmc@vger.kernel.org, stable@kernel.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Disable data error interrupts while we are actually recording that there
is not such errors.  This will prevent, in some cases, the warning message
printed at new request queuing (in atmci_start_request()).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/atmel-mci.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-remove-data-error-interrupt-after-xfer drivers/mmc/host/atmel-mci.c
--- a/drivers/mmc/host/atmel-mci.c~mmc-atmel-mci-remove-data-error-interrupt-after-xfer
+++ a/drivers/mmc/host/atmel-mci.c
@@ -1294,6 +1294,7 @@ static void atmci_tasklet_func(unsigned 
 			} else {
 				data->bytes_xfered = data->blocks * data->blksz;
 				data->error = 0;
+				mci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS);
 			}
 
 			if (!data->stop) {
_
