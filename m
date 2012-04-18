From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 3/8] dmaengine: split out virtual channel DMA support from
 sa11x0 driver
Date: Wed, 18 Apr 2012 11:11:16 +0100
Message-ID: <E1SKRr2-0004bC-8a@rmk-PC.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120418100954.GK25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-mmc@vger.kernel.org

Split the virtual slave channel DMA support from the sa11x0 driver so
this code can be shared with other slave DMA engine drivers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/Kconfig      |    4 +
 drivers/dma/Makefile     |    1 +
 drivers/dma/sa11x0-dma.c |  249 ++++++++++++++-------------------------------
 drivers/dma/virt-dma.c   |   99 ++++++++++++++++++
 drivers/dma/virt-dma.h   |  138 +++++++++++++++++++++++++
 5 files changed, 320 insertions(+), 171 deletions(-)
 create mode 100644 drivers/dma/virt-dma.c
 create mode 100644 drivers/dma/virt-dma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index cf9da36..5828ac4 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -255,6 +255,7 @@ config DMA_SA11X0
 	tristate "SA-11x0 DMA support"
 	depends on ARCH_SA1100
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the DMA engine found on Intel StrongARM SA-1100 and
 	  SA-1110 SoCs.  This DMA engine can only be used with on-chip
@@ -263,6 +264,9 @@ config DMA_SA11X0
 config DMA_ENGINE
 	bool
 
+config DMA_VIRTUAL_CHANNELS
+	tristate
+
 comment "DMA Clients"
 	depends on DMA_ENGINE
 
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 86b795b..fc05f7d 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -2,6 +2,7 @@ ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
 ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
 
 obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
+obj-$(CONFIG_DMA_VIRTUAL_CHANNELS) += virt-dma.o
 obj-$(CONFIG_NET_DMA) += iovlock.o
 obj-$(CONFIG_INTEL_MID_DMAC) += intel_mid_dma.o
 obj-$(CONFIG_DMATEST) += dmatest.o
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index ec78cce..5f1d2e6 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -21,6 +21,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include "virt-dma.h"
+
 #define NR_PHY_CHAN	6
 #define DMA_ALIGN	3
 #define DMA_MAX_SIZE	0x1fff
@@ -72,12 +74,11 @@ struct sa11x0_dma_sg {
 };
 
 struct sa11x0_dma_desc {
-	struct dma_async_tx_descriptor tx;
+	struct virt_dma_desc	vd;
+
 	u32			ddar;
 	size_t			size;
 
-	/* maybe protected by c->lock */
-	struct list_head	node;
 	unsigned		sglen;
 	struct sa11x0_dma_sg	sg[0];
 };
@@ -85,15 +86,11 @@ struct sa11x0_dma_desc {
 struct sa11x0_dma_phy;
 
 struct sa11x0_dma_chan {
-	struct dma_chan		chan;
-	spinlock_t		lock;
-	dma_cookie_t		lc;
+	struct virt_dma_chan	vc;
 
-	/* protected by c->lock */
+	/* protected by c->vc.lock */
 	struct sa11x0_dma_phy	*phy;
 	enum dma_status		status;
-	struct list_head	desc_submitted;
-	struct list_head	desc_issued;
 
 	/* protected by d->lock */
 	struct list_head	node;
@@ -109,7 +106,7 @@ struct sa11x0_dma_phy {
 
 	struct sa11x0_dma_chan	*vchan;
 
-	/* Protected by c->lock */
+	/* Protected by c->vc.lock */
 	unsigned		sg_load;
 	struct sa11x0_dma_desc	*txd_load;
 	unsigned		sg_done;
@@ -127,13 +124,12 @@ struct sa11x0_dma_dev {
 	spinlock_t		lock;
 	struct tasklet_struct	task;
 	struct list_head	chan_pending;
-	struct list_head	desc_complete;
 	struct sa11x0_dma_phy	phy[NR_PHY_CHAN];
 };
 
 static struct sa11x0_dma_chan *to_sa11x0_dma_chan(struct dma_chan *chan)
 {
-	return container_of(chan, struct sa11x0_dma_chan, chan);
+	return container_of(chan, struct sa11x0_dma_chan, vc.chan);
 }
 
 static struct sa11x0_dma_dev *to_sa11x0_dma(struct dma_device *dmadev)
@@ -141,27 +137,26 @@ static struct sa11x0_dma_dev *to_sa11x0_dma(struct dma_device *dmadev)
 	return container_of(dmadev, struct sa11x0_dma_dev, slave);
 }
 
-static struct sa11x0_dma_desc *to_sa11x0_dma_tx(struct dma_async_tx_descriptor *tx)
+static struct sa11x0_dma_desc *sa11x0_dma_next_desc(struct sa11x0_dma_chan *c)
 {
-	return container_of(tx, struct sa11x0_dma_desc, tx);
+	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
+
+	return vd ? container_of(vd, struct sa11x0_dma_desc, vd) : NULL;
 }
 
-static struct sa11x0_dma_desc *sa11x0_dma_next_desc(struct sa11x0_dma_chan *c)
+static void sa11x0_dma_free_desc(struct virt_dma_desc *vd)
 {
-	if (list_empty(&c->desc_issued))
-		return NULL;
-
-	return list_first_entry(&c->desc_issued, struct sa11x0_dma_desc, node);
+	kfree(container_of(vd, struct sa11x0_dma_desc, vd));
 }
 
 static void sa11x0_dma_start_desc(struct sa11x0_dma_phy *p, struct sa11x0_dma_desc *txd)
 {
-	list_del(&txd->node);
+	list_del(&txd->vd.node);
 	p->txd_load = txd;
 	p->sg_load = 0;
 
 	dev_vdbg(p->dev->slave.dev, "pchan %u: txd %p[%x]: starting: DDAR:%x\n",
-		p->num, txd, txd->tx.cookie, txd->ddar);
+		p->num, &txd->vd, txd->vd.tx.cookie, txd->ddar);
 }
 
 static void noinline sa11x0_dma_start_sg(struct sa11x0_dma_phy *p,
@@ -229,21 +224,13 @@ static void noinline sa11x0_dma_complete(struct sa11x0_dma_phy *p,
 	struct sa11x0_dma_desc *txd = p->txd_done;
 
 	if (++p->sg_done == txd->sglen) {
-		struct sa11x0_dma_dev *d = p->dev;
-
-		dev_vdbg(d->slave.dev, "pchan %u: txd %p[%x]: completed\n",
-			p->num, p->txd_done, p->txd_done->tx.cookie);
-
-		c->lc = txd->tx.cookie;
-
-		spin_lock(&d->lock);
-		list_add_tail(&txd->node, &d->desc_complete);
-		spin_unlock(&d->lock);
+		vchan_cookie_complete(&txd->vd);
 
 		p->sg_done = 0;
 		p->txd_done = p->txd_load;
 
-		tasklet_schedule(&d->task);
+		if (!p->txd_done)
+			tasklet_schedule(&p->dev->task);
 	}
 
 	sa11x0_dma_start_sg(p, c);
@@ -280,7 +267,7 @@ static irqreturn_t sa11x0_dma_irq(int irq, void *dev_id)
 	if (c) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&c->lock, flags);
+		spin_lock_irqsave(&c->vc.lock, flags);
 		/*
 		 * Now that we're holding the lock, check that the vchan
 		 * really is associated with this pchan before touching the
@@ -294,7 +281,7 @@ static irqreturn_t sa11x0_dma_irq(int irq, void *dev_id)
 			if (dcsr & DCSR_DONEB)
 				sa11x0_dma_complete(p, c);
 		}
-		spin_unlock_irqrestore(&c->lock, flags);
+		spin_unlock_irqrestore(&c->vc.lock, flags);
 	}
 
 	return IRQ_HANDLED;
@@ -332,28 +319,15 @@ static void sa11x0_dma_tasklet(unsigned long arg)
 	struct sa11x0_dma_dev *d = (struct sa11x0_dma_dev *)arg;
 	struct sa11x0_dma_phy *p;
 	struct sa11x0_dma_chan *c;
-	struct sa11x0_dma_desc *txd, *txn;
-	LIST_HEAD(head);
 	unsigned pch, pch_alloc = 0;
 
 	dev_dbg(d->slave.dev, "tasklet enter\n");
 
-	/* Get the completed tx descriptors */
-	spin_lock_irq(&d->lock);
-	list_splice_init(&d->desc_complete, &head);
-	spin_unlock_irq(&d->lock);
-
-	list_for_each_entry(txd, &head, node) {
-		c = to_sa11x0_dma_chan(txd->tx.chan);
-
-		dev_dbg(d->slave.dev, "vchan %p: txd %p[%x] completed\n",
-			c, txd, txd->tx.cookie);
-
-		spin_lock_irq(&c->lock);
+	list_for_each_entry(c, &d->slave.channels, vc.chan.device_node) {
+		spin_lock_irq(&c->vc.lock);
 		p = c->phy;
-		if (p) {
-			if (!p->txd_done)
-				sa11x0_dma_start_txd(c);
+		if (p && !p->txd_done) {
+			sa11x0_dma_start_txd(c);
 			if (!p->txd_done) {
 				/* No current txd associated with this channel */
 				dev_dbg(d->slave.dev, "pchan %u: free\n", p->num);
@@ -363,7 +337,7 @@ static void sa11x0_dma_tasklet(unsigned long arg)
 				p->vchan = NULL;
 			}
 		}
-		spin_unlock_irq(&c->lock);
+		spin_unlock_irq(&c->vc.lock);
 	}
 
 	spin_lock_irq(&d->lock);
@@ -380,7 +354,7 @@ static void sa11x0_dma_tasklet(unsigned long arg)
 			/* Mark this channel allocated */
 			p->vchan = c;
 
-			dev_dbg(d->slave.dev, "pchan %u: alloc vchan %p\n", pch, c);
+			dev_dbg(d->slave.dev, "pchan %u: alloc vchan %p\n", pch, &c->vc);
 		}
 	}
 	spin_unlock_irq(&d->lock);
@@ -390,42 +364,18 @@ static void sa11x0_dma_tasklet(unsigned long arg)
 			p = &d->phy[pch];
 			c = p->vchan;
 
-			spin_lock_irq(&c->lock);
+			spin_lock_irq(&c->vc.lock);
 			c->phy = p;
 
 			sa11x0_dma_start_txd(c);
-			spin_unlock_irq(&c->lock);
+			spin_unlock_irq(&c->vc.lock);
 		}
 	}
 
-	/* Now free the completed tx descriptor, and call their callbacks */
-	list_for_each_entry_safe(txd, txn, &head, node) {
-		dma_async_tx_callback callback = txd->tx.callback;
-		void *callback_param = txd->tx.callback_param;
-
-		dev_dbg(d->slave.dev, "txd %p[%x]: callback and free\n",
-			txd, txd->tx.cookie);
-
-		kfree(txd);
-
-		if (callback)
-			callback(callback_param);
-	}
-
 	dev_dbg(d->slave.dev, "tasklet exit\n");
 }
 
 
-static void sa11x0_dma_desc_free(struct sa11x0_dma_dev *d, struct list_head *head)
-{
-	struct sa11x0_dma_desc *txd, *txn;
-
-	list_for_each_entry_safe(txd, txn, head, node) {
-		dev_dbg(d->slave.dev, "txd %p: freeing\n", txd);
-		kfree(txd);
-	}
-}
-
 static int sa11x0_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	return 0;
@@ -436,18 +386,12 @@ static void sa11x0_dma_free_chan_resources(struct dma_chan *chan)
 	struct sa11x0_dma_chan *c = to_sa11x0_dma_chan(chan);
 	struct sa11x0_dma_dev *d = to_sa11x0_dma(chan->device);
 	unsigned long flags;
-	LIST_HEAD(head);
 
-	spin_lock_irqsave(&c->lock, flags);
-	spin_lock(&d->lock);
+	spin_lock_irqsave(&d->lock, flags);
 	list_del_init(&c->node);
-	spin_unlock(&d->lock);
-
-	list_splice_tail_init(&c->desc_submitted, &head);
-	list_splice_tail_init(&c->desc_issued, &head);
-	spin_unlock_irqrestore(&c->lock, flags);
+	spin_unlock_irqrestore(&d->lock, flags);
 
-	sa11x0_dma_desc_free(d, &head);
+	vchan_free_chan_resources(&c->vc);
 }
 
 static dma_addr_t sa11x0_dma_pos(struct sa11x0_dma_phy *p)
@@ -473,21 +417,15 @@ static enum dma_status sa11x0_dma_tx_status(struct dma_chan *chan,
 	struct sa11x0_dma_dev *d = to_sa11x0_dma(chan->device);
 	struct sa11x0_dma_phy *p;
 	struct sa11x0_dma_desc *txd;
-	dma_cookie_t last_used, last_complete;
 	unsigned long flags;
 	enum dma_status ret;
 	size_t bytes = 0;
 
-	last_used = c->chan.cookie;
-	last_complete = c->lc;
-
-	ret = dma_async_is_complete(cookie, last_complete, last_used);
-	if (ret == DMA_SUCCESS) {
-		dma_set_tx_state(state, last_complete, last_used, 0);
+	ret = dma_cookie_status(&c->vc.chan, cookie, state);
+	if (ret == DMA_SUCCESS)
 		return ret;
-	}
 
-	spin_lock_irqsave(&c->lock, flags);
+	spin_lock_irqsave(&c->vc.lock, flags);
 	p = c->phy;
 	ret = c->status;
 	if (p) {
@@ -524,12 +462,13 @@ static enum dma_status sa11x0_dma_tx_status(struct dma_chan *chan,
 		if (txd != p->txd_load && p->txd_load)
 			bytes += p->txd_load->size;
 	}
-	list_for_each_entry(txd, &c->desc_issued, node) {
+	list_for_each_entry(txd, &c->vc.desc_issued, vd.node) {
 		bytes += txd->size;
 	}
-	spin_unlock_irqrestore(&c->lock, flags);
+	spin_unlock_irqrestore(&c->vc.lock, flags);
 
-	dma_set_tx_state(state, last_complete, last_used, bytes);
+	if (state)
+		state->residue = bytes;
 
 	dev_vdbg(d->slave.dev, "tx_status: bytes 0x%zx\n", bytes);
 
@@ -547,40 +486,20 @@ static void sa11x0_dma_issue_pending(struct dma_chan *chan)
 	struct sa11x0_dma_dev *d = to_sa11x0_dma(chan->device);
 	unsigned long flags;
 
-	spin_lock_irqsave(&c->lock, flags);
-	list_splice_tail_init(&c->desc_submitted, &c->desc_issued);
-	if (!list_empty(&c->desc_issued)) {
-		spin_lock(&d->lock);
-		if (!c->phy && list_empty(&c->node)) {
-			list_add_tail(&c->node, &d->chan_pending);
-			tasklet_schedule(&d->task);
-			dev_dbg(d->slave.dev, "vchan %p: issued\n", c);
+	spin_lock_irqsave(&c->vc.lock, flags);
+	if (vchan_issue_pending(&c->vc)) {
+		if (!c->phy) {
+			spin_lock(&d->lock);
+			if (list_empty(&c->node)) {
+				list_add_tail(&c->node, &d->chan_pending);
+				tasklet_schedule(&d->task);
+				dev_dbg(d->slave.dev, "vchan %p: issued\n", &c->vc);
+			}
+			spin_unlock(&d->lock);
 		}
-		spin_unlock(&d->lock);
 	} else
-		dev_dbg(d->slave.dev, "vchan %p: nothing to issue\n", c);
-	spin_unlock_irqrestore(&c->lock, flags);
-}
-
-static dma_cookie_t sa11x0_dma_tx_submit(struct dma_async_tx_descriptor *tx)
-{
-	struct sa11x0_dma_chan *c = to_sa11x0_dma_chan(tx->chan);
-	struct sa11x0_dma_desc *txd = to_sa11x0_dma_tx(tx);
-	unsigned long flags;
-
-	spin_lock_irqsave(&c->lock, flags);
-	c->chan.cookie += 1;
-	if (c->chan.cookie < 0)
-		c->chan.cookie = 1;
-	txd->tx.cookie = c->chan.cookie;
-
-	list_add_tail(&txd->node, &c->desc_submitted);
-	spin_unlock_irqrestore(&c->lock, flags);
-
-	dev_dbg(tx->chan->device->dev, "vchan %p: txd %p[%x]: submitted\n",
-		c, txd, txd->tx.cookie);
-
-	return txd->tx.cookie;
+		dev_dbg(d->slave.dev, "vchan %p: nothing to issue\n", &c->vc);
+	spin_unlock_irqrestore(&c->vc.lock, flags);
 }
 
 static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
@@ -596,7 +515,7 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 	/* SA11x0 channels can only operate in their native direction */
 	if (dir != (c->ddar & DDAR_RW ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV)) {
 		dev_err(chan->device->dev, "vchan %p: bad DMA direction: DDAR:%08x dir:%u\n",
-			c, c->ddar, dir);
+			&c->vc, c->ddar, dir);
 		return NULL;
 	}
 
@@ -612,14 +531,14 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 			j += DIV_ROUND_UP(len, DMA_MAX_SIZE & ~DMA_ALIGN) - 1;
 		if (addr & DMA_ALIGN) {
 			dev_dbg(chan->device->dev, "vchan %p: bad buffer alignment: %08x\n",
-				c, addr);
+				&c->vc, addr);
 			return NULL;
 		}
 	}
 
 	txd = kzalloc(sizeof(*txd) + j * sizeof(txd->sg[0]), GFP_ATOMIC);
 	if (!txd) {
-		dev_dbg(chan->device->dev, "vchan %p: kzalloc failed\n", c);
+		dev_dbg(chan->device->dev, "vchan %p: kzalloc failed\n", &c->vc);
 		return NULL;
 	}
 
@@ -655,17 +574,14 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 		} while (len);
 	}
 
-	dma_async_tx_descriptor_init(&txd->tx, &c->chan);
-	txd->tx.flags = flags;
-	txd->tx.tx_submit = sa11x0_dma_tx_submit;
 	txd->ddar = c->ddar;
 	txd->size = size;
 	txd->sglen = j;
 
 	dev_dbg(chan->device->dev, "vchan %p: txd %p: size %u nr %u\n",
-		c, txd, txd->size, txd->sglen);
+		&c->vc, &txd->vd, txd->size, txd->sglen);
 
-	return &txd->tx;
+	return vchan_tx_prep(&c->vc, &txd->vd, flags);
 }
 
 static int sa11x0_dma_slave_config(struct sa11x0_dma_chan *c, struct dma_slave_config *cfg)
@@ -695,8 +611,8 @@ static int sa11x0_dma_slave_config(struct sa11x0_dma_chan *c, struct dma_slave_c
 	if (maxburst == 8)
 		ddar |= DDAR_BS;
 
-	dev_dbg(c->chan.device->dev, "vchan %p: dma_slave_config addr %x width %u burst %u\n",
-		c, addr, width, maxburst);
+	dev_dbg(c->vc.chan.device->dev, "vchan %p: dma_slave_config addr %x width %u burst %u\n",
+		&c->vc, addr, width, maxburst);
 
 	c->ddar = ddar | (addr & 0xf0000000) | (addr & 0x003ffffc) << 6;
 
@@ -718,16 +634,13 @@ static int sa11x0_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		return sa11x0_dma_slave_config(c, (struct dma_slave_config *)arg);
 
 	case DMA_TERMINATE_ALL:
-		dev_dbg(d->slave.dev, "vchan %p: terminate all\n", c);
+		dev_dbg(d->slave.dev, "vchan %p: terminate all\n", &c->vc);
 		/* Clear the tx descriptor lists */
-		spin_lock_irqsave(&c->lock, flags);
-		list_splice_tail_init(&c->desc_submitted, &head);
-		list_splice_tail_init(&c->desc_issued, &head);
+		spin_lock_irqsave(&c->vc.lock, flags);
+		vchan_get_all_descriptors(&c->vc, &head);
 
 		p = c->phy;
 		if (p) {
-			struct sa11x0_dma_desc *txd, *txn;
-
 			dev_dbg(d->slave.dev, "pchan %u: terminating\n", p->num);
 			/* vchan is assigned to a pchan - stop the channel */
 			writel(DCSR_RUN | DCSR_IE |
@@ -735,17 +648,13 @@ static int sa11x0_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 				DCSR_STRTB | DCSR_DONEB,
 				p->base + DMA_DCSR_C);
 
-			list_for_each_entry_safe(txd, txn, &d->desc_complete, node)
-				if (txd->tx.chan == &c->chan)
-					list_move(&txd->node, &head);
-
 			if (p->txd_load) {
 				if (p->txd_load != p->txd_done)
-					list_add_tail(&p->txd_load->node, &head);
+					list_add_tail(&p->txd_load->vd.node, &head);
 				p->txd_load = NULL;
 			}
 			if (p->txd_done) {
-				list_add_tail(&p->txd_done->node, &head);
+				list_add_tail(&p->txd_done->vd.node, &head);
 				p->txd_done = NULL;
 			}
 			c->phy = NULL;
@@ -754,14 +663,14 @@ static int sa11x0_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 			spin_unlock(&d->lock);
 			tasklet_schedule(&d->task);
 		}
-		spin_unlock_irqrestore(&c->lock, flags);
-		sa11x0_dma_desc_free(d, &head);
+		spin_unlock_irqrestore(&c->vc.lock, flags);
+		vchan_dma_desc_free_list(&c->vc, &head);
 		ret = 0;
 		break;
 
 	case DMA_PAUSE:
-		dev_dbg(d->slave.dev, "vchan %p: pause\n", c);
-		spin_lock_irqsave(&c->lock, flags);
+		dev_dbg(d->slave.dev, "vchan %p: pause\n", &c->vc);
+		spin_lock_irqsave(&c->vc.lock, flags);
 		if (c->status == DMA_IN_PROGRESS) {
 			c->status = DMA_PAUSED;
 
@@ -774,26 +683,26 @@ static int sa11x0_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 				spin_unlock(&d->lock);
 			}
 		}
-		spin_unlock_irqrestore(&c->lock, flags);
+		spin_unlock_irqrestore(&c->vc.lock, flags);
 		ret = 0;
 		break;
 
 	case DMA_RESUME:
-		dev_dbg(d->slave.dev, "vchan %p: resume\n", c);
-		spin_lock_irqsave(&c->lock, flags);
+		dev_dbg(d->slave.dev, "vchan %p: resume\n", &c->vc);
+		spin_lock_irqsave(&c->vc.lock, flags);
 		if (c->status == DMA_PAUSED) {
 			c->status = DMA_IN_PROGRESS;
 
 			p = c->phy;
 			if (p) {
 				writel(DCSR_RUN | DCSR_IE, p->base + DMA_DCSR_S);
-			} else if (!list_empty(&c->desc_issued)) {
+			} else if (!list_empty(&c->vc.desc_issued)) {
 				spin_lock(&d->lock);
 				list_add_tail(&c->node, &d->chan_pending);
 				spin_unlock(&d->lock);
 			}
 		}
-		spin_unlock_irqrestore(&c->lock, flags);
+		spin_unlock_irqrestore(&c->vc.lock, flags);
 		ret = 0;
 		break;
 
@@ -853,15 +762,13 @@ static int __devinit sa11x0_dma_init_dmadev(struct dma_device *dmadev,
 			return -ENOMEM;
 		}
 
-		c->chan.device = dmadev;
 		c->status = DMA_IN_PROGRESS;
 		c->ddar = chan_desc[i].ddar;
 		c->name = chan_desc[i].name;
-		spin_lock_init(&c->lock);
-		INIT_LIST_HEAD(&c->desc_submitted);
-		INIT_LIST_HEAD(&c->desc_issued);
 		INIT_LIST_HEAD(&c->node);
-		list_add_tail(&c->chan.device_node, &dmadev->channels);
+
+		c->vc.desc_free = sa11x0_dma_free_desc;
+		vchan_init(&c->vc, dmadev);
 	}
 
 	return dma_async_device_register(dmadev);
@@ -890,8 +797,9 @@ static void sa11x0_dma_free_channels(struct dma_device *dmadev)
 {
 	struct sa11x0_dma_chan *c, *cn;
 
-	list_for_each_entry_safe(c, cn, &dmadev->channels, chan.device_node) {
-		list_del(&c->chan.device_node);
+	list_for_each_entry_safe(c, cn, &dmadev->channels, vc.chan.device_node) {
+		list_del(&c->vc.chan.device_node);
+		tasklet_kill(&c->vc.task);
 		kfree(c);
 	}
 }
@@ -915,7 +823,6 @@ static int __devinit sa11x0_dma_probe(struct platform_device *pdev)
 
 	spin_lock_init(&d->lock);
 	INIT_LIST_HEAD(&d->chan_pending);
-	INIT_LIST_HEAD(&d->desc_complete);
 
 	d->base = ioremap(res->start, resource_size(res));
 	if (!d->base) {
diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
new file mode 100644
index 0000000..bd85b05
--- /dev/null
+++ b/drivers/dma/virt-dma.c
@@ -0,0 +1,99 @@
+/*
+ * Virtual DMA channel support for DMAengine
+ *
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+#include "virt-dma.h"
+
+static struct virt_dma_desc *to_virt_desc(struct dma_async_tx_descriptor *tx)
+{
+	return container_of(tx, struct virt_dma_desc, tx);
+}
+
+dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct virt_dma_chan *vc = to_virt_chan(tx->chan);
+	struct virt_dma_desc *vd = to_virt_desc(tx);
+	unsigned long flags;
+	dma_cookie_t cookie;
+
+	spin_lock_irqsave(&vc->lock, flags);
+	cookie = dma_cookie_assign(tx);
+
+	list_add_tail(&vd->node, &vc->desc_submitted);
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	dev_dbg(vc->chan.device->dev, "vchan %p: txd %p[%x]: submitted\n",
+		vc, vd, cookie);
+
+	return cookie;
+}
+EXPORT_SYMBOL_GPL(vchan_tx_submit);
+
+/*
+ * This tasklet handles the completion of a DMA descriptor by
+ * calling its callback and freeing it.
+ */
+static void vchan_complete(unsigned long arg)
+{
+	struct virt_dma_chan *vc = (struct virt_dma_chan *)arg;
+	LIST_HEAD(head);
+
+	spin_lock_irq(&vc->lock);
+	list_splice_tail_init(&vc->desc_completed, &head);
+	spin_unlock_irq(&vc->lock);
+
+	while (!list_empty(&head)) {
+		struct virt_dma_desc *vd = list_first_entry(&head,
+				struct virt_dma_desc, node);
+		dma_async_tx_callback cb = vd->tx.callback;
+		void *cb_data = vd->tx.callback_param;
+
+		list_del(&vd->node);
+
+		vc->desc_free(vd);
+
+		if (cb)
+			cb(cb_data);
+	}
+}
+
+void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct virt_dma_desc *vd = list_first_entry(head,
+			struct virt_dma_desc, node);
+		list_del(&vd->node);
+		dev_dbg(vc->chan.device->dev, "txd %p: freeing\n", vd);
+		vc->desc_free(vd);
+	}
+}
+EXPORT_SYMBOL_GPL(vchan_dma_desc_free_list);
+
+void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev)
+{
+	dma_cookie_init(&vc->chan);
+
+	spin_lock_init(&vc->lock);
+	INIT_LIST_HEAD(&vc->desc_submitted);
+	INIT_LIST_HEAD(&vc->desc_issued);
+	INIT_LIST_HEAD(&vc->desc_completed);
+
+	tasklet_init(&vc->task, vchan_complete, (unsigned long)vc);
+
+	vc->chan.device = dmadev;
+	list_add_tail(&vc->chan.device_node, &dmadev->channels);
+}
+EXPORT_SYMBOL_GPL(vchan_init);
+
+MODULE_AUTHOR("Russell King");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
new file mode 100644
index 0000000..825bb96
--- /dev/null
+++ b/drivers/dma/virt-dma.h
@@ -0,0 +1,138 @@
+/*
+ * Virtual DMA channel support for DMAengine
+ *
+ * Copyright (C) 2012 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef VIRT_DMA_H
+#define VIRT_DMA_H
+
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+
+#include "dmaengine.h"
+
+struct virt_dma_desc {
+	struct dma_async_tx_descriptor tx;
+	/* protected by vc.lock */
+	struct list_head node;
+};
+
+struct virt_dma_chan {
+	struct dma_chan	chan;
+	struct tasklet_struct task;
+	void (*desc_free)(struct virt_dma_desc *);
+
+	spinlock_t lock;
+
+	/* protected by vc.lock */
+	struct list_head desc_submitted;
+	struct list_head desc_issued;
+	struct list_head desc_completed;
+};
+
+static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct virt_dma_chan, chan);
+}
+
+void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head);
+
+void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev);
+
+/**
+ * vchan_tx_prep - prepare a descriptor
+ * vc: virtual channel allocating this descriptor
+ * vd: virtual descriptor to prepare
+ * tx_flags: flags argument passed in to prepare function
+ */
+static inline struct dma_async_tx_descriptor *vchan_tx_prep(struct virt_dma_chan *vc,
+	struct virt_dma_desc *vd, unsigned long tx_flags)
+{
+	extern dma_cookie_t vchan_tx_submit(struct dma_async_tx_descriptor *);
+
+	dma_async_tx_descriptor_init(&vd->tx, &vc->chan);
+	vd->tx.flags = tx_flags;
+	vd->tx.tx_submit = vchan_tx_submit;
+
+	return &vd->tx;
+}
+
+/**
+ * vchan_issue_pending - move submitted descriptors to issued list
+ * vc: virtual channel to update
+ *
+ * vc.lock must be held by caller
+ */
+static inline bool vchan_issue_pending(struct virt_dma_chan *vc)
+{
+	list_splice_tail_init(&vc->desc_submitted, &vc->desc_issued);
+	return !list_empty(&vc->desc_issued);
+}
+
+/**
+ * vchan_cookie_complete - report completion of a descriptor
+ * vd: virtual descriptor to update
+ *
+ * vc.lock must be held by caller
+ */
+static inline void vchan_cookie_complete(struct virt_dma_desc *vd)
+{
+	struct virt_dma_chan *vc = to_virt_chan(vd->tx.chan);
+
+	dma_cookie_complete(&vd->tx);
+	dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
+		vd, vd->tx.cookie);
+	list_add_tail(&vd->node, &vc->desc_completed);
+
+	tasklet_schedule(&vc->task);
+}
+
+/**
+ * vchan_next_desc - peek at the next descriptor to be processed
+ * vc: virtual channel to obtain descriptor from
+ *
+ * vc.lock must be held by caller
+ */
+static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_chan *vc)
+{
+	if (list_empty(&vc->desc_issued))
+		return NULL;
+
+	return list_first_entry(&vc->desc_issued, struct virt_dma_desc, node);
+}
+
+/**
+ * vchan_get_all_descriptors - obtain all submitted and issued descriptors
+ * vc: virtual channel to get descriptors from
+ * head: list of descriptors found
+ *
+ * vc.lock must be held by caller
+ *
+ * Removes all submitted and issued descriptors from internal lists, and
+ * provides a list of all descriptors found
+ */
+static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
+	struct list_head *head)
+{
+	list_splice_tail_init(&vc->desc_submitted, head);
+	list_splice_tail_init(&vc->desc_issued, head);
+	list_splice_tail_init(&vc->desc_completed, head);
+}
+
+static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
+{
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&vc->lock, flags);
+	vchan_get_all_descriptors(vc, &head);
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	vchan_dma_desc_free_list(vc, &head);
+}
+
+#endif
-- 
1.7.4.4

