From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 03/13] pinctrl-jz4780: add a pinctrl driver for the Ingenic jz4780 SoC
Date: Wed, 18 Jan 2017 00:14:11 +0100
Message-ID: <20170117231421.16310-4-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

This driver reuses the core of the driver already present in
pinctrl-ingenic.c, and just supplies callbacks to perform the low-level
operations.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/ingenic/Kconfig          |   6 ++
 drivers/pinctrl/ingenic/Makefile         |   1 +
 drivers/pinctrl/ingenic/pinctrl-jz4780.c | 179 +++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/pinctrl/ingenic/pinctrl-jz4780.c

diff --git a/drivers/pinctrl/ingenic/Kconfig b/drivers/pinctrl/ingenic/Kconfig
index 9923ce127183..15b6514c1948 100644
--- a/drivers/pinctrl/ingenic/Kconfig
+++ b/drivers/pinctrl/ingenic/Kconfig
@@ -12,3 +12,9 @@ config PINCTRL_JZ4740
 	default y
 	depends on MACH_JZ4740 || COMPILE_TEST
 	select PINCTRL_INGENIC
+
+config PINCTRL_JZ4780
+	bool "Pinctrl driver for the Ingenic JZ4780 SoC"
+	default y
+	depends on MACH_JZ4780 || COMPILE_TEST
+	select PINCTRL_INGENIC
diff --git a/drivers/pinctrl/ingenic/Makefile b/drivers/pinctrl/ingenic/Makefile
index 8b2c8b789dc9..ad691f053207 100644
--- a/drivers/pinctrl/ingenic/Makefile
+++ b/drivers/pinctrl/ingenic/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
 obj-$(CONFIG_PINCTRL_JZ4740)	+= pinctrl-jz4740.o
+obj-$(CONFIG_PINCTRL_JZ4780)	+= pinctrl-jz4780.o
diff --git a/drivers/pinctrl/ingenic/pinctrl-jz4780.c b/drivers/pinctrl/ingenic/pinctrl-jz4780.c
new file mode 100644
index 000000000000..a191cd1711e7
--- /dev/null
+++ b/drivers/pinctrl/ingenic/pinctrl-jz4780.c
@@ -0,0 +1,179 @@
+/*
+ * Ingenic jz4780 pinctrl driver
+ *
+ * Copyright (c) 2013 Imagination Technologies
+ * Copyright (c) 2017 Paul Cercueil <paul@crapouillou.net>
+ *
+ * Authors: Paul Burton <paul.burton@imgtec.com>,
+ *          Paul Cercueil <paul@crapouillou.net>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include "pinctrl-ingenic.h"
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+/* GPIO port register offsets */
+#define GPIO_PIN	0x00
+#define GPIO_INT	0x10
+#define GPIO_INTS	0x14
+#define GPIO_INTC	0x18
+#define GPIO_MSK	0x20
+#define GPIO_MSKS	0x24
+#define GPIO_MSKC	0x28
+#define GPIO_PAT1	0x30
+#define GPIO_PAT1S	0x34
+#define GPIO_PAT1C	0x38
+#define GPIO_PAT0	0x40
+#define GPIO_PAT0S	0x44
+#define GPIO_PAT0C	0x48
+#define GPIO_FLG	0x50
+#define GPIO_FLGC	0x58
+#define GPIO_PEN	0x70
+#define GPIO_PENS	0x74
+#define GPIO_PENC	0x78
+
+static void jz4780_set_gpio(void __iomem *base,
+		unsigned int offset, bool output)
+{
+	writel(1 << offset, base + GPIO_INTC);
+	writel(1 << offset, base + GPIO_MSKS);
+
+	if (output)
+		writel(1 << offset, base + GPIO_PAT1C);
+	else
+		writel(1 << offset, base + GPIO_PAT1S);
+}
+
+static int jz4780_get_bias(void __iomem *base, unsigned int offset)
+{
+	return !((readl(base + GPIO_PEN) >> offset) & 0x1);
+}
+
+static void jz4780_set_bias(void __iomem *base,
+		unsigned int offset, bool enable)
+{
+	if (enable)
+		writel(1 << offset, base + GPIO_PENC);
+	else
+		writel(1 << offset, base + GPIO_PENS);
+}
+
+static void jz4780_gpio_set_value(void __iomem *base,
+		unsigned int offset, int value)
+{
+	if (value)
+		writel(1 << offset, base + GPIO_PAT0S);
+	else
+		writel(1 << offset, base + GPIO_PAT0C);
+}
+
+static int jz4780_gpio_get_value(void __iomem *base, unsigned int offset)
+{
+	return (readl(base + GPIO_PIN) >> offset) & 0x1;
+}
+
+static u32 jz4780_irq_read(void __iomem *base)
+{
+	return readl(base + GPIO_FLG);
+}
+
+static void jz4780_irq_mask(void __iomem *base, unsigned int offset, bool mask)
+{
+	if (mask)
+		writel(1 << offset, base + GPIO_MSKS);
+	else
+		writel(1 << offset, base + GPIO_MSKC);
+}
+
+static void jz4780_irq_ack(void __iomem *base, unsigned int offset)
+{
+	writel(1 << offset, base + GPIO_FLGC);
+}
+
+static void jz4780_irq_set_type(void __iomem *base,
+		unsigned int offset, unsigned int type)
+{
+	enum {
+		PAT_EDGE_RISING		= 0x3,
+		PAT_EDGE_FALLING	= 0x2,
+		PAT_LEVEL_HIGH		= 0x1,
+		PAT_LEVEL_LOW		= 0x0,
+	} pat;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		pat = PAT_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		pat = PAT_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		pat = PAT_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+	default:
+		pat = PAT_LEVEL_LOW;
+		break;
+	};
+
+	writel(1 << offset, base + ((pat & 0x2) ? GPIO_PAT1S : GPIO_PAT1C));
+	writel(1 << offset, base + ((pat & 0x1) ? GPIO_PAT0S : GPIO_PAT0C));
+	writel(1 << offset, base + GPIO_INTS);
+}
+
+static void jz4780_set_function(void __iomem *base,
+		unsigned int offset, unsigned int func)
+{
+	writel(1 << offset, base + GPIO_INTC);
+	writel(1 << offset, base + GPIO_MSKC);
+	writel(1 << offset, base + ((func & 0x2) ? GPIO_PAT1S : GPIO_PAT1C));
+	writel(1 << offset, base + ((func & 0x1) ? GPIO_PAT0S : GPIO_PAT0C));
+}
+
+static const struct ingenic_pinctrl_ops jz4780_pinctrl_ops = {
+	.nb_functions	= 4,
+	.set_function	= jz4780_set_function,
+	.set_gpio	= jz4780_set_gpio,
+	.set_bias	= jz4780_set_bias,
+	.get_bias	= jz4780_get_bias,
+	.gpio_set_value	= jz4780_gpio_set_value,
+	.gpio_get_value	= jz4780_gpio_get_value,
+	.irq_read	= jz4780_irq_read,
+	.irq_mask	= jz4780_irq_mask,
+	.irq_ack	= jz4780_irq_ack,
+	.irq_set_type	= jz4780_irq_set_type,
+};
+
+static int jz4780_pinctrl_probe(struct platform_device *pdev)
+{
+	return ingenic_pinctrl_probe(pdev, &jz4780_pinctrl_ops);
+}
+
+static const struct of_device_id jz4780_pinctrl_dt_match[] = {
+	{ .compatible = "ingenic,jz4780-pinctrl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4780_pinctrl_dt_match);
+
+
+static struct platform_driver jz4780_pinctrl_driver = {
+	.driver = {
+		.name = "jz4780-pinctrl",
+		.of_match_table = of_match_ptr(jz4780_pinctrl_dt_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = jz4780_pinctrl_probe,
+};
+
+static int __init jz4780_pinctrl_drv_register(void)
+{
+	return platform_driver_register(&jz4780_pinctrl_driver);
+}
+postcore_initcall(jz4780_pinctrl_drv_register);
-- 
2.11.0
