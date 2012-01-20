From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 04/31] ARM: amba: integrator: convert to use
 amba_device_alloc
Date: Fri, 20 Jan 2012 09:23:44 +0000
Message-ID: <E1RoAhE-0005EU-Tt@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37425 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab2ATJYK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:24:10 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>

Convert Integrator IM/PD-1 to use the new amba_device_alloc APIs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/impd1.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 8cbb75a..3e538da 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -401,24 +401,21 @@ static int impd1_probe(struct lm_device *dev)
 
 		pc_base = dev->resource.start + idev->offset;
 
-		d = kzalloc(sizeof(struct amba_device), GFP_KERNEL);
+		d = amba_device_alloc(NULL, pc_base, SZ_4K);
 		if (!d)
 			continue;
 
 		dev_set_name(&d->dev, "lm%x:%5.5lx", dev->id, idev->offset >> 12);
 		d->dev.parent	= &dev->dev;
-		d->res.start	= dev->resource.start + idev->offset;
-		d->res.end	= d->res.start + SZ_4K - 1;
-		d->res.flags	= IORESOURCE_MEM;
 		d->irq[0]	= dev->irq;
 		d->irq[1]	= dev->irq;
 		d->periphid	= idev->id;
 		d->dev.platform_data = idev->platform_data;
 
-		ret = amba_device_register(d, &dev->resource);
+		ret = amba_device_add(d, &dev->resource);
 		if (ret) {
 			dev_err(&d->dev, "unable to register device: %d\n", ret);
-			kfree(d);
+			amba_device_put(d);
 		}
 	}
 
-- 
1.7.4.4

