From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] mmc: sdhci-of-at91: don't put device in suspend after probe
Date: Thu, 11 Feb 2016 10:46:08 +0100
Message-ID: <CAPDyKFqCKFm_8XSWwQNy7WEjx8-Xhr4JFVCmpA87tOtqFD-r3A@mail.gmail.com>
References: <1455098283-14500-1-git-send-email-ludovic.desroches@atmel.com>
	<56BB2414.1040606@intel.com>
	<20160210125139.GB14937@odux.rfo.atmel.com>
	<CAPDyKFp-N6yEtc=U9rCuR9QxijPU8+xK1xE5qJeoERx+K8NkSw@mail.gmail.com>
	<20160211090856.GG14937@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34404 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbcBKJqJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2016 04:46:09 -0500
Received: by mail-yw0-f179.google.com with SMTP id h129so35070241ywb.1
        for <linux-mmc@vger.kernel.org>; Thu, 11 Feb 2016 01:46:08 -0800 (PST)
In-Reply-To: <20160211090856.GG14937@odux.rfo.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>

[...]

>> >
>> >> Currently, sdhci disables card detect interrupts when runtime sus=
pended,
>> >> and drivers use a card-detect GPIO to wake-up.
>> >>
>> >
>> > It is what I have seen going through the sdhci layer. So next ques=
tion is:
>> > is it normal to not take care of card detect interrupts? We keep e=
nabled
>> > some IRQs probably for SDIO modules IRQ but not for card detection=
=2E I
>> > don't understand the reason.
>>
>> If SDIO IRQ is enabled the mmc controller needs to stay runtime
>> resumed (as it's the mmc controller that monitors the IRQ), unless y=
ou
>> can re-configure the SDIO IRQ as a wakeup. For example by re-routing
>> it to a GPIO irq.
>> Whether this wakeup configuration can stay the same between system P=
M
>> and runtime PM is SoC dependent.
>
> I don't know if we are talking about the same thing. In
> sdhci_runtime_suspend_host(), we set SDHCI_INT_CARD_INT as a kind of
> wakeup irq before considering the host as suspended
> (host->runtime_suspended =3D true), isn't it?

No, you have got this wrong. The card detect IRQ is disabled at
sdhci_runtime_suspend_host().

It's not related to SDIO irq, as in that case the controller can't be
runtime suspended (unless wakeup is supported).

>
> Why not adding SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE?
>
> In my case, it allows me to use runtime PM to disable two clocks and
> keep one enabled (I need this one to get the irq) when suspending the=
 device.

That seems like a very special case and normally not how runtime PM is =
used.

So, if you only want to disable|enable some clocks from runtime PM, I
suggest you keep that out of the library function
sdhci_runtime_suspend_host() and deal with that in your driver
instead.

>
>>
>> Regarding card detects in runtime PM:
>>
>> If you have an option to use GPIO IRQs or it's possible to configure
>> the card detect IRQ as a wakeup in any other way, runtime PM works
>> fine.
>>
>
> It will depend of the customer but I am not sure I'll want to use a p=
io
> as a gpio for this if there is a pio routed to the sdhci controller.

That all has to do with how the SoC is designed from power management
point of view.

In general, it's a good idea to have card detect on GPIO, as it allows
to put other unused parts of the silicon into a low power state.

>
>> Now, when the card detect *can't* be configured as a wakeup in runti=
me
>> suspend mode, there are two options.
>>
>> 1) Rely on using MMC_CAP_NEEDS_POLL.
>> 2) Prevent runtime PM.
>>
>> Which option that's preferred is SoC/ mmc controller dependent.
>> Although but please consider below recommendations.
>>
>> - In some cases using polling works really well, as the the mmc core
>> get fast/easy information about whether a card is inserted or not, v=
ia
>> the ->get_cd() host ops.
>>
>> - In some cases ->get_cd() is broken (or not implemented) and always
>> returns a value indicating a card is inserted. That means external
>> regulators for the card must be enabled and a card initialization
>> sequence needs to be executed to find out whether a card was *really=
*
>> inserted.
>>
>> So to conclude, if the controller supports card detection but withou=
t
>> wakeup support and the polling mode sucks, then it probably better t=
o
>> prevent runtime PM. Otherwise polling is probably better.
>>
>
> It is weird to claim that I need polling since I have a working card
> detect.

It's not, if you really care about saving power.

Although, as I stated, which solution that's best, depends on the SoC.

[...]

So, we have a regression to fix here. I can propose a patch adopting
the above recommendations!?

That's solution doesn=E2=80=99t have to stay long term, as you can try =
to
optimize it later on to what suits your SoC the best.

Kind regards
Uffe
