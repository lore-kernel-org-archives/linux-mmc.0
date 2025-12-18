Received: from mail-m19731116.qiye.163.com (mail-m19731116.qiye.163.com [220.197.31.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF5B33A9F5
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066743; cv=none; b=SM6UioeRoS4XhhEPMYOJB3jQT1JLQqdifGK6cnCX02pUgOZp6CXN86av/trC6FbtE8G2jk6cXq+uuwVZ4pVHVSy0S7L9ZNIrKd1/if6Mkx6P3D6nh5RQO2Q0h1TaChkAZk2GMIY1I5q19AuuYkaLJO6/Nzcp/i0pBsiMr45k0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066743; c=relaxed/simple;
	bh=wDAcOnDYxE1QhpKCtBvrMWBrr7U6UW4cjE29+91eDWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Q2dEc1JdI7n+2Qs5ER/9IOVe/PCJYpt2rdue1p4NaCwZr4rlTQbPK+N5w3WKLnHWHiKNNKuqaAjMft1KOECFlXTdNLqvOofgfPsbTwjNE4VXkdD6IApy/scMF+xc+mtbqu4F2ffXHZ3eALX3sZ5Aa53Idn4ziHzAY0uhz36WWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=co7/fIw3; arc=none smtp.client-ip=220.197.31.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="co7/fIw3"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb41a;
	Thu, 18 Dec 2025 22:05:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 12/18] mmc: dw_mmc: Remove DW_MCI_SEND_STATUS and DW_MCI_RECV_STATUS macros
Date: Thu, 18 Dec 2025 22:00:39 +0800
Message-Id: <1766066445-14144-13-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c7b2a809cckunm1f354c4b76df
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4fTFZLQkhOHxgdH0pNGEtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=co7/fIw3NGFVD6nryFSIvwqf8BT78/Ok417gx6Qal/y1MJaNsxDFtsnqSyCyX0z9V0XnnPVwygCPSIBqcV3kCj+N9lzxjU2/0FiGiv3o7GYEcd3R4LNp8jHIH3i407QdnnTyl9cG+Zj/y8EptWOme5yPF810ATWtrRMBuFG3ErU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=59PNBbeMhdY9fmNQh/XVN9wXLB/Uwsn4xRlh+OhC01c=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Use MMC_DATA_READ and MMC_DATA_WRITE defined by MMC core instead.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 03aed41..db21f36 100644
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

