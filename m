From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/21] mmc: dw_mmc: Remove the public dw_mmc header file
Date: Fri, 30 Dec 2016 13:47:20 +0100
Message-ID: <1483102054-1752-8-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35642 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753687AbcL3MsJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:09 -0500
Received: by mail-lf0-f54.google.com with SMTP id b14so236437218lfg.2
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:08 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

There are currently no external users of the public dw_mmc header file,
except the dw_mmc driver itself. Therefore let's move the definitions from
the public dw_mmc header file into the existing private dw_mmc header file
and then remove the public one.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS                        |   1 -
 drivers/mmc/host/dw_mmc-exynos.c   |   1 -
 drivers/mmc/host/dw_mmc-k3.c       |   1 -
 drivers/mmc/host/dw_mmc-pci.c      |   1 -
 drivers/mmc/host/dw_mmc-pltfm.c    |   1 -
 drivers/mmc/host/dw_mmc-rockchip.c |   1 -
 drivers/mmc/host/dw_mmc.c          |   1 -
 drivers/mmc/host/dw_mmc.h          | 257 ++++++++++++++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h         | 274 -------------------------------------
 9 files changed, 257 insertions(+), 281 deletions(-)
 delete mode 100644 include/linux/mmc/dw_mmc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9..b09febe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10862,7 +10862,6 @@ SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
 M:	Jaehoon Chung <jh80.chung@samsung.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
-F:	include/linux/mmc/dw_mmc.h
 F:	drivers/mmc/host/dw_mmc*
 
 SYSTEM TRACE MODULE CLASS
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index e133528..25691cc 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/dw_mmc.h>
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 9821e6b..e38fb00 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -11,7 +11,6 @@
 #include <linux/clk.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/dw_mmc.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index ab82796..ab87132 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
-#include <linux/mmc/dw_mmc.h>
 #include "dw_mmc.h"
 
 #define PCI_BAR_NO 2
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 1236d49b..58c13e2 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -20,7 +20,6 @@
 #include <linux/slab.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
-#include <linux/mmc/dw_mmc.h>
 #include <linux/of.h>
 #include <linux/clk.h>
 
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 9a46e46..372fb6e 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -11,7 +11,6 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/mmc/host.h>
-#include <linux/mmc/dw_mmc.h>
 #include <linux/of_address.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b44306b..c2242cd 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -32,7 +32,6 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
 #include <linux/mmc/sdio.h>
-#include <linux/mmc/dw_mmc.h>
 #include <linux/bitops.h>
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index c594658..9601461 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -14,6 +14,263 @@
 #ifndef _DW_MMC_H_
 #define _DW_MMC_H_
 
+#include <linux/scatterlist.h>
+#include <linux/mmc/core.h>
+#include <linux/dmaengine.h>
+#include <linux/reset.h>
+
+#define MAX_MCI_SLOTS	2
+
+enum dw_mci_state {
+	STATE_IDLE = 0,
+	STATE_SENDING_CMD,
+	STATE_SENDING_DATA,
+	STATE_DATA_BUSY,
+	STATE_SENDING_STOP,
+	STATE_DATA_ERROR,
+	STATE_SENDING_CMD11,
+	STATE_WAITING_CMD11_DONE,
+};
+
+enum {
+	EVENT_CMD_COMPLETE = 0,
+	EVENT_XFER_COMPLETE,
+	EVENT_DATA_COMPLETE,
+	EVENT_DATA_ERROR,
+};
+
+enum dw_mci_cookie {
+	COOKIE_UNMAPPED,
+	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of dwmmc */
+	COOKIE_MAPPED,		/* mapped by prepare_data() of dwmmc */
+};
+
+struct mmc_data;
+
+enum {
+	TRANS_MODE_PIO = 0,
+	TRANS_MODE_IDMAC,
+	TRANS_MODE_EDMAC
+};
+
+struct dw_mci_dma_slave {
+	struct dma_chan *ch;
+	enum dma_transfer_direction direction;
+};
+
+/**
+ * struct dw_mci - MMC controller state shared between all slots
+ * @lock: Spinlock protecting the queue and associated data.
+ * @irq_lock: Spinlock protecting the INTMASK setting.
+ * @regs: Pointer to MMIO registers.
+ * @fifo_reg: Pointer to MMIO registers for data FIFO
+ * @sg: Scatterlist entry currently being processed by PIO code, if any.
+ * @sg_miter: PIO mapping scatterlist iterator.
+ * @cur_slot: The slot which is currently using the controller.
+ * @mrq: The request currently being processed on @cur_slot,
+ *	or NULL if the controller is idle.
+ * @cmd: The command currently being sent to the card, or NULL.
+ * @data: The data currently being transferred, or NULL if no data
+ *	transfer is in progress.
+ * @stop_abort: The command currently prepared for stoping transfer.
+ * @prev_blksz: The former transfer blksz record.
+ * @timing: Record of current ios timing.
+ * @use_dma: Whether DMA channel is initialized or not.
+ * @using_dma: Whether DMA is in use for the current transfer.
+ * @dma_64bit_address: Whether DMA supports 64-bit address mode or not.
+ * @sg_dma: Bus address of DMA buffer.
+ * @sg_cpu: Virtual address of DMA buffer.
+ * @dma_ops: Pointer to platform-specific DMA callbacks.
+ * @cmd_status: Snapshot of SR taken upon completion of the current
+ * @ring_size: Buffer size for idma descriptors.
+ *	command. Only valid when EVENT_CMD_COMPLETE is pending.
+ * @dms: structure of slave-dma private data.
+ * @phy_regs: physical address of controller's register map
+ * @data_status: Snapshot of SR taken upon completion of the current
+ *	data transfer. Only valid when EVENT_DATA_COMPLETE or
+ *	EVENT_DATA_ERROR is pending.
+ * @stop_cmdr: Value to be loaded into CMDR when the stop command is
+ *	to be sent.
+ * @dir_status: Direction of current transfer.
+ * @tasklet: Tasklet running the request state machine.
+ * @pending_events: Bitmask of events flagged by the interrupt handler
+ *	to be processed by the tasklet.
+ * @completed_events: Bitmask of events which the state machine has
+ *	processed.
+ * @state: Tasklet state.
+ * @queue: List of slots waiting for access to the controller.
+ * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
+ *	rate and timeout calculations.
+ * @current_speed: Configured rate of the controller.
+ * @num_slots: Number of slots available.
+ * @fifoth_val: The value of FIFOTH register.
+ * @verid: Denote Version ID.
+ * @dev: Device associated with the MMC controller.
+ * @pdata: Platform data associated with the MMC controller.
+ * @drv_data: Driver specific data for identified variant of the controller
+ * @priv: Implementation defined private data.
+ * @biu_clk: Pointer to bus interface unit clock instance.
+ * @ciu_clk: Pointer to card interface unit clock instance.
+ * @slot: Slots sharing this MMC controller.
+ * @fifo_depth: depth of FIFO.
+ * @data_shift: log2 of FIFO item size.
+ * @part_buf_start: Start index in part_buf.
+ * @part_buf_count: Bytes of partial data in part_buf.
+ * @part_buf: Simple buffer for partial fifo reads/writes.
+ * @push_data: Pointer to FIFO push function.
+ * @pull_data: Pointer to FIFO pull function.
+ * @vqmmc_enabled: Status of vqmmc, should be true or false.
+ * @irq_flags: The flags to be passed to request_irq.
+ * @irq: The irq value to be passed to request_irq.
+ * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
+ * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
+ * @dto_timer: Timer for broken data transfer over scheme.
+ *
+ * Locking
+ * =======
+ *
+ * @lock is a softirq-safe spinlock protecting @queue as well as
+ * @cur_slot, @mrq and @state. These must always be updated
+ * at the same time while holding @lock.
+ *
+ * @irq_lock is an irq-safe spinlock protecting the INTMASK register
+ * to allow the interrupt handler to modify it directly.  Held for only long
+ * enough to read-modify-write INTMASK and no other locks are grabbed when
+ * holding this one.
+ *
+ * The @mrq field of struct dw_mci_slot is also protected by @lock,
+ * and must always be written at the same time as the slot is added to
+ * @queue.
+ *
+ * @pending_events and @completed_events are accessed using atomic bit
+ * operations, so they don't need any locking.
+ *
+ * None of the fields touched by the interrupt handler need any
+ * locking. However, ordering is important: Before EVENT_DATA_ERROR or
+ * EVENT_DATA_COMPLETE is set in @pending_events, all data-related
+ * interrupts must be disabled and @data_status updated with a
+ * snapshot of SR. Similarly, before EVENT_CMD_COMPLETE is set, the
+ * CMDRDY interrupt must be disabled and @cmd_status updated with a
+ * snapshot of SR, and before EVENT_XFER_COMPLETE can be set, the
+ * bytes_xfered field of @data must be written. This is ensured by
+ * using barriers.
+ */
+struct dw_mci {
+	spinlock_t		lock;
+	spinlock_t		irq_lock;
+	void __iomem		*regs;
+	void __iomem		*fifo_reg;
+
+	struct scatterlist	*sg;
+	struct sg_mapping_iter	sg_miter;
+
+	struct dw_mci_slot	*cur_slot;
+	struct mmc_request	*mrq;
+	struct mmc_command	*cmd;
+	struct mmc_data		*data;
+	struct mmc_command	stop_abort;
+	unsigned int		prev_blksz;
+	unsigned char		timing;
+
+	/* DMA interface members*/
+	int			use_dma;
+	int			using_dma;
+	int			dma_64bit_address;
+
+	dma_addr_t		sg_dma;
+	void			*sg_cpu;
+	const struct dw_mci_dma_ops	*dma_ops;
+	/* For idmac */
+	unsigned int		ring_size;
+
+	/* For edmac */
+	struct dw_mci_dma_slave *dms;
+	/* Registers's physical base address */
+	resource_size_t		phy_regs;
+
+	u32			cmd_status;
+	u32			data_status;
+	u32			stop_cmdr;
+	u32			dir_status;
+	struct tasklet_struct	tasklet;
+	unsigned long		pending_events;
+	unsigned long		completed_events;
+	enum dw_mci_state	state;
+	struct list_head	queue;
+
+	u32			bus_hz;
+	u32			current_speed;
+	u32			num_slots;
+	u32			fifoth_val;
+	u16			verid;
+	struct device		*dev;
+	struct dw_mci_board	*pdata;
+	const struct dw_mci_drv_data	*drv_data;
+	void			*priv;
+	struct clk		*biu_clk;
+	struct clk		*ciu_clk;
+	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
+
+	/* FIFO push and pull */
+	int			fifo_depth;
+	int			data_shift;
+	u8			part_buf_start;
+	u8			part_buf_count;
+	union {
+		u16		part_buf16;
+		u32		part_buf32;
+		u64		part_buf;
+	};
+	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
+	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
+
+	bool			vqmmc_enabled;
+	unsigned long		irq_flags; /* IRQ flags */
+	int			irq;
+
+	int			sdio_id0;
+
+	struct timer_list       cmd11_timer;
+	struct timer_list       dto_timer;
+};
+
+/* DMA ops for Internal/External DMAC interface */
+struct dw_mci_dma_ops {
+	/* DMA Ops */
+	int (*init)(struct dw_mci *host);
+	int (*start)(struct dw_mci *host, unsigned int sg_len);
+	void (*complete)(void *host);
+	void (*stop)(struct dw_mci *host);
+	void (*cleanup)(struct dw_mci *host);
+	void (*exit)(struct dw_mci *host);
+};
+
+struct dma_pdata;
+
+/* Board platform data */
+struct dw_mci_board {
+	u32 num_slots;
+
+	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
+
+	u32 caps;	/* Capabilities */
+	u32 caps2;	/* More capabilities */
+	u32 pm_caps;	/* PM capabilities */
+	/*
+	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
+	 * but note that this may not be reliable after a bootloader has used
+	 * it.
+	 */
+	unsigned int fifo_depth;
+
+	/* delay in mS before detecting cards after interrupt */
+	u32 detect_delay_ms;
+
+	struct reset_control *rstc;
+	struct dw_mci_dma_ops *dma_ops;
+	struct dma_pdata *data;
+};
+
 #define DW_MMC_240A		0x240a
 #define DW_MMC_280A		0x280a
 
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
deleted file mode 100644
index 15db6f8..0000000
--- a/include/linux/mmc/dw_mmc.h
+++ /dev/null
@@ -1,274 +0,0 @@
-/*
- * Synopsys DesignWare Multimedia Card Interface driver
- *  (Based on NXP driver for lpc 31xx)
- *
- * Copyright (C) 2009 NXP Semiconductors
- * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef LINUX_MMC_DW_MMC_H
-#define LINUX_MMC_DW_MMC_H
-
-#include <linux/scatterlist.h>
-#include <linux/mmc/core.h>
-#include <linux/dmaengine.h>
-#include <linux/reset.h>
-
-#define MAX_MCI_SLOTS	2
-
-enum dw_mci_state {
-	STATE_IDLE = 0,
-	STATE_SENDING_CMD,
-	STATE_SENDING_DATA,
-	STATE_DATA_BUSY,
-	STATE_SENDING_STOP,
-	STATE_DATA_ERROR,
-	STATE_SENDING_CMD11,
-	STATE_WAITING_CMD11_DONE,
-};
-
-enum {
-	EVENT_CMD_COMPLETE = 0,
-	EVENT_XFER_COMPLETE,
-	EVENT_DATA_COMPLETE,
-	EVENT_DATA_ERROR,
-};
-
-enum dw_mci_cookie {
-	COOKIE_UNMAPPED,
-	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of dwmmc */
-	COOKIE_MAPPED,		/* mapped by prepare_data() of dwmmc */
-};
-
-struct mmc_data;
-
-enum {
-	TRANS_MODE_PIO = 0,
-	TRANS_MODE_IDMAC,
-	TRANS_MODE_EDMAC
-};
-
-struct dw_mci_dma_slave {
-	struct dma_chan *ch;
-	enum dma_transfer_direction direction;
-};
-
-/**
- * struct dw_mci - MMC controller state shared between all slots
- * @lock: Spinlock protecting the queue and associated data.
- * @irq_lock: Spinlock protecting the INTMASK setting.
- * @regs: Pointer to MMIO registers.
- * @fifo_reg: Pointer to MMIO registers for data FIFO
- * @sg: Scatterlist entry currently being processed by PIO code, if any.
- * @sg_miter: PIO mapping scatterlist iterator.
- * @cur_slot: The slot which is currently using the controller.
- * @mrq: The request currently being processed on @cur_slot,
- *	or NULL if the controller is idle.
- * @cmd: The command currently being sent to the card, or NULL.
- * @data: The data currently being transferred, or NULL if no data
- *	transfer is in progress.
- * @stop_abort: The command currently prepared for stoping transfer.
- * @prev_blksz: The former transfer blksz record.
- * @timing: Record of current ios timing.
- * @use_dma: Whether DMA channel is initialized or not.
- * @using_dma: Whether DMA is in use for the current transfer.
- * @dma_64bit_address: Whether DMA supports 64-bit address mode or not.
- * @sg_dma: Bus address of DMA buffer.
- * @sg_cpu: Virtual address of DMA buffer.
- * @dma_ops: Pointer to platform-specific DMA callbacks.
- * @cmd_status: Snapshot of SR taken upon completion of the current
- * @ring_size: Buffer size for idma descriptors.
- *	command. Only valid when EVENT_CMD_COMPLETE is pending.
- * @dms: structure of slave-dma private data.
- * @phy_regs: physical address of controller's register map
- * @data_status: Snapshot of SR taken upon completion of the current
- *	data transfer. Only valid when EVENT_DATA_COMPLETE or
- *	EVENT_DATA_ERROR is pending.
- * @stop_cmdr: Value to be loaded into CMDR when the stop command is
- *	to be sent.
- * @dir_status: Direction of current transfer.
- * @tasklet: Tasklet running the request state machine.
- * @pending_events: Bitmask of events flagged by the interrupt handler
- *	to be processed by the tasklet.
- * @completed_events: Bitmask of events which the state machine has
- *	processed.
- * @state: Tasklet state.
- * @queue: List of slots waiting for access to the controller.
- * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
- *	rate and timeout calculations.
- * @current_speed: Configured rate of the controller.
- * @num_slots: Number of slots available.
- * @fifoth_val: The value of FIFOTH register.
- * @verid: Denote Version ID.
- * @dev: Device associated with the MMC controller.
- * @pdata: Platform data associated with the MMC controller.
- * @drv_data: Driver specific data for identified variant of the controller
- * @priv: Implementation defined private data.
- * @biu_clk: Pointer to bus interface unit clock instance.
- * @ciu_clk: Pointer to card interface unit clock instance.
- * @slot: Slots sharing this MMC controller.
- * @fifo_depth: depth of FIFO.
- * @data_shift: log2 of FIFO item size.
- * @part_buf_start: Start index in part_buf.
- * @part_buf_count: Bytes of partial data in part_buf.
- * @part_buf: Simple buffer for partial fifo reads/writes.
- * @push_data: Pointer to FIFO push function.
- * @pull_data: Pointer to FIFO pull function.
- * @vqmmc_enabled: Status of vqmmc, should be true or false.
- * @irq_flags: The flags to be passed to request_irq.
- * @irq: The irq value to be passed to request_irq.
- * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
- * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
- * @dto_timer: Timer for broken data transfer over scheme.
- *
- * Locking
- * =======
- *
- * @lock is a softirq-safe spinlock protecting @queue as well as
- * @cur_slot, @mrq and @state. These must always be updated
- * at the same time while holding @lock.
- *
- * @irq_lock is an irq-safe spinlock protecting the INTMASK register
- * to allow the interrupt handler to modify it directly.  Held for only long
- * enough to read-modify-write INTMASK and no other locks are grabbed when
- * holding this one.
- *
- * The @mrq field of struct dw_mci_slot is also protected by @lock,
- * and must always be written at the same time as the slot is added to
- * @queue.
- *
- * @pending_events and @completed_events are accessed using atomic bit
- * operations, so they don't need any locking.
- *
- * None of the fields touched by the interrupt handler need any
- * locking. However, ordering is important: Before EVENT_DATA_ERROR or
- * EVENT_DATA_COMPLETE is set in @pending_events, all data-related
- * interrupts must be disabled and @data_status updated with a
- * snapshot of SR. Similarly, before EVENT_CMD_COMPLETE is set, the
- * CMDRDY interrupt must be disabled and @cmd_status updated with a
- * snapshot of SR, and before EVENT_XFER_COMPLETE can be set, the
- * bytes_xfered field of @data must be written. This is ensured by
- * using barriers.
- */
-struct dw_mci {
-	spinlock_t		lock;
-	spinlock_t		irq_lock;
-	void __iomem		*regs;
-	void __iomem		*fifo_reg;
-
-	struct scatterlist	*sg;
-	struct sg_mapping_iter	sg_miter;
-
-	struct dw_mci_slot	*cur_slot;
-	struct mmc_request	*mrq;
-	struct mmc_command	*cmd;
-	struct mmc_data		*data;
-	struct mmc_command	stop_abort;
-	unsigned int		prev_blksz;
-	unsigned char		timing;
-
-	/* DMA interface members*/
-	int			use_dma;
-	int			using_dma;
-	int			dma_64bit_address;
-
-	dma_addr_t		sg_dma;
-	void			*sg_cpu;
-	const struct dw_mci_dma_ops	*dma_ops;
-	/* For idmac */
-	unsigned int		ring_size;
-
-	/* For edmac */
-	struct dw_mci_dma_slave *dms;
-	/* Registers's physical base address */
-	resource_size_t		phy_regs;
-
-	u32			cmd_status;
-	u32			data_status;
-	u32			stop_cmdr;
-	u32			dir_status;
-	struct tasklet_struct	tasklet;
-	unsigned long		pending_events;
-	unsigned long		completed_events;
-	enum dw_mci_state	state;
-	struct list_head	queue;
-
-	u32			bus_hz;
-	u32			current_speed;
-	u32			num_slots;
-	u32			fifoth_val;
-	u16			verid;
-	struct device		*dev;
-	struct dw_mci_board	*pdata;
-	const struct dw_mci_drv_data	*drv_data;
-	void			*priv;
-	struct clk		*biu_clk;
-	struct clk		*ciu_clk;
-	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
-
-	/* FIFO push and pull */
-	int			fifo_depth;
-	int			data_shift;
-	u8			part_buf_start;
-	u8			part_buf_count;
-	union {
-		u16		part_buf16;
-		u32		part_buf32;
-		u64		part_buf;
-	};
-	void (*push_data)(struct dw_mci *host, void *buf, int cnt);
-	void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
-
-	bool			vqmmc_enabled;
-	unsigned long		irq_flags; /* IRQ flags */
-	int			irq;
-
-	int			sdio_id0;
-
-	struct timer_list       cmd11_timer;
-	struct timer_list       dto_timer;
-};
-
-/* DMA ops for Internal/External DMAC interface */
-struct dw_mci_dma_ops {
-	/* DMA Ops */
-	int (*init)(struct dw_mci *host);
-	int (*start)(struct dw_mci *host, unsigned int sg_len);
-	void (*complete)(void *host);
-	void (*stop)(struct dw_mci *host);
-	void (*cleanup)(struct dw_mci *host);
-	void (*exit)(struct dw_mci *host);
-};
-
-struct dma_pdata;
-
-/* Board platform data */
-struct dw_mci_board {
-	u32 num_slots;
-
-	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
-
-	u32 caps;	/* Capabilities */
-	u32 caps2;	/* More capabilities */
-	u32 pm_caps;	/* PM capabilities */
-	/*
-	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
-	 * but note that this may not be reliable after a bootloader has used
-	 * it.
-	 */
-	unsigned int fifo_depth;
-
-	/* delay in mS before detecting cards after interrupt */
-	u32 detect_delay_ms;
-
-	struct reset_control *rstc;
-	struct dw_mci_dma_ops *dma_ops;
-	struct dma_pdata *data;
-};
-
-#endif /* LINUX_MMC_DW_MMC_H */
-- 
1.9.1

