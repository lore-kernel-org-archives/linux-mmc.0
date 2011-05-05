From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 01/22] OMAP: sDMA: descriptor autoloading feature
Date: Thu,  5 May 2011 14:51:01 +0300
Message-ID: <1304596282-4095-2-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:46964 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab1EELv4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:51:56 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Venkatraman S <svenkatr@ti.com>, Shilimkar Santosh <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Venkatraman S <svenkatr@ti.com>

Add sDMA driver support for descriptor autoloading feature.
 Descriptor autoloading is OMAP sDMA v5 hardware capability that can be exploited for scatter gather
 scenarios, currently available in OMAP3630 and OMAP4430.

  The feature works as described below.
  1) A sDMA channel is programmed to be in 'linked list' mode.
  2) The client (sDMA user) provides a list of descriptors in a linked list format.
  3) Each of the 'descriptor' (element in the linked list) contains an updated set of DMA
  configuration register values.
  4) Client starts DMA transfer.
  5) sDMA controller loads the first element to its register configuration memory and executes the
  transfer.
  6) After completion, loads the next element (in linked list) to configuration memory and executes
  the transfer, without MCU intervention.
  7) Interrupt is generated after all transfers are completed; this can be configured to be done
  differently.

  Configurations and additional features
  1) Fast mode & non-fast mode
        Fast mode/non-fast decides on how the first transfer begins. In non-fast mode, the first
	element in the linked list is loaded only after completing the transfer according to the
	configurations already in the sDMA channel registers. In fast mode, the loading of the first
	element precedes the transfer.

  2) Pause / resume of transfers
	A transfer can be paused after a descriptor set has been loaded, provided the 'pause
	bit' is set in the linked list element.
	An ongoing transfer cannot be paused. If the 'pause bit' is set, transfer is not
	started after loading the register set from memory.
	Such a transfer can be resumed later.

  3) Descriptor types
	3 possible configurations of descriptors (initialized as linked list elements)
	are possible. Type 1 provides the maximum flexibility, which contains most
	register definitions of a DMA logical channel. Fewer options are present in type
	2. Type 3 can just modify source/destinations address of transfers. In all
	transfers, unmodified registers settings are maintained for the next transfer.

	Patch provides options / API for
	    1) Setting up a descriptor loading for DMA channel for sg type transfers
	    2) configuration with linked list elements
	    3) Starting / pause and resume of the said transfers, query state
	    4) Clearing the sglist mode

Signed-off-by: Venkatraman S <svenkatr@ti.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/plat-omap/dma.c              |  279 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h |  173 ++++++++++++++++++++
 2 files changed, 452 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index c22217c..7f64366 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -52,16 +52,37 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
 enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #endif
 
+/* CDP Register bitmaps */
+#define DMA_LIST_CDP_DST_VALID	BIT(0)
+#define DMA_LIST_CDP_SRC_VALID	BIT(2)
+#define DMA_LIST_CDP_TYPE1	BIT(4)
+#define DMA_LIST_CDP_TYPE2	BIT(5)
+#define DMA_LIST_CDP_TYPE3	(BIT(4) | BIT(5))
+#define DMA_LIST_CDP_PAUSEMODE	BIT(7)
+#define DMA_LIST_CDP_LISTMODE	BIT(8)
+#define DMA_LIST_CDP_FASTMODE	BIT(10)
+/* CAPS register bitmaps */
+#define DMA_CAPS_SGLIST_SUPPORT	BIT(20)
+
+#define DMA_LIST_DESC_PAUSE	BIT(0)
+#define DMA_LIST_DESC_SRC_VALID	BIT(24)
+#define DMA_LIST_DESC_DST_VALID	BIT(26)
+#define DMA_LIST_DESC_BLK_END	BIT(28)
+
 #define OMAP_DMA_ACTIVE			0x01
 #define OMAP2_DMA_CSR_CLEAR_MASK	0xffffffff
 
 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
+#define OMAP_DMA_INVALID_FRAME_COUNT	0xffff
+#define OMAP_DMA_INVALID_ELEM_COUNT	0xffffff
+#define OMAP_DMA_INVALID_DESCRIPTOR_POINTER	0xfffffffc
 
 static struct omap_system_dma_plat_info *p;
 static struct omap_dma_dev_attr *d;
 
 static int enable_1510_mode;
 static u32 errata;
+static int dma_caps0_status;
 
 static struct omap_dma_global_context_registers {
 	u32 dma_irqenable_l0;
@@ -166,6 +187,76 @@ static inline void set_gdma_dev(int req, int dev)
 #define set_gdma_dev(req, dev)	do {} while (0)
 #endif
 
+static inline void omap_dma_list_set_ntype(struct omap_dma_sglist_node *node,
+					   int value)
+{
+	node->num_of_elem |= ((value) << 29);
+}
+
+static void omap_set_dma_sglist_pausebit(
+		struct omap_dma_list_config_params *lcfg, int nelem, int set)
+{
+	struct omap_dma_sglist_node *sgn = lcfg->sghead;
+
+	if (nelem > 0 && nelem < lcfg->num_elem) {
+		lcfg->pausenode = nelem;
+		sgn += nelem;
+
+		if (set)
+			sgn->next_desc_add_ptr |= DMA_LIST_DESC_PAUSE;
+		else
+			sgn->next_desc_add_ptr &= ~(DMA_LIST_DESC_PAUSE);
+	}
+}
+
+static int dma_sglist_set_phy_params(struct omap_dma_sglist_node *sghead,
+		dma_addr_t phyaddr, int nelem)
+{
+	struct omap_dma_sglist_node *sgcurr, *sgprev;
+	dma_addr_t elem_paddr = phyaddr;
+
+	for (sgprev = sghead;
+		sgprev < sghead + nelem;
+		sgprev++) {
+
+		sgcurr = sgprev + 1;
+		sgprev->next = sgcurr;
+		elem_paddr += (int)sizeof(*sgcurr);
+		sgprev->next_desc_add_ptr = elem_paddr;
+
+		switch (sgcurr->desc_type) {
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
+			omap_dma_list_set_ntype(sgprev, 1);
+			break;
+
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
+		/* intentional no break */
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
+			omap_dma_list_set_ntype(sgprev, 2);
+			break;
+
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
+			/* intentional no break */
+		case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
+			omap_dma_list_set_ntype(sgprev, 3);
+			break;
+
+		default:
+			return -EINVAL;
+
+		}
+		if (sgcurr->flags & OMAP_DMA_LIST_SRC_VALID)
+			sgprev->num_of_elem |= DMA_LIST_DESC_SRC_VALID;
+		if (sgcurr->flags & OMAP_DMA_LIST_DST_VALID)
+			sgprev->num_of_elem |= DMA_LIST_DESC_DST_VALID;
+		if (sgcurr->flags & OMAP_DMA_LIST_NOTIFY_BLOCK_END)
+			sgprev->num_of_elem |= DMA_LIST_DESC_BLK_END;
+	}
+	sgprev--;
+	sgprev->next_desc_add_ptr = OMAP_DMA_INVALID_DESCRIPTOR_POINTER;
+	return 0;
+}
+
 void omap_set_dma_priority(int lch, int dst_port, int priority)
 {
 	unsigned long reg;
@@ -778,6 +869,7 @@ void omap_free_dma(int lch)
 		/* Make sure the DMA transfer is stopped. */
 		p->dma_write(0, CCR, lch);
 		omap_clear_dma(lch);
+		omap_clear_dma_sglist_mode(lch);
 	}
 
 	spin_lock_irqsave(&dma_chan_lock, flags);
@@ -1770,6 +1862,192 @@ int omap_get_dma_chain_src_pos(int chain_id)
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */
 
+int omap_set_dma_sglist_mode(int lch, struct omap_dma_sglist_node *sgparams,
+	dma_addr_t padd, int nelem, struct omap_dma_channel_params *chparams)
+{
+	struct omap_dma_list_config_params *lcfg;
+	int l = DMA_LIST_CDP_LISTMODE; /* Enable Linked list mode in CDP */
+
+	if ((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) == 0) {
+		printk(KERN_ERR "omap DMA: sglist feature not supported\n");
+		return -EPERM;
+	}
+	if (dma_chan[lch].flags & OMAP_DMA_ACTIVE) {
+		printk(KERN_ERR "omap DMA: configuring active DMA channel\n");
+		return -EPERM;
+	}
+
+	if (padd == 0) {
+		printk(KERN_ERR "omap DMA: sglist invalid dma_addr\n");
+		return -EINVAL;
+	}
+	lcfg = &dma_chan[lch].list_config;
+
+	lcfg->sghead = sgparams;
+	lcfg->num_elem = nelem;
+	lcfg->sgheadphy = padd;
+	lcfg->pausenode = -1;
+
+
+	if (NULL == chparams)
+		l |= DMA_LIST_CDP_FASTMODE;
+	else
+		omap_set_dma_params(lch, chparams);
+
+	p->dma_write(l, CDP, lch);
+	p->dma_write(0, CCDN, lch); /* Reset List index numbering */
+	/* Initialize frame and element counters to invalid values */
+	p->dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN, lch);
+	p->dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN, lch);
+
+	return dma_sglist_set_phy_params(sgparams, lcfg->sgheadphy, nelem);
+
+}
+EXPORT_SYMBOL(omap_set_dma_sglist_mode);
+
+void omap_clear_dma_sglist_mode(int lch)
+{
+	/* Clear entire CDP which is related to sglist handling */
+	p->dma_write(0, CDP, lch);
+	p->dma_write(0, CCDN, lch);
+	/**
+	 * Put back the original enabled irqs, which
+	 * could have been overwritten by type 1 or type 2
+	 * descriptors
+	 */
+	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
+	return;
+}
+EXPORT_SYMBOL(omap_clear_dma_sglist_mode);
+
+int omap_start_dma_sglist_transfers(int lch, int pauseafter)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgn;
+	unsigned int l, type_id;
+
+	lcfg = &dma_chan[lch].list_config;
+	sgn = lcfg->sghead;
+
+	lcfg->pausenode = 0;
+	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
+
+	/* Program the head descriptor's properties into CDP */
+	switch (lcfg->sghead->desc_type) {
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1:
+		type_id = DMA_LIST_CDP_TYPE1;
+		break;
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a:
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b:
+		type_id = DMA_LIST_CDP_TYPE2;
+		break;
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a:
+	case OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b:
+		type_id = DMA_LIST_CDP_TYPE3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	l = p->dma_read(CDP, lch);
+	l |= type_id;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
+		l |= DMA_LIST_CDP_SRC_VALID;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
+		l |= DMA_LIST_CDP_DST_VALID;
+
+	p->dma_write(l, CDP, lch);
+	p->dma_write((lcfg->sgheadphy), CNDP, lch);
+	/**
+	 * Barrier needed as writes to the
+	 * descriptor memory needs to be flushed
+	 * before it's used by DMA controller
+	 */
+	wmb();
+	omap_start_dma(lch);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_start_dma_sglist_transfers);
+
+int omap_resume_dma_sglist_transfers(int lch, int pauseafter)
+{
+	struct omap_dma_list_config_params *lcfg;
+	struct omap_dma_sglist_node *sgn;
+	int l, sys_cf;
+
+	lcfg = &dma_chan[lch].list_config;
+	sgn = lcfg->sghead;
+
+	/* Maintain the pause state in descriptor */
+	omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
+	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
+
+	/**
+	 * Barrier needed as writes to the
+	 * descriptor memory needs to be flushed
+	 * before it's used by DMA controller
+	 */
+	wmb();
+
+	/* Errata i557 - pausebit should be cleared in no standby mode */
+	sys_cf = p->dma_read(OCP_SYSCONFIG, 0);
+	l = sys_cf;
+	/* Middle mode reg set no Standby */
+	l &= ~(BIT(12) | BIT(13));
+	p->dma_write(l, OCP_SYSCONFIG, 0);
+
+	/* Clear pause bit in CDP */
+	l = p->dma_read(CDP, lch);
+	l &= ~(DMA_LIST_CDP_PAUSEMODE);
+	p->dma_write(l, CDP, lch);
+
+	omap_start_dma(lch);
+
+	/* Errata i557 - put in the old value */
+	p->dma_write(sys_cf, OCP_SYSCONFIG, 0);
+	return 0;
+}
+EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
+
+void omap_release_dma_sglist(int lch)
+{
+	omap_clear_dma_sglist_mode(lch);
+	omap_free_dma(lch);
+
+	return;
+}
+EXPORT_SYMBOL(omap_release_dma_sglist);
+
+int omap_get_completed_sglist_nodes(int lch)
+{
+	int list_count;
+
+	list_count = p->dma_read(CCDN, lch);
+	return list_count & 0xffff; /* only 16 LSB bits are valid */
+}
+EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
+
+int omap_dma_sglist_is_paused(int lch)
+{
+	int list_state;
+	list_state = p->dma_read(CDP, lch);
+	return (list_state & DMA_LIST_CDP_PAUSEMODE) ? 1 : 0;
+}
+EXPORT_SYMBOL(omap_dma_sglist_is_paused);
+
+void omap_dma_set_sglist_fastmode(int lch, int fastmode)
+{
+	int l = p->dma_read(CDP, lch);
+
+	if (fastmode)
+		l |= DMA_LIST_CDP_FASTMODE;
+	else
+		l &= ~(DMA_LIST_CDP_FASTMODE);
+	p->dma_write(l, CDP, lch);
+}
+EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
+
 /*----------------------------------------------------------------------------*/
 
 #ifdef CONFIG_ARCH_OMAP1
@@ -1997,6 +2275,7 @@ static int __devinit omap_system_dma_probe(struct platform_device *pdev)
 			ret = -ENOMEM;
 			goto exit_dma_lch_fail;
 		}
+		dma_caps0_status = p->dma_read(CAPS_0, 0);
 	}
 
 	spin_lock_init(&dma_chan_lock);
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index d1c916f..4d73eb1 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -401,6 +401,13 @@ struct omap_dma_channel_params {
 #endif
 };
 
+struct omap_dma_list_config_params {
+	unsigned int num_elem;
+	struct omap_dma_sglist_node *sghead;
+	dma_addr_t sgheadphy;
+	unsigned int pausenode;
+};
+
 struct omap_dma_lch {
 	int next_lch;
 	int dev_id;
@@ -416,6 +423,7 @@ struct omap_dma_lch {
 	int state;
 	int chain_id;
 	int status;
+	struct omap_dma_list_config_params list_config;
 };
 
 struct omap_dma_dev_attr {
@@ -437,6 +445,84 @@ struct omap_system_dma_plat_info {
 	u32 (*dma_read)(int reg, int lch);
 };
 
+struct omap_dma_sglist_type1_params {
+	u32 src_addr;
+	u32 dst_addr;
+	u16 cfn_fn;
+	u16 cicr;
+	u16 dst_elem_idx;
+	u16 src_elem_idx;
+	u32 dst_frame_idx_or_pkt_size;
+	u32 src_frame_idx_or_pkt_size;
+	u32 color;
+	u32 csdp;
+	u32 clnk_ctrl;
+	u32 ccr;
+};
+
+struct omap_dma_sglist_type2a_params {
+	u32 src_addr;
+	u32 dst_addr;
+	u16 cfn_fn;
+	u16 cicr;
+	u16 dst_elem_idx;
+	u16 src_elem_idx;
+	u32 dst_frame_idx_or_pkt_size;
+	u32 src_frame_idx_or_pkt_size;
+};
+
+struct omap_dma_sglist_type2b_params {
+	u32 src_or_dest_addr;
+	u16 cfn_fn;
+	u16 cicr;
+	u16 dst_elem_idx;
+	u16 src_elem_idx;
+	u32 dst_frame_idx_or_pkt_size;
+	u32 src_frame_idx_or_pkt_size;
+};
+
+struct omap_dma_sglist_type3a_params {
+	u32 src_addr;
+	u32 dst_addr;
+};
+
+struct omap_dma_sglist_type3b_params {
+	u32 src_or_dest_addr;
+};
+
+enum omap_dma_sglist_descriptor_select {
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE1,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2b,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3a,
+	OMAP_DMA_SGLIST_DESCRIPTOR_TYPE3b,
+};
+
+union omap_dma_sglist_node_type {
+	struct omap_dma_sglist_type1_params t1;
+	struct omap_dma_sglist_type2a_params t2a;
+	struct omap_dma_sglist_type2b_params t2b;
+	struct omap_dma_sglist_type3a_params t3a;
+	struct omap_dma_sglist_type3b_params t3b;
+};
+
+struct omap_dma_sglist_node {
+
+	/* Common elements for all descriptors */
+	dma_addr_t next_desc_add_ptr;
+	u32 num_of_elem;
+	/* Type specific elements */
+	union omap_dma_sglist_node_type sg_node;
+	/* Control fields */
+	unsigned short flags;
+	/* Fields that can be set in flags variable */
+	#define OMAP_DMA_LIST_SRC_VALID		BIT(0)
+	#define OMAP_DMA_LIST_DST_VALID		BIT(1)
+	#define OMAP_DMA_LIST_NOTIFY_BLOCK_END	BIT(2)
+	enum omap_dma_sglist_descriptor_select desc_type;
+	struct omap_dma_sglist_node *next;
+};
+
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
@@ -530,4 +616,91 @@ static inline int omap_lcd_dma_running(void)
 }
 #endif
 
+/**
+ * omap_set_dma_sglist_mode()	Switch channel to scatter gather mode
+ * @lch:	Logical channel to switch to sglist mode
+ * @sghead:	Contains the descriptor elements to be executed
+ *		Should be allocated using dma_alloc_coherent
+ * @padd:	The dma address of sghead, as returned by dma_alloc_coherent
+ * @nelem:	Number of elements in sghead
+ * @chparams:	DMA channel transfer parameters. Can be NULL
+ */
+extern int omap_set_dma_sglist_mode(int lch,
+	struct omap_dma_sglist_node *sghead, dma_addr_t padd,
+	int nelem, struct omap_dma_channel_params *chparams);
+
+/**
+ * omap_clear_dma_sglist_mode()	Switch from scatter gather mode
+ *				to normal mode
+ * @lch:	The logical channel to be switched to normal mode
+ *
+ * Switches the requested logical channel to normal mode
+ * from scatter gather mode
+ */
+extern void omap_clear_dma_sglist_mode(int lch);
+
+/**
+ * omap_start_dma_sglist_transfers()	Starts the sglist transfer
+ * @lch:	logical channel on which sglist transfer to be started
+ * @pauseafter:	index of the element on which to pause the transfer
+ *		set to -1 if no pause is needed till end of transfer
+ *
+ * Start the dma transfer in list mode
+ * The index (in pauseafter) is absolute (from the head of the list)
+ * User should have previously called omap_set_dma_sglist_mode()
+ */
+extern int omap_start_dma_sglist_transfers(int lch, int pauseafter);
+
+/**
+ * omap_resume_dma_sglist_transfers()	Resumes a previously paused
+ *					sglist transfer
+ * @lch:	The logical channel to be resumed
+ * @pauseafter:	The index of sglist to be paused again
+ *		set to -1 if no pause is needed till end of transfer
+ *
+ * Resume the previously paused transfer
+ * The index (in pauseafter) is absolute (from the head of the list)
+ */
+extern int omap_resume_dma_sglist_transfers(int lch, int pauseafter);
+
+/**
+ * omap_release_dma_sglist()	Releases a previously requested
+ *				DMA channel which is in sglist mode
+ * @lch:	The logical channel to be released
+ */
+extern void omap_release_dma_sglist(int lch);
+
+/**
+ * omap_get_completed_sglist_nodes()	Returns a list of completed
+ *					sglist nodes
+ * @lch:	The logical on which the query is to be made
+ *
+ * Returns the number of completed elements in the linked list
+ * The value is transient if the API is invoked for an ongoing transfer
+ */
+int omap_get_completed_sglist_nodes(int lch);
+
+/**
+ * omap_dma_sglist_is_paused()	Query is the logical channel in
+ *				sglist mode is paused or note
+ * @lch:	The logical on which the query is to be made
+ *
+ * Returns non zero if the linked list is currently in pause state
+ */
+int omap_dma_sglist_is_paused(int lch);
+
+/**
+ * omap_dma_set_sglist_fastmode() Set the sglist transfer to fastmode
+ * @lch:	The logical channel which is to be changed to fastmode
+ * @fastmode:	Set or clear the fastmode status
+ *		1 = set fastmode
+ *		0 = clear fastmode
+ *
+ * In fastmode, DMA register settings are updated from the first element
+ * of the linked list, before initiating the tranfer.
+ * In non-fastmode, the first element is used only after completing the
+ * transfer as already configured in the registers
+ */
+void omap_dma_set_sglist_fastmode(int lch, int fastmode);
+
 #endif /* __ASM_ARCH_DMA_H */
-- 
1.7.0.4

