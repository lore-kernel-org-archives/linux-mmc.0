From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] MMC: Fix multiblock SDIO transfers in ATMEL MCI
Date: Fri, 10 Dec 2010 19:14:32 +0100
Message-ID: <1292004872-5122-1-git-send-email-nicolas.ferre@atmel.com>
References: <20101210162351.GA11798@void.printf.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:54483 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754472Ab0LJRGA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Dec 2010 12:06:00 -0500
In-Reply-To: <20101210162351.GA11798@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, yauhen.kharuzhy@promwad.com, Nicolas Ferre <nicolas.ferre@atmel.com>

Based on report made by Yauhen in:
"MMC: Fix multiblock SDIO transfers in AT91 MCI" patch,
I report those changes to the brother driver: atmel-mci.

So, this patch sets SDIO transfer types: SDIO block and SDIO byte
transfers instead of using ordinary MMC block transfers.
It is checking opcode for SDIO CMD53 and setting transfer
type in MCI_CMDR register properly.

Reported-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---

Hi Chris,

In addition to the at91_mci multiblock SDIO fix, I add this little one too as
it concerns the brother driver atmel-mci with same issue.

I hope that you will be able to queue those fixes to .37-final and stable...

Thanks a lot, best regards,

 drivers/mmc/host/atmel-mci.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 301351a..ad2a7a0 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -26,6 +26,7 @@
 #include <linux/stat.h>
 
 #include <linux/mmc/host.h>
+#include <linux/mmc/sdio.h>
 
 #include <mach/atmel-mci.h>
 #include <linux/atmel-mci.h>
@@ -532,12 +533,17 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 	data = cmd->data;
 	if (data) {
 		cmdr |= MCI_CMDR_START_XFER;
-		if (data->flags & MMC_DATA_STREAM)
-			cmdr |= MCI_CMDR_STREAM;
-		else if (data->blocks > 1)
-			cmdr |= MCI_CMDR_MULTI_BLOCK;
-		else
-			cmdr |= MCI_CMDR_BLOCK;
+
+		if (cmd->opcode == SD_IO_RW_EXTENDED) {
+			cmdr |= MCI_CMDR_SDIO_BLOCK;
+		} else {
+			if (data->flags & MMC_DATA_STREAM)
+				cmdr |= MCI_CMDR_STREAM;
+			else if (data->blocks > 1)
+				cmdr |= MCI_CMDR_MULTI_BLOCK;
+			else
+				cmdr |= MCI_CMDR_BLOCK;
+		}
 
 		if (data->flags & MMC_DATA_READ)
 			cmdr |= MCI_CMDR_TRDIR_READ;
-- 
1.7.3

