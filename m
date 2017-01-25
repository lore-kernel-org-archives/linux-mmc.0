From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 04/14] GPIO: Add gpio-ingenic driver
Date: Wed, 25 Jan 2017 19:51:57 +0100
Message-ID: <20170125185207.23902-5-paul@crapouillou.net>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170125185207.23902-1-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

This driver handles the GPIOs of all the Ingenic JZ47xx SoCs
currently supported by the upsteam Linux kernel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpio/Kconfig        |  10 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-ingenic.c | 367 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 378 insertions(+)
 create mode 100644 drivers/gpio/gpio-ingenic.c

v2: Consider it's a new patch. Completely rewritten from v1.
v3: Add missing include <linux/pinctrl/consumer.h> and drop semicolon after }

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d5d36549ecc1..21992ca29342 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -225,6 +225,16 @@ config GPIO_ICH
 
 	  If unsure, say N.
 
+config GPIO_INGENIC
+	tristate "Ingenic JZ47xx SoCs GPIO support"
+	depends on MACH_INGENIC || COMPILE_TEST
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to support the GPIO functionality present on the
+	  JZ4740 and JZ4780 SoCs from Ingenic.
+
+	  If unsure, say N.
+
 config GPIO_IOP
 	tristate "Intel IOP GPIO"
 	depends on ARCH_IOP32X || ARCH_IOP33X || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a7676b82de6f..3c5412ae56f0 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
+obj-$(CONFIG_GPIO_INGENIC)	+= gpio-ingenic.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
diff --git a/drivers/gpio/gpio-ingenic.c b/drivers/gpio/gpio-ingenic.c
new file mode 100644
index 000000000000..1bb6c4d5b8ba
--- /dev/null
+++ b/drivers/gpio/gpio-ingenic.c
@@ -0,0 +1,367 @@
+/*
+ * Ingenic JZ47xx GPIO driver
+ *
+ * Copyright (c) 2017 Paul Cercueil <paul@crapouillou.net>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
+
+#define GPIO_PIN	0x00
+#define GPIO_MSK	0x20
+
+#define JZ4740_GPIO_DATA	0x10
+#define JZ4740_GPIO_SELECT	0x50
+#define JZ4740_GPIO_DIR		0x60
+#define JZ4740_GPIO_TRIG	0x70
+#define JZ4740_GPIO_FLAG	0x80
+
+#define JZ4780_GPIO_INT		0x10
+#define JZ4780_GPIO_PAT1	0x30
+#define JZ4780_GPIO_PAT0	0x40
+#define JZ4780_GPIO_FLAG	0x50
+
+#define REG_SET(x) ((x) + 0x4)
+#define REG_CLEAR(x) ((x) + 0x8)
+
+enum jz_version {
+	ID_JZ4740,
+	ID_JZ4780,
+};
+
+struct ingenic_gpio_chip {
+	void __iomem *base;
+	struct gpio_chip gc;
+	struct irq_chip irq_chip;
+	unsigned int irq;
+	enum jz_version version;
+};
+
+static inline bool gpio_get_value(struct ingenic_gpio_chip *jzgc, u8 offset)
+{
+	if (jzgc->version >= ID_JZ4780)
+		return readl(jzgc->base + GPIO_PIN) & BIT(offset);
+	else
+		return readl(jzgc->base + JZ4740_GPIO_DATA) & BIT(offset);
+}
+
+static void gpio_set_value(struct ingenic_gpio_chip *jzgc, u8 offset, int value)
+{
+	u8 reg;
+
+	if (jzgc->version >= ID_JZ4780)
+		reg = JZ4780_GPIO_PAT0;
+	else
+		reg = JZ4740_GPIO_DATA;
+
+	if (value)
+		writel(BIT(offset), jzgc->base + REG_SET(reg));
+	else
+		writel(BIT(offset), jzgc->base + REG_CLEAR(reg));
+}
+
+static void irq_set_type(struct ingenic_gpio_chip *jzgc,
+		u8 offset, unsigned int type)
+{
+	u8 reg1, reg2;
+
+	if (jzgc->version >= ID_JZ4780) {
+		reg1 = JZ4780_GPIO_PAT1;
+		reg2 = JZ4780_GPIO_PAT0;
+	} else {
+		reg1 = JZ4740_GPIO_TRIG;
+		reg2 = JZ4740_GPIO_DIR;
+	}
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		writel(BIT(offset), jzgc->base + REG_SET(reg2));
+		writel(BIT(offset), jzgc->base + REG_SET(reg1));
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		writel(BIT(offset), jzgc->base + REG_CLEAR(reg2));
+		writel(BIT(offset), jzgc->base + REG_SET(reg1));
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		writel(BIT(offset), jzgc->base + REG_SET(reg2));
+		writel(BIT(offset), jzgc->base + REG_CLEAR(reg1));
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+	default:
+		writel(BIT(offset), jzgc->base + REG_CLEAR(reg2));
+		writel(BIT(offset), jzgc->base + REG_CLEAR(reg1));
+		break;
+	}
+}
+
+static void ingenic_gpio_irq_mask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	writel(BIT(irqd->hwirq), jzgc->base + REG_SET(GPIO_MSK));
+}
+
+static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	writel(BIT(irqd->hwirq), jzgc->base + REG_CLEAR(GPIO_MSK));
+}
+
+static void ingenic_gpio_irq_enable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	int irq = irqd->hwirq;
+
+	if (jzgc->version >= ID_JZ4780)
+		writel(BIT(irq), jzgc->base + REG_SET(JZ4780_GPIO_INT));
+	else
+		writel(BIT(irq), jzgc->base + REG_SET(JZ4740_GPIO_SELECT));
+
+	ingenic_gpio_irq_unmask(irqd);
+}
+
+static void ingenic_gpio_irq_disable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	int irq = irqd->hwirq;
+
+	ingenic_gpio_irq_mask(irqd);
+
+	if (jzgc->version >= ID_JZ4780)
+		writel(BIT(irq), jzgc->base + REG_CLEAR(JZ4780_GPIO_INT));
+	else
+		writel(BIT(irq), jzgc->base + REG_CLEAR(JZ4740_GPIO_SELECT));
+}
+
+static void ingenic_gpio_irq_ack(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	int irq = irqd->hwirq;
+	bool high;
+
+	if (irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) {
+		/*
+		 * Switch to an interrupt for the opposite edge to the one that
+		 * triggered the interrupt being ACKed.
+		 */
+		high = gpio_get_value(jzgc, irq);
+		if (high)
+			irq_set_type(jzgc, irq, IRQ_TYPE_EDGE_FALLING);
+		else
+			irq_set_type(jzgc, irq, IRQ_TYPE_EDGE_RISING);
+	}
+
+	if (jzgc->version >= ID_JZ4780)
+		writel(BIT(irq), jzgc->base + REG_CLEAR(JZ4780_GPIO_FLAG));
+	else
+		writel(BIT(irq), jzgc->base + REG_SET(JZ4740_GPIO_DATA));
+}
+
+static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_set_handler_locked(irqd, handle_edge_irq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_set_handler_locked(irqd, handle_level_irq);
+		break;
+	default:
+		irq_set_handler_locked(irqd, handle_bad_irq);
+	}
+
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		/*
+		 * The hardware does not support interrupts on both edges. The
+		 * best we can do is to set up a single-edge interrupt and then
+		 * switch to the opposing edge when ACKing the interrupt.
+		 */
+		bool high = gpio_get_value(jzgc, irqd->hwirq);
+
+		type = high ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
+	}
+
+	irq_set_type(jzgc, irqd->hwirq, type);
+	return 0;
+}
+
+static int ingenic_gpio_irq_set_wake(struct irq_data *irqd, unsigned int on)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	return irq_set_irq_wake(jzgc->irq, on);
+}
+
+static void ingenic_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
+	unsigned long flag, i;
+
+	chained_irq_enter(irq_chip, desc);
+
+	if (jzgc->version >= ID_JZ4780)
+		flag = readl(jzgc->base + JZ4780_GPIO_FLAG);
+	else
+		flag = readl(jzgc->base + JZ4740_GPIO_FLAG);
+
+	for_each_set_bit(i, &flag, 32)
+		generic_handle_irq(irq_linear_revmap(gc->irqdomain, i));
+	chained_irq_exit(irq_chip, desc);
+}
+
+static void ingenic_gpio_set(struct gpio_chip *gc,
+		unsigned int offset, int value)
+{
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	gpio_set_value(jzgc, offset, value);
+}
+
+static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	return (int) gpio_get_value(jzgc, offset);
+}
+
+static int ingenic_gpio_direction_input(struct gpio_chip *gc,
+		unsigned int offset)
+{
+	return pinctrl_gpio_direction_input(gc->base + offset);
+}
+
+static int ingenic_gpio_direction_output(struct gpio_chip *gc,
+		unsigned int offset, int value)
+{
+	ingenic_gpio_set(gc, offset, value);
+	return pinctrl_gpio_direction_output(gc->base + offset);
+}
+
+static const struct of_device_id ingenic_gpio_of_match[] = {
+	{ .compatible = "ingenic,jz4740-gpio", .data = (void *)ID_JZ4740 },
+	{ .compatible = "ingenic,jz4780-gpio", .data = (void *)ID_JZ4780 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ingenic_gpio_of_match);
+
+static int ingenic_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id = of_match_device(
+			ingenic_gpio_of_match, dev);
+	struct ingenic_gpio_chip *jzgc;
+	int err;
+
+	jzgc = devm_kzalloc(dev, sizeof(*jzgc), GFP_KERNEL);
+	if (!jzgc)
+		return -ENOMEM;
+
+	jzgc->base = of_iomap(dev->of_node, 0);
+	if (!jzgc->base) {
+		dev_err(dev, "failed to map IO memory\n");
+		return -ENXIO;
+	}
+
+	jzgc->gc.base = -1;
+	jzgc->gc.ngpio = 32;
+	jzgc->gc.parent = dev;
+	jzgc->gc.of_node = dev->of_node;
+	jzgc->gc.label = "";
+	jzgc->gc.owner = THIS_MODULE;
+	jzgc->version = (enum jz_version)of_id->data;
+
+	jzgc->gc.set = ingenic_gpio_set;
+	jzgc->gc.get = ingenic_gpio_get;
+	jzgc->gc.direction_input = ingenic_gpio_direction_input;
+	jzgc->gc.direction_output = ingenic_gpio_direction_output;
+
+	if (of_property_read_bool(dev->of_node, "gpio-ranges")) {
+		jzgc->gc.request = gpiochip_generic_request;
+		jzgc->gc.free = gpiochip_generic_free;
+	}
+
+	of_property_read_u32(dev->of_node, "base", &jzgc->gc.base);
+
+	err = devm_gpiochip_add_data(dev, &jzgc->gc, jzgc);
+	if (err)
+		return err;
+
+	if (!of_property_read_bool(dev->of_node, "interrupt-controller"))
+		return 0;
+
+	jzgc->irq = irq_of_parse_and_map(dev->of_node, 0);
+	if (!jzgc->irq)
+		return -EINVAL;
+
+	jzgc->irq_chip.name = dev->of_node->name;
+	jzgc->irq_chip.irq_enable = ingenic_gpio_irq_enable;
+	jzgc->irq_chip.irq_disable = ingenic_gpio_irq_disable;
+	jzgc->irq_chip.irq_unmask = ingenic_gpio_irq_unmask;
+	jzgc->irq_chip.irq_mask = ingenic_gpio_irq_mask;
+	jzgc->irq_chip.irq_ack = ingenic_gpio_irq_ack;
+	jzgc->irq_chip.irq_set_type = ingenic_gpio_irq_set_type;
+	jzgc->irq_chip.irq_set_wake = ingenic_gpio_irq_set_wake;
+	jzgc->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
+
+	err = gpiochip_irqchip_add(&jzgc->gc, &jzgc->irq_chip, 0,
+			handle_level_irq, IRQ_TYPE_NONE);
+	if (err)
+		return err;
+
+	gpiochip_set_chained_irqchip(&jzgc->gc, &jzgc->irq_chip,
+			jzgc->irq, ingenic_gpio_irq_handler);
+	return 0;
+}
+
+static int ingenic_gpio_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver ingenic_gpio_driver = {
+	.driver = {
+		.name = "gpio-ingenic",
+		.of_match_table = of_match_ptr(ingenic_gpio_of_match),
+	},
+	.probe = ingenic_gpio_probe,
+	.remove = ingenic_gpio_remove,
+};
+
+static int __init ingenic_gpio_drv_register(void)
+{
+	return platform_driver_register(&ingenic_gpio_driver);
+}
+subsys_initcall(ingenic_gpio_drv_register);
+
+static void __exit ingenic_gpio_drv_unregister(void)
+{
+	platform_driver_unregister(&ingenic_gpio_driver);
+}
+module_exit(ingenic_gpio_drv_unregister);
+
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("Ingenic JZ47xx GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0
