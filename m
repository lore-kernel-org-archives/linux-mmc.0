From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] mmc: sdhci-of-at91: don't put device in suspend after probe
Date: Wed, 10 Feb 2016 16:56:11 +0100
Message-ID: <CAPDyKFp-N6yEtc=U9rCuR9QxijPU8+xK1xE5qJeoERx+K8NkSw@mail.gmail.com>
References: <1455098283-14500-1-git-send-email-ludovic.desroches@atmel.com>
	<56BB2414.1040606@intel.com>
	<20160210125139.GB14937@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34349 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbcBJP4M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2016 10:56:12 -0500
Received: by mail-yk0-f179.google.com with SMTP id u9so9277805ykd.1
        for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2016 07:56:11 -0800 (PST)
In-Reply-To: <20160210125139.GB14937@odux.rfo.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>

On 10 February 2016 at 13:51, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Hi Adrian,
>
> On Wed, Feb 10, 2016 at 01:50:44PM +0200, Adrian Hunter wrote:
>> On 10/02/16 11:58, Ludovic Desroches wrote:
>> > By putting the device in suspend at the end of the probe, it is
>> > impossible to wake up on non software event such as card
>> > insertion/removal.
>> >
>> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> > ---
>> >
>> > Hi,
>> >
>> > Since I had no feedback on this topic:
>> > http://permalink.gmane.org/gmane.linux.kernel.mmc/35160
>> >
>> > I would like to no more put the device in suspend at the end of the probe. If
>> > my device is suspended at the end of the probe, I have no issue to resume on
>> > a software event such as mounting my sdcard but hardware event such as card
>> > insertion and removal do not trigger a resume.
>>
>> You can't use runtime PM unless you have a way to wake-up.
>>
>
> Thanks for your feedback. I am a bit disappointed since Ulf advised me to use
> runtime PM instead of system PM.

Sorry about that, but of course I can't know exactly how your hardware work.

>
>> Currently, sdhci disables card detect interrupts when runtime suspended,
>> and drivers use a card-detect GPIO to wake-up.
>>
>
> It is what I have seen going through the sdhci layer. So next question is:
> is it normal to not take care of card detect interrupts? We keep enabled
> some IRQs probably for SDIO modules IRQ but not for card detection. I
> don't understand the reason.

If SDIO IRQ is enabled the mmc controller needs to stay runtime
resumed (as it's the mmc controller that monitors the IRQ), unless you
can re-configure the SDIO IRQ as a wakeup. For example by re-routing
it to a GPIO irq.
Whether this wakeup configuration can stay the same between system PM
and runtime PM is SoC dependent.

Regarding card detects in runtime PM:

If you have an option to use GPIO IRQs or it's possible to configure
the card detect IRQ as a wakeup in any other way, runtime PM works
fine.

Now, when the card detect *can't* be configured as a wakeup in runtime
suspend mode, there are two options.

1) Rely on using MMC_CAP_NEEDS_POLL.
2) Prevent runtime PM.

Which option that's preferred is SoC/ mmc controller dependent.
Although but please consider below recommendations.

- In some cases using polling works really well, as the the mmc core
get fast/easy information about whether a card is inserted or not, via
the ->get_cd() host ops.

- In some cases ->get_cd() is broken (or not implemented) and always
returns a value indicating a card is inserted. That means external
regulators for the card must be enabled and a card initialization
sequence needs to be executed to find out whether a card was *really*
inserted.

So to conclude, if the controller supports card detection but without
wakeup support and the polling mode sucks, then it probably better to
prevent runtime PM. Otherwise polling is probably better.

Regarding card detect in system PM:
If the SoC supports card detect IRQs being configured as wakeup, it's
recommended to do that!

If it can't support wakeup, no worries! The mmc core will run a check
for card insert/removal after a system PM resume sequence is
completed.

>
>>
>> >
>> > It seems there are only two sdhci drivers using runtime pm so maybe nobody has
>> > noticed this issue.

In more general, I wouldn't be surprised if the PM related code in
sdhci is fragile/broken for some SoC/sdhci variants. Although, it's
just an impression I get by studying the code.

>> >
>> > Regards
>> >
>> > Ludovic
>> >
>> >  drivers/mmc/host/sdhci-of-at91.c | 2 --
>> >  1 file changed, 2 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>> > index 9cb86fb..ae24dea 100644
>> > --- a/drivers/mmc/host/sdhci-of-at91.c
>> > +++ b/drivers/mmc/host/sdhci-of-at91.c
>> > @@ -210,8 +210,6 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>> >     if (ret)
>> >             goto pm_runtime_disable;
>> >
>> > -   pm_runtime_put_autosuspend(&pdev->dev);
>> > -

1) Before doing this consider the option to use polling. (MMC_CAP_NEEDS_POLL).

2) The driver may also handle non-removable cards (depending on the
SoC configuration). In those cases it's perfectly okay to use runtime
PM. So, I think you need some conditional check before deciding to
prevent runtime PM. And don't forget to restore the usage count in
->remove().

>> >     return 0;
>> >
>> >  pm_runtime_disable:
>> >
>>

Kind regards
Uffe
