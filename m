From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 01/31] ARM: amba: add amba_device allocation/add/put functions
Date: Fri, 20 Jan 2012 09:22:43 +0000
Message-ID: <E1RoAgF-0005EI-Sg@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

Add functions to allocate and initialize AMBA device structures, and
add them to the Linux device manager.  This allows us to kill this
type of operation from individual platforms, moving it to core code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/amba/bus.c       |  100 ++++++++++++++++++++++++++++++++++-----------
 include/linux/amba/bus.h |    3 +
 2 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 54eaf96..82b65e1 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -497,38 +497,20 @@ static void amba_device_release(struct device *dev)
 }
 
 /**
- *	amba_device_register - register an AMBA device
- *	@dev: AMBA device to register
- *	@parent: parent memory resource
+ *	amba_device_add - add a previously allocated AMBA device structure
+ *	@dev: AMBA device allocated by amba_device_alloc
+ *	@parent: resource parent for this devices resources
  *
- *	Setup the AMBA device, reading the cell ID if present.
- *	Claim the resource, and register the AMBA device with
- *	the Linux device manager.
+ *	Claim the resource, and read the device cell ID if not already
+ *	initialized.  Register the AMBA device with the Linux device
+ *	manager.
  */
-int amba_device_register(struct amba_device *dev, struct resource *parent)
+int amba_device_add(struct amba_device *dev, struct resource *parent)
 {
 	u32 size;
 	void __iomem *tmp;
 	int i, ret;
 
-	device_initialize(&dev->dev);
-
-	/*
-	 * Copy from device_add
-	 */
-	if (dev->dev.init_name) {
-		dev_set_name(&dev->dev, "%s", dev->dev.init_name);
-		dev->dev.init_name = NULL;
-	}
-
-	dev->dev.release = amba_device_release;
-	dev->dev.bus = &amba_bustype;
-	dev->dev.dma_mask = &dev->dma_mask;
-	dev->res.name = dev_name(&dev->dev);
-
-	if (!dev->dev.coherent_dma_mask && dev->dma_mask)
-		dev_warn(&dev->dev, "coherent dma mask is unset\n");
-
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		goto err_out;
@@ -596,6 +578,74 @@ int amba_device_register(struct amba_device *dev, struct resource *parent)
  err_out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(amba_device_add);
+
+static void amba_device_initialize(struct amba_device *dev, const char *name)
+{
+	device_initialize(&dev->dev);
+	if (name)
+		dev_set_name(&dev->dev, "%s", name);
+	dev->dev.release = amba_device_release;
+	dev->dev.bus = &amba_bustype;
+	dev->dev.dma_mask = &dev->dma_mask;
+	dev->res.name = dev_name(&dev->dev);
+}
+
+/**
+ *	amba_device_alloc - allocate an AMBA device
+ *	@name: sysfs name of the AMBA device
+ *	@base: base of AMBA device
+ *	@size: size of AMBA device
+ *
+ *	Allocate and initialize an AMBA device structure.  Returns %NULL
+ *	on failure.
+ */
+struct amba_device *amba_device_alloc(const char *name, resource_size_t base,
+	size_t size)
+{
+	struct amba_device *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (dev) {
+		amba_device_initialize(dev, name);
+		dev->res.start = base;
+		dev->res.end = base + size - 1;
+		dev->res.flags = IORESOURCE_MEM;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(amba_device_alloc);
+
+/**
+ *	amba_device_register - register an AMBA device
+ *	@dev: AMBA device to register
+ *	@parent: parent memory resource
+ *
+ *	Setup the AMBA device, reading the cell ID if present.
+ *	Claim the resource, and register the AMBA device with
+ *	the Linux device manager.
+ */
+int amba_device_register(struct amba_device *dev, struct resource *parent)
+{
+	amba_device_initialize(dev, dev->dev.init_name);
+	dev->dev.init_name = NULL;
+
+	if (!dev->dev.coherent_dma_mask && dev->dma_mask)
+		dev_warn(&dev->dev, "coherent dma mask is unset\n");
+
+	return amba_device_add(dev, parent);
+}
+
+/**
+ *	amba_device_put - put an AMBA device
+ *	@dev: AMBA device to put
+ */
+void amba_device_put(struct amba_device *dev)
+{
+	put_device(&dev->dev);
+}
+EXPORT_SYMBOL_GPL(amba_device_put);
 
 /**
  *	amba_device_unregister - unregister an AMBA device
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 724c69c..e192962 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -60,6 +60,9 @@ extern struct bus_type amba_bustype;
 
 int amba_driver_register(struct amba_driver *);
 void amba_driver_unregister(struct amba_driver *);
+struct amba_device *amba_device_alloc(const char *, resource_size_t, size_t);
+void amba_device_put(struct amba_device *);
+int amba_device_add(struct amba_device *, struct resource *);
 int amba_device_register(struct amba_device *, struct resource *);
 void amba_device_unregister(struct amba_device *);
 struct amba_device *amba_find_device(const char *, struct device *, unsigned int, unsigned int);
-- 
1.7.4.4
