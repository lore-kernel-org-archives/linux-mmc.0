From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 3/6] dmaengine: core: Introduce new,
 universal API to request a channel
Date: Fri, 27 Nov 2015 10:29:39 +0200
Message-ID: <1448612982-28141-4-git-send-email-peter.ujfalusi@ti.com>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The two API function can cover most, if not all current APIs used to
request a channel. With minimal effort dmaengine drivers, platforms and
dmaengine user drivers can be converted to use the two function.

struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);

To request any channel matching with the requested capabilities, can be
used to request channel for memcpy, memset, xor, etc where no hardware
synchronization is needed.

struct dma_chan *dma_request_chan(struct device *dev, const char *name,
				  const dma_cap_mask_t *mask);
To request a slave channel. The mask parameter is optional and it is used
to check if the received channel's capabilities can satisfy the requested
mask. The dma_request_chan() will try to find the channel via DT, ACPI or
in case if the kernel booted in non DT/ACPI mode it will use a filter
lookup table and retrieves the RESOURCE_DMA from the requester's device.
This legacy mode needs changes in platform code, in dmaengine drivers and
finally the dmaengine user drivers can be converted:

RESOURCE_DMA needs to be added to the platform devices with names

For each dmaengine driver a string array listing the devices handled by the
given DMA driver:

static char *da8xx_edma0_devices[] = {
	"davinci-mcasp.0",
	"da830-mmc.0",
};

This information is going to be needed by the dmaengine driver, so
modification to the platform_data is needed, and the driver map should be
added to the pdata of the DMA driver:

da8xx_edma0_pdata.devnames = da8xx_edma0_devices;
da8xx_edma0_pdata.devcnt = ARRAY_SIZE(da8xx_edma0_devices);

The DMA driver then needs to convigure the needed device -> filter_fn
mapping before it registers with dma_async_device_register() :

if (info->devnames) {
	ecc->dma_slave.filter_map.devnames = info->devnames;
	ecc->dma_slave.filter_map.devcnt = info->devcnt;
	ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
}

When neither DT or ACPI lookup is available the dma_request_chan() will
try to match the requester's device name with the filter_map's list of
device names, when a match found it will requests the named DMA resource
using the requester's pdev and with the needed information available it
will try to get the channele with the dma_get_channel() internal function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c   | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h | 21 +++++++++++
 2 files changed, 112 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 1249165fb4b2..14c8e8a76641 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -43,6 +43,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -715,6 +716,96 @@ struct dma_chan *dma_request_slave_channel(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dma_request_slave_channel);
 
+static bool dma_filter_dev_is_match(struct dma_device *device,
+				    struct device *dev)
+{
+	bool found = false;
+	int i;
+
+	if (!device->filter_map.devcnt)
+		return false;
+
+	for (i = 0; i < device->filter_map.devcnt; i++) {
+		if (!strcmp(device->filter_map.devnames[i], dev_name(dev))) {
+			found = true;
+			break;
+		}
+	}
+
+	return found;
+}
+
+struct dma_chan *dma_request_chan(struct device *dev, const char *name,
+				  const dma_cap_mask_t *mask)
+{
+	struct dma_device *device, *_d;
+	struct dma_chan *chan = NULL;
+
+	/* If device-tree is present get slave info from here */
+	if (dev->of_node)
+		chan = of_dma_request_slave_channel(dev->of_node, name);
+
+	/* If device was enumerated by ACPI get slave info from here */
+	if (ACPI_HANDLE(dev) && !chan)
+		chan = acpi_dma_request_slave_chan_by_name(dev, name);
+
+	if (chan)
+		goto validate;
+
+	/* Try to find the channel via the DMA filter map(s) */
+	mutex_lock(&dma_list_mutex);
+	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
+		bool match = dma_filter_dev_is_match(device, dev);
+		struct resource *r;
+
+		if (!match)
+			continue;
+
+		r = platform_get_resource_byname(to_platform_device(dev),
+						 IORESOURCE_DMA, name);
+		if (!r)
+			continue;
+
+		chan = dma_get_channel(device, mask,
+				       device->filter_map.filter_fn,
+				       &r->start);
+		if (!IS_ERR(chan))
+			break;
+	}
+	mutex_unlock(&dma_list_mutex);
+
+	if (!chan)
+		return ERR_PTR(-EPROBE_DEFER);
+validate:
+	if (IS_ERR(chan) || !mask)
+		return chan;
+
+	if (!__dma_device_satisfies_mask(chan->device, mask)) {
+		dev_dbg(chan->device->dev, "%s: wrong capabilities for %s:%s\n",
+			__func__, dev_name(dev), name);
+		dma_release_channel(chan);
+		chan = ERR_PTR(-ENODEV);
+	}
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(dma_request_chan);
+
+struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
+{
+	struct dma_chan *chan;
+
+	if (!mask)
+		return ERR_PTR(-ENODEV);
+
+	chan = __dma_request_channel(mask, NULL, NULL);
+	if (!chan)
+		chan = ERR_PTR(-ENODEV);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(dma_request_chan_by_mask);
+
 void dma_release_channel(struct dma_chan *chan)
 {
 	mutex_lock(&dma_list_mutex);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index a2b7c2071cf4..e17be9a136f1 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -606,6 +606,12 @@ enum dmaengine_alignment {
 	DMAENGINE_ALIGN_64_BYTES = 6,
 };
 
+struct dma_filter {
+	dma_filter_fn filter_fn;
+	int devcnt;
+	char **devnames;
+};
+
 /**
  * struct dma_device - info on the entity supplying DMA services
  * @chancnt: how many DMA channels are supported
@@ -669,6 +675,7 @@ struct dma_device {
 	unsigned int privatecnt;
 	struct list_head channels;
 	struct list_head global_node;
+	struct dma_filter filter_map;
 	dma_cap_mask_t  cap_mask;
 	unsigned short max_xor;
 	unsigned short max_pq;
@@ -1235,6 +1242,11 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 struct dma_chan *dma_request_slave_channel_reason(struct device *dev,
 						  const char *name);
 struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
+
+struct dma_chan *dma_request_chan(struct device *dev, const char *name,
+				  const dma_cap_mask_t *mask);
+struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
 #else
@@ -1268,6 +1280,15 @@ static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
 {
 	return NULL;
 }
+static inline struct dma_chan *dma_request_chan(struct device *dev,
+				const char *name, const dma_cap_mask_t *mask)
+{
+	return ERR_PTR(-ENODEV);
+}
+static inline struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
+{
+	return ERR_PTR(-ENODEV);
+}
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
-- 
2.6.3
