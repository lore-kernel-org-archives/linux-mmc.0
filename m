From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 02/15] dmaengine: core: Move and merge the code paths using
 private_candidate
Date: Wed, 2 Dec 2015 15:59:12 +0200
Message-ID: <1449064765-27427-3-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: tony@atomide.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Channel matching with private_candidate() is used in two paths, the error
checking is slightly different in them and they are duplicating code also.
Move the code under find_candidate() to provide consistent execution and
going to allow us to reuse this mode of channel lookup later.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c | 81 +++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6311e1fc80be..ea9d66982d40 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -546,6 +546,42 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 	return NULL;
 }
 
+static struct dma_chan *find_candidate(struct dma_device *device,
+				       const dma_cap_mask_t *mask,
+				       dma_filter_fn fn, void *fn_param)
+{
+	struct dma_chan *chan = private_candidate(mask, device, fn, fn_param);
+	int err;
+
+	if (chan) {
+		/* Found a suitable channel, try to grab, prep, and return it.
+		 * We first set DMA_PRIVATE to disable balance_ref_count as this
+		 * channel will not be published in the general-purpose
+		 * allocator
+		 */
+		dma_cap_set(DMA_PRIVATE, device->cap_mask);
+		device->privatecnt++;
+		err = dma_chan_get(chan);
+
+		if (err) {
+			if (err == -ENODEV) {
+				pr_debug("%s: %s module removed\n", __func__,
+					 dma_chan_name(chan));
+				list_del_rcu(&device->global_node);
+			} else
+				pr_debug("%s: failed to get %s: (%d)\n",
+					 __func__, dma_chan_name(chan), err);
+
+			if (--device->privatecnt == 0)
+				dma_cap_clear(DMA_PRIVATE, device->cap_mask);
+
+			chan = ERR_PTR(err);
+		}
+	}
+
+	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
+}
+
 /**
  * dma_get_slave_channel - try to get specific channel exclusively
  * @chan: target channel
@@ -584,7 +620,6 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
 {
 	dma_cap_mask_t mask;
 	struct dma_chan *chan;
-	int err;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -592,23 +627,11 @@ struct dma_chan *dma_get_any_slave_channel(struct dma_device *device)
 	/* lock against __dma_request_channel */
 	mutex_lock(&dma_list_mutex);
 
-	chan = private_candidate(&mask, device, NULL, NULL);
-	if (chan) {
-		dma_cap_set(DMA_PRIVATE, device->cap_mask);
-		device->privatecnt++;
-		err = dma_chan_get(chan);
-		if (err) {
-			pr_debug("%s: failed to get %s: (%d)\n",
-				__func__, dma_chan_name(chan), err);
-			chan = NULL;
-			if (--device->privatecnt == 0)
-				dma_cap_clear(DMA_PRIVATE, device->cap_mask);
-		}
-	}
+	chan = find_candidate(device, &mask, NULL, NULL);
 
 	mutex_unlock(&dma_list_mutex);
 
-	return chan;
+	return IS_ERR(chan) ? NULL : chan;
 }
 EXPORT_SYMBOL_GPL(dma_get_any_slave_channel);
 
@@ -625,35 +648,15 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 {
 	struct dma_device *device, *_d;
 	struct dma_chan *chan = NULL;
-	int err;
 
 	/* Find a channel */
 	mutex_lock(&dma_list_mutex);
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
-		chan = private_candidate(mask, device, fn, fn_param);
-		if (chan) {
-			/* Found a suitable channel, try to grab, prep, and
-			 * return it.  We first set DMA_PRIVATE to disable
-			 * balance_ref_count as this channel will not be
-			 * published in the general-purpose allocator
-			 */
-			dma_cap_set(DMA_PRIVATE, device->cap_mask);
-			device->privatecnt++;
-			err = dma_chan_get(chan);
+		chan = find_candidate(device, mask, fn, fn_param);
+		if (!IS_ERR(chan))
+			break;
 
-			if (err == -ENODEV) {
-				pr_debug("%s: %s module removed\n",
-					 __func__, dma_chan_name(chan));
-				list_del_rcu(&device->global_node);
-			} else if (err)
-				pr_debug("%s: failed to get %s: (%d)\n",
-					 __func__, dma_chan_name(chan), err);
-			else
-				break;
-			if (--device->privatecnt == 0)
-				dma_cap_clear(DMA_PRIVATE, device->cap_mask);
-			chan = NULL;
-		}
+		chan = NULL;
 	}
 	mutex_unlock(&dma_list_mutex);
 
-- 
2.6.3
