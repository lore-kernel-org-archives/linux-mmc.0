From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 03/15] dmaengine: core: Introduce new,
 universal API to request a channel
Date: Wed, 2 Dec 2015 15:59:13 +0200
Message-ID: <1449064765-27427-4-git-send-email-peter.ujfalusi@ti.com>
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

The two API function can cover most, if not all current APIs used to
request a channel. With minimal effort dmaengine drivers, platforms and
dmaengine user drivers can be converted to use the two function.

struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);

To request any channel matching with the requested capabilities, can be
used to request channel for memcpy, memset, xor, etc where no hardware
synchronization is needed.

struct dma_chan *dma_request_chan(struct device *dev, const char *name);
To request a slave channel. The dma_request_chan() will try to find the
channel via DT, ACPI or in case if the kernel booted in non DT/ACPI mode
it will use a filter lookup table and retrieves the needed information from
the dma_filter_map provided by the DMA drivers.
This legacy mode needs changes in platform code, in dmaengine drivers and
finally the dmaengine user drivers can be converted:

For each dmaengine driver an array of DMA device, slave and the parameter
for the filter function needs to be added:

static const struct dma_filter_map da830_edma_map[] = {
	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
	{ "davinci-mcasp.1", "rx", EDMA_FILTER_PARAM(0, 2) },
	{ "davinci-mcasp.1", "tx", EDMA_FILTER_PARAM(0, 3) },
	{ "davinci-mcasp.2", "rx", EDMA_FILTER_PARAM(0, 4) },
	{ "davinci-mcasp.2", "tx", EDMA_FILTER_PARAM(0, 5) },
	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
};

This information is going to be needed by the dmaengine driver, so
modification to the platform_data is needed, and the driver map should be
added to the pdata of the DMA driver:

da8xx_edma0_pdata.slave_map = da830_edma_map;
da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da830_edma_map);

The DMA driver then needs to configure the needed device -> filter_fn
mapping before it registers with dma_async_device_register() :

if (info->slave_map) {
	ecc->dma_slave.filter_map.map = info->slave_map;
	ecc->dma_slave.filter_map.mapcnt = info->slavecnt;
	ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
}

When neither DT or ACPI lookup is available the dma_request_chan() will
try to match the requester's device name with the filter_map's list of
device names, when a match found it will use the information from the
dma_filter_map to get the channel with the dma_get_channel() internal
function.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/dmaengine/client.txt | 23 +++------
 drivers/dma/dmaengine.c            | 98 ++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h          | 27 +++++++++++
 3 files changed, 131 insertions(+), 17 deletions(-)

diff --git a/Documentation/dmaengine/client.txt b/Documentation/dmaengine/client.txt
index d9f9f461102a..6c72a06eb1a5 100644
--- a/Documentation/dmaengine/client.txt
+++ b/Documentation/dmaengine/client.txt
@@ -22,25 +22,14 @@ The slave DMA usage consists of following steps:
    Channel allocation is slightly different in the slave DMA context,
    client drivers typically need a channel from a particular DMA
    controller only and even in some cases a specific channel is desired.
-   To request a channel dma_request_channel() API is used.
+   To request a channel dma_request_chan() API is used.
 
    Interface:
-	struct dma_chan *dma_request_channel(dma_cap_mask_t mask,
-			dma_filter_fn filter_fn,
-			void *filter_param);
-   where dma_filter_fn is defined as:
-	typedef bool (*dma_filter_fn)(struct dma_chan *chan, void *filter_param);
-
-   The 'filter_fn' parameter is optional, but highly recommended for
-   slave and cyclic channels as they typically need to obtain a specific
-   DMA channel.
-
-   When the optional 'filter_fn' parameter is NULL, dma_request_channel()
-   simply returns the first channel that satisfies the capability mask.
-
-   Otherwise, the 'filter_fn' routine will be called once for each free
-   channel which has a capability in 'mask'.  'filter_fn' is expected to
-   return 'true' when the desired DMA channel is found.
+	struct dma_chan *dma_request_chan(struct device *dev, const char *name);
+
+   Which will find and return the 'name' DMA channel associated with the 'dev'
+   device. The association is done via DT, ACPI or board file based
+   dma_map_filter matching table.
 
    A channel allocated via this interface is exclusive to the caller,
    until dma_release_channel() is called.
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ea9d66982d40..b9dc1512c4aa 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -43,6 +43,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -712,6 +713,103 @@ struct dma_chan *dma_request_slave_channel(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dma_request_slave_channel);
 
+const static struct dma_filter_map *dma_filter_match(struct dma_device *device,
+					       const char *name,
+					       struct device *dev)
+{
+	const struct dma_filter_map *map_found = NULL;
+	int i;
+
+	if (!device->filter_map.mapcnt)
+		return NULL;
+
+	for (i = 0; i < device->filter_map.mapcnt; i++) {
+		const struct dma_filter_map *map = &device->filter_map.map[i];
+
+		if (!strcmp(map->devname, dev_name(dev)) &&
+		    !strcmp(map->slave, name)) {
+			map_found = map;
+			break;
+		}
+	}
+
+	return map_found;
+}
+
+/**
+ * dma_request_chan - try to allocate an exclusive slave channel
+ * @dev:	pointer to client device structure
+ * @name:	slave channel name
+ *
+ * Returns pointer to appropriate DMA channel on success or an error pointer.
+ */
+struct dma_chan *dma_request_chan(struct device *dev, const char *name)
+{
+	struct dma_device *device, *_d;
+	struct dma_chan *chan = NULL;
+
+	/* If device-tree is present get slave info from here */
+	if (dev->of_node)
+		chan = of_dma_request_slave_channel(dev->of_node, name);
+
+	/* If device was enumerated by ACPI get slave info from here */
+	if (has_acpi_companion(dev) && !chan)
+		chan = acpi_dma_request_slave_chan_by_name(dev, name);
+
+	if (chan) {
+		/* Valid channel found */
+		if (!IS_ERR(chan))
+			return chan;
+
+		pr_warn("%s: %s DMA request failed, falling back to legacy\n",
+			__func__, dev->of_node ? "OF" : "ACPI");
+	}
+
+	/* Try to find the channel via the DMA filter map(s) */
+	mutex_lock(&dma_list_mutex);
+	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
+		dma_cap_mask_t mask;
+		const struct dma_filter_map *map = dma_filter_match(device,
+								    name, dev);
+
+		if (!map)
+			continue;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+
+		chan = find_candidate(device, &mask,
+				      device->filter_map.filter_fn, map->param);
+		if (!IS_ERR(chan))
+			break;
+	}
+	mutex_unlock(&dma_list_mutex);
+
+	return chan ? chan : ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL_GPL(dma_request_chan);
+
+/**
+ * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
+ * @mask: capabilities that the channel must satisfy
+ *
+ * Returns pointer to appropriate DMA channel on success or an error pointer.
+ */
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
index a2b7c2071cf4..49d48e69c179 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -606,6 +606,18 @@ enum dmaengine_alignment {
 	DMAENGINE_ALIGN_64_BYTES = 6,
 };
 
+struct dma_filter_map {
+        char *devname;
+        char *slave;
+        void *param;
+};
+
+struct dma_filter {
+        dma_filter_fn filter_fn;
+        int mapcnt;
+        const struct dma_filter_map *map;
+};
+
 /**
  * struct dma_device - info on the entity supplying DMA services
  * @chancnt: how many DMA channels are supported
@@ -669,6 +681,7 @@ struct dma_device {
 	unsigned int privatecnt;
 	struct list_head channels;
 	struct list_head global_node;
+	struct dma_filter filter_map;
 	dma_cap_mask_t  cap_mask;
 	unsigned short max_xor;
 	unsigned short max_pq;
@@ -1235,6 +1248,10 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 struct dma_chan *dma_request_slave_channel_reason(struct device *dev,
 						  const char *name);
 struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
+
+struct dma_chan *dma_request_chan(struct device *dev, const char *name);
+struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
+
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
 #else
@@ -1268,6 +1285,16 @@ static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
 {
 	return NULL;
 }
+static inline struct dma_chan *dma_request_chan(struct device *dev,
+						const char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+static inline struct dma_chan *dma_request_chan_by_mask(
+						const dma_cap_mask_t *mask)
+{
+	return ERR_PTR(-ENODEV);
+}
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
-- 
2.6.3
