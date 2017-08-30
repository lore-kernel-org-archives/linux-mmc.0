From: Ziyuan <ziyuan.biubiu@gmail.com>
Subject: [PATCH] mmc: dw_mmc: correct outdated comment for use_dma
Date: Wed, 30 Aug 2017 10:58:21 +0800
Message-ID: <1504061901-15857-1-git-send-email-ziyuan.biubiu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:56247 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbdH3C6v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2017 22:58:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, Ziyuan <ziyuan.biubiu@gmail.com>

Since commit 3fc7eaef44db ("mmc: dw_mmc: Add external dma interface
support") use_dma no longer means only the data transfer mode, and
includes dma transmission channel. So make it more clear.

Signed-off-by: Ziyuan <ziyuan.biubiu@gmail.com>
---
 drivers/mmc/host/dw_mmc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 34474ad..e3124f0 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -74,7 +74,8 @@ struct dw_mci_dma_slave {
  * @stop_abort: The command currently prepared for stoping transfer.
  * @prev_blksz: The former transfer blksz record.
  * @timing: Record of current ios timing.
- * @use_dma: Whether DMA channel is initialized or not.
+ * @use_dma: Which DMA channel is in use for the current transfer, zero
+ *	denotes PIO mode.
  * @using_dma: Whether DMA is in use for the current transfer.
  * @dma_64bit_address: Whether DMA supports 64-bit address mode or not.
  * @sg_dma: Bus address of DMA buffer.
-- 
2.7.4


