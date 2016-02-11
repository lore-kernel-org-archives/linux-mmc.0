From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [RFC PATCH] mmc: sdhci-of-at91: don't put device in suspend
 after probe
Date: Thu, 11 Feb 2016 12:05:53 +0100
Message-ID: <20160211110553.GH14937@odux.rfo.atmel.com>
References: <1455098283-14500-1-git-send-email-ludovic.desroches@atmel.com>
 <56BB2414.1040606@intel.com>
 <20160210125139.GB14937@odux.rfo.atmel.com>
 <CAPDyKFp-N6yEtc=U9rCuR9QxijPU8+xK1xE5qJeoERx+K8NkSw@mail.gmail.com>
 <20160211090856.GG14937@odux.rfo.atmel.com>
 <CAPDyKFqCKFm_8XSWwQNy7WEjx8-Xhr4JFVCmpA87tOtqFD-r3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqCKFm_8XSWwQNy7WEjx8-Xhr4JFVCmpA87tOtqFD-r3A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 11, 2016 at 10:46:08AM +0100, Ulf Hansson wrote:
> [...]
>=20
> >> >
> >> >> Currently, sdhci disables card detect interrupts when runtime s=
uspended,
> >> >> and drivers use a card-detect GPIO to wake-up.
> >> >>
> >> >
> >> > It is what I have seen going through the sdhci layer. So next qu=
estion is:
> >> > is it normal to not take care of card detect interrupts? We keep=
 enabled
> >> > some IRQs probably for SDIO modules IRQ but not for card detecti=
on. I
> >> > don't understand the reason.
> >>
> >> If SDIO IRQ is enabled the mmc controller needs to stay runtime
> >> resumed (as it's the mmc controller that monitors the IRQ), unless=
 you
> >> can re-configure the SDIO IRQ as a wakeup. For example by re-routi=
ng
> >> it to a GPIO irq.
> >> Whether this wakeup configuration can stay the same between system=
 PM
> >> and runtime PM is SoC dependent.
> >
> > I don't know if we are talking about the same thing. In
> > sdhci_runtime_suspend_host(), we set SDHCI_INT_CARD_INT as a kind o=
f
> > wakeup irq before considering the host as suspended
> > (host->runtime_suspended =3D true), isn't it?
>=20
> No, you have got this wrong. The card detect IRQ is disabled at
> sdhci_runtime_suspend_host().
>=20

Ok for card detect. For my knowledge, what is the purpose of enabling
SHDCI_INT_CARD_INT?

> It's not related to SDIO irq, as in that case the controller can't be
> runtime suspended (unless wakeup is supported).
>=20
> >
> > Why not adding SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE?
> >
> > In my case, it allows me to use runtime PM to disable two clocks an=
d
> > keep one enabled (I need this one to get the irq) when suspending t=
he device.
>=20
> That seems like a very special case and normally not how runtime PM i=
s used.
>=20
> So, if you only want to disable|enable some clocks from runtime PM, I
> suggest you keep that out of the library function
> sdhci_runtime_suspend_host() and deal with that in your driver
> instead.
>=20
> >
> >>
> >> Regarding card detects in runtime PM:
> >>
> >> If you have an option to use GPIO IRQs or it's possible to configu=
re
> >> the card detect IRQ as a wakeup in any other way, runtime PM works
> >> fine.
> >>
> >
> > It will depend of the customer but I am not sure I'll want to use a=
 pio
> > as a gpio for this if there is a pio routed to the sdhci controller=
=2E
>=20
> That all has to do with how the SoC is designed from power management
> point of view.
>=20

I don't agree this point. We have connected the card detect to the cont=
roller=20
on our Xplained board but someone can do another board and use a gpio.

So depending on the board we should use runtime PM or not. As you
suggested, I have to find a clever way to know when I can use runtime P=
M
or not: non removable device, gpio cd, etc.

> In general, it's a good idea to have card detect on GPIO, as it allow=
s
> to put other unused parts of the silicon into a low power state.
>=20
> >
> >> Now, when the card detect *can't* be configured as a wakeup in run=
time
> >> suspend mode, there are two options.
> >>
> >> 1) Rely on using MMC_CAP_NEEDS_POLL.
> >> 2) Prevent runtime PM.
> >>
> >> Which option that's preferred is SoC/ mmc controller dependent.
> >> Although but please consider below recommendations.
> >>
> >> - In some cases using polling works really well, as the the mmc co=
re
> >> get fast/easy information about whether a card is inserted or not,=
 via
> >> the ->get_cd() host ops.
> >>
> >> - In some cases ->get_cd() is broken (or not implemented) and alwa=
ys
> >> returns a value indicating a card is inserted. That means external
> >> regulators for the card must be enabled and a card initialization
> >> sequence needs to be executed to find out whether a card was *real=
ly*
> >> inserted.
> >>
> >> So to conclude, if the controller supports card detection but with=
out
> >> wakeup support and the polling mode sucks, then it probably better=
 to
> >> prevent runtime PM. Otherwise polling is probably better.
> >>
> >
> > It is weird to claim that I need polling since I have a working car=
d
> > detect.
>=20
> It's not, if you really care about saving power.
>=20
> Although, as I stated, which solution that's best, depends on the SoC=
=2E
>=20
> [...]
>=20
> So, we have a regression to fix here. I can propose a patch adopting
> the above recommendations!?
>=20
> That's solution doesn=E2=80=99t have to stay long term, as you can tr=
y to
> optimize it later on to what suits your SoC the best.

Ok I'll have a try with MMC_CAP_NEEDS_POLL and after the investigation
about the sdio module I'll try to propose something better.

Regards

Ludovic
