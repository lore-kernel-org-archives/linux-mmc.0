From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 02/13] pinctrl-jz4740: add a pinctrl driver for the Ingenic jz4740 SoC
Date: Wed, 18 Jan 2017 00:14:10 +0100
Message-ID: <20170117231421.16310-3-paul@crapouillou.net>
References: <20170117231421.16310-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117231421.16310-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-mmc@vger.kernel.org

From: Paul Burton <paul.burton@imgtec.com>

This driver handles pin configuration, pin muxing, and GPIOs of the
jz4740 SoC from Ingenic.

It is separated into two files:
- pinctrl-ingenic.c, which contains the core functions that can be
  shared across all Ingenic SoCs,
- pinctrl-jz4740.c, which contains the jz4740-pinctrl driver.

The reason behind separating some functions out of the jz4740-pinctrl
driver, is that the pin/GPIO controllers of the Ingenic SoCs are
extremely similar across SoC versions, except that some have the
registers shuffled around. Making a distinct separation will permit the
reuse of large parts of the driver to support the other SoCs from
Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pinctrl/Kconfig                   |   1 +
 drivers/pinctrl/Makefile                  |   1 +
 drivers/pinctrl/ingenic/Kconfig           |  14 +
 drivers/pinctrl/ingenic/Makefile          |   2 +
 drivers/pinctrl/ingenic/pinctrl-ingenic.c | 847 ++++++++++++++++++++++++++++++
 drivers/pinctrl/ingenic/pinctrl-ingenic.h |  42 ++
 drivers/pinctrl/ingenic/pinctrl-jz4740.c  | 190 +++++++
 include/dt-bindings/pinctrl/ingenic.h     |  11 +
 8 files changed, 1108 insertions(+)
 create mode 100644 drivers/pinctrl/ingenic/Kconfig
 create mode 100644 drivers/pinctrl/ingenic/Makefile
 create mode 100644 drivers/pinctrl/ingenic/pinctrl-ingenic.c
 create mode 100644 drivers/pinctrl/ingenic/pinctrl-ingenic.h
 create mode 100644 drivers/pinctrl/ingenic/pinctrl-jz4740.c
 create mode 100644 include/dt-bindings/pinctrl/ingenic.h

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 54044a8ecbd7..e13ca8cc1cde 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -282,6 +282,7 @@ source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
 source "drivers/pinctrl/berlin/Kconfig"
 source "drivers/pinctrl/freescale/Kconfig"
+source "drivers/pinctrl/ingenic/Kconfig"
 source "drivers/pinctrl/intel/Kconfig"
 source "drivers/pinctrl/mvebu/Kconfig"
 source "drivers/pinctrl/nomadik/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 25d50a86981d..93b6837af7bb 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
 obj-y				+= bcm/
 obj-$(CONFIG_PINCTRL_BERLIN)	+= berlin/
 obj-y				+= freescale/
+obj-$(CONFIG_PINCTRL_INGENIC)	+= ingenic/
 obj-$(CONFIG_X86)		+= intel/
 obj-$(CONFIG_PINCTRL_MVEBU)	+= mvebu/
 obj-y				+= nomadik/
diff --git a/drivers/pinctrl/ingenic/Kconfig b/drivers/pinctrl/ingenic/Kconfig
new file mode 100644
index 000000000000..9923ce127183
--- /dev/null
+++ b/drivers/pinctrl/ingenic/Kconfig
@@ -0,0 +1,14 @@
+#
+# Ingenic SoCs pin control drivers
+#
+config PINCTRL_INGENIC
+	bool
+	select PINMUX
+	select GPIOLIB_IRQCHIP
+	select GENERIC_PINCONF
+
+config PINCTRL_JZ4740
+	bool "Pinctrl driver for the Ingenic JZ4740 SoC"
+	default y
+	depends on MACH_JZ4740 || COMPILE_TEST
+	select PINCTRL_INGENIC
diff --git a/drivers/pinctrl/ingenic/Makefile b/drivers/pinctrl/ingenic/Makefile
new file mode 100644
index 000000000000..8b2c8b789dc9
--- /dev/null
+++ b/drivers/pinctrl/ingenic/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
+obj-$(CONFIG_PINCTRL_JZ4740)	+= pinctrl-jz4740.o
diff --git a/drivers/pinctrl/ingenic/pinctrl-ingenic.c b/drivers/pinctrl/ingenic/pinctrl-ingenic.c
new file mode 100644
index 000000000000..22a2be6d72f1
--- /dev/null
+++ b/drivers/pinctrl/ingenic/pinctrl-ingenic.c
@@ -0,0 +1,847 @@
+/*
+ * Ingenic SoCs pinctrl driver
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
+#include <linux/compiler.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/pinctrl/ingenic.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "pinctrl-ingenic.h"
+
+struct ingenic_pinctrl;
+
+struct ingenic_pinctrl_pin {
+	struct ingenic_gpio_chip *gpio_chip;
+	unsigned int idx;
+	unsigned int func;
+	unsigned long *configs;
+	unsigned int num_configs;
+};
+
+struct ingenic_pinctrl_group {
+	const char *name;
+	struct device_node *of_node;
+
+	unsigned int num_pins;
+	struct ingenic_pinctrl_pin *pins;
+	unsigned int *pin_indices;
+};
+
+struct ingenic_pinctrl_func {
+	const char *name;
+	struct device_node *of_node;
+
+	unsigned int num_groups;
+	struct ingenic_pinctrl_group **groups;
+	const char **group_names;
+};
+
+struct ingenic_gpio_chip {
+	char name[3];
+	unsigned int idx;
+	void __iomem *base;
+	struct gpio_chip gc;
+	struct irq_chip irq_chip;
+	struct ingenic_pinctrl *pinctrl;
+	const struct ingenic_pinctrl_ops *ops;
+	uint32_t pull_ups;
+	uint32_t pull_downs;
+	unsigned int irq;
+	struct pinctrl_gpio_range grange;
+};
+
+struct ingenic_pinctrl {
+	struct device *dev;
+	uint32_t base;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_pin_desc *pdesc;
+
+	unsigned int num_gpio_chips;
+	struct ingenic_gpio_chip *gpio_chips;
+
+	unsigned int num_groups;
+	struct ingenic_pinctrl_group *groups;
+
+	unsigned int num_funcs;
+	struct ingenic_pinctrl_func *funcs;
+};
+
+#define gc_to_jzgc(gpiochip) \
+	container_of(gpiochip, struct ingenic_gpio_chip, gc)
+
+#define PINS_PER_GPIO_PORT 32
+
+static struct ingenic_pinctrl_group *find_group_by_of_node(
+		struct ingenic_pinctrl *jzpc, struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i < jzpc->num_groups; i++)
+		if (jzpc->groups[i].of_node == np)
+			return &jzpc->groups[i];
+
+	return NULL;
+}
+
+static struct ingenic_pinctrl_func *find_func_by_of_node(
+		struct ingenic_pinctrl *jzpc, struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i < jzpc->num_funcs; i++)
+		if (jzpc->funcs[i].of_node == np)
+			return &jzpc->funcs[i];
+
+	return NULL;
+}
+
+static void ingenic_gpio_set(struct gpio_chip *gc,
+		unsigned int offset, int value)
+{
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+
+	jzgc->ops->gpio_set_value(jzgc->base, offset, value);
+}
+
+static int ingenic_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+
+	return jzgc->ops->gpio_get_value(jzgc->base, offset);
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
+static void ingenic_gpio_irq_mask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+
+	jzgc->ops->irq_mask(jzgc->base, irqd->hwirq, true);
+}
+
+static void ingenic_gpio_irq_unmask(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+
+	jzgc->ops->irq_mask(jzgc->base, irqd->hwirq, false);
+}
+
+static void ingenic_gpio_irq_ack(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+	unsigned int high;
+	int irq = irqd->hwirq;
+
+	if (irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) {
+		/*
+		 * Switch to an interrupt for the opposite edge to the one that
+		 * triggered the interrupt being ACKed.
+		 */
+		high = jzgc->ops->gpio_get_value(jzgc->base, irq);
+		if (high)
+			jzgc->ops->irq_set_type(jzgc->base, irq,
+					IRQ_TYPE_EDGE_FALLING);
+		else
+			jzgc->ops->irq_set_type(jzgc->base, irq,
+					IRQ_TYPE_EDGE_RISING);
+	}
+
+	jzgc->ops->irq_ack(jzgc->base, irq);
+}
+
+static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_LEVEL_LOW:
+		break;
+	default:
+		pr_err("unsupported external interrupt type\n");
+		return -EINVAL;
+	}
+
+	if (type & IRQ_TYPE_EDGE_BOTH)
+		irq_set_handler_locked(irqd, handle_edge_irq);
+	else
+		irq_set_handler_locked(irqd, handle_level_irq);
+
+	if (type == IRQ_TYPE_EDGE_BOTH) {
+		/*
+		 * The hardware does not support interrupts on both edges. The
+		 * best we can do is to set up a single-edge interrupt and then
+		 * switch to the opposing edge when ACKing the interrupt.
+		 */
+		int value = jzgc->ops->gpio_get_value(jzgc->base, irqd->hwirq);
+
+		type = value ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
+	}
+
+	jzgc->ops->irq_set_type(jzgc->base, irqd->hwirq, type);
+	return 0;
+}
+
+static int ingenic_gpio_irq_set_wake(struct irq_data *irqd, unsigned int on)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+
+	return irq_set_irq_wake(jzgc->irq, on);
+}
+
+static void ingenic_gpio_irq_handler(struct irq_desc *desc)
+{
+	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
+	struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
+	unsigned long flag, i;
+
+	chained_irq_enter(irq_chip, desc);
+	flag = jzgc->ops->irq_read(jzgc->base);
+
+	for_each_set_bit(i, &flag, 32)
+		generic_handle_irq(irq_linear_revmap(gc->irqdomain, i));
+	chained_irq_exit(irq_chip, desc);
+}
+
+static int ingenic_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+
+	return jzpc->num_groups;
+}
+
+static const char *ingenic_pinctrl_get_group_name(
+		struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+
+	return jzpc->groups[selector].name;
+}
+
+static int ingenic_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+		unsigned int selector, const unsigned int **pins,
+		unsigned int *num_pins)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector >= jzpc->num_groups)
+		return -EINVAL;
+
+	*pins = jzpc->groups[selector].pin_indices;
+	*num_pins = jzpc->groups[selector].num_pins;
+	return 0;
+}
+
+static int ingenic_pinctrl_dt_node_to_map(
+		struct pinctrl_dev *pctldev, struct device_node *np,
+		struct pinctrl_map **map, unsigned int *num_maps)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+	struct ingenic_pinctrl_func *func;
+	struct ingenic_pinctrl_group *group;
+	struct pinctrl_map *new_map;
+	unsigned int map_num, i;
+
+	group = find_group_by_of_node(jzpc, np);
+	if (!group)
+		return -EINVAL;
+
+	func = find_func_by_of_node(jzpc, of_get_parent(np));
+	if (!func)
+		return -EINVAL;
+
+	map_num = 1 + group->num_pins;
+	new_map = devm_kzalloc(jzpc->dev,
+				sizeof(*new_map) * map_num, GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
+	new_map[0].data.mux.function = func->name;
+	new_map[0].data.mux.group = group->name;
+
+	for (i = 0; i < group->num_pins; i++) {
+		new_map[i + 1].type = PIN_MAP_TYPE_CONFIGS_PIN;
+		new_map[i + 1].data.configs.group_or_pin =
+			jzpc->pdesc[group->pins[i].idx].name;
+		new_map[i + 1].data.configs.configs = group->pins[i].configs;
+		new_map[i + 1].data.configs.num_configs =
+			group->pins[i].num_configs;
+	}
+
+	*map = new_map;
+	*num_maps = map_num;
+	return 0;
+}
+
+static void ingenic_pinctrl_dt_free_map(struct pinctrl_dev *pctldev,
+		struct pinctrl_map *map, unsigned int num_maps)
+{
+}
+
+static struct pinctrl_ops ingenic_pctlops = {
+	.get_groups_count = ingenic_pinctrl_get_groups_count,
+	.get_group_name = ingenic_pinctrl_get_group_name,
+	.get_group_pins = ingenic_pinctrl_get_group_pins,
+	.dt_node_to_map = ingenic_pinctrl_dt_node_to_map,
+	.dt_free_map = ingenic_pinctrl_dt_free_map,
+};
+
+static int ingenic_pinmux_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+
+	return jzpc->num_funcs;
+}
+
+static const char *ingenic_pinmux_get_function_name(
+		struct pinctrl_dev *pctldev, unsigned int selector)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+
+	return jzpc->funcs[selector].name;
+}
+
+static int ingenic_pinmux_get_function_groups(struct pinctrl_dev *pctldev,
+		unsigned int selector, const char * const **groups,
+		unsigned int * const num_groups)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector >= jzpc->num_funcs)
+		return -EINVAL;
+
+	*groups = jzpc->funcs[selector].group_names;
+	*num_groups = jzpc->funcs[selector].num_groups;
+
+	return 0;
+}
+
+static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
+		struct ingenic_pinctrl_pin *pin)
+{
+	struct ingenic_gpio_chip *jzgc = &jzpc->gpio_chips[
+		pin->idx / PINS_PER_GPIO_PORT];
+	unsigned int idx = pin->idx % PINS_PER_GPIO_PORT;
+
+	if (pin->func == JZ_PIN_MODE_GPIO) {
+		dev_dbg(jzpc->dev, "set pin P%c%u to GPIO\n",
+				'A' + pin->gpio_chip->idx, idx);
+
+		jzgc->ops->set_gpio(jzgc->base, idx, false);
+	} else if (pin->func < jzgc->ops->nb_functions) {
+		dev_dbg(jzpc->dev, "set pin P%c%u to function %u\n",
+				'A' + pin->gpio_chip->idx, idx, pin->func);
+
+		jzgc->ops->set_function(jzgc->base, idx, pin->func);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ingenic_pinmux_set_mux(struct pinctrl_dev *pctldev,
+		unsigned int selector, unsigned int group)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+	struct ingenic_pinctrl_group *grp = &jzpc->groups[group];
+	unsigned int i;
+	int err = 0;
+
+	if (selector >= jzpc->num_funcs || group >= jzpc->num_groups)
+		return -EINVAL;
+
+	for (i = 0; i < grp->num_pins; i++) {
+		err = ingenic_pinmux_set_pin_fn(jzpc, &grp->pins[i]);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int ingenic_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
+		struct pinctrl_gpio_range *range,
+		unsigned int offset, bool input)
+{
+	struct ingenic_gpio_chip *jzgc = gc_to_jzgc(range->gc);
+	unsigned int idx;
+
+	idx = offset - (jzgc->idx * PINS_PER_GPIO_PORT);
+
+	jzgc->ops->set_gpio(jzgc->base, idx, !input);
+	return 0;
+}
+
+static struct pinmux_ops ingenic_pmxops = {
+	.get_functions_count = ingenic_pinmux_get_functions_count,
+	.get_function_name = ingenic_pinmux_get_function_name,
+	.get_function_groups = ingenic_pinmux_get_function_groups,
+	.set_mux = ingenic_pinmux_set_mux,
+	.gpio_set_direction = ingenic_pinmux_gpio_set_direction,
+};
+
+static int ingenic_pinconf_get(struct pinctrl_dev *pctldev,
+		unsigned int pin, unsigned long *config)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+	struct ingenic_gpio_chip *jzgc;
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	unsigned int idx, pull;
+
+	if (pin >= (jzpc->num_gpio_chips * PINS_PER_GPIO_PORT))
+		return -EINVAL;
+	jzgc = &jzpc->gpio_chips[pin / PINS_PER_GPIO_PORT];
+	idx = pin % PINS_PER_GPIO_PORT;
+
+	pull = jzgc->ops->get_bias(jzgc->base, idx);
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (pull)
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (!pull || !(jzgc->pull_ups & (1 << idx)))
+			return -EINVAL;
+		break;
+
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (!pull || !(jzgc->pull_downs & (1 << idx)))
+			return -EINVAL;
+		break;
+
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, 1);
+	return 0;
+}
+
+static int ingenic_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+		unsigned long *configs, unsigned int num_configs)
+{
+	struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
+	struct ingenic_gpio_chip *jzgc;
+	unsigned int idx, cfg;
+
+	if (pin >= (jzpc->num_gpio_chips * PINS_PER_GPIO_PORT))
+		return -EINVAL;
+
+	jzgc = &jzpc->gpio_chips[pin / PINS_PER_GPIO_PORT];
+	idx = pin % PINS_PER_GPIO_PORT;
+
+	for (cfg = 0; cfg < num_configs; cfg++) {
+		switch (pinconf_to_config_param(configs[cfg])) {
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			continue;
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	for (cfg = 0; cfg < num_configs; cfg++) {
+		switch (pinconf_to_config_param(configs[cfg])) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			jzgc->ops->set_bias(jzgc->base, idx, false);
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_UP:
+			if (!(jzgc->pull_ups & (1 << idx)))
+				return -EINVAL;
+			jzgc->ops->set_bias(jzgc->base, idx, true);
+			break;
+
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			if (!(jzgc->pull_downs & (1 << idx)))
+				return -EINVAL;
+			jzgc->ops->set_bias(jzgc->base, idx, true);
+			break;
+
+		default:
+			unreachable();
+		}
+	}
+
+	return 0;
+}
+
+static struct pinconf_ops ingenic_confops = {
+	.is_generic = true,
+	.pin_config_get = ingenic_pinconf_get,
+	.pin_config_set = ingenic_pinconf_set,
+};
+
+static int ingenic_pinctrl_parse_dt_gpio(struct ingenic_pinctrl *jzpc,
+		struct ingenic_gpio_chip *jzgc, struct device_node *np)
+{
+	int err;
+
+	jzgc->pinctrl = jzpc;
+	snprintf(jzgc->name, sizeof(jzgc->name), "P%c", 'A' + jzgc->idx);
+
+	jzgc->base = of_iomap(np, 0);
+	if (!jzgc->base) {
+		dev_err(jzpc->dev, "failed to map IO memory\n");
+		return -ENXIO;
+	}
+
+	jzgc->gc.base = jzpc->base + (jzgc->idx * PINS_PER_GPIO_PORT);
+	jzgc->gc.ngpio = PINS_PER_GPIO_PORT;
+	jzgc->gc.parent = jzpc->dev;
+	jzgc->gc.of_node = np;
+	jzgc->gc.label = np->name;
+	jzgc->gc.owner = THIS_MODULE;
+
+	jzgc->gc.set = ingenic_gpio_set;
+	jzgc->gc.get = ingenic_gpio_get;
+	jzgc->gc.direction_input = ingenic_gpio_direction_input;
+	jzgc->gc.direction_output = ingenic_gpio_direction_output;
+
+	if (of_property_read_u32_index(np, "ingenic,pull-ups", 0,
+				&jzgc->pull_ups))
+		jzgc->pull_ups = 0;
+	if (of_property_read_u32_index(np, "ingenic,pull-downs", 0,
+				&jzgc->pull_downs))
+		jzgc->pull_downs = 0;
+
+	if (jzgc->pull_ups & jzgc->pull_downs) {
+		dev_err(jzpc->dev, "GPIO port %c has overlapping pull ups & pull downs\n",
+			'A' + jzgc->idx);
+		return -EINVAL;
+	}
+
+	err = devm_gpiochip_add_data(jzpc->dev, &jzgc->gc, NULL);
+	if (err)
+		return err;
+
+	if (!of_find_property(np, "interrupt-controller", NULL))
+		return 0;
+
+	jzgc->irq = irq_of_parse_and_map(np, 0);
+	if (!jzgc->irq)
+		return -EINVAL;
+
+	jzgc->irq_chip.name = jzgc->name;
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
+static int find_gpio_chip_by_of_node(struct gpio_chip *chip, void *data)
+{
+	return chip->of_node == data;
+}
+
+static int ingenic_pinctrl_parse_dt_pincfg(struct ingenic_pinctrl *jzpc,
+		struct ingenic_pinctrl_pin *pin, phandle cfg_handle)
+{
+	struct device_node *cfg_node;
+	int err;
+
+	cfg_node = of_find_node_by_phandle(cfg_handle);
+	if (!cfg_node)
+		return -EINVAL;
+
+	err = pinconf_generic_parse_dt_config(cfg_node, NULL,
+			&pin->configs, &pin->num_configs);
+	if (err)
+		return err;
+
+	err = devm_add_action(jzpc->dev, (void (*)(void *))kfree, pin->configs);
+	if (err) {
+		kfree(pin->configs);
+		return err;
+	}
+
+	return 0;
+}
+
+static int ingenic_pinctrl_parse_dt_func(struct ingenic_pinctrl *jzpc,
+		struct device_node *np, unsigned int *ifunc,
+		unsigned int *igroup)
+{
+	struct ingenic_pinctrl_func *func;
+	struct ingenic_pinctrl_group *grp;
+	struct device_node *group_node, *gpio_node;
+	struct gpio_chip *gpio_chip;
+	phandle gpio_handle, cfg_handle;
+	struct property *pp;
+	__be32 *plist;
+	unsigned int i, j;
+	int err;
+	const unsigned int vals_per_pin = 4;
+
+	func = &jzpc->funcs[(*ifunc)++];
+	func->of_node = np;
+	func->name = np->name;
+
+	func->num_groups = of_get_child_count(np);
+	func->groups = devm_kzalloc(jzpc->dev, sizeof(*func->groups) *
+			func->num_groups, GFP_KERNEL);
+	func->group_names = devm_kzalloc(jzpc->dev,
+			sizeof(*func->group_names) * func->num_groups,
+			GFP_KERNEL);
+	if (!func->groups || !func->group_names)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_child_of_node(np, group_node) {
+		pp = of_find_property(group_node, "ingenic,pins", NULL);
+		if (!pp)
+			return -EINVAL;
+		if ((pp->length / sizeof(__be32)) % vals_per_pin)
+			return -EINVAL;
+
+		grp = &jzpc->groups[(*igroup)++];
+		grp->of_node = group_node;
+		grp->name = group_node->name;
+		grp->num_pins = (pp->length / sizeof(__be32)) / vals_per_pin;
+		grp->pins = devm_kzalloc(jzpc->dev, sizeof(*grp->pins) *
+				grp->num_pins, GFP_KERNEL);
+		grp->pin_indices = devm_kzalloc(jzpc->dev,
+				sizeof(*grp->pin_indices) * grp->num_pins,
+				GFP_KERNEL);
+		if (!grp->pins)
+			return -EINVAL;
+
+		plist = pp->value;
+		for (j = 0; j < grp->num_pins; j++) {
+			gpio_handle = be32_to_cpup(plist++);
+			grp->pins[j].idx = be32_to_cpup(plist++);
+			grp->pins[j].func = be32_to_cpup(plist++);
+			cfg_handle = be32_to_cpup(plist++);
+
+			gpio_node = of_find_node_by_phandle(gpio_handle);
+			if (!gpio_node)
+				return -EINVAL;
+
+			gpio_chip = gpiochip_find(gpio_node,
+					find_gpio_chip_by_of_node);
+			if (!gpio_chip)
+				return -EINVAL;
+
+			grp->pins[j].gpio_chip = gc_to_jzgc(gpio_chip);
+
+			err = ingenic_pinctrl_parse_dt_pincfg(jzpc,
+					&grp->pins[j], cfg_handle);
+			if (err)
+				return err;
+
+			grp->pins[j].idx += grp->pins[j].gpio_chip->idx *
+				PINS_PER_GPIO_PORT;
+			grp->pin_indices[j] = grp->pins[j].idx;
+		}
+
+		func->groups[i] = grp;
+		func->group_names[i] = grp->name;
+		i++;
+	}
+
+	return 0;
+}
+
+int ingenic_pinctrl_probe(struct platform_device *pdev,
+		const struct ingenic_pinctrl_ops *ops)
+{
+	struct device *dev = &pdev->dev;
+	struct ingenic_pinctrl *jzpc;
+	struct ingenic_gpio_chip *jzgc;
+	struct pinctrl_desc *pctl_desc;
+	struct device_node *np, *chips_node, *functions_node;
+	unsigned int i, j;
+	int err;
+
+	if (!dev->of_node) {
+		dev_err(dev, "device tree node not found\n");
+		return -ENODEV;
+	}
+
+	jzpc = devm_kzalloc(dev, sizeof(*jzpc), GFP_KERNEL);
+	if (!jzpc)
+		return -ENOMEM;
+
+	jzpc->dev = dev;
+	platform_set_drvdata(pdev, jzpc);
+
+	jzpc->base = 0;
+	of_property_read_u32(dev->of_node, "base", &jzpc->base);
+
+	chips_node = of_find_node_by_name(dev->of_node, "gpio-chips");
+	if (!chips_node) {
+		dev_err(dev, "Missing \"chips\" devicetree node\n");
+		return -EINVAL;
+	}
+
+	jzpc->num_gpio_chips = of_get_available_child_count(chips_node);
+	if (!jzpc->num_gpio_chips) {
+		dev_err(dev, "No GPIO chips found\n");
+		return -EINVAL;
+	}
+
+	functions_node = of_find_node_by_name(dev->of_node, "functions");
+	if (!functions_node) {
+		dev_err(dev, "Missing \"functions\" devicetree node\n");
+		return -EINVAL;
+	}
+
+	jzpc->num_funcs = of_get_available_child_count(functions_node);
+	if (!jzpc->num_funcs) {
+		dev_err(dev, "No functions found\n");
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(functions_node, np) {
+		jzpc->num_groups += of_get_available_child_count(np);
+	}
+
+	if (!jzpc->num_groups) {
+		dev_err(dev, "No groups found\n");
+		return -EINVAL;
+	}
+
+	/* allocate memory for GPIO chips, pin groups & functions */
+	jzpc->gpio_chips = devm_kzalloc(jzpc->dev, sizeof(*jzpc->gpio_chips) *
+			jzpc->num_gpio_chips, GFP_KERNEL);
+	jzpc->groups = devm_kzalloc(jzpc->dev, sizeof(*jzpc->groups) *
+			jzpc->num_groups, GFP_KERNEL);
+	jzpc->funcs = devm_kzalloc(jzpc->dev, sizeof(*jzpc->funcs) *
+			jzpc->num_funcs, GFP_KERNEL);
+	pctl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctl_desc), GFP_KERNEL);
+	if (!jzpc->gpio_chips || !jzpc->groups || !jzpc->funcs || !pctl_desc)
+		return -ENOMEM;
+
+	/* fill in pinctrl_desc structure */
+	pctl_desc->name = dev_name(dev);
+	pctl_desc->owner = THIS_MODULE;
+	pctl_desc->pctlops = &ingenic_pctlops;
+	pctl_desc->pmxops = &ingenic_pmxops;
+	pctl_desc->confops = &ingenic_confops;
+	pctl_desc->npins = jzpc->num_gpio_chips * PINS_PER_GPIO_PORT;
+	pctl_desc->pins = jzpc->pdesc = devm_kzalloc(&pdev->dev,
+			sizeof(*jzpc->pdesc) * pctl_desc->npins, GFP_KERNEL);
+	if (!jzpc->pdesc)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl_desc->npins; i++) {
+		jzpc->pdesc[i].number = i;
+		jzpc->pdesc[i].name = kasprintf(GFP_KERNEL, "P%c%d",
+						'A' + (i / PINS_PER_GPIO_PORT),
+						i % PINS_PER_GPIO_PORT);
+	}
+
+	/* Register GPIO chips */
+
+	i = 0;
+	for_each_child_of_node(chips_node, np) {
+		if (!of_find_property(np, "gpio-controller", NULL)) {
+			dev_err(dev, "GPIO chip missing \"gpio-controller\" flag\n");
+			return -EINVAL;
+		}
+
+		jzpc->gpio_chips[i].idx = i;
+		jzpc->gpio_chips[i].ops = ops;
+
+		err = ingenic_pinctrl_parse_dt_gpio(jzpc,
+				&jzpc->gpio_chips[i++], np);
+		if (err) {
+			dev_err(dev, "failed to register GPIO chip: %d\n", err);
+			return err;
+		}
+	}
+
+	i = 0;
+	j = 0;
+	for_each_child_of_node(functions_node, np) {
+		err = ingenic_pinctrl_parse_dt_func(jzpc, np, &i, &j);
+		if (err) {
+			dev_err(dev, "failed to parse function %s\n",
+					np->full_name);
+			return err;
+		}
+	}
+
+	for (i = 0; i < jzpc->num_groups; i++)
+		dev_dbg(dev, "group '%s'\n", jzpc->groups[i].name);
+	for (i = 0; i < jzpc->num_funcs; i++)
+		dev_dbg(dev, "func '%s'\n", jzpc->funcs[i].name);
+
+	jzpc->pctl = pinctrl_register(pctl_desc, dev, jzpc);
+	if (!jzpc->pctl) {
+		dev_err(dev, "Failed pinctrl registration\n");
+		return -EINVAL;
+	}
+
+	/* register pinctrl GPIO ranges */
+	for (i = 0; i < jzpc->num_gpio_chips; i++) {
+		jzgc = &jzpc->gpio_chips[i];
+
+		jzgc->grange.name = jzgc->name;
+		jzgc->grange.id = jzgc->idx;
+		jzgc->grange.pin_base = jzgc->idx * PINS_PER_GPIO_PORT;
+		jzgc->grange.base = jzgc->gc.base;
+		jzgc->grange.npins = jzgc->gc.ngpio;
+		jzgc->grange.gc = &jzgc->gc;
+		pinctrl_add_gpio_range(jzpc->pctl, &jzgc->grange);
+	}
+
+	return 0;
+}
diff --git a/drivers/pinctrl/ingenic/pinctrl-ingenic.h b/drivers/pinctrl/ingenic/pinctrl-ingenic.h
new file mode 100644
index 000000000000..76cb7ffa68e5
--- /dev/null
+++ b/drivers/pinctrl/ingenic/pinctrl-ingenic.h
@@ -0,0 +1,42 @@
+/*
+ * Ingenic SoCs pinctrl driver
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
+#ifndef PINCTRL_INGENIC_H
+#define PINCTRL_INGENIC_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct platform_device;
+
+struct ingenic_pinctrl_ops {
+	unsigned int nb_functions;
+
+	void (*set_function)(void __iomem *base,
+			unsigned int offset, unsigned int function);
+	void (*set_gpio)(void __iomem *base, unsigned int offset, bool output);
+	int  (*get_bias)(void __iomem *base, unsigned int offset);
+	void (*set_bias)(void __iomem *base, unsigned int offset, bool enable);
+	void (*gpio_set_value)(void __iomem *base,
+			unsigned int offset, int value);
+	int  (*gpio_get_value)(void __iomem *base, unsigned int offset);
+	u32  (*irq_read)(void __iomem *base);
+	void (*irq_mask)(void __iomem *base, unsigned int irq, bool mask);
+	void (*irq_ack)(void __iomem *base, unsigned int irq);
+	void (*irq_set_type)(void __iomem *base,
+			unsigned int irq, unsigned int type);
+};
+
+int ingenic_pinctrl_probe(struct platform_device *pdev,
+		const struct ingenic_pinctrl_ops *ops);
+
+#endif /* PINCTRL_INGENIC_H */
diff --git a/drivers/pinctrl/ingenic/pinctrl-jz4740.c b/drivers/pinctrl/ingenic/pinctrl-jz4740.c
new file mode 100644
index 000000000000..ae0b9d903258
--- /dev/null
+++ b/drivers/pinctrl/ingenic/pinctrl-jz4740.c
@@ -0,0 +1,190 @@
+/*
+ * Ingenic jz4740 pinctrl driver
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
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+/* GPIO port register offsets */
+#define GPIO_PIN	0x00
+#define GPIO_DATA	0x10
+#define GPIO_DATAS	0x14
+#define GPIO_DATAC	0x18
+#define GPIO_MASK	0x20
+#define GPIO_MASKS	0x24
+#define GPIO_MASKC	0x28
+#define GPIO_PULL_DIS	0x30
+#define GPIO_PULL_DISS	0x34
+#define GPIO_PULL_DISC	0x38
+#define GPIO_FUNC	0x40
+#define GPIO_FUNCS	0x44
+#define GPIO_FUNCC	0x48
+#define GPIO_SELECT	0x50
+#define GPIO_SELECTS	0x54
+#define GPIO_SELECTC	0x58
+#define GPIO_DIR	0x60
+#define GPIO_DIRS	0x64
+#define GPIO_DIRC	0x68
+#define GPIO_TRIG	0x70
+#define GPIO_TRIGS	0x74
+#define GPIO_TRIGC	0x78
+#define GPIO_FLAG	0x80
+#define GPIO_FLAGC	0x14
+#define GPIO_REGS_SIZE	0x100
+
+static void jz4740_set_gpio(void __iomem *base,
+		unsigned int offset, bool output)
+{
+	writel(1 << offset, base + GPIO_FUNCC);
+	writel(1 << offset, base + GPIO_SELECTC);
+	writel(1 << offset, base + GPIO_TRIGC);
+
+	if (output)
+		writel(1 << offset, base + GPIO_DIRS);
+	else
+		writel(1 << offset, base + GPIO_DIRC);
+}
+
+static int jz4740_get_bias(void __iomem *base, unsigned int offset)
+{
+	return !((readl(base + GPIO_PULL_DIS) >> offset) & 0x1);
+}
+
+static void jz4740_set_bias(void __iomem *base,
+		unsigned int offset, bool enable)
+{
+	if (enable)
+		writel(1 << offset, base + GPIO_PULL_DISC);
+	else
+		writel(1 << offset, base + GPIO_PULL_DISS);
+}
+
+static void jz4740_gpio_set_value(void __iomem *base,
+		unsigned int offset, int value)
+{
+	if (value)
+		writel(1 << offset, base + GPIO_DATAS);
+	else
+		writel(1 << offset, base + GPIO_DATAC);
+}
+
+static int jz4740_gpio_get_value(void __iomem *base, unsigned int offset)
+{
+	return (readl(base + GPIO_DATA) >> offset) & 0x1;
+}
+
+static u32 jz4740_irq_read(void __iomem *base)
+{
+	return readl(base + GPIO_FLAG);
+}
+
+static void jz4740_irq_mask(void __iomem *base, unsigned int irq, bool mask)
+{
+	if (mask)
+		writel(1 << irq, base + GPIO_MASKS);
+	else
+		writel(1 << irq, base + GPIO_MASKC);
+}
+
+static void jz4740_irq_ack(void __iomem *base, unsigned int irq)
+{
+	writel(1 << irq, base + GPIO_FLAGC);
+}
+
+static void jz4740_irq_set_type(void __iomem *base,
+		unsigned int offset, unsigned int type)
+{
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		writel(1 << offset, base + GPIO_DIRS);
+		writel(1 << offset, base + GPIO_TRIGS);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		writel(1 << offset, base + GPIO_DIRC);
+		writel(1 << offset, base + GPIO_TRIGS);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		writel(1 << offset, base + GPIO_DIRS);
+		writel(1 << offset, base + GPIO_TRIGC);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+	default:
+		writel(1 << offset, base + GPIO_DIRC);
+		writel(1 << offset, base + GPIO_TRIGC);
+		break;
+	}
+}
+
+static void jz4740_set_function(void __iomem *base,
+		unsigned int offset, unsigned int func)
+{
+	writel(1 << offset, base + GPIO_FUNCS);
+	writel(1 << offset, base + GPIO_TRIGC);
+
+	switch (func) {
+	case 2:
+		writel(1 << offset, base + GPIO_TRIGS);
+	case 1: /* fallthrough */
+		writel(1 << offset, base + GPIO_SELECTS);
+		break;
+	case 0:
+	default:
+		writel(1 << offset, base + GPIO_SELECTC);
+		break;
+	}
+}
+
+static const struct ingenic_pinctrl_ops jz4740_pinctrl_ops = {
+	.nb_functions	= 3,
+	.set_function	= jz4740_set_function,
+	.set_gpio	= jz4740_set_gpio,
+	.set_bias	= jz4740_set_bias,
+	.get_bias	= jz4740_get_bias,
+	.gpio_set_value	= jz4740_gpio_set_value,
+	.gpio_get_value	= jz4740_gpio_get_value,
+	.irq_read	= jz4740_irq_read,
+	.irq_mask	= jz4740_irq_mask,
+	.irq_ack	= jz4740_irq_ack,
+	.irq_set_type	= jz4740_irq_set_type,
+};
+
+static int jz4740_pinctrl_probe(struct platform_device *pdev)
+{
+	return ingenic_pinctrl_probe(pdev, &jz4740_pinctrl_ops);
+}
+
+static const struct of_device_id jz4740_pinctrl_dt_match[] = {
+	{ .compatible = "ingenic,jz4740-pinctrl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4740_pinctrl_dt_match);
+
+
+static struct platform_driver jz4740_pinctrl_driver = {
+	.driver = {
+		.name = "jz4740-pinctrl",
+		.of_match_table = of_match_ptr(jz4740_pinctrl_dt_match),
+		.suppress_bind_attrs = true,
+	},
+	.probe = jz4740_pinctrl_probe,
+};
+
+static int __init jz4740_pinctrl_drv_register(void)
+{
+	return platform_driver_register(&jz4740_pinctrl_driver);
+}
+postcore_initcall(jz4740_pinctrl_drv_register);
diff --git a/include/dt-bindings/pinctrl/ingenic.h b/include/dt-bindings/pinctrl/ingenic.h
new file mode 100644
index 000000000000..19eb173844b1
--- /dev/null
+++ b/include/dt-bindings/pinctrl/ingenic.h
@@ -0,0 +1,11 @@
+#ifndef DT_BINDINGS_PINCTRL_INGENIC_H
+#define DT_BINDINGS_PINCTRL_INGENIC_H
+
+#define JZ_PIN_MODE_FUNCTION_0	0
+#define JZ_PIN_MODE_FUNCTION_1	1
+#define JZ_PIN_MODE_FUNCTION_2	2
+#define JZ_PIN_MODE_FUNCTION_3	3
+
+#define JZ_PIN_MODE_GPIO	255
+
+#endif /* DT_BINDINGS_PINCTRL_INGENIC_H */
-- 
2.11.0
