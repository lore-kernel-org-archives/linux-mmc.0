From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v12 2/9] mmc: cavium: Add core MMC driver for Cavium SOCs
Date: Fri, 17 Mar 2017 14:34:53 +0100
Message-ID: <20170317133453.GA2739@hardcore>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <20170310132507.32025-3-jglauber@cavium.com>
 <CAPDyKFqW7-JiNZTpCEUv+=Hf_rLh4x89h+i7_9UUwmxRERg_5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:36138
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750998AbdCQNfG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Mar 2017 09:35:06 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFqW7-JiNZTpCEUv+=Hf_rLh4x89h+i7_9UUwmxRERg_5A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On Fri, Mar 17, 2017 at 12:24:57PM +0100, Ulf Hansson wrote:
> On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
> > This core driver will be used by a MIPS platform driver
> > or by an ARM64 PCI driver. The core driver implements the
> > mmc_host_ops and slot probe & remove functions.
> > Callbacks are provided to allow platform specific interrupt
> > enable and bus locking.
> >
> > The host controller supports:
> > - up to 4 slots that can contain sd-cards or eMMC chips
> > - 1, 4 and 8 bit bus width
> > - SDR and DDR
> > - transfers up to 52 Mhz (might be less when multiple slots are used)
> > - DMA read/write
> > - multi-block read/write (but not stream mode)
> >
> > Voltage is limited to 3.3v and shared for all slots (vmmc and vmmcq).
> >
> > A global lock for all MMC devices is required because the host
> > controller is shared.
> >
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> > ---
> >  drivers/mmc/host/cavium-mmc.c | 988 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/cavium-mmc.h | 178 ++++++++
> >  2 files changed, 1166 insertions(+)
> >  create mode 100644 drivers/mmc/host/cavium-mmc.c
> >  create mode 100644 drivers/mmc/host/cavium-mmc.h
> >
> > diff --git a/drivers/mmc/host/cavium-mmc.c b/drivers/mmc/host/cavium-mmc.c
> > new file mode 100644
> > index 0000000..11fdcfb
> > --- /dev/null
> > +++ b/drivers/mmc/host/cavium-mmc.c
> > @@ -0,0 +1,988 @@
> > +/*
> > + * Shared part of driver for MMC/SDHC controller on Cavium OCTEON and
> > + * ThunderX SOCs.
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + *
> > + * Copyright (C) 2012-2017 Cavium Inc.
> > + * Authors:
> > + *   David Daney <david.daney@cavium.com>
> > + *   Peter Swain <pswain@cavium.com>
> > + *   Steven J. Hill <steven.hill@cavium.com>
> > + *   Jan Glauber <jglauber@cavium.com>
> > + */
> > +#include <linux/bitfield.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-direction.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/slot-gpio.h>
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/scatterlist.h>
> > +#include <linux/time.h>
> > +
> > +#include "cavium-mmc.h"
> > +
> > +const char *cvm_mmc_irq_names[] = {
> > +       "MMC Buffer",
> > +       "MMC Command",
> > +       "MMC DMA",
> > +       "MMC Command Error",
> > +       "MMC DMA Error",
> > +       "MMC Switch",
> > +       "MMC Switch Error",
> > +       "MMC DMA int Fifo",
> > +       "MMC DMA int",
> > +};
> 
> Debug-leftover?
> 
> [...]

No, this is used by both Octeon and ThunderX drivers. Maybe I should
have put it into an extra patch.

> > +
> > +static void cvm_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +       struct cvm_mmc_slot *slot = mmc_priv(mmc);
> > +       struct cvm_mmc_host *host = slot->host;
> > +       int clk_period = 0, power_class = 10, bus_width = 0;
> > +       u64 clock, emm_switch;
> > +
> > +       host->acquire_bus(host);
> > +       cvm_mmc_switch_to(slot);
> > +
> > +       /* Set the power state */
> > +       switch (ios->power_mode) {
> > +       case MMC_POWER_ON:
> > +               break;
> > +
> > +       case MMC_POWER_OFF:
> > +               cvm_mmc_reset_bus(slot);
> > +
> > +               if (host->global_pwr_gpiod)
> > +                       gpiod_set_value_cansleep(host->global_pwr_gpiod, 0);
> 
> If I have understood the changelog correctly this GPIO is shared for
> all slots, right?

Yes.

> In such case, this doesn't work. You need to centralize the management
> of this GPIO pin (to enable reference counting), as otherwise one slot
> can decide to power off its card while another still uses their card
> and expecting the power to be on.

OK. I could create a function in the shared part with ref counting.
On the other side, only the existing Octeon HW will use the global_pwr_gpiod,
and this HW only has one slot. For all new HW we'll use the GPIO regulator,
so I think it is not worth changing it. I'll add a comment.

> Another option would be to model it as GPIO regulator (using a device
> tree overlay as we discussed earlier), then you get the reference
> counting for free - and easily get ocr_avail mask from the mmc core's
> regulator API. :-)
> 

No, this is what I already do in case host->global_pwr_gpiod is not set.

> Moreover, I didn't find this GPIO being documented as a DT binding, it
> should and it should also be marked as deprecated.

Good point, I'll add it.

> > +               else
> > +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +               break;
> > +
> > +       case MMC_POWER_UP:
> > +               if (host->global_pwr_gpiod)
> > +                       gpiod_set_value_cansleep(host->global_pwr_gpiod, 1);
> 
> Dittto.
> 
> > +               else
> > +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> > +               break;
> > +       }
> > +
> 
> [...]
> 
> > +
> > +static int cvm_mmc_of_parse(struct device *dev, struct cvm_mmc_slot *slot)
> > +{
> > +       u32 id, cmd_skew = 0, dat_skew = 0, bus_width = 0, f_max = 0;
> > +       struct device_node *node = dev->of_node;
> > +       struct mmc_host *mmc = slot->mmc;
> > +       u64 clock_period;
> > +       int ret;
> > +
> > +       ret = of_property_read_u32(node, "reg", &id);
> > +       if (ret) {
> > +               dev_err(dev, "Missing or invalid reg property on %s\n",
> > +                       of_node_full_name(node));
> > +               return ret;
> > +       }
> > +
> > +       if (id >= CAVIUM_MAX_MMC || slot->host->slot[id]) {
> > +               dev_err(dev, "Invalid reg property on %s\n",
> > +                       of_node_full_name(node));
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Deprecated Cavium bindings for old firmware */
> > +       of_property_read_u32(node, "cavium,bus-max-width", &bus_width);
> > +       of_property_read_u32(node, "spi-max-frequency", &f_max);
> > +       if (slot->host->global_pwr_gpiod) {
> > +               /* Get a sane OCR mask for other parts of the MMC subsytem. */
> > +               ret = mmc_of_parse_voltage(node, &mmc->ocr_avail);
> 
> I noticed your comment to Arnd for the cover-letter. So I assume you
> will remove this and instead assign mmc->ocr_avail a default value in
> cases when you don't have a vmmc regulator to find it from.

Yes.

> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       /* Cavium-specific DT properties */
> > +       of_property_read_u32(node, "cavium,cmd-clk-skew", &cmd_skew);
> > +       of_property_read_u32(node, "cavium,dat-clk-skew", &dat_skew);
> > +
> > +       if (!slot->host->global_pwr_gpiod) {
> > +               mmc->supply.vmmc = devm_regulator_get(dev, "vmmc");
> > +               if (IS_ERR(mmc->supply.vmmc))
> > +                       return PTR_ERR(mmc->supply.vmmc);
> > +
> > +               ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
> > +               if (ret > 0)
> > +                       mmc->ocr_avail = ret;
> > +       }
> > +
> > +       /* Common MMC bindings */
> > +       ret = mmc_of_parse(mmc);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Set bus width */
> > +       if (!bus_width) {
> > +               if (mmc->caps & MMC_CAP_8_BIT_DATA)
> > +                       bus_width = 8;
> > +               else if (mmc->caps & MMC_CAP_4_BIT_DATA)
> > +                       bus_width = 4;
> > +               else
> > +                       bus_width = 1;
> > +       }
> > +
> > +       switch (bus_width) {
> > +       case 8:
> > +               slot->bus_width = 2;
> 
> Why do you need to store this in slot struct? The information is
> already available in the mmc host.

I guess it is in the slot because the HW encoding is different from the
mmc bus width. Let me see if removing it simplifies the code.

> > +               slot->mmc->caps = MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
> 
> This is wrong, as you will clear all the other mmc caps potentially
> assigned by mmc_of_parse() above.

Good catch.

> Moreover, you can use mmc->caps instead of slot->mmc->caps.

Yup.

> > +               break;
> > +       case 4:
> > +               slot->bus_width = 1;
> > +               slot->mmc->caps = MMC_CAP_4_BIT_DATA;
> > +               break;
> > +       case 1:
> > +               slot->bus_width = 0;
> > +               break;
> > +       }
> 
> I would rather make the deprecated bindings to take the lowest
> precedence and besides, this bus_width setup looks messy. How about
> something like this instead:

Previously you said I should parse deprecated bindings first, so I did
that ;-

> mmc_of_parse();
> 
> if (!(mmc->caps & (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA))) {
>     of_property_read_u32(node, "cavium,bus-max-width", &bus_width);
>     if (bus_width == 8)
>           mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA;
>     else if (bus_width == 4)
>           mmc->caps |= MMC_CAP_4_BIT_DATA;
> }

OK.

> > +
> > +       /* Set maximum and minimum frequency */
> > +       if (f_max)
> > +               mmc->f_max = f_max;
> 
> Again, let's make sure the deprecated bindings takes lower precedence.
> Thus if mmc->f_max has a value let's use that and if not, then parse
> the deprecated DT binding and use that value instead.

OK.

> > +       if (!mmc->f_max || mmc->f_max > 52000000)
> > +               mmc->f_max = 52000000;
> > +       mmc->f_min = 400000;
> > +
> > +       /* Sampling register settings, period in picoseconds */
> > +       clock_period = 1000000000000ull / slot->host->sys_freq;
> > +       slot->cmd_cnt = (cmd_skew + clock_period / 2) / clock_period;
> > +       slot->dat_cnt = (dat_skew + clock_period / 2) / clock_period;
> > +
> > +       return id;
> > +}
> 
> [...]
> 
> > diff --git a/drivers/mmc/host/cavium-mmc.h b/drivers/mmc/host/cavium-mmc.h
> > new file mode 100644
> > index 0000000..c3843448
> > --- /dev/null
> > +++ b/drivers/mmc/host/cavium-mmc.h
> 
> [...]
> 
>  +
> > +/* Protoypes */
> > +irqreturn_t cvm_mmc_interrupt(int irq, void *dev_id);
> > +int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host);
> > +int cvm_mmc_of_slot_remove(struct cvm_mmc_slot *slot);
> > +extern const char *cvm_mmc_irq_names[];
> 
> Debug leftover?

No, as I said before this is the interface I need for sharing
cavium-mmc.c and using it from the Octeon and ThunderX drivers.

Should I put the interface into a separate patch (together with the
interrupt names)?

Thanks for the review!
Jan

> Kind regards
> Uffe
