From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 03/31] ARM: amba: ux500: convert to use amba_device_alloc
Date: Fri, 20 Jan 2012 09:23:24 +0000
Message-ID: <E1RoAgu-0005EQ-Fo@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

Convert ux500 to use the new amba_device_alloc APIs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-ux500/devices-common.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index c563e54..e8c34fa 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -26,16 +26,10 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
 	struct amba_device *dev;
 	int ret;
 
-	dev = kzalloc(sizeof *dev, GFP_KERNEL);
+	dev = amba_device_alloc(name, base, SZ_4K);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev->dev.init_name = name;
-
-	dev->res.start = base;
-	dev->res.end = base + SZ_4K - 1;
-	dev->res.flags = IORESOURCE_MEM;
-
 	dev->dma_mask = DMA_BIT_MASK(32);
 	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 
@@ -46,9 +40,9 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
 
 	dev->dev.platform_data = pdata;
 
-	ret = amba_device_register(dev, &iomem_resource);
+	ret = amba_device_add(dev, &iomem_resource);
 	if (ret) {
-		kfree(dev);
+		amba_device_put(dev);
 		return ERR_PTR(ret);
 	}
 
-- 
1.7.4.4

