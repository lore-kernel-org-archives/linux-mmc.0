From: Kyoungil Kim <ki0351.kim@samsung.com>
Subject: [PATCH v3] mmc: dw_mmc: read all data in FIFO after Data transfer over
 interrupt in pio mode
Date: Tue, 22 Jan 2013 16:46:30 +0900
Message-ID: <000401cdf874$97e25620$c7a70260$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:11530 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab3AVHqm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 02:46:42 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MH000MC0O97C2T0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 16:46:31 +0900 (KST)
Received: from DOKI0351KIM04 ([12.23.119.96])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MH000J4TO9JVSL0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Jan 2013 16:46:31 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kyoungil Kim' <ki0351.kim@samsung.com>

In dwc manual, the below contents are described.
"During end of packet, interrupt is not generated if threshold
programming is larger than any remaining data. It is responsibility
of host to read remaining bytes on seeing Data Transfer Done
interrupt"
We also have seen the data cannot be read fully
when "sg_miter->length" is less than FIFO size.

Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 323c502..41d59da 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1430,7 +1430,7 @@ static void dw_mci_pull_data(struct dw_mci *host, void *buf, int cnt)
 	host->pull_data(host, buf, cnt);
 }
 
-static void dw_mci_read_data_pio(struct dw_mci *host)
+static void dw_mci_read_data_pio(struct dw_mci *host, bool dto)
 {
 	struct sg_mapping_iter *sg_miter = &host->sg_miter;
 	void *buf;
@@ -1465,7 +1465,9 @@ static void dw_mci_read_data_pio(struct dw_mci *host)
 		sg_miter->consumed = offset;
 		status = mci_readl(host, MINTSTS);
 		mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
-	} while (status & SDMMC_INT_RXDR); /*if the RXDR is ready read again*/
+	/* if the RXDR is ready read again */
+	} while ((status & SDMMC_INT_RXDR) ||
+			(dto && SDMMC_GET_FCNT(mci_readl(host, STATUS))));
 	data->bytes_xfered += nbytes;
 
 	if (!remain) {
@@ -1597,7 +1599,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 			smp_wmb();
 			if (host->dir_status == DW_MCI_RECV_STATUS) {
 				if (host->sg != NULL)
-					dw_mci_read_data_pio(host);
+					dw_mci_read_data_pio(host, true);
 			}
 			set_bit(EVENT_DATA_COMPLETE, &host->pending_events);
 			tasklet_schedule(&host->tasklet);
@@ -1606,7 +1608,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
 		if (pending & SDMMC_INT_RXDR) {
 			mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
 			if (host->dir_status == DW_MCI_RECV_STATUS && host->sg)
-				dw_mci_read_data_pio(host);
+				dw_mci_read_data_pio(host, false);
 		}
 
 		if (pending & SDMMC_INT_TXDR) {
-- 
1.7.4.1

