From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 02/31] ARM: amba: of: convert to use amba_device_alloc
Date: Fri, 20 Jan 2012 09:23:04 +0000
Message-ID: <E1RoAga-0005EM-1q@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37402 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab2ATJXb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 04:23:31 -0500
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson <STEricsson_nomadik_linux@list.st.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>

Convert DT code to use the new amba_device_alloc APIs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/of/platform.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 63b3ec4..cae9477 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -253,7 +253,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	if (!of_device_is_available(node))
 		return NULL;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	dev = amba_device_alloc(NULL, 0, 0);
 	if (!dev)
 		return NULL;
 
@@ -283,14 +283,14 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	if (ret)
 		goto err_free;
 
-	ret = amba_device_register(dev, &iomem_resource);
+	ret = amba_device_add(dev, &iomem_resource);
 	if (ret)
 		goto err_free;
 
 	return dev;
 
 err_free:
-	kfree(dev);
+	amba_device_put(dev);
 	return NULL;
 }
 #else /* CONFIG_ARM_AMBA */
-- 
1.7.4.4

