From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/13] pinctrl-jz4740: add a pinctrl driver for the
 Ingenic jz4740 SoC
Date: Wed, 18 Jan 2017 11:16:32 +0100
Message-ID: <CACRpkdYK7PAUZL9btuOM-FUvtWoHFi9juXaBUBhAhgncUUegXA@mail.gmail.com>
References: <20170117231421.16310-1-paul@crapouillou.net> <20170117231421.16310-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170117231421.16310-3-paul@crapouillou.net>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-p
List-Id: linux-mmc@vger.kernel.org

n Wed, Jan 18, 2017 at 12:14 AM, Paul Cercueil <paul@crapouillou.net> wrote:

> From: Paul Burton <paul.burton@imgtec.com>
>
> This driver handles pin configuration, pin muxing, and GPIOs of the
> jz4740 SoC from Ingenic.
>
> It is separated into two files:
> - pinctrl-ingenic.c, which contains the core functions that can be
>   shared across all Ingenic SoCs,
> - pinctrl-jz4740.c, which contains the jz4740-pinctrl driver.
>
> The reason behind separating some functions out of the jz4740-pinctrl
> driver, is that the pin/GPIO controllers of the Ingenic SoCs are
> extremely similar across SoC versions, except that some have the
> registers shuffled around. Making a distinct separation will permit the
> reuse of large parts of the driver to support the other SoCs from
> Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

> diff --git a/drivers/pinctrl/ingenic/Kconfig b/drivers/pinctrl/ingenic/Kconfig
> new file mode 100644
> index 000000000000..9923ce127183
> --- /dev/null
> +++ b/drivers/pinctrl/ingenic/Kconfig
> @@ -0,0 +1,14 @@
> +#
> +# Ingenic SoCs pin control drivers
> +#
> +config PINCTRL_INGENIC
> +       bool
> +       select PINMUX
> +       select GPIOLIB_IRQCHIP
> +       select GENERIC_PINCONF

I like it already when it looks like that :D

> +#include <linux/compiler.h>
> +#include <linux/gpio.h>

For drivers, just
#include <linux/gpio/driver.h>

> +struct ingenic_gpio_chip {
> +       char name[3];
> +       unsigned int idx;
> +       void __iomem *base;
> +       struct gpio_chip gc;
> +       struct irq_chip irq_chip;
> +       struct ingenic_pinctrl *pinctrl;
> +       const struct ingenic_pinctrl_ops *ops;
> +       uint32_t pull_ups;
> +       uint32_t pull_downs;
> +       unsigned int irq;
> +       struct pinctrl_gpio_range grange;

Usually we add GPIO ranges from the device tree for device tree
drivers, look at the syntax in:
Documentation/devicetree/bindings/gpio/gpio.txt

git grep gpio-ranges arch/arm/boot/dts/
gives you a few examples.

> +#define gc_to_jzgc(gpiochip) \
> +       container_of(gpiochip, struct ingenic_gpio_chip, gc)

Unless you must have this, please switch to using
struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
and use [devm_]gpiochip_add_data() in the probe so
you can get the data from the gpiochip directly.

> +static void ingenic_gpio_set(struct gpio_chip *gc,
> +               unsigned int offset, int value)
> +{
> +       struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
> +
> +       jzgc->ops->gpio_set_value(jzgc->base, offset, value);
> +}

struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
etc everywhere.

> +static void ingenic_gpio_irq_ack(struct irq_data *irqd)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
> +       struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
> +       unsigned int high;
> +       int irq = irqd->hwirq;
> +
> +       if (irqd_get_trigger_type(irqd) == IRQ_TYPE_EDGE_BOTH) {
> +               /*
> +                * Switch to an interrupt for the opposite edge to the one that
> +                * triggered the interrupt being ACKed.
> +                */
> +               high = jzgc->ops->gpio_get_value(jzgc->base, irq);
> +               if (high)
> +                       jzgc->ops->irq_set_type(jzgc->base, irq,
> +                                       IRQ_TYPE_EDGE_FALLING);
> +               else
> +                       jzgc->ops->irq_set_type(jzgc->base, irq,
> +                                       IRQ_TYPE_EDGE_RISING);

Neat hack. This is often how you have to do it indeed.

> +static int ingenic_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
> +       struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
> +
> +       switch (type) {
> +       case IRQ_TYPE_EDGE_BOTH:
> +       case IRQ_TYPE_EDGE_RISING:
> +       case IRQ_TYPE_EDGE_FALLING:
> +       case IRQ_TYPE_LEVEL_HIGH:
> +       case IRQ_TYPE_LEVEL_LOW:
> +               break;
> +       default:
> +               pr_err("unsupported external interrupt type\n");

Should you set the irq handlet to handle_bad_irq() in this case?
That's what I usually do.

> +               return -EINVAL;
> +       }
> +
> +       if (type & IRQ_TYPE_EDGE_BOTH)
> +               irq_set_handler_locked(irqd, handle_edge_irq);
> +       else
> +               irq_set_handler_locked(irqd, handle_level_irq);

Nice.

> +       jzgc->ops->irq_set_type(jzgc->base, irqd->hwirq, type);

Getting a bit of feeling that it's a bit much indirection vtable
business going on here, but depends on the series as a whole.

> +static int ingenic_gpio_irq_set_wake(struct irq_data *irqd, unsigned int on)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
> +       struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
> +
> +       return irq_set_irq_wake(jzgc->irq, on);
> +}

I'm uncertain with these. Allright I guess, I'm just too bad at understanding
wakeup IRQs.

> +static void ingenic_gpio_irq_handler(struct irq_desc *desc)
> +{
> +       struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> +       struct ingenic_gpio_chip *jzgc = gc_to_jzgc(gc);
> +       struct irq_chip *irq_chip = irq_data_get_irq_chip(&desc->irq_data);
> +       unsigned long flag, i;
> +
> +       chained_irq_enter(irq_chip, desc);
> +       flag = jzgc->ops->irq_read(jzgc->base);
> +
> +       for_each_set_bit(i, &flag, 32)
> +               generic_handle_irq(irq_linear_revmap(gc->irqdomain, i));
> +       chained_irq_exit(irq_chip, desc);
> +}

Clean & nice.

> +static int ingenic_pinctrl_dt_node_to_map(
> +               struct pinctrl_dev *pctldev, struct device_node *np,
> +               struct pinctrl_map **map, unsigned int *num_maps)
> +{
> +       struct ingenic_pinctrl *jzpc = pinctrl_dev_get_drvdata(pctldev);
> +       struct ingenic_pinctrl_func *func;
> +       struct ingenic_pinctrl_group *group;
> +       struct pinctrl_map *new_map;
> +       unsigned int map_num, i;
> +
> +       group = find_group_by_of_node(jzpc, np);
> +       if (!group)
> +               return -EINVAL;
> +
> +       func = find_func_by_of_node(jzpc, of_get_parent(np));
> +       if (!func)
> +               return -EINVAL;
> +
> +       map_num = 1 + group->num_pins;
> +       new_map = devm_kzalloc(jzpc->dev,
> +                               sizeof(*new_map) * map_num, GFP_KERNEL);
> +       if (!new_map)
> +               return -ENOMEM;
> +
> +       new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
> +       new_map[0].data.mux.function = func->name;
> +       new_map[0].data.mux.group = group->name;
> +
> +       for (i = 0; i < group->num_pins; i++) {
> +               new_map[i + 1].type = PIN_MAP_TYPE_CONFIGS_PIN;
> +               new_map[i + 1].data.configs.group_or_pin =
> +                       jzpc->pdesc[group->pins[i].idx].name;
> +               new_map[i + 1].data.configs.configs = group->pins[i].configs;
> +               new_map[i + 1].data.configs.num_configs =
> +                       group->pins[i].num_configs;
> +       }
> +
> +       *map = new_map;
> +       *num_maps = map_num;
> +       return 0;
> +}

This may change due to DT bindings reviews. I would prefer if you use
generic functions.

> +static int ingenic_pinctrl_parse_dt_gpio(struct ingenic_pinctrl *jzpc,
> +               struct ingenic_gpio_chip *jzgc, struct device_node *np)

Naming here: parse or probe or init. This function is certainly not just
parsing the DT. init() or probe() is better.

> +       jzgc->gc.base = jzpc->base + (jzgc->idx * PINS_PER_GPIO_PORT);

No. No hard-coded GPIO bases on new GPIO driver.
Set this to -1 so it uses dynamic allocation of GPIO numbers.

> +       if (of_property_read_u32_index(np, "ingenic,pull-ups", 0,
> +                               &jzgc->pull_ups))
> +               jzgc->pull_ups = 0;
> +       if (of_property_read_u32_index(np, "ingenic,pull-downs", 0,
> +                               &jzgc->pull_downs))
> +               jzgc->pull_downs = 0;
> +
> +       if (jzgc->pull_ups & jzgc->pull_downs) {
> +               dev_err(jzpc->dev, "GPIO port %c has overlapping pull ups & pull downs\n",
> +                       'A' + jzgc->idx);
> +               return -EINVAL;
> +       }

These bindings look suspicious. But I will review them in the binding
document.

> +static int ingenic_pinctrl_parse_dt_pincfg(struct ingenic_pinctrl *jzpc,
> +               struct ingenic_pinctrl_pin *pin, phandle cfg_handle)
> +{
> +       struct device_node *cfg_node;
> +       int err;
> +
> +       cfg_node = of_find_node_by_phandle(cfg_handle);
> +       if (!cfg_node)
> +               return -EINVAL;
> +
> +       err = pinconf_generic_parse_dt_config(cfg_node, NULL,
> +                       &pin->configs, &pin->num_configs);
> +       if (err)
> +               return err;
> +
> +       err = devm_add_action(jzpc->dev, (void (*)(void *))kfree, pin->configs);

That looks very clever.

But when we have pinctrl_utils_free_map() and other helpers already
this free:ing looks like some reinvented wheel.

Can we create something that free:s the maps from
pinctrl_utils_reserve_map() in a similar way and use that?
Just thinking aloud.

> +static int ingenic_pinctrl_parse_dt_func(struct ingenic_pinctrl *jzpc,
> +               struct device_node *np, unsigned int *ifunc,
> +               unsigned int *igroup)
> +{
> +       struct ingenic_pinctrl_func *func;
> +       struct ingenic_pinctrl_group *grp;
> +       struct device_node *group_node, *gpio_node;
> +       struct gpio_chip *gpio_chip;
> +       phandle gpio_handle, cfg_handle;
> +       struct property *pp;
> +       __be32 *plist;
> +       unsigned int i, j;
> +       int err;
> +       const unsigned int vals_per_pin = 4;
> +
> +       func = &jzpc->funcs[(*ifunc)++];
> +       func->of_node = np;
> +       func->name = np->name;
> +
> +       func->num_groups = of_get_child_count(np);
> +       func->groups = devm_kzalloc(jzpc->dev, sizeof(*func->groups) *
> +                       func->num_groups, GFP_KERNEL);
> +       func->group_names = devm_kzalloc(jzpc->dev,
> +                       sizeof(*func->group_names) * func->num_groups,
> +                       GFP_KERNEL);
> +       if (!func->groups || !func->group_names)
> +               return -ENOMEM;
> +
> +       i = 0;
> +       for_each_child_of_node(np, group_node) {
> +               pp = of_find_property(group_node, "ingenic,pins", NULL);
> +               if (!pp)
> +                       return -EINVAL;
> +               if ((pp->length / sizeof(__be32)) % vals_per_pin)
> +                       return -EINVAL;
> +
> +               grp = &jzpc->groups[(*igroup)++];
> +               grp->of_node = group_node;
> +               grp->name = group_node->name;
> +               grp->num_pins = (pp->length / sizeof(__be32)) / vals_per_pin;
> +               grp->pins = devm_kzalloc(jzpc->dev, sizeof(*grp->pins) *
> +                               grp->num_pins, GFP_KERNEL);
> +               grp->pin_indices = devm_kzalloc(jzpc->dev,
> +                               sizeof(*grp->pin_indices) * grp->num_pins,
> +                               GFP_KERNEL);
> +               if (!grp->pins)
> +                       return -EINVAL;
> +
> +               plist = pp->value;
> +               for (j = 0; j < grp->num_pins; j++) {
> +                       gpio_handle = be32_to_cpup(plist++);
> +                       grp->pins[j].idx = be32_to_cpup(plist++);
> +                       grp->pins[j].func = be32_to_cpup(plist++);
> +                       cfg_handle = be32_to_cpup(plist++);
> +
> +                       gpio_node = of_find_node_by_phandle(gpio_handle);
> +                       if (!gpio_node)
> +                               return -EINVAL;
> +
> +                       gpio_chip = gpiochip_find(gpio_node,
> +                                       find_gpio_chip_by_of_node);
> +                       if (!gpio_chip)
> +                               return -EINVAL;
> +
> +                       grp->pins[j].gpio_chip = gc_to_jzgc(gpio_chip);
> +
> +                       err = ingenic_pinctrl_parse_dt_pincfg(jzpc,
> +                                       &grp->pins[j], cfg_handle);
> +                       if (err)
> +                               return err;
> +
> +                       grp->pins[j].idx += grp->pins[j].gpio_chip->idx *
> +                               PINS_PER_GPIO_PORT;
> +                       grp->pin_indices[j] = grp->pins[j].idx;
> +               }
> +
> +               func->groups[i] = grp;
> +               func->group_names[i] = grp->name;
> +               i++;
> +       }
> +
> +       return 0;
> +}

Tony Lindgren has added generic function and group parsing for drivers
that keep functions and groups in the device tree. This code is committed
and available in the pinctrl git tree.

Look at commits:
commit c7059c5ac70aea194b07b2d811df433eb0ca81b5
pinctrl: core: Add generic pinctrl functions for managing groups
commit a76edc89b100e4fefb2a5c00cd8cd557437659e7
pinctrl: core: Add generic pinctrl functions for managing groups
commit caeb774ea3b1bc25dc2f24681c27543aba6ca7ae
pinctrl: single: Use generic pinctrl helpers for managing groups
commit 571aec4df5b72a80f80d1e524da8fbd7ff525c98
pinctrl: single: Use generic pinmux helpers for managing functions
commit 3fd6d6ad73af90522321451a2d10b0a8967d47d1
pinctrl: imx: use generic pinmux helpers for managing functions

So two drivers already switch to generic code handling this.

Please investigate and try out the above.

> +int ingenic_pinctrl_probe(struct platform_device *pdev,
> +               const struct ingenic_pinctrl_ops *ops)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct ingenic_pinctrl *jzpc;
> +       struct ingenic_gpio_chip *jzgc;
> +       struct pinctrl_desc *pctl_desc;
> +       struct device_node *np, *chips_node, *functions_node;
> +       unsigned int i, j;
> +       int err;
> +
> +       if (!dev->of_node) {
> +               dev_err(dev, "device tree node not found\n");
> +               return -ENODEV;
> +       }

I think this check is not necessary since you only probe from device tree.
We usually skip it these days.

> +       jzpc->base = 0;
> +       of_property_read_u32(dev->of_node, "base", &jzpc->base);

If this is the Linux GPIO number base then NACK, we don't define
Linux-specific things in the device tree.

Please use dynamic allocation of GPIO base anyways, as stated
above.

> +       chips_node = of_find_node_by_name(dev->of_node, "gpio-chips");

This looks like a very dubious new DT bindings. Will review in that
document.

> +       jzpc->num_gpio_chips = of_get_available_child_count(chips_node);
> +       if (!jzpc->num_gpio_chips) {
> +               dev_err(dev, "No GPIO chips found\n");
> +               return -EINVAL;
> +       }

Usually it is better to create one device per gpiochip.

> +       /* register pinctrl GPIO ranges */
> +       for (i = 0; i < jzpc->num_gpio_chips; i++) {
> +               jzgc = &jzpc->gpio_chips[i];
> +
> +               jzgc->grange.name = jzgc->name;
> +               jzgc->grange.id = jzgc->idx;
> +               jzgc->grange.pin_base = jzgc->idx * PINS_PER_GPIO_PORT;
> +               jzgc->grange.base = jzgc->gc.base;
> +               jzgc->grange.npins = jzgc->gc.ngpio;
> +               jzgc->grange.gc = &jzgc->gc;
> +               pinctrl_add_gpio_range(jzpc->pctl, &jzgc->grange);
> +       }

I strongly recommend defining the GPIO ranges in the device tree
and if not possible, to add the GPIO range from the gpiochip
side and not the pinctrl side.

> +struct ingenic_pinctrl_ops {
> +       unsigned int nb_functions;
> +
> +       void (*set_function)(void __iomem *base,
> +                       unsigned int offset, unsigned int function);
> +       void (*set_gpio)(void __iomem *base, unsigned int offset, bool output);
> +       int  (*get_bias)(void __iomem *base, unsigned int offset);
> +       void (*set_bias)(void __iomem *base, unsigned int offset, bool enable);
> +       void (*gpio_set_value)(void __iomem *base,
> +                       unsigned int offset, int value);
> +       int  (*gpio_get_value)(void __iomem *base, unsigned int offset);
> +       u32  (*irq_read)(void __iomem *base);
> +       void (*irq_mask)(void __iomem *base, unsigned int irq, bool mask);
> +       void (*irq_ack)(void __iomem *base, unsigned int irq);
> +       void (*irq_set_type)(void __iomem *base,
> +                       unsigned int irq, unsigned int type);
> +};

This is a *lot* of vtable indirections. Are you sure this is a good
idea?

> +static void jz4740_set_gpio(void __iomem *base,
> +               unsigned int offset, bool output)
> +{
> +       writel(1 << offset, base + GPIO_FUNCC);
> +       writel(1 << offset, base + GPIO_SELECTC);
> +       writel(1 << offset, base + GPIO_TRIGC);
> +
> +       if (output)
> +               writel(1 << offset, base + GPIO_DIRS);
> +       else
> +               writel(1 << offset, base + GPIO_DIRC);
> +}

Replace all (1 << offset) things with:

#include <linux/bitops.h>

BIT(offset)

Simple and clean.

> +static int jz4740_get_bias(void __iomem *base, unsigned int offset)
> +{
> +       return !((readl(base + GPIO_PULL_DIS) >> offset) & 0x1);
> +}

Similarly:
return !((readl(base + GPIO_PULL_DIR) & BIT(offset));

Follow these patterns everywhere.

> +static int jz4740_gpio_get_value(void __iomem *base, unsigned int offset)
> +{
> +       return (readl(base + GPIO_DATA) >> offset) & 0x1;
> +}

return !!(readl(base + GPIO_DATA) & BIT(offset));

Yours,
Linus Walleij
