From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Wed, 26 Jan 2011 19:44:11 +0100
Message-ID: <AANLkTi=KKfxTRzW1iyLKjM0Ho6x7kYpwGwx7F-gD4EaM@mail.gmail.com>
References: <20110114082310.GB27523@intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
	<5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
	<20110120050803.GA5732@void.printf.net>
	<AANLkTimZyv9f5b5VxmmYyO3qPrb9Y25-=yUV_GYma3e_@mail.gmail.com>
	<8250E4885F9967469CAC3FB5CBA2CE69934EFA98B2@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54026 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab1AZSoL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jan 2011 13:44:11 -0500
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69934EFA98B2@irsmsx501.ger.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

2011/1/25 Tardy, Pierre <pierre.tardy@intel.com>:

> Actually in sdhci, you power off the MMC IP block, you power OFF the
> MCLK (at least on our platform)
>
> I don't know other platform where mmc clock is not controlled more or
> less directlty by the sdhc IP.

This is the case with host/mmci.c.

It is taking a clock inside the driver (MCLK), but since it's an AMBA
primecell, you can see that when it's probed it also requests and
optional IP clock in drivers/amba/bus.c.

The ARM reference platforms are wired with two different clocks
connected to each of these.

There are platforms, such as the U300 that just connect the two
into one terminal though. To get a chance to handle the abstraction
for both cases these two clocks refer to the same struct clk in the
clock tree.

>> Further this patch cannot be applied as-is.
>> It needs a clause where it will wait for the clock gating to
>> be sync:ed *before* calling the suspend hook.
>
> That's the purpose of those hunks:
>
> iff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8c3769b..27931f6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -20,6 +20,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/scatterlist.h>
> =A0#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
>
> =A0#include <linux/leds.h>
>
> @@ -1221,6 +1222,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
> =A0{
> =A0 =A0 =A0 =A0struct sdhci_host *host;
> =A0 =A0 =A0 =A0unsigned long flags;
> + =A0 =A0 =A0 unsigned int lastclock;
> =A0 =A0 =A0 =A0u8 ctrl;
>
> =A0 =A0 =A0 =A0host =3D mmc_priv(mmc);
> @@ -1231,6 +1233,27 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* get/put runtime_pm usage counter at ios->clock tra=
nsitions
> + =A0 =A0 =A0 =A0* We need to do it before any other chip access, as =
sdhci could
> + =A0 =A0 =A0 =A0* be power gated
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 lastclock =3D host->iosclock;
> + =A0 =A0 =A0 host->iosclock =3D ios->clock;
> + =A0 =A0 =A0 if (lastclock =3D=3D 0 && ios->clock !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, fla=
gs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->mmc->parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> + =A0 =A0 =A0 } else if (lastclock !=3D 0 && ios->clock =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, fla=
gs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_mark_last_busy(host->mmc->pa=
rent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_autosuspend(host->mmc->p=
arent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* no need to configure the rest.. */
> + =A0 =A0 =A0 if (host->iosclock =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Reset the chip on each power off.
> =A0 =A0 =A0 =A0 * Should clear out any weird states.
> =A0 =A0 =A0 =A0 */

Aha I get it. So it uses the freq shift from the existing clock gate
code to hint rpm, that's actually how I envisioned that this would
work for this case.

Now I really started liking this patch.
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

> @@ -1303,6 +1326,8 @@ static int sdhci_get_ro(struct mmc_host *mmc)
>
> I'm wondering if this code could be generic to all drivers, and if cl=
ock gating could not be taking/releasing reference counter on the mmc_b=
us whenever there is a clock gating transition?
> We could condition that on some MMC_CAP_POWERGATE_WILL_CLKGATE capabi=
lity flag.

Time will tell I guess, the code in each driver will surely be similar
to the above, but I already see some deviations, e.g. some HW
will need to delay the actual action taken, some may want to
manipulate a register or regulator etc, so I'd leave it open-ended
like this.

Yours,
Linus Walleij
