From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 05/31] ARM: amba: mxs: convert to use amba_device_alloc
Date: Fri, 20 Jan 2012 09:24:05 +0000
Message-ID: <E1RoAhZ-0005EY-BZ@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37433 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab2ATJYc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:24:32 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Convert MXS to use the new amba_device_alloc APIs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-mxs/devices.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mxs/devices.c b/arch/arm/mach-mxs/devices.c
index fe3e847..052d8dd 100644
--- a/arch/arm/mach-mxs/devices.c
+++ b/arch/arm/mach-mxs/devices.c
@@ -77,16 +77,18 @@ struct platform_device *__init mxs_add_platform_device_dmamask(
 
 int __init mxs_add_amba_device(const struct amba_device *dev)
 {
-	struct amba_device *adev = kmalloc(sizeof(*adev), GFP_KERNEL);
+	struct amba_device *adev = amba_device_alloc(dev->init_name,
+		dev->res.start, resource_size(&dev->res));
 
 	if (!adev) {
 		pr_err("%s: failed to allocate memory", __func__);
 		return -ENOMEM;
 	}
 
-	*adev = *dev;
+	adev->irq[0] = dev->irq[0];
+	adev->irq[1] = dev->irq[1];
 
-	return amba_device_register(adev, &iomem_resource);
+	return amba_device_add(adev, &iomem_resource);
 }
 
 struct device mxs_apbh_bus = {
-- 
1.7.4.4

