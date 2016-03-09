From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: dw_mmc: fix warning reported by kernel-doc
Date: Wed,  9 Mar 2016 10:33:55 +0800
Message-ID: <1457490835-18045-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:44924 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbcCICmt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2016 21:42:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

Try to fix the warning reported by:
scripts/kernel-doc -man -v include/linux/mmc/dw_mmc.h > /dev/null

warning: No description found for parameter 'irq_lock'
warning: No description found for parameter 'stop_abort'
warning: No description found for parameter 'prev_blksz'
warning: No description found for parameter 'timing'
warning: No description found for parameter 'ring_size'
warning: No description found for parameter 'dms'
warning: No description found for parameter 'phy_regs'
warning: No description found for parameter 'fifoth_val'
warning: No description found for parameter 'vqmmc_enabled'
warning: No description found for parameter 'cmd11_timer'
warning: Excess struct/union/enum/typedef member 'card_tasklet'
description in 'dw_mci'

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 include/linux/mmc/dw_mmc.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 7b41c6d..c8b6a4d 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -55,6 +55,7 @@ struct dw_mci_dma_slave {
 /**
  * struct dw_mci - MMC controller state shared between all slots
  * @lock: Spinlock protecting the queue and associated data.
+ * @irq_lock: Spinlock protecting the INTMASK setting.
  * @regs: Pointer to MMIO registers.
  * @fifo_reg: Pointer to MMIO registers for data FIFO
  * @sg: Scatterlist entry currently being processed by PIO code, if any.
@@ -65,6 +66,9 @@ struct dw_mci_dma_slave {
  * @cmd: The command currently being sent to the card, or NULL.
  * @data: The data currently being transferred, or NULL if no data
  *	transfer is in progress.
+ * @stop_abort: The command currently prepared for stoping transfer.
+ * @prev_blksz: The former transfer blksz record.
+ * @timing: Record of current ios timing.
  * @use_dma: Whether DMA channel is initialized or not.
  * @using_dma: Whether DMA is in use for the current transfer.
  * @dma_64bit_address: Whether DMA supports 64-bit address mode or not.
@@ -72,7 +76,10 @@ struct dw_mci_dma_slave {
  * @sg_cpu: Virtual address of DMA buffer.
  * @dma_ops: Pointer to platform-specific DMA callbacks.
  * @cmd_status: Snapshot of SR taken upon completion of the current
+ * @ring_size: Buffer size for idma descriptors.
  *	command. Only valid when EVENT_CMD_COMPLETE is pending.
+ * @dms: structure of slave-dma private data.
+ * @phy_regs: physical address of controller's register map
  * @data_status: Snapshot of SR taken upon completion of the current
  *	data transfer. Only valid when EVENT_DATA_COMPLETE or
  *	EVENT_DATA_ERROR is pending.
@@ -80,7 +87,6 @@ struct dw_mci_dma_slave {
  *	to be sent.
  * @dir_status: Direction of current transfer.
  * @tasklet: Tasklet running the request state machine.
- * @card_tasklet: Tasklet handling card detect.
  * @pending_events: Bitmask of events flagged by the interrupt handler
  *	to be processed by the tasklet.
  * @completed_events: Bitmask of events which the state machine has
@@ -91,6 +97,7 @@ struct dw_mci_dma_slave {
  *	rate and timeout calculations.
  * @current_speed: Configured rate of the controller.
  * @num_slots: Number of slots available.
+ * @fifoth_val: The value of FIFOTH register.
  * @verid: Denote Version ID.
  * @dev: Device associated with the MMC controller.
  * @pdata: Platform data associated with the MMC controller.
@@ -107,9 +114,11 @@ struct dw_mci_dma_slave {
  * @push_data: Pointer to FIFO push function.
  * @pull_data: Pointer to FIFO pull function.
  * @quirks: Set of quirks that apply to specific versions of the IP.
+ * @vqmmc_enabled: Status of vqmmc, should be true or false.
  * @irq_flags: The flags to be passed to request_irq.
  * @irq: The irq value to be passed to request_irq.
  * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
+ * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
  * @dto_timer: Timer for broken data transfer over scheme.
  *
  * Locking
-- 
2.3.7


