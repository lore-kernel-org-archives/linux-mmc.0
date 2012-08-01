From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 3/3] mmc: dw_mmc: fix error handling in PIO mode
Date: Wed, 01 Aug 2012 09:30:46 +0900
Message-ID: <006501cd6f7c$e4ca6670$ae5f3350$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52448 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab2HAAav (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jul 2012 20:30:51 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M8100HBQW1N5L80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Aug 2012 09:30:47 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M8100HW1W3A2H90@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Aug 2012 09:30:46 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Data transfer will be continued until all the bytes are transmitted,
even if data crc error occurs during a multiple-block data transfer.
This means RXDR/TXDR interrupts will occurs until data transfer is
terminated. Early setting of host->sg to NULL prevents going into
xxx_data_pio functions, hence permanent unhandled RXDR/TXDR interrupts
occurs. And checking error interrupt status in the xxx_data_pio functions
is no need because dw_mci_interrupt does do the same. This patch also
removes it.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1a5db20..cf8511b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1429,22 +1429,10 @@ static void dw_mci_read_data_pio(struct dw_mci *host)
 			nbytes += len;
 			remain -= len;
 		} while (remain);
-		sg_miter->consumed = offset;
 
+		sg_miter->consumed = offset;
 		status = mci_readl(host, MINTSTS);
 		mci_writel(host, RINTSTS, SDMMC_INT_RXDR);
-		if (status & DW_MCI_DATA_ERROR_FLAGS) {
-			host->data_status = status;
-			data->bytes_xfered += nbytes;
-			sg_miter_stop(sg_miter);
-			host->sg = NULL;
-			smp_wmb();
-
-			set_bit(EVENT_DATA_ERROR, &host->pending_events);
-
-			tasklet_schedule(&host->tasklet);
-			return;
-		}
 	} while (status & SDMMC_INT_RXDR); /*if the RXDR is ready read again*/
 	data->bytes_xfered += nbytes;
 
@@ -1497,23 +1485,10 @@ static void dw_mci_write_data_pio(struct dw_mci *host)
 			nbytes += len;
 			remain -= len;
 		} while (remain);
-		sg_miter->consumed = offset;
 
+		sg_miter->consumed = offset;
 		status = mci_readl(host, MINTSTS);
 		mci_writel(host, RINTSTS, SDMMC_INT_TXDR);
-		if (status & DW_MCI_DATA_ERROR_FLAGS) {
-			host->data_status = status;
-			data->bytes_xfered += nbytes;
-			sg_miter_stop(sg_miter);
-			host->sg = NULL;
-
-			smp_wmb();
-
-			set_bit(EVENT_DATA_ERROR, &host->pending_events);
-
-			tasklet_schedule(&host->tasklet);
-			return;
-		}
 	} while (status & SDMMC_INT_TXDR); /* if TXDR write again */
 	data->bytes_xfered += nbytes;
 
-- 
1.7.0.4


