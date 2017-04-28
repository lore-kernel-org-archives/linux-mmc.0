From: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Subject: [PATCH v5 04/14] GPIO: Add gpio-ingenic driver
Date: Fri, 28 Apr 2017 22:08:14 +0200
Message-ID: <20170428200824.10906-5-paul@crapouillou.net>
References: <20170402204244.14216-2-paul@crapouillou.net>
 <20170428200824.10906-1-paul@crapouillou.net>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170428200824.10906-1-paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Paul Burton <paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This driver handles the GPIOs of all the Ingenic JZ47xx SoCs
currently supported by the upsteam Linux kernel.

Signed-off-by: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
---
 drivers/gpio/Kconfig        |  10 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-ingenic.c | 399 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 410 insertions(+)
 create mode 100644 drivers/gpio/gpio-ingenic.c

 v2: Consider it's a new patch. Completely rewritten from v1.
 v3: Add missing include <linux/pinctrl/consumer.h> and drop semicolon after }
 v4: Completely rewritten from v3.
 v5: Get bank number from 'reg' property; drop dependency on PINCTRL_INGENIC
     (note: selecting PINCTRL would cause cyclic Kconfig dependencies, that's
      why I just dropped the dependency on PINCTRL_INGENIC)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 05043071fc98..7a5f9cf123c1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -241,6 +241,16 @@ config GPIO_ICH
 
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
index becb96c724fe..3fceb4ab3ca7 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_GPIO_GPIO_MM)	+= gpio-gpio-mm.o
 obj-$(CONFIG_GPIO_GRGPIO)	+= gpio-grgpio.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
+obj-$(CONFIG_GPIO_INGENIC)	+= gpio-ingenic.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
diff --git a/drivers/gpio/gpio-ingenic.c b/drivers/gpio/gpio-ingenic.c
new file mode 100644
index 000000000000..34e9339bd815
--- /dev/null
+++ b/drivers/gpio/gpio-ingenic.c
@@ -0,0 +1,399 @@
+/*
+ * Ingenic JZ47xx GPIO driver
+ *
+ * Copyright (c) 2017 Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>
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
+#include <linux/regmap.h>
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
+#define JZ4770_GPIO_INT		0x10
+#define JZ4770_GPIO_PAT1	0x30
+#define JZ4770_GPIO_PAT0	0x40
+#define JZ4770_GPIO_FLAG	0x50
+
+#define REG_SET(x) ((x) + 0x4)
+#define REG_CLEAR(x) ((x) + 0x8)
+
+enum jz_version {
+	ID_JZ4740,
+	ID_JZ4770,
+	ID_JZ4780,
+};
+
+struct ingenic_gpio_chip {
+	struct regmap *map;
+	struct gpio_chip gc;
+	struct irq_chip irq_chip;
+	unsigned int irq, reg_base;
+	enum jz_version version;
+};
+
+static u32 gpio_ingenic_read_reg(struct ingenic_gpio_chip *jzgc, u8 reg)
+{
+	unsigned int val;
+
+	regmap_read(jzgc->map, jzgc->reg_base + reg, &val);
+
+	return (u32) val;
+}
+
+static void gpio_ingenic_set_bit(struct ingenic_gpio_chip *jzgc,
+		u8 reg, u8 offset, bool set)
+{
+	if (set)
+		reg = REG_SET(reg);
+	else
+		reg = REG_CLEAR(reg);
+
+	regmap_write(jzgc->map, jzgc->reg_base + reg, BIT(offset));
+}
+
+static inline bool gpio_get_value(struct ingenic_gpio_chip *jzgc, u8 offset)
+{
+	unsigned int val;
+
+	if (jzgc->version >= ID_JZ4770)
+		val = gpio_ingenic_read_reg(jzgc, GPIO_PIN);
+	else
+		val = gpio_ingenic_read_reg(jzgc, JZ4740_GPIO_DATA);
+
+	return !!(val & BIT(offset));
+}
+
+static void gpio_set_value(struct ingenic_gpio_chip *jzgc, u8 offset, int value)
+{
+	if (jzgc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_PAT0, offset, !!value);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, offset, !!value);
+}
+
+static void irq_set_type(struct ingenic_gpio_chip *jzgc,
+		u8 offset, unsigned int type)
+{
+	u8 reg1, reg2;
+
+	if (jzgc->version >= ID_JZ4770) {
+		reg1 = JZ4770_GPIO_PAT1;
+		reg2 = JZ4770_GPIO_PAT0;
+	} else {
+		reg1 = JZ4740_GPIO_TRIG;
+		reg2 = JZ4740_GPIO_DIR;
+	}
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, true);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, true);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+	default:
+		gpio_ingenic_set_bit(jzgc, reg2, offset, false);
+		gpio_ingenic_set_bit(jzgc, reg1, offset, false);
+		break;
+	}
+}
+
+static void ingenic_gpio_irq_mask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, true);
+}
+
+static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+
+	gpio_ingenic_set_bit(jzgc, GPIO_MSK, irqd->hwirq, false);
+}
+
+static void ingenic_gpio_irq_enable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
+	int irq = irqd->hwirq;
+
+	if (jzgc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, true);
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
+	if (jzgc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_INT, irq, false);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
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
+	if (jzgc->version >= ID_JZ4770)
+		gpio_ingenic_set_bit(jzgc, JZ4770_GPIO_FLAG, irq, false);
+	else
+		gpio_ingenic_set_bit(jzgc, JZ4740_GPIO_DATA, irq, true);
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
+	if (jzgc->version >= ID_JZ4770)
+		flag = gpio_ingenic_read_reg(jzgc, JZ4770_GPIO_FLAG);
+	else
+		flag = gpio_ingenic_read_reg(jzgc, JZ4740_GPIO_FLAG);
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
+	{ .compatible = "ingenic,jz4770-gpio", .data = (void *)ID_JZ4770 },
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
+	u32 bank;
+	int err;
+
+	jzgc = devm_kzalloc(dev, sizeof(*jzgc), GFP_KERNEL);
+	if (!jzgc)
+		return -ENOMEM;
+
+	jzgc->map = dev_get_drvdata(dev->parent);
+	if (!jzgc->map) {
+		dev_err(dev, "Cannot get parent regmap\n");
+		return -ENXIO;
+	}
+
+	err = of_property_read_u32(dev->of_node, "reg", &bank);
+	if (err) {
+		dev_err(dev, "Cannot read \"reg\" property: %i\n", err);
+		return err;
+	}
+
+	jzgc->reg_base = bank * 0x100;
+
+	jzgc->gc.label = devm_kasprintf(dev, GFP_KERNEL, "GPIO%c", 'A' + bank);
+	if (!jzgc->gc.label)
+		return -ENOMEM;
+
+	/* DO NOT EXPAND THIS: FOR BACKWARD GPIO NUMBERSPACE COMPATIBIBILITY
+	 * ONLY: WORK TO TRANSITION CONSUMERS TO USE THE GPIO DESCRIPTOR API IN
+	 * <linux/gpio/consumer.h> INSTEAD.
+	 */
+	jzgc->gc.base = bank * 32;
+
+	jzgc->gc.ngpio = 32;
+	jzgc->gc.parent = dev;
+	jzgc->gc.of_node = dev->of_node;
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
+	err = devm_gpiochip_add_data(dev, &jzgc->gc, jzgc);
+	if (err)
+		return err;
+
+	jzgc->irq = irq_of_parse_and_map(dev->of_node, 0);
+	if (!jzgc->irq)
+		return -EINVAL;
+
+	jzgc->irq_chip.name = jzgc->gc.label;
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
+MODULE_AUTHOR("Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>");
+MODULE_DESCRIPTION("Ingenic JZ47xx GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
