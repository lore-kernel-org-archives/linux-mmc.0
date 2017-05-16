From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH 4/5] of/platform: Make of_platform_device_destroy globally visible
Date: Tue, 16 May 2017 11:36:54 +0200
Message-ID: <20170516093655.17746-5-jglauber@cavium.com>
References: <20170516093655.17746-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170516093655.17746-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: David Daney <david.daney@cavium.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

of_platform_device_destroy is the counterpart to
of_platform_device_create which is a non-static function.

After creating a platform device it might be necessary
to destroy it to deal with -EPROBE_DEFER where a
repeated of_platform_device_create call would fail otherwise.

Therefore also make of_platform_device_destroy globally visible.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/of/platform.c       | 3 ++-
 include/linux/of_platform.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 71fecc2..703a421 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -523,7 +523,7 @@ static int __init of_platform_default_populate_init(void)
 arch_initcall_sync(of_platform_default_populate_init);
 #endif
 
-static int of_platform_device_destroy(struct device *dev, void *data)
+int of_platform_device_destroy(struct device *dev, void *data)
 {
 	/* Do not touch devices not populated from the device tree */
 	if (!dev->of_node || !of_node_check_flag(dev->of_node, OF_POPULATED))
@@ -544,6 +544,7 @@ static int of_platform_device_destroy(struct device *dev, void *data)
 	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(of_platform_device_destroy);
 
 /**
  * of_platform_depopulate() - Remove devices populated from device tree
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index dc8224a..e0d1946 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -64,6 +64,7 @@ extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent);
 
+extern int of_platform_device_destroy(struct device *dev, void *data);
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
-- 
2.9.0.rc0.21.g7777322
