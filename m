From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 18/31] ARM: amba: provide common initializers for static amba
 devices
Date: Fri, 20 Jan 2012 09:28:30 +0000
Message-ID: <E1RoAlq-0005FT-1b@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60996 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2ATJ2y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:28:54 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/amba/bus.h |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index e192962..a9fab83 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -92,4 +92,37 @@ void amba_release_regions(struct amba_device *);
 #define amba_manf(d)	AMBA_MANF_BITS((d)->periphid)
 #define amba_part(d)	AMBA_PART_BITS((d)->periphid)
 
+#define __AMBA_DEV(busid, data, mask)				\
+	{							\
+		.coherent_dma_mask = mask,			\
+		.init_name = busid,				\
+		.platform_data = data,				\
+	}
+
+/*
+ * APB devices do not themselves have the ability to address memory,
+ * so DMA masks should be zero (much like USB peripheral devices.)
+ * The DMA controller DMA masks should be used instead (much like
+ * USB host controllers in conventional PCs.)
+ */
+#define AMBA_APB_DEVICE(name, busid, id, base, irqs, data)	\
+struct amba_device name##_device = {				\
+	.dev = __AMBA_DEV(busid, data, 0),			\
+	.res = DEFINE_RES_MEM(base, SZ_4K),			\
+	.irq = irqs,						\
+	.periphid = id,						\
+}
+
+/*
+ * AHB devices are DMA capable, so set their DMA masks
+ */
+#define AMBA_AHB_DEVICE(name, busid, id, base, irqs, data)	\
+struct amba_device name##_device = {				\
+	.dev = __AMBA_DEV(busid, data, ~0ULL),			\
+	.res = DEFINE_RES_MEM(base, SZ_4K),			\
+	.dma_mask = ~0ULL,					\
+	.irq = irqs,						\
+	.periphid = id,						\
+}
+
 #endif
-- 
1.7.4.4

