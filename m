From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: change the macro name from DTO to DRTO
Date: Mon, 27 May 2013 13:47:57 +0900
Message-ID: <51A2E57D.1000902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48371 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3E0Err (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2013 00:47:47 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MNF00MT4XBM07M0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 May 2013 13:47:46 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Will Newton <will.newton@gmail.com>, James Hogan <james.hogan@imgtec.com>

At Interrupt status register, Bit9 is Data Read Timeout.
But we used macro name as the DTO. It could be confused with the Data
Transfer Over(DTO)-Bit[3].
it's clearly that is changed the DRTO instead of DTO.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 drivers/mmc/host/dw_mmc.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b10e5e1..7dca5e9 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -39,7 +39,7 @@
 #include "dw_mmc.h"
 
 /* Common flag combinations */
-#define DW_MCI_DATA_ERROR_FLAGS	(SDMMC_INT_DTO | SDMMC_INT_DCRC | \
+#define DW_MCI_DATA_ERROR_FLAGS	(SDMMC_INT_DRTO | SDMMC_INT_DCRC | \
 				 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
 				 SDMMC_INT_EBE)
 #define DW_MCI_CMD_ERROR_FLAGS	(SDMMC_INT_RTO | SDMMC_INT_RCRC | \
@@ -1093,7 +1093,7 @@ static void dw_mci_tasklet_func(unsigned long priv)
 			status = host->data_status;
 
 			if (status & DW_MCI_DATA_ERROR_FLAGS) {
-				if (status & SDMMC_INT_DTO) {
+				if (status & SDMMC_INT_DRTO) {
 					data->error = -ETIMEDOUT;
 				} else if (status & SDMMC_INT_DCRC) {
 					data->error = -EILSEQ;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 0b74189..2f52c87 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -98,7 +98,7 @@
 #define SDMMC_INT_HLE			BIT(12)
 #define SDMMC_INT_FRUN			BIT(11)
 #define SDMMC_INT_HTO			BIT(10)
-#define SDMMC_INT_DTO			BIT(9)
+#define SDMMC_INT_DRTO			BIT(9)
 #define SDMMC_INT_RTO			BIT(8)
 #define SDMMC_INT_DCRC			BIT(7)
 #define SDMMC_INT_RCRC			BIT(6)
-- 
1.7.9.5
