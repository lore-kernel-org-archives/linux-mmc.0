From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 02/03] omap sDMA: descriptor autoloading feature
Date: Wed, 10 Mar 2010 19:42:06 +0530
Message-ID: <618f0c911003100612q591776ect74d48baebe31e494@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f176.google.com ([209.85.223.176]:37056 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360Ab0CJOMI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2010 09:12:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>

See previous post http://patchwork.kernel.org/patch/82908/
This is rebased on 2.6.34-rc1

CC: Adrian Hunter <adrian.hunter@nokia.com>
CC: Madhusudhan C <madhu.cr@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/plat-omap/dma.c              |  269 ++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/dma.h |  170 +++++++++++++++++++++
 2 files changed, 438 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..6c92c34 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -46,12 +46,40 @@ enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE,
DMA_CH_STARTED,
 enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 #endif

+/* CDP Register bitmaps */
+#define DMA_LIST_CDP_DST_VALID	(BIT(0))
+#define DMA_LIST_CDP_SRC_VALID	(BIT(2))
+#define DMA_LIST_CDP_TYPE1	(BIT(4))
+#define DMA_LIST_CDP_TYPE2	(BIT(5))
+#define DMA_LIST_CDP_TYPE3	(BIT(4) | BIT(5))
+#define DMA_LIST_CDP_PAUSEMODE	(BIT(7))
+#define DMA_LIST_CDP_LISTMODE	(BIT(8))
+#define DMA_LIST_CDP_FASTMODE	(BIT(10))
+/* CAPS register bitmaps */
+#define DMA_CAPS_SGLIST_SUPPORT	(BIT(20))
+
+#define DMA_LIST_DESC_PAUSE	(BIT(0))
+#define DMA_LIST_DESC_SRC_VALID	(BIT(24))
+#define DMA_LIST_DESC_DST_VALID	(BIT(26))
+#define DMA_LIST_DESC_BLK_END	(BIT(28))
+
 #define OMAP_DMA_ACTIVE			0x01
 #define OMAP2_DMA_CSR_CLEAR_MASK	0xffe

 #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
+#define OMAP_DMA_INVALID_FRAME_COUNT	(0xffff)
+#define OMAP_DMA_INVALID_ELEM_COUNT	(0xffffff)
+#define OMAP_DMA_INVALID_DESCRIPTOR_POINTER	(0xfffffffc)

 static int enable_1510_mode;
+static int dma_caps0_status;
+
+struct omap_dma_list_config_params {
+	unsigned int num_elem;
+	struct omap_dma_sglist_node *sghead;
+	dma_addr_t sgheadphy;
+	unsigned int pausenode;
+};

 static struct omap_dma_global_context_registers {
 	u32 dma_irqenable_l0;
@@ -76,7 +104,11 @@ struct omap_dma_lch {
 	int chain_id;

 	int status;
+
+	/* Required for descriptor loading */
+	struct omap_dma_list_config_params list_config;
 #endif
+
 	long flags;
 };

@@ -214,6 +246,76 @@ static void clear_lch_regs(int lch)
 		__raw_writew(0, lch_base + i);
 }

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
+		dma_addr_t phyaddr, int nelem, int cicr)
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
@@ -825,6 +927,7 @@ void omap_free_dma(int lch)
 		/* Make sure the DMA transfer is stopped. */
 		dma_write(0, CCR(lch));
 		omap_clear_dma(lch);
+		omap_clear_dma_sglist_mode(lch);
 	}

 	spin_lock_irqsave(&dma_chan_lock, flags);
@@ -1809,7 +1912,170 @@ int omap_get_dma_chain_src_pos(int chain_id)
 EXPORT_SYMBOL(omap_get_dma_chain_src_pos);
 #endif	/* ifndef CONFIG_ARCH_OMAP1 */

-/*----------------------------------------------------------------------------*/
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
+	dma_write(l, CDP(lch));
+	dma_write(0, CCDN(lch)); /* Reset List index numbering */
+	/* Initialize frame and element counters to invalid values */
+	dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(lch));
+	dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(lch));
+
+	return dma_sglist_set_phy_params(sgparams, lcfg->sgheadphy,
+			nelem, dma_read(CICR(lch)));
+
+}
+EXPORT_SYMBOL(omap_set_dma_sglist_mode);
+
+int omap_clear_dma_sglist_mode(int lch)
+{
+	int l;
+
+	l = dma_read(CDP(lch));
+	l &= ~DMA_LIST_CDP_LISTMODE;
+	dma_write(l, CDP(lch));
+	return 0;
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
+	l = dma_read(CDP(lch));
+	l |= type_id;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_SRC_VALID)
+		l |= DMA_LIST_CDP_SRC_VALID;
+	if (lcfg->sghead->flags & OMAP_DMA_LIST_DST_VALID)
+		l |= DMA_LIST_CDP_DST_VALID;
+
+	dma_write(l, CDP(lch));
+	dma_write((lcfg->sgheadphy), CNDP(lch));
+
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
+	int l;
+
+	lcfg = &dma_chan[lch].list_config;
+	sgn = lcfg->sghead;
+
+	/* Clear previous pause and set new value */
+	omap_set_dma_sglist_pausebit(lcfg, lcfg->pausenode, 0);
+	omap_set_dma_sglist_pausebit(lcfg, pauseafter, 1);
+
+	/* Clear pause bit in CDP */
+	l = dma_read(CDP(lch));
+	l &= ~(DMA_LIST_CDP_PAUSEMODE);
+	dma_write(l, CDP(lch));
+	omap_start_dma(lch);
+	return 0;
+}
+EXPORT_SYMBOL(omap_resume_dma_sglist_transfers);
+
+int omap_release_dma_sglist(int lch)
+{
+	int ret;
+	ret = omap_clear_dma_sglist_mode(lch);
+	if (ret)
+		return ret;
+	else
+		omap_free_dma(lch);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_release_dma_sglist);
+
+int omap_get_completed_sglist_nodes(int lch)
+{
+	int list_count;
+
+	list_count = dma_read(CCDN(lch));
+	return list_count & 0xffff; /* only 16 LSB bits are valid */
+}
+EXPORT_SYMBOL(omap_get_completed_sglist_nodes);
+
+int omap_dma_sglist_is_paused(int lch)
+{
+	int list_state;
+	list_state = dma_read(CDP(lch));
+	return (list_state & DMA_LIST_CDP_PAUSEMODE) ? 1 : 0;
+}
+EXPORT_SYMBOL(omap_dma_sglist_is_paused);
+
+void omap_dma_set_sglist_fastmode(int lch, int fastmode)
+{
+	int l = dma_read(CDP(lch));
+
+	if (fastmode)
+		l |= DMA_LIST_CDP_FASTMODE;
+	else
+		l &= ~(DMA_LIST_CDP_FASTMODE);
+	dma_write(l, CDP(lch));
+}
+EXPORT_SYMBOL(omap_dma_set_sglist_fastmode);
+

 #ifdef CONFIG_ARCH_OMAP1

@@ -2057,6 +2323,7 @@ static int __init omap_init_dma(void)
 			r = -ENOMEM;
 			goto out_free;
 		}
+		dma_caps0_status = dma_read(CAPS_0);
 	}

 	if (cpu_is_omap15xx()) {
diff --git a/arch/arm/plat-omap/include/plat/dma.h
b/arch/arm/plat-omap/include/plat/dma.h
index 02232ca..4267388 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -115,8 +115,12 @@
 #define OMAP1_DMA_COLOR_U(n)		(0x40 * (n) + 0x22)
 #define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
 #define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)	/* not on 15xx */
+#define OMAP1_DMA_COLOR(n)		0
 #define OMAP1_DMA_CCEN(n)		0
 #define OMAP1_DMA_CCFN(n)		0
+#define OMAP1_DMA_CDP(n)		0
+#define OMAP1_DMA_CNDP(n)		0
+#define OMAP1_DMA_CCDN(n)		0

 /* Channel specific registers only on omap2 */
 #define OMAP_DMA4_CSSA(n)		(0x60 * (n) + 0x9c)
@@ -135,6 +139,8 @@
 #define OMAP1_DMA_IRQSTATUS_L0		0
 #define OMAP1_DMA_IRQENABLE_L0		0
 #define OMAP1_DMA_OCP_SYSCONFIG		0
+#define OMAP1_DMA_CAPS_0		0
+
 #define OMAP_DMA4_HW_ID			0
 #define OMAP_DMA4_CAPS_0_L		0
 #define OMAP_DMA4_CAPS_0_U		0
@@ -463,6 +469,83 @@ struct omap_dma_channel_params {
 #endif
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
+union omap_dma_sglist_node_type{
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

 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
@@ -548,6 +631,93 @@ extern int omap_modify_dma_chain_params(int chain_id,
 extern int omap_dma_chain_status(int chain_id);
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
+extern int omap_clear_dma_sglist_mode(int lch);
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
+extern int omap_release_dma_sglist(int lch);
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
 #if defined(CONFIG_ARCH_OMAP1) && defined(CONFIG_FB_OMAP)
 #include <mach/lcd_dma.h>
 #else
-- 
1.6.3.3
