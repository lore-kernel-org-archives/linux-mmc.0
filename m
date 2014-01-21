From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Tue, 21 Jan 2014 19:34:15 +0100
Message-ID: <52DEBDA7.7030200@samsung.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
 <1390190215-22700-2-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:46985 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144AbaAUSec (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 13:34:32 -0500
In-reply-to: <1390190215-22700-2-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, Ian Campbell <ijc+devicetree@hellion.org.uk>, galak@codeaurora.org, chris@printf.net, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

Hi,

On 20.01.2014 04:56, Olof Johansson wrote:
> This patch enables support for power-on sequencing of SDIO peripherals through DT.
>
> In general, it's quite common that wifi modules and other similar
> peripherals have several signals in addition to the SDIO interface that
> needs wiggling before the module will power on. It's common to have a
> reference clock, one or several power rails and one or several lines
> for reset/enable type functions.
>
> The binding as written today introduces a number of reset gpios,
> a regulator and a clock specifier. The code will handle up to 2 gpio
> reset lines, but it's trivial to increase to more than that if needed
> at some point.
>
> Implementation-wise, the MMC core has been changed to handle this during
> host power up, before the host interface is powered on. I have not yet
> implemented the power-down side, I wanted people to have a chance for
> reporting back w.r.t. issues (or comments on the bindings) first.
>
> I have not tested the regulator portion, since the system and module
> I'm working on doesn't need one (Samsung Chromebook with Marvell
> 8797-based wifi). Testing of those portions (and reporting back) would
> be appreciated.

While I fully agree that this is an important problem that needs to be 
solved, I really don't think this is the right way, because:

a) power-up sequence is really specific to the MMC device and often it's 
not simply a matter of switching on one regulator or one clock, e.g. 
specific time constraints need to be met.

b) you can have WLAN chips in which SDIO is just one of the options to 
use as host interface, which may be also HSIC, I2C or UART. Really. See [1].

c) this is leaking device specific details to generic host code, which 
isn't really elegant.

Now, to make this a bit more constructive, [2] is a solution that I came 
up with (not perfect either), which simply adds a separate platform 
device for the low level part of the chip. I believe this is a better 
solution because:

a) you can often see such WLAN/BT combo chip as a set of separate 
devices, e.g. SDIO WLAN, UART BT and a simple PMIC or management IC, 
which provides power/reset control, out of band signalling and etc. for 
the first two, so it isn't that bad to have a separate device node for 
the last one,

b) you have full freedom of defining your DT binding with whatever data 
you need, any number of clocks, regulators, GPIOs and even out of band 
interrupts (IMHO the most important one).

c) you can implement power-on, power-off sequences as needed for your 
particular device,

d) you have full separation of device-specific data from MMC core (or 
any other subsystem simply used as a way to perform I/O to the chip).

Now what's missing there is a way to signal the MMC core or any other 
transport that a device showed up and the controller should be woken up 
out of standby and scan of the bus initialized. This could be done by 
explicitly specifying the device as a subnode of the 
MMC/UART/USB(HSIC)/I2C or whatever with a link (phandle) to the power 
controller of the chip or the other way around - a link to the 
MMC/UART/... controller from the power controller node.

What do you think?

Best regards,
Tomasz

References:
[1] - http://www.marvell.com/wireless/assets/marvell_avastar_88w8797.pdf
[2] - 
https://review.tizen.org/git/?p=platform/kernel/linux-3.10.git;a=commitdiff;h=978bc9523622248271e4007330ae1a0eee6e0254

>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>   Documentation/devicetree/bindings/mmc/mmc.txt |   11 +++++++
>   drivers/mmc/core/core.c                       |   42 +++++++++++++++++++++++++
>   drivers/mmc/core/host.c                       |   30 +++++++++++++++++-
>   include/linux/mmc/host.h                      |    5 +++
>   4 files changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 458b57f..962e0ee 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -5,6 +5,8 @@ these definitions.
>   Interpreted by the OF core:
>   - reg: Registers location and length.
>   - interrupts: Interrupts used by the MMC controller.
> +- clocks: Clocks needed for the host controller, if any.
> +- clock-names: Goes with clocks above.
>
>   Card detection:
>   If no property below is supplied, host native card detect is used.
> @@ -30,6 +32,15 @@ Optional properties:
>   - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>   - full-pwr-cycle: full power cycle of the card is supported
>
> +Card power and reset control:
> +The following properties can be specified for cases where the MMC
> +peripheral needs additional reset, regulator and clock lines. It is for
> +example common for WiFi/BT adapters to have these separate from the main
> +MMC bus:
> +  - card-reset-gpios: Specify GPIOs for card reset (reset active low)
> +  - card-external-vcc-supply: Regulator to drive (independent) card VCC
> +  - clock with name "card_ext_clock": External clock provided to the card
> +
>   *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>   polarity properties, we have to fix the meaning of the "normal" and "inverted"
>   line levels. We choose to follow the SDHCI standard, which specifies both those
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 098374b..c43e6c8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -13,11 +13,13 @@
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
> +#include <linux/clk.h>
>   #include <linux/completion.h>
>   #include <linux/device.h>
>   #include <linux/delay.h>
>   #include <linux/pagemap.h>
>   #include <linux/err.h>
> +#include <linux/gpio.h>
>   #include <linux/leds.h>
>   #include <linux/scatterlist.h>
>   #include <linux/log2.h>
> @@ -1519,6 +1521,43 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
>   	mmc_host_clk_release(host);
>   }
>
> +static void mmc_card_power_up(struct mmc_host *host)
> +{
> +	int i;
> +	struct gpio_desc **gds = host->card_reset_gpios;
> +
> +	for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> +		if (gds[i]) {
> +			dev_dbg(host->parent, "Asserting reset line %d", i);
> +			gpiod_set_value(gds[i], 1);
> +		}
> +	}
> +
> +	if (host->card_regulator) {
> +		dev_dbg(host->parent, "Enabling external regulator");
> +		if (regulator_enable(host->card_regulator))
> +			dev_err(host->parent, "Failed to enable external regulator");
> +	}
> +
> +	if (host->card_clk) {
> +		dev_dbg(host->parent, "Enabling external clock");
> +		clk_prepare_enable(host->card_clk);
> +	}
> +
> +	/* 2ms delay to let clocks and power settle */
> +	mmc_delay(20);
> +
> +	for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> +		if (gds[i]) {
> +			dev_dbg(host->parent, "Deasserting reset line %d", i);
> +			gpiod_set_value(gds[i], 0);
> +		}
> +	}
> +
> +	/* 2ms delay to after reset release */
> +	mmc_delay(20);
> +}
> +
>   /*
>    * Apply power to the MMC stack.  This is a two-stage process.
>    * First, we enable power to the card without the clock running.
> @@ -1535,6 +1574,9 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>   	if (host->ios.power_mode == MMC_POWER_ON)
>   		return;
>
> +	/* Power up the card/module first, if needed */
> +	mmc_card_power_up(host);
> +
>   	mmc_host_clk_hold(host);
>
>   	host->ios.vdd = fls(ocr) - 1;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 49bc403..e6b850b 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -12,14 +12,18 @@
>    *  MMC host class device management
>    */
>
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>   #include <linux/idr.h>
>   #include <linux/of.h>
>   #include <linux/of_gpio.h>
>   #include <linux/pagemap.h>
>   #include <linux/export.h>
>   #include <linux/leds.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/suspend.h>
>
> @@ -312,7 +316,7 @@ int mmc_of_parse(struct mmc_host *host)
>   	u32 bus_width;
>   	bool explicit_inv_wp, gpio_inv_wp = false;
>   	enum of_gpio_flags flags;
> -	int len, ret, gpio;
> +	int i, len, ret, gpio;
>
>   	if (!host->parent || !host->parent->of_node)
>   		return 0;
> @@ -415,6 +419,30 @@ int mmc_of_parse(struct mmc_host *host)
>   	if (explicit_inv_wp ^ gpio_inv_wp)
>   		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
>
> +	/* Parse card power/reset/clock control */
> +	if (of_find_property(np, "card-reset-gpios", NULL)) {
> +		struct gpio_desc *gpd;
> +		for (i = 0; i < ARRAY_SIZE(host->card_reset_gpios); i++) {
> +			gpd = devm_gpiod_get_index(host->parent, "card-reset", i);
> +			if (IS_ERR(gpd))
> +				break;
> +			gpiod_direction_output(gpd, 0);
> +			host->card_reset_gpios[i] = gpd;
> +		}
> +
> +		gpd = devm_gpiod_get_index(host->parent, "card-reset", ARRAY_SIZE(host->card_reset_gpios));
> +		if (!IS_ERR(gpd)) {
> +			dev_warn(host->parent, "More reset gpios than we can handle");
> +			gpiod_put(gpd);
> +		}
> +	}
> +
> +	host->card_clk = of_clk_get_by_name(np, "card_ext_clock");
> +	if (IS_ERR(host->card_clk))
> +		host->card_clk = NULL;
> +
> +	host->card_regulator = regulator_get(host->parent, "card-external-vcc");
> +
>   	if (of_find_property(np, "cap-sd-highspeed", &len))
>   		host->caps |= MMC_CAP_SD_HIGHSPEED;
>   	if (of_find_property(np, "cap-mmc-highspeed", &len))
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 99f5709..6781887 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -297,6 +297,11 @@ struct mmc_host {
>   	unsigned long           clkgate_delay;
>   #endif
>
> +	/* card specific properties to deal with power and reset */
> +	struct regulator	*card_regulator; /* External VCC needed by the card */
> +	struct gpio_desc	*card_reset_gpios[2]; /* External resets, active low */
> +	struct clk		*card_clk;	/* External clock needed by the card */
> +
>   	/* host specific block data */
>   	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
>   	unsigned short		max_segs;	/* see blk_queue_max_segments */
>
