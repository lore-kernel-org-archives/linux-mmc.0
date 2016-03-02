From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/3] mmc: pwrseq: convert to proper platform device
Date: Wed,  2 Mar 2016 16:45:43 +0000
Message-ID: <1456937143-27370-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456937078-27241-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456937078-27241-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mfuzzey@parkeon.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

simple-pwrseq and emmc-pwrseq drivers rely on platform_device
structure from of_find_device_by_node(), this works mostly. But, as there
is no driver associated with this devices, cases like default/init pinctrl
setup would never be performed by pwrseq. This becomes problem when the
gpios used in pwrseq require pinctrl setup.

Currently most of the common pinctrl setup is done in
drivers/base/pinctrl.c by pinctrl_bind_pins().

There are two ways to solve this issue on either convert pwrseq drivers
to a proper platform drivers or copy the exact code from
pcintrl_bind_pins(). I prefer converting pwrseq to proper drivers so that
other cases like setting up clks/parents from dt would also be possible.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/Kconfig         |  21 ++++++++
 drivers/mmc/core/Makefile        |   4 +-
 drivers/mmc/core/pwrseq.c        | 105 +++++++++++++++++----------------------
 drivers/mmc/core/pwrseq.h        |  19 ++++---
 drivers/mmc/core/pwrseq_emmc.c   |  75 +++++++++++++++++-----------
 drivers/mmc/core/pwrseq_simple.c |  79 ++++++++++++++++-------------
 6 files changed, 174 insertions(+), 129 deletions(-)

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 4c33d76..250f223 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -1,3 +1,24 @@
 #
 # MMC core configuration
 #
+config PWRSEQ_EMMC
+	tristate "HW reset support for eMMC"
+	default y
+	depends on OF
+	help
+	  This selects Hardware reset support aka pwrseq-emmc for eMMC
+	  devices. By default this option is set to y.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pwrseq_emmc.
+
+config PWRSEQ_SIMPLE
+	tristate "Simple HW reset support for MMC"
+	default y
+	depends on OF
+	help
+	  This selects simple hardware reset support aka pwrseq-simple for MMC
+	  devices. By default this option is set to y.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called pwrseq_simple.
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 2c25138..f007151 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,5 +8,7 @@ mmc_core-y			:= core.o bus.o host.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
 				   quirks.o slot-gpio.o
-mmc_core-$(CONFIG_OF)		+= pwrseq.o pwrseq_simple.o pwrseq_emmc.o
+mmc_core-$(CONFIG_OF)		+= pwrseq.o
+obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
+obj-$(CONFIG_PWRSEQ_EMMC)	+= pwrseq_emmc.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index 4c1d175..d6ab77d 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -8,88 +8,52 @@
  *  MMC power sequence management
  */
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 
 #include <linux/mmc/host.h>
 
 #include "pwrseq.h"
 
-struct mmc_pwrseq_match {
-	const char *compatible;
-	struct mmc_pwrseq *(*alloc)(struct mmc_host *host, struct device *dev);
-};
-
-static struct mmc_pwrseq_match pwrseq_match[] = {
-	{
-		.compatible = "mmc-pwrseq-simple",
-		.alloc = mmc_pwrseq_simple_alloc,
-	}, {
-		.compatible = "mmc-pwrseq-emmc",
-		.alloc = mmc_pwrseq_emmc_alloc,
-	},
-};
-
-static struct mmc_pwrseq_match *mmc_pwrseq_find(struct device_node *np)
-{
-	struct mmc_pwrseq_match *match = ERR_PTR(-ENODEV);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(pwrseq_match); i++) {
-		if (of_device_is_compatible(np,	pwrseq_match[i].compatible)) {
-			match = &pwrseq_match[i];
-			break;
-		}
-	}
-
-	return match;
-}
+static DEFINE_MUTEX(pwrseq_list_mutex);
+static LIST_HEAD(pwrseq_list);
 
 int mmc_pwrseq_alloc(struct mmc_host *host)
 {
-	struct platform_device *pdev;
 	struct device_node *np;
-	struct mmc_pwrseq_match *match;
-	struct mmc_pwrseq *pwrseq;
-	int ret = 0;
+	struct mmc_pwrseq *p, *pwrseq = NULL;
 
 	np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
 	if (!np)
 		return 0;
 
-	pdev = of_find_device_by_node(np);
-	if (!pdev) {
-		ret = -ENODEV;
-		goto err;
+	mutex_lock(&pwrseq_list_mutex);
+	list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
+		if (p->dev->of_node == np) {
+			pwrseq = p;
+			try_module_get(pwrseq->owner);
+			host->pwrseq = pwrseq;
+			break;
+		}
 	}
 
-	match = mmc_pwrseq_find(np);
-	if (IS_ERR(match)) {
-		ret = PTR_ERR(match);
-		goto err;
-	}
+	of_node_put(np);
+	mutex_unlock(&pwrseq_list_mutex);
 
-	pwrseq = match->alloc(host, &pdev->dev);
-	if (IS_ERR(pwrseq)) {
-		ret = PTR_ERR(pwrseq);
-		goto err;
-	}
+	if (!pwrseq)
+		return -EPROBE_DEFER;
 
-	host->pwrseq = pwrseq;
 	dev_info(host->parent, "allocated mmc-pwrseq\n");
 
-err:
-	of_node_put(np);
-	return ret;
+	return 0;
 }
 
 void mmc_pwrseq_pre_power_on(struct mmc_host *host)
 {
 	struct mmc_pwrseq *pwrseq = host->pwrseq;
 
-	if (pwrseq && pwrseq->ops && pwrseq->ops->pre_power_on)
+	if (pwrseq && pwrseq->ops->pre_power_on)
 		pwrseq->ops->pre_power_on(host);
 }
 
@@ -97,7 +61,7 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host)
 {
 	struct mmc_pwrseq *pwrseq = host->pwrseq;
 
-	if (pwrseq && pwrseq->ops && pwrseq->ops->post_power_on)
+	if (pwrseq && pwrseq->ops->post_power_on)
 		pwrseq->ops->post_power_on(host);
 }
 
@@ -105,7 +69,7 @@ void mmc_pwrseq_power_off(struct mmc_host *host)
 {
 	struct mmc_pwrseq *pwrseq = host->pwrseq;
 
-	if (pwrseq && pwrseq->ops && pwrseq->ops->power_off)
+	if (pwrseq && pwrseq->ops->power_off)
 		pwrseq->ops->power_off(host);
 }
 
@@ -113,8 +77,31 @@ void mmc_pwrseq_free(struct mmc_host *host)
 {
 	struct mmc_pwrseq *pwrseq = host->pwrseq;
 
-	if (pwrseq && pwrseq->ops && pwrseq->ops->free)
-		pwrseq->ops->free(host);
+	if (pwrseq) {
+		module_put(pwrseq->owner);
+		host->pwrseq = NULL;
+	}
+}
+
+int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
+{
+	if (!pwrseq || !pwrseq->ops || !pwrseq->dev)
+		return -EINVAL;
 
-	host->pwrseq = NULL;
+	mutex_lock(&pwrseq_list_mutex);
+	list_add(&pwrseq->pwrseq_node, &pwrseq_list);
+	mutex_unlock(&pwrseq_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mmc_pwrseq_register);
+
+void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq)
+{
+	if (pwrseq) {
+		mutex_lock(&pwrseq_list_mutex);
+		list_del(&pwrseq->pwrseq_node);
+		mutex_unlock(&pwrseq_list_mutex);
+	}
 }
+EXPORT_SYMBOL_GPL(mmc_pwrseq_unregister);
diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index 133de04..d69e751 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -8,32 +8,39 @@
 #ifndef _MMC_CORE_PWRSEQ_H
 #define _MMC_CORE_PWRSEQ_H
 
+#include <linux/mmc/host.h>
+
 struct mmc_pwrseq_ops {
 	void (*pre_power_on)(struct mmc_host *host);
 	void (*post_power_on)(struct mmc_host *host);
 	void (*power_off)(struct mmc_host *host);
-	void (*free)(struct mmc_host *host);
 };
 
 struct mmc_pwrseq {
 	const struct mmc_pwrseq_ops *ops;
+	struct device *dev;
+	struct list_head pwrseq_node;
+	struct module *owner;
 };
 
 #ifdef CONFIG_OF
 
+int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq);
+void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq);
+
 int mmc_pwrseq_alloc(struct mmc_host *host);
 void mmc_pwrseq_pre_power_on(struct mmc_host *host);
 void mmc_pwrseq_post_power_on(struct mmc_host *host);
 void mmc_pwrseq_power_off(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
-struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
-					   struct device *dev);
-struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
-					 struct device *dev);
-
 #else
 
+static inline int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
+{
+	return -ENOSYS;
+}
+static inline void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq) {}
 static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
 static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
 static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index c2d732a..adc9c0c 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -9,6 +9,9 @@
  */
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -42,20 +45,6 @@ static void mmc_pwrseq_emmc_reset(struct mmc_host *host)
 	__mmc_pwrseq_emmc_reset(pwrseq);
 }
 
-static void mmc_pwrseq_emmc_free(struct mmc_host *host)
-{
-	struct mmc_pwrseq_emmc *pwrseq =  to_pwrseq_emmc(host->pwrseq);
-
-	unregister_restart_handler(&pwrseq->reset_nb);
-	gpiod_put(pwrseq->reset_gpio);
-	kfree(pwrseq);
-}
-
-static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
-	.post_power_on = mmc_pwrseq_emmc_reset,
-	.free = mmc_pwrseq_emmc_free,
-};
-
 static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
 				    unsigned long mode, void *cmd)
 {
@@ -66,21 +55,22 @@ static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
-					 struct device *dev)
+static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
+	.post_power_on = mmc_pwrseq_emmc_reset,
+};
+
+static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_emmc *pwrseq;
-	int ret = 0;
+	struct device *dev = &pdev->dev;
 
-	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_emmc), GFP_KERNEL);
+	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	pwrseq->reset_gpio = gpiod_get(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(pwrseq->reset_gpio)) {
-		ret = PTR_ERR(pwrseq->reset_gpio);
-		goto free;
-	}
+	pwrseq->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(pwrseq->reset_gpio))
+		return PTR_ERR(pwrseq->reset_gpio);
 
 	/*
 	 * register reset handler to ensure emmc reset also from
@@ -92,9 +82,38 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
 	register_restart_handler(&pwrseq->reset_nb);
 
 	pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
+	pwrseq->pwrseq.dev = dev;
+	pwrseq->pwrseq.owner = THIS_MODULE;
+	platform_set_drvdata(pdev, pwrseq);
+
+	return mmc_pwrseq_register(&pwrseq->pwrseq);
+}
+
+static int mmc_pwrseq_emmc_remove(struct platform_device *pdev)
+{
+	struct mmc_pwrseq_emmc *pwrseq = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&pwrseq->reset_nb);
+	mmc_pwrseq_unregister(&pwrseq->pwrseq);
 
-	return &pwrseq->pwrseq;
-free:
-	kfree(pwrseq);
-	return ERR_PTR(ret);
+	return 0;
 }
+
+static const struct of_device_id mmc_pwrseq_emmc_of_match[] = {
+	{ .compatible = "mmc-pwrseq-emmc",},
+	{/* sentinel */},
+};
+
+MODULE_DEVICE_TABLE(of, mmc_pwrseq_emmc_of_match);
+
+static struct platform_driver mmc_pwrseq_emmc_driver = {
+	.probe = mmc_pwrseq_emmc_probe,
+	.remove = mmc_pwrseq_emmc_remove,
+	.driver = {
+		.name = "pwrseq_emmc",
+		.of_match_table = mmc_pwrseq_emmc_of_match,
+	},
+};
+
+module_platform_driver(mmc_pwrseq_emmc_driver);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 03573e1..2d2d79a 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -8,7 +8,10 @@
  *  Simple MMC power sequence management
  */
 #include <linux/clk.h>
+#include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -76,58 +79,64 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 	}
 }
 
-static void mmc_pwrseq_simple_free(struct mmc_host *host)
-{
-	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
-
-	if (!IS_ERR(pwrseq->reset_gpios))
-		gpiod_put_array(pwrseq->reset_gpios);
-
-	if (!IS_ERR(pwrseq->ext_clk))
-		clk_put(pwrseq->ext_clk);
-
-	kfree(pwrseq);
-}
-
 static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
 	.post_power_on = mmc_pwrseq_simple_post_power_on,
 	.power_off = mmc_pwrseq_simple_power_off,
-	.free = mmc_pwrseq_simple_free,
 };
 
-struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
-					   struct device *dev)
+static const struct of_device_id mmc_pwrseq_simple_of_match[] = {
+	{ .compatible = "mmc-pwrseq-simple",},
+	{/* sentinel */},
+};
+MODULE_DEVICE_TABLE(of, mmc_pwrseq_simple_of_match);
+
+static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
-	int ret = 0;
+	struct device *dev = &pdev->dev;
 
-	pwrseq = kzalloc(sizeof(*pwrseq), GFP_KERNEL);
+	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	pwrseq->ext_clk = clk_get(dev, "ext_clock");
-	if (IS_ERR(pwrseq->ext_clk) &&
-	    PTR_ERR(pwrseq->ext_clk) != -ENOENT) {
-		ret = PTR_ERR(pwrseq->ext_clk);
-		goto free;
-	}
+	pwrseq->ext_clk = devm_clk_get(dev, "ext_clock");
+	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
+		return PTR_ERR(pwrseq->ext_clk);
 
-	pwrseq->reset_gpios = gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
+	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
+							GPIOD_OUT_HIGH);
 	if (IS_ERR(pwrseq->reset_gpios) &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
-		ret = PTR_ERR(pwrseq->reset_gpios);
-		goto clk_put;
+		return PTR_ERR(pwrseq->reset_gpios);
 	}
 
+	pwrseq->pwrseq.dev = dev;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
+	pwrseq->pwrseq.owner = THIS_MODULE;
+	platform_set_drvdata(pdev, pwrseq);
 
-	return &pwrseq->pwrseq;
-clk_put:
-	if (!IS_ERR(pwrseq->ext_clk))
-		clk_put(pwrseq->ext_clk);
-free:
-	kfree(pwrseq);
-	return ERR_PTR(ret);
+	return mmc_pwrseq_register(&pwrseq->pwrseq);
 }
+
+static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
+{
+	struct mmc_pwrseq_simple *pwrseq = platform_get_drvdata(pdev);
+
+	mmc_pwrseq_unregister(&pwrseq->pwrseq);
+
+	return 0;
+}
+
+static struct platform_driver mmc_pwrseq_simple_driver = {
+	.probe = mmc_pwrseq_simple_probe,
+	.remove = mmc_pwrseq_simple_remove,
+	.driver = {
+		.name = "pwrseq_simple",
+		.of_match_table = mmc_pwrseq_simple_of_match,
+	},
+};
+
+module_platform_driver(mmc_pwrseq_simple_driver);
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
