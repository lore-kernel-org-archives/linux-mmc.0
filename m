Received: from mail-m1973192.qiye.163.com (mail-m1973192.qiye.163.com [220.197.31.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEA2517B9
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767670727; cv=none; b=bfEOEEFA7T30zUTQpoD6Ofj7BT+3K1J49kYUGtno0FV6hbh2Qw8ds02kb6Gvu3mTQrWAAlLD7KJQnC/40Ej1CPcNJMlOp7LzXv4KCXu7H/0J0sCnkafe59kM93LAl7QfWTbGTZQxV6dq8/1qe8kDqHTvzZBW0jflXlcns20LKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767670727; c=relaxed/simple;
	bh=+bQG9AmjKdxxb36Ddxw7lY58ScRIDW5V4gmH+Ej/Umc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bsgXtnzxKcKSeHwO/n9UtqmmAHm4b4m+ACr59cESIHvjbImR8Yf05AJO1Y1hAVzyj7uOPG8ZauPm1IR90YNbrfl0H09QJeus3vu7xaJqgyMaHFcPCcWLNXlFFI6mRdr/oZp1gIkkOFEsxEPiD5M/1K5zShdzjuaGo+WwJhM2bDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VR2JFPX8; arc=none smtp.client-ip=220.197.31.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VR2JFPX8"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c4aba9;
	Tue, 6 Jan 2026 10:23:03 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 12/18] mmc: dw_mmc: Remove DW_MCI_SEND_STATUS and DW_MCI_RECV_STATUS macros
Date: Tue,  6 Jan 2026 10:17:03 +0800
Message-Id: <1767665829-183001-13-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911d6e6009cckunmc69ba49b79cb3d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh8aQlZMQxgeQk0dGksZGR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VR2JFPX8vZ+q4eT+CdkfJ/uid4eLD+oT2CwVP1g6hmgyppIbEefZKbIiGVSoKMIoUU4NfI4GzYqjb04ZoWrhQjzOmgAQim+dZUvPsf+e83aInv5UW/YeRqKcmRWOM92Z8iel8tOs9bpDHBUYuW5mx0UCjTSuUe1XnD8qGDqIabQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=W1ogu9jVn+W7Esc1qrW0VD96fKAiivGPtyQbCVztHw0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Use MMC_DATA_READ and MMC_DATA_WRITE defined by MMC core instead.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ae22386..00b3e7e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -40,8 +40,6 @@
 				 SDMMC_INT_RESP_ERR | SDMMC_INT_HLE)
 #define DW_MCI_ERROR_FLAGS	(DW_MCI_DATA_ERROR_FLAGS | \
 				 DW_MCI_CMD_ERROR_FLAGS)
-#define DW_MCI_SEND_STATUS	1
-#define DW_MCI_RECV_STATUS	2
 #define DW_MCI_DMA_THRESHOLD	16
 
 #define DW_MCI_FREQ_MAX	200000000	/* unit: HZ */
@@ -1085,9 +1083,9 @@ static void dw_mci_submit_data(struct dw_mci *host, struct mmc_data *data)
 	host->data = data;
 
 	if (data->flags & MMC_DATA_READ)
-		host->dir_status = DW_MCI_RECV_STATUS;
+		host->dir_status = MMC_DATA_READ;
 	else
-		host->dir_status = DW_MCI_SEND_STATUS;
+		host->dir_status = MMC_DATA_WRITE;
 
 	dw_mci_ctrl_thld(host, data);
 
@@ -1853,7 +1851,7 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 			data->error = -EILSEQ;
 		} else if (status & SDMMC_INT_EBE) {
 			if (host->dir_status ==
-				DW_MCI_SEND_STATUS) {
+				MMC_DATA_WRITE) {
 				/*
 				 * No data CRC status was returned.
 				 * The number of bytes transferred
@@ -1862,7 +1860,7 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 				data->bytes_xfered = 0;
 				data->error = -ETIMEDOUT;
 			} else if (host->dir_status ==
-					DW_MCI_RECV_STATUS) {
+					MMC_DATA_READ) {
 				data->error = -EILSEQ;
 			}
 		} else {
@@ -2007,7 +2005,7 @@ static void dw_mci_work_func(struct work_struct *t)
 				 * avoids races and keeps things simple.
 				 */
 				if (err != -ETIMEDOUT &&
-				    host->dir_status == DW_MCI_RECV_STATUS) {
+				    host->dir_status == MMC_DATA_READ) {
 					state = STATE_SENDING_DATA;
 					continue;
 				}
@@ -2051,7 +2049,7 @@ static void dw_mci_work_func(struct work_struct *t)
 				 * If all data-related interrupts don't come
 				 * within the given time in reading data state.
 				 */
-				if (host->dir_status == DW_MCI_RECV_STATUS)
+				if (host->dir_status == MMC_DATA_READ)
 					dw_mci_set_drto(host);
 				break;
 			}
@@ -2091,7 +2089,7 @@ static void dw_mci_work_func(struct work_struct *t)
 				 * interrupt doesn't come within the given time.
 				 * in reading data state.
 				 */
-				if (host->dir_status == DW_MCI_RECV_STATUS)
+				if (host->dir_status == MMC_DATA_READ)
 					dw_mci_set_drto(host);
 				break;
 			}
@@ -2759,7 +2757,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			if (!host->data_status)
 				host->data_status = pending;
 			smp_wmb(); /* drain writebuffer */
-			if (host->dir_status == DW_MCI_RECV_STATUS) {
+			if (host->dir_status == MMC_DATA_READ) {
 				if (host->sg != NULL)
 					dw_mci_read_data_pio(host, true);
 			}
@@ -2771,13 +2769,13 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 
 		if (pending & SDMMC_INT_RXDR) {
 			mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
-			if (host->dir_status == DW_MCI_RECV_STATUS && host->sg)
+			if (host->dir_status == MMC_DATA_READ && host->sg)
 				dw_mci_read_data_pio(host, false);
 		}
 
 		if (pending & SDMMC_INT_TXDR) {
 			mci_writel(host, RINTSTS, SDMMC_INT_TXDR);
-			if (host->dir_status == DW_MCI_SEND_STATUS && host->sg)
+			if (host->dir_status == MMC_DATA_WRITE && host->sg)
 				dw_mci_write_data_pio(host);
 		}
 
-- 
2.7.4

