From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC v2 2/2] mmc: meson-mx-sdio: Add a driver for the Amlogic
 Meson8 and Meson8b SoCs
Date: Mon, 2 Oct 2017 20:45:39 +0200
Message-ID: <CAFBinCCW5r=DFLyBgSrQzDkqHr6uN7Opvi6Tdmb8k+ikw+qnPA@mail.gmail.com>
References: <20170924190528.21841-1-martin.blumenstingl@googlemail.com>
 <20170924190528.21841-3-martin.blumenstingl@googlemail.com> <CAPDyKFqj1CkhHO4SvUySEV4OnKcTeHRu6YAfBPSN4hvkQpHKfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFqj1CkhHO4SvUySEV4OnKcTeHRu6YAfBPSN4hvkQpHKfA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Carlo Caione <carlo-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Mon, Oct 2, 2017 at 10:08 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> [...]
>
>> +#define MESON_MX_SDIO_MAX_SLOTS                                        3
>> +
>> +struct meson_mx_mmc_slot {
>> +       struct device                   *dev;
>> +       struct mmc_host                 *mmc;
>> +       struct meson_mx_mmc_host        *host;
>> +
>> +       struct mmc_request              *mrq;
>> +       struct mmc_command              *cmd;
>> +       int                             error;
>> +
>> +       unsigned int                    id;
>> +};
>
> If I recall correctly, we agreed on postponing the multiple slot
> support for now as to start simple.
yes, indeed

> Therefore, can you please remove all that code, and instead only use
> the struct meson_mx_mmc_host for the data needed.
I initially wanted to keep these structs separated to make it easier
to spot which part of the logic might have to be changed to support
multiple slots
looking back at it: currently meson_mx_mmc_slot only contains very
generic stuff, so it'll (hopefully) be easy to spot the relevant parts
anyways
I'll remove it, which will even fix a warning found by the "kbuild
test robot" (where I didn't initialize but use the "slot" variable in
meson_mx_mmc_timeout)

> Just to be clear, I am fine having using the mmc slot bindings, as we
> agreed. However as only one slot is supported in this stage, we don't
> need a separate struct for that.
ACK

>> +
>> +struct meson_mx_mmc_host {
>> +       struct device                   *dev;
>> +
>> +       struct clk                      *parent_clk;
>> +       struct clk                      *core_clk;
>> +       struct clk_divider              cfg_div;
>> +       struct clk                      *cfg_div_clk;
>> +       struct clk_fixed_factor         fixed_factor;
>> +       struct clk                      *fixed_factor_clk;
>> +
>> +       void __iomem                    *base;
>> +       int                             irq;
>> +       spinlock_t                      irq_lock;
>> +
>> +       struct timer_list               cmd_timeout;
>> +
>> +       struct meson_mx_mmc_slot        *slot;
>> +};
>> +
>
> [...]
>
>> +static int meson_mx_mmc_slot_probe(struct device *slot_dev,
>> +                                  struct meson_mx_mmc_host *host)
>> +{
>> +       struct meson_mx_mmc_slot *slot;
>> +       struct mmc_host *mmc;
>> +       unsigned int id;
>> +       int ret;
>> +
>> +       if (of_property_read_u32(slot_dev->of_node, "reg", &id)) {
>> +               dev_err(slot_dev, "missing 'reg' property\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (id >= MESON_MX_SDIO_MAX_SLOTS) {
>> +               dev_err(slot_dev, "invalid 'reg' property value %d\n", id);
>> +               return -EINVAL;
>> +       }
>> +
>> +       mmc = mmc_alloc_host(sizeof(*slot), slot_dev);
>> +       if (!mmc)
>> +               return -ENOMEM;
>> +
>> +       slot = mmc_priv(mmc);
>> +       slot->dev = slot_dev;
>> +       slot->mmc = mmc;
>> +       slot->id = id;
>> +       slot->host = host;
>> +
>> +       host->slot = slot;
>> +
>> +       /* Get regulators and the supported OCR mask */
>> +       ret = mmc_regulator_get_supply(mmc);
>> +       if (ret == -EPROBE_DEFER)
>> +               goto error_free_host;
>> +
>> +       mmc->max_req_size = MESON_MX_SDIO_BOUNCE_REQ_SIZE;
>> +       mmc->max_seg_size = mmc->max_req_size;
>> +       mmc->max_blk_count =
>> +               FIELD_GET(MESON_MX_SDIO_SEND_REPEAT_PACKAGE_TIMES_MASK,
>> +                         0xffffffff);
>> +       mmc->max_blk_size = FIELD_GET(MESON_MX_SDIO_EXT_DATA_RW_NUMBER_MASK,
>> +                                     0xffffffff);
>> +       mmc->max_blk_size -= (4 * MESON_MX_SDIO_RESPONSE_CRC16_BITS);
>> +       mmc->max_blk_size /= BITS_PER_BYTE;
>> +
>> +       /* Get the min and max supported clock rates */
>> +       mmc->f_min = clk_round_rate(host->cfg_div_clk, 1);
>> +       mmc->f_max = clk_round_rate(host->cfg_div_clk,
>> +                                   clk_get_rate(host->parent_clk));
>> +
>> +       mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
>> +       mmc->ops = &meson_mx_mmc_ops;
>> +
>> +       ret = mmc_of_parse(mmc);
>> +       if (ret)
>> +               goto error_free_host;
>> +
>> +       ret = mmc_add_host(mmc);
>> +       if (ret)
>> +               goto error_free_host;
>> +
>> +       return 0;
>> +
>> +error_free_host:
>> +       mmc_free_host(mmc);
>> +       return ret;
>> +}
>> +
>> +static int meson_mx_mmc_probe_slots(struct meson_mx_mmc_host *host)
>> +{
>> +       struct device_node *slot_node;
>> +       struct platform_device *slot_pdev;
>> +       int ret;
>> +
>> +       for_each_child_of_node(host->dev->of_node, slot_node) {
>> +               if (!of_device_is_compatible(slot_node, "mmc-slot"))
>> +                       continue;
>> +
>> +               /*
>> +                * TODO: the MMC core framework currently does not support
>> +                * controllers with multiple slots properly.
>> +                */
>> +               if (host->slot) {
>> +                       dev_warn(host->dev,
>> +                                "skipping slot other than the first\n");
>> +                       continue;
>> +               }
>> +
>> +               slot_pdev = of_platform_device_create(slot_node, NULL,
>> +                                                     host->dev);
>> +               if (!slot_pdev)
>> +                       continue;
>> +
>> +               ret = meson_mx_mmc_slot_probe(&slot_pdev->dev, host);
>> +               if (ret) {
>> +                       of_platform_device_destroy(&slot_pdev->dev, NULL);
>> +                       return ret;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>
> For the above two functions, please simplify the code by limiting them
> to deal with only one valid mmc-slot.
OK, I'll do that - however I'll leave that TODO comment in the code so
people know that this is on purpose

> [...]
>
> Besides the comments on the multiple slot support, this looks good to me.
awesome, thanks for reviewing!
I'll send an updated version as soon as I have time


Regards,
Martin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
