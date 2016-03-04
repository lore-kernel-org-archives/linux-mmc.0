From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix wakeup issue when using runtime pm
Date: Fri, 4 Mar 2016 10:09:37 +0100
Message-ID: <CAPDyKFpovsOMVSxifefFcvHFoNL-AaBH_tbWbN7QRQqv2hrSnw@mail.gmail.com>
References: <20160212120415.GJ14937@odux.rfo.atmel.com>
	<1455357400-32145-1-git-send-email-ludovic.desroches@atmel.com>
	<CAPDyKFroVY0ZdqPScpGiJ8Y_QhhZ7asf0R0MzSx0WzVi5c2neg@mail.gmail.com>
	<20160216152204.GE2607@odux.rfo.atmel.com>
	<20160217103515.GM2607@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36252 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758765AbcCDJJj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 04:09:39 -0500
Received: by mail-wm0-f42.google.com with SMTP id n186so25209662wmn.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2016 01:09:38 -0800 (PST)
In-Reply-To: <20160217103515.GM2607@odux.rfo.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Adrian Hunter <adrian.hunter@intel.com>

On 17 February 2016 at 11:35, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> On Tue, Feb 16, 2016 at 04:22:04PM +0100, Ludovic Desroches wrote:
>> On Tue, Feb 16, 2016 at 03:38:29PM +0100, Ulf Hansson wrote:
>> > On 13 February 2016 at 10:56, Ludovic Desroches
>> > <ludovic.desroches@atmel.com> wrote:
>> > > When suspending the sdhci host, the only hardware event that could wake
>> > > up the host is a sdio irq if they are enabled. If we want to wakeup on
>> > > card detect events, a gpio as to be used.
>> > > If we don't want to use a gpio but the card detect pio of the controller
>> > > then we need to keep enabled the clock of the controller interface to
>> > > get the interrupt and to not set the host in a suspended state to have the
>> > > interrupt handled.
>> > >
>> > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> > > ---
>> > >  drivers/mmc/host/sdhci-of-at91.c | 46 ++++++++++++++++++++++++++++++----------
>> > >  1 file changed, 35 insertions(+), 11 deletions(-)
>> > >
>> > > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>> > > index efec736..2159c6e 100644
>> > > --- a/drivers/mmc/host/sdhci-of-at91.c
>> > > +++ b/drivers/mmc/host/sdhci-of-at91.c
>> > > @@ -18,6 +18,7 @@
>> > >  #include <linux/err.h>
>> > >  #include <linux/io.h>
>> > >  #include <linux/mmc/host.h>
>> > > +#include <linux/mmc/slot-gpio.h>
>> > >  #include <linux/module.h>
>> > >  #include <linux/of.h>
>> > >  #include <linux/of_device.h>
>> > > @@ -45,7 +46,6 @@ static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
>> > >
>> > >  static const struct sdhci_pltfm_data soc_data_sama5d2 = {
>> > >         .ops = &sdhci_at91_sama5d2_ops,
>> > > -       .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
>> >
>> > You probably have some leftovers from earlier local changes, as this
>> > isn't going to apply to my next branch.
>> >
>>
>> Yes, it is based on the first patch of this thread, it was only to
>> discuss about it.
>>
>> > >         .quirks2 = SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST,
>> > >  };
>> > >
>> > > @@ -55,17 +55,37 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>> > >  };
>> > >
>> > >  #ifdef CONFIG_PM
>> > > +static bool sdhci_at91_use_sdhci_runtime(struct sdhci_host *host)
>> > > +{
>> > > +       u32 caps = host->mmc->caps;
>> > > +
>> > > +       return (caps & MMC_CAP_NONREMOVABLE) ||
>> > > +              (!IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)));
>
>
> I am wondering if I should take account of sdio irq enabled or not here.
>
> I have a sdio device which drives me crazy because of power management.
> The driver of this device is in staging, it is wilc1000. It seems that I
> am stuck because the sdio irq are not received. If I don't disable the
> clock of the controller (hclock), I should receive the sdio IRQ as I
> receive card detect ones, isn't it?
>
> It doesn't work, it seems I have also to not disabled mainck and gck
> which are clocks needed to generate the clock sent to the sdio device.
> If none of the clocks have to be disabled, where it has to be managed?

That's a typical issue for SDIO IRQs, especially when the controller
HW manages IRQs (there are other ways to deal with SDIO IRQs as well).

Currently, the simplest way to deal with this in the driver is to do a
pm_runtime_get_sync() when the SDIO IRQ gets enabled, and
pm_runtime_put() when it gets disabled.

>
> Do I have to anticipate this use case in the driver of my sdhci
> controller or does it have to be managed in the sdio device driver? They
> are using sdio_claim/release_host to suspend or resume the host but
> maybe they use it in a bad way.

The wilc100 SDIO func driver should *not* keep the host claimed to
deal with SDIO irqs. Only when it configures them.

Instead, you need to deal with this in the sdhci driver, when you get
the call to enable/disable SDIO IRQs.

Moreover, from a system PM point of view. If the wilc100 SDIO func
driver wants the platform to wake up on SDIO IRQs, it needs to set
MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ from its ->suspend()
callback.

In that way, your sdhci driver can act accordingly from its system PM
callbacks. In other words, depending on MMC_PM_KEEP_POWER and
MMC_PM_WAKE_SDIO_IRQ to *not* call pm_runtime_force_suspend().

[...]

Kind regards
Uffe
