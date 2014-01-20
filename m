From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Mon, 20 Jan 2014 11:13:02 -0800
Message-ID: <20140120191302.GA32178@quad.lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
 <CAPDyKFoywt_LcWXdWJCWMU8-GT2vLW27eiuF0WEyjHJV+96HpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64056 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaATTO7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2014 14:14:59 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so7440228pab.29
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2014 11:14:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPDyKFoywt_LcWXdWJCWMU8-GT2vLW27eiuF0WEyjHJV+96HpA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, mark.rutland@arm.com, Pawel Moll <pawel.moll@arm.com>, ijc+devicetree@hellion.org.ok, galak@codeaurora.org, Chris Ball <chris@printf.net>

On Mon, Jan 20, 2014 at 09:44:23AM +0100, Ulf Hansson wrote:
> On 20 January 2014 04:56, Olof Johansson <olof@lixom.net> wrote:
> > This patch enables support for power-on sequencing of SDIO peripherals through DT.
> >
> > In general, it's quite common that wifi modules and other similar
> > peripherals have several signals in addition to the SDIO interface that
> > needs wiggling before the module will power on. It's common to have a
> > reference clock, one or several power rails and one or several lines
> > for reset/enable type functions.
> >
> > The binding as written today introduces a number of reset gpios,
> > a regulator and a clock specifier. The code will handle up to 2 gpio
> > reset lines, but it's trivial to increase to more than that if needed
> > at some point.
> >
> > Implementation-wise, the MMC core has been changed to handle this during
> > host power up, before the host interface is powered on. I have not yet
> > implemented the power-down side, I wanted people to have a chance for
> > reporting back w.r.t. issues (or comments on the bindings) first.
> >
> > I have not tested the regulator portion, since the system and module
> > I'm working on doesn't need one (Samsung Chromebook with Marvell
> > 8797-based wifi). Testing of those portions (and reporting back) would
> > be appreciated.
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc.txt |   11 +++++++
> >  drivers/mmc/core/core.c                       |   42 +++++++++++++++++++++++++
> >  drivers/mmc/core/host.c                       |   30 +++++++++++++++++-
> >  include/linux/mmc/host.h                      |    5 +++
> >  4 files changed, 87 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> > index 458b57f..962e0ee 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> > @@ -5,6 +5,8 @@ these definitions.
> >  Interpreted by the OF core:
> >  - reg: Registers location and length.
> >  - interrupts: Interrupts used by the MMC controller.
> > +- clocks: Clocks needed for the host controller, if any.
> > +- clock-names: Goes with clocks above.
> >
> >  Card detection:
> >  If no property below is supplied, host native card detect is used.
> > @@ -30,6 +32,15 @@ Optional properties:
> >  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
> >  - full-pwr-cycle: full power cycle of the card is supported
> >
> > +Card power and reset control:
> > +The following properties can be specified for cases where the MMC
> > +peripheral needs additional reset, regulator and clock lines. It is for
> > +example common for WiFi/BT adapters to have these separate from the main
> > +MMC bus:
> > +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
> > +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> > +  - clock with name "card_ext_clock": External clock provided to the card
> > +
> >  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
> >  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> >  line levels. We choose to follow the SDHCI standard, which specifies both those
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 098374b..c43e6c8 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -13,11 +13,13 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/clk.h>
> >  #include <linux/completion.h>
> >  #include <linux/device.h>
> >  #include <linux/delay.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/err.h>
> > +#include <linux/gpio.h>
> >  #include <linux/leds.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/log2.h>
> > @@ -1519,6 +1521,43 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
> >         mmc_host_clk_release(host);
> >  }
> >
> > +static void mmc_card_power_up(struct mmc_host *host)
> > +{
> > +       int i;
> > +       struct gpio_desc **gds = host->card_reset_gpios;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> > +               if (gds[i]) {
> > +                       dev_dbg(host->parent, "Asserting reset line %d", i);
> > +                       gpiod_set_value(gds[i], 1);
> > +               }
> > +       }
> > +
> > +       if (host->card_regulator) {
> > +               dev_dbg(host->parent, "Enabling external regulator");
> > +               if (regulator_enable(host->card_regulator))
> > +                       dev_err(host->parent, "Failed to enable external regulator");
> > +       }
> > +
> > +       if (host->card_clk) {
> > +               dev_dbg(host->parent, "Enabling external clock");
> > +               clk_prepare_enable(host->card_clk);
> > +       }
> > +
> > +       /* 2ms delay to let clocks and power settle */
> > +       mmc_delay(20);
> > +
> > +       for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> > +               if (gds[i]) {
> > +                       dev_dbg(host->parent, "Deasserting reset line %d", i);
> > +                       gpiod_set_value(gds[i], 0);
> > +               }
> > +       }
> > +
> > +       /* 2ms delay to after reset release */
> > +       mmc_delay(20);
> > +}
> > +
> >  /*
> >   * Apply power to the MMC stack.  This is a two-stage process.
> >   * First, we enable power to the card without the clock running.
> > @@ -1535,6 +1574,9 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
> >         if (host->ios.power_mode == MMC_POWER_ON)
> >                 return;
> >
> > +       /* Power up the card/module first, if needed */
> > +       mmc_card_power_up(host);
> > +
> >         mmc_host_clk_hold(host);
> >
> >         host->ios.vdd = fls(ocr) - 1;
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 49bc403..e6b850b 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -12,14 +12,18 @@
> >   *  MMC host class device management
> >   */
> >
> > +#include <linux/kernel.h>
> > +#include <linux/clk.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/idr.h>
> >  #include <linux/of.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/export.h>
> >  #include <linux/leds.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/suspend.h>
> >
> > @@ -312,7 +316,7 @@ int mmc_of_parse(struct mmc_host *host)
> >         u32 bus_width;
> >         bool explicit_inv_wp, gpio_inv_wp = false;
> >         enum of_gpio_flags flags;
> > -       int len, ret, gpio;
> > +       int i, len, ret, gpio;
> >
> >         if (!host->parent || !host->parent->of_node)
> >                 return 0;
> > @@ -415,6 +419,30 @@ int mmc_of_parse(struct mmc_host *host)
> >         if (explicit_inv_wp ^ gpio_inv_wp)
> >                 host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> >
> > +       /* Parse card power/reset/clock control */
> 
> I would like us to prevent to open up for confusion with the "eMMC hw
> reset" when adding this. Unless we are able to combine them in some
> way?
> 
> Could we maybe add some more comments about in what scenarios this DT
> property would be useful?

Ok, can do. How about something like:

	/*
	 * Some cards need separate power/reset/clock control from the main
	 * MMC/SDIO bus. Parse the description of those controls so we can
	 * power on the card before the host controller.
	 */


> > +       if (of_find_property(np, "card-reset-gpios", NULL)) {
> > +               struct gpio_desc *gpd;
> > +               for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> > +                       gpd = devm_gpiod_get_index(host->parent, "card-reset", i);
> > +                       if (IS_ERR(gpd))
> > +                               break;
> > +                       gpiod_direction_output(gpd, 0);
> > +                       host->card_reset_gpios[i] = gpd;
> > +               }
> > +
> > +               gpd = devm_gpiod_get_index(host->parent, "card-reset", ARRAY_SIZE(host->card_reset_gpios));
> > +               if (!IS_ERR(gpd)) {
> > +                       dev_warn(host->parent, "More reset gpios than we can handle");
> > +                       gpiod_put(gpd);
> > +               }
> > +       }
> > +
> > +       host->card_clk = of_clk_get_by_name(np, "card_ext_clock");
> 
> of_clk_get_by_name relies on COMMON_CLK, is that really what you want here?
> 
> > +       if (IS_ERR(host->card_clk))
> > +               host->card_clk = NULL;
> > +
> > +       host->card_regulator = regulator_get(host->parent, "card-external-vcc");
> 
> Is the above regulator related to host->ocr_avail mask? Could the
> above regulator be replaced by vmmc?

I have to admit that I don't know MMC as well as I could, but OCR seems to be
something that's between the driver/controller/device, not related to external
power control in this case?

> At the moment host drivers uses mmc_regulator_get_supply(), which
> fetches regulators called "vmmc" and "vqmmc". It is also common to
> have these defined in DT like "vmmc-supply". This has not been
> properly documented for most host cases, and we should fix that. I
> also think it would make sense to include these in the documentation
> for the common mmc bindings, instead of host specific bindings.

Hm, I had been of the impression that the vmmc stuff is to control
power/voltage on the signal lines, not for external card power. Still, even in
that case there's need for the reset line handling and clock control.

I'll take a look and see if there's a way to handle that in a properly
sequenced way and still use the same regulator.


-Olof
