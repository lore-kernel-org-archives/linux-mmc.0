From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 02/11] mmc: tmio_mmc: support the generic MMC GPIO card
 hotplug helper
Date: Fri, 6 Jan 2012 12:01:39 +0900
Message-ID: <CANqRtoTLh2i9s6F_g10+RPnDvA+RkpVYqaYb6-Z=8dvk_YyGYw@mail.gmail.com>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
	<1325686636-23905-3-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51357 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab2AFDBl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2012 22:01:41 -0500
In-Reply-To: <1325686636-23905-3-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Jan 4, 2012 at 11:17 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> If the platform specified a GPIO number and IRQ trigger polarity flag=
s, use
> the generic MMC GPIO card hotplug helper.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 | =A0 =A04 --
> =A0drivers/mmc/host/tmio_mmc_pio.c | =A0 69 +++++++++++++++++--------=
--------------
> =A0include/linux/mfd/tmio.h =A0 =A0 =A0 =A0| =A0 19 +++++++---
> =A03 files changed, 43 insertions(+), 49 deletions(-)
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 0dc9804..4ef9307 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -1,8 +1,10 @@
> =A0#ifndef MFD_TMIO_H
> =A0#define MFD_TMIO_H
>
> +#include <linux/device.h>
> =A0#include <linux/fb.h>
> =A0#include <linux/io.h>
> +#include <linux/jiffies.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/pm_runtime.h>
>
> @@ -64,8 +66,8 @@
> =A0#define TMIO_MMC_SDIO_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> =A0/*
> =A0* Some platforms can detect card insertion events with controller =
powered
> - * down, in which case they have to call tmio_mmc_cd_wakeup() to pow=
er up the
> - * controller and report the event to the driver.
> + * down, using a GPIO IRQ, in which case they have to fill in cd_irq=
, cd_gpio,
> + * and cd_flags fields of struct tmio_mmc_data.
> =A0*/
> =A0#define TMIO_MMC_HAS_COLD_CD =A0 =A0 =A0 =A0 =A0 (1 << 3)
> =A0/*
> @@ -98,18 +100,23 @@ struct tmio_mmc_data {
> =A0 =A0 =A0 =A0struct tmio_mmc_dma =A0 =A0 =A0 =A0 =A0 =A0 *dma;
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev=
;
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0power;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd_=
gpio;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd_=
irq;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd_fl=
ags;
> =A0 =A0 =A0 =A0void (*set_pwr)(struct platform_device *host, int stat=
e);
> =A0 =A0 =A0 =A0void (*set_clk_div)(struct platform_device *host, int =
state);
> =A0 =A0 =A0 =A0int (*get_cd)(struct platform_device *host);
> =A0 =A0 =A0 =A0int (*write16_hook)(struct tmio_mmc_host *host, int ad=
dr);
> =A0};

This looks much easier than callbacks and notifiers. Thanks!

But why do you need to pass three values here? I expected it to be
sufficient with GPIO and perhaps also with trigger flags. Shouldn't
gpio_to_irq() give you the IRQ from the GPIO? And why on earth would
we want to trigger on something else than both edges?

The SoC code may me rather limited in terms of supporting
gpio_to_irq() but that needs to be fixed then. On SH-Mobile the PFC
code has been updated to allow this, so it's only SoC-specific code
missing. Anyone with access to hardware and data sheet can do this,
and if there are some issues with this then I'd be happy to help
myself.

On the cosmetic side, wouldn't it make sense to have a structure of
these values and just pass that along? Otherwise people will mix and
match short and ints for the GPIO and it may become rather messy over
time.

Thanks,

/ magnus
