From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 01/11] mmc: atmel-mci: remove the MMC_DATA_STREAM flag
Date: Mon, 01 Feb 2016 21:07:26 +0900
Message-ID: <1454328456-22918-2-git-send-email-jh80.chung@samsung.com>
References: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46527 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbcBAMHk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 07:07:40 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1V014NTB0PZOB0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 01 Feb 2016 21:07:37 +0900 (KST)
In-reply-to: <1454328456-22918-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sonic.zhang@analog.com, robert.jarzmik@free.fr, andi.shyti@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the MMC_DATA_STREAM flag because it isn't used anymore.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/atmel-mci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 851ccd9..7f9d3de 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -848,9 +848,7 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 		if (cmd->opcode == SD_IO_RW_EXTENDED) {
 			cmdr |= ATMCI_CMDR_SDIO_BLOCK;
 		} else {
-			if (data->flags & MMC_DATA_STREAM)
-				cmdr |= ATMCI_CMDR_STREAM;
-			else if (data->blocks > 1)
+			if (data->blocks > 1)
 				cmdr |= ATMCI_CMDR_MULTI_BLOCK;
 			else
 				cmdr |= ATMCI_CMDR_BLOCK;
@@ -1371,10 +1369,7 @@ static void atmci_start_request(struct atmel_mci *host,
 		host->stop_cmdr |= ATMCI_CMDR_STOP_XFER;
 		if (!(data->flags & MMC_DATA_WRITE))
 			host->stop_cmdr |= ATMCI_CMDR_TRDIR_READ;
-		if (data->flags & MMC_DATA_STREAM)
-			host->stop_cmdr |= ATMCI_CMDR_STREAM;
-		else
-			host->stop_cmdr |= ATMCI_CMDR_MULTI_BLOCK;
+		host->stop_cmdr |= ATMCI_CMDR_MULTI_BLOCK;
 	}
 
 	/*
-- 
1.9.1

