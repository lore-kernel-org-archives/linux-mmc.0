From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 1/3] dmaengine: add dma_get_slave_sg_limits()
Date: Wed, 6 Mar 2013 14:56:05 -0500
Message-ID: <1362599767-11292-2-git-send-email-mporter@ti.com>
References: <1362599767-11292-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1362599767-11292-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add a dmaengine API to retrieve slave SG transfer limits.

The API is optionally implemented by dmaengine drivers and when
unimplemented will return a NULL pointer. A client driver using
this API provides the required dma channel, address width, and
burst size of the transfer. dma_get_slave_sg_limits() returns an
SG limits structure with the maximum number and size of SG segments
that the given channel can handle.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
---
 include/linux/dmaengine.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 91ac8da..a4a6aac 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -371,6 +371,18 @@ struct dma_slave_config {
 	unsigned int slave_id;
 };
 
+/* struct dma_slave_sg_limits - expose SG transfer limits of a channel
+ *
+ * @max_seg_nr: maximum number of SG segments supported on a SG/SLAVE
+ *	    channel (0 for no maximum or not a SG/SLAVE channel)
+ * @max_seg_len: maximum length of SG segments supported on a SG/SLAVE
+ *	     channel (0 for no maximum or not a SG/SLAVE channel)
+ */
+struct dma_slave_sg_limits {
+	u32 max_seg_nr;
+	u32 max_seg_len;
+};
+
 static inline const char *dma_chan_name(struct dma_chan *chan)
 {
 	return dev_name(&chan->dev->device);
@@ -534,6 +546,7 @@ struct dma_tx_state {
  *	struct with auxiliary transfer status information, otherwise the call
  *	will just return a simple status code
  * @device_issue_pending: push pending transactions to hardware
+ * @device_slave_sg_limits: return the slave SG capabilities
  */
 struct dma_device {
 
@@ -602,6 +615,9 @@ struct dma_device {
 					    dma_cookie_t cookie,
 					    struct dma_tx_state *txstate);
 	void (*device_issue_pending)(struct dma_chan *chan);
+	struct dma_slave_sg_limits *(*device_slave_sg_limits)(
+		struct dma_chan *chan, enum dma_slave_buswidth addr_width,
+		u32 maxburst);
 };
 
 static inline int dmaengine_device_control(struct dma_chan *chan,
@@ -963,6 +979,29 @@ dma_set_tx_state(struct dma_tx_state *st, dma_cookie_t last, dma_cookie_t used,
 	}
 }
 
+/**
+ * dma_get_slave_sg_limits - get DMAC SG transfer capabilities
+ * @chan: target DMA channel
+ * @addr_width: address width of the DMA transfer
+ * @maxburst: maximum DMA transfer burst size
+ *
+ * Get SG transfer capabilities for a specified channel. If the dmaengine
+ * driver does not implement SG transfer capabilities then NULL is
+ * returned.
+ */
+static inline struct dma_slave_sg_limits
+*dma_get_slave_sg_limits(struct dma_chan *chan,
+		       enum dma_slave_buswidth addr_width,
+		       u32 maxburst)
+{
+	if (chan->device->device_slave_sg_limits)
+		return chan->device->device_slave_sg_limits(chan,
+							  addr_width,
+							  maxburst);
+
+	return NULL;
+}
+
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie);
 #ifdef CONFIG_DMA_ENGINE
 enum dma_status dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx);
-- 
1.7.9.5
