From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 03/14] pinctrl-ingenic: add a pinctrl driver for the
 Ingenic jz47xx SoCs
Date: Tue, 31 Jan 2017 15:05:43 +0100
Message-ID: <CACRpkdZKNACkOYJtUcYavriSxSDMy0iLt2SUX+d8DcKPXofXyw@mail.gmail.com>
References: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
 <20170125185207.23902-1-paul@crapouillou.net> <20170125185207.23902-4-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20170125185207.23902-4-paul@crapouillou.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, linux-p
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 25, 2017 at 7:51 PM, Paul Cercueil <paul@crapouillou.net> wrote:

> This driver handles pin configuration and pin muxing for the
> JZ4740 and JZ4780 SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

This is starting to look very nice.

> +#include <linux/compiler.h>
> +#include <linux/gpio.h>

Use <linux/gpio/driver.h> if it is a GPIO driver. I should
be enough ... I think.

> +static int ingenic_pinctrl_parse_dt_func(struct ingenic_pinctrl *jzpc,
> +               struct device_node *np)
> +{
> +       unsigned int num_groups;
> +       struct device_node *group_node;
> +       unsigned int i, j;
> +       int err, npins, *pins, *confs;
> +       const char **groups;
> +
> +       num_groups = of_get_child_count(np);
> +       groups = devm_kzalloc(jzpc->dev,
> +                       sizeof(*groups) * num_groups, GFP_KERNEL);
> +       if (!groups)
> +               return -ENOMEM;
> +
> +       i = 0;
> +       for_each_child_of_node(np, group_node) {
> +               groups[i++] = group_node->name;
> +
> +               npins = of_property_count_elems_of_size(group_node,
> +                               "ingenic,pins", 8);
> +               if (npins < 0)
> +                       return npins;
> +
> +               pins = devm_kzalloc(jzpc->dev,
> +                               sizeof(*pins) * npins, GFP_KERNEL);
> +               confs = devm_kzalloc(jzpc->dev,
> +                               sizeof(*confs) * npins, GFP_KERNEL);
> +               if (!pins || !confs)
> +                       return -ENOMEM;
> +
> +               for (j = 0; j < npins; j++) {
> +                       of_property_read_u32_index(group_node,
> +                                       "ingenic,pins", j * 2, &pins[j]);
> +
> +                       of_property_read_u32_index(group_node,
> +                                       "ingenic,pins", j * 2 + 1, &confs[j]);

If I didn't mention before this could pperhaps just use "pins"?

Or does these DT entries not match the generic bindings?

> +               }
> +
> +               err = pinctrl_generic_add_group(jzpc->pctl, group_node->name,
> +                               pins, npins, confs);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return pinmux_generic_add_function(jzpc->pctl, np->name,
> +                       groups, num_groups, NULL);
> +}

If you just use "pins" can this even be parsed by a generic parser function
pinconf_generic_dt_subnode_to_map()?

Yours,
Linus Walleij
