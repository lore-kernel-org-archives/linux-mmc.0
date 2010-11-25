From: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
Subject: [PATCH] MMC: Fix multiblock SDIO transfers in AT91 MCI
Date: Thu, 25 Nov 2010 12:11:51 +0200
Message-ID: <1290679911-5992-1-git-send-email-yauhen.kharuzhy@promwad.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61118 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab0KYKMZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2010 05:12:25 -0500
Received: by ewy5 with SMTP id 5so344023ewy.19
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2010 02:12:24 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>

The AT91 MCI has special SDIO transfer types: SDIO block and SDIO byte
transfers, but at91_mci driver doesn't use them and handles all SDIO
transfers as ordinary MMC block transfers. This causes problems for
multiple-block SDIO transfers (in particular for 256-bytes blocks).

Fix this situation by check opcode for SDIO CMD53 and set transfer
type in AT91_MCI_CMDR register properly.

This patch was tested with libertas SDIO driver: problem with TX
timeouts on big packets was eliminated.

Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
---
 arch/arm/mach-at91/include/mach/at91_mci.h |    2 ++
 drivers/mmc/host/at91_mci.c                |   13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_mci.h b/arch/arm/mach-at91/include/mach/at91_mci.h
index 57f8ee1..27ac6f5 100644
--- a/arch/arm/mach-at91/include/mach/at91_mci.h
+++ b/arch/arm/mach-at91/include/mach/at91_mci.h
@@ -74,6 +74,8 @@
 #define			AT91_MCI_TRTYP_BLOCK	(0 << 19)
 #define			AT91_MCI_TRTYP_MULTIPLE	(1 << 19)
 #define			AT91_MCI_TRTYP_STREAM	(2 << 19)
+#define			AT91_MCI_TRTYP_SDIO_BYTE	(4 << 19)
+#define			AT91_MCI_TRTYP_SDIO_BLOCK	(5 << 19)
 
 #define AT91_MCI_BLKR		0x18		/* Block Register */
 #define		AT91_MCI_BLKR_BCNT(n)	((0xffff & (n)) << 0)	/* Block count */
diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 591ab54..d3e6a96 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -69,6 +69,7 @@
 #include <linux/highmem.h>
 
 #include <linux/mmc/host.h>
+#include <linux/mmc/sdio.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -493,10 +494,14 @@ static void at91_mci_send_command(struct at91mci_host *host, struct mmc_command
 		else if (data->flags & MMC_DATA_WRITE)
 			cmdr |= AT91_MCI_TRCMD_START;
 
-		if (data->flags & MMC_DATA_STREAM)
-			cmdr |= AT91_MCI_TRTYP_STREAM;
-		if (data->blocks > 1)
-			cmdr |= AT91_MCI_TRTYP_MULTIPLE;
+		if (cmd->opcode == SD_IO_RW_EXTENDED) {
+			cmdr |= AT91_MCI_TRTYP_SDIO_BLOCK;
+		} else {
+			if (data->flags & MMC_DATA_STREAM)
+				cmdr |= AT91_MCI_TRTYP_STREAM;
+			if (data->blocks > 1)
+				cmdr |= AT91_MCI_TRTYP_MULTIPLE;
+		}
 	}
 	else {
 		block_length = 0;
-- 
1.7.2.3

