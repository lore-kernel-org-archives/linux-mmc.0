From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 0/2] mmc: sdhci: potentially bad behavior when using vmmc
 supply
Date: Mon, 9 Nov 2015 08:41:04 +0100
Message-ID: <20151109074104.GB27482@odux.rfo.atmel.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFrNNyUrJemgA2OHL35EqpG74_1i9bCqkVkZZZMxNGrHgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:45666 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbbKIHlb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 02:41:31 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFrNNyUrJemgA2OHL35EqpG74_1i9bCqkVkZZZMxNGrHgw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, pierre.samat@atmel.com

Hi Ulf,

Thanks for your answer.

On Fri, Nov 06, 2015 at 05:42:51PM +0100, Ulf Hansson wrote:
> On 6 November 2015 at 16:59, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > Hi,
> >
> > I would like to have some feedback for these two patches. I have two questions.
> >
> > 1.
> >
> > To suppress the warnings telling me I have no vmmc and vqmmc supplies, I have
> > added them and discovered that adding a vmmc supply involve only writing 1 in
> > the Power Control Register involves enabling the SD Bus Power with a non valid
> > value for the SD Bus Voltage. If the host controllers strictly follows the
> > specification, it shall not enable SD Bus Power. So enough if it seems useless
> > to configure SD Bus Voltage because we have an external regulator, do it.
> 
> I can't give you a detailed answer about the sdhci HW as I only have
> limited knowledge.
> 
> What I can say is that people have been trying to fix all kind of
> crazy corner cases by adding quirks and callbacks. This seems like yet
> another one.
> 

I know your point of view about it and I won't try to add another quirk
:).

IMO, it's not a quirk since it is mention in the specification that
the SD Host Driver shall set the SD Bus Voltage Select.

> So, by turning sdhci into a set of library functions you could easier
> pick and decide to what suites your particular variant. In this case
> it seems like would have relied on using the external regulators to
> control voltages, instead of some internal sdhci registers.
>

Yes, this is it. Even if you are using an extarnal regulator, you still
have to set SD Bus Power because it drives the SDCLK. For that reason you
need to set a valid Bus Voltage.
 
> >
> > By the way, I am curious to understand what is really the SD Bus Voltage. I
> > mean talking about bus voltage makes me thinking more about vqmmc than vmmc.
> > Is it only bad naming or do I miss something?
> >
> > From the specification, there is this figure:
> >
> >                     HOST
> > ---------------------------------------------------
> > | ------------        3.3V                        |       VDD
> > | | Power SW |------------------------------------|----------
> > | ------------   |              |                 |
> > |       ---------|              |                 |
> > |       |                       |                 |
> > | --------------     ----------------------       |
> > | | Ref. Volt. |-----| Regulator/Selector |       |
> > | --------------     ----------------------       |
> > |                    3.3V/1.8V  |                 |
> > |                               |                 |
> > |                               |---------------  |
> > |                               |       |  |   |  |
> > |                               |       R  R   _  |
> > |                               |       |  |   _  |
> > |                               |       |  |   |  |
> > |                               |       |  |  /// |
> > |                            -------    |  |      |       CLK
> > |                            |     |----)--)------|----------
> > |  -----------------------   |Multi|    |  |      |       CMD
> > |  |Random Logic Circuits|---|Drive|----)---------|----------
> > |  -----------------------   |I/O  |    |         |       DAT
> > |                            |     |--------------|----------
> > |                            -------              |
> > ---------------------------------------------------
> >
> > In my mind vmmc is the 3.3V signal and vqmmc is the 3.3V/1.8V signal, so why
> > talking about bus voltage?
> 
> "IO voltage", "bus voltage", "VQMMC", etc they all mean the same thing
> to me. It's the voltage level of the signals going to the card.
> 

I agree, I share your understanding so. I am disappointed about managing
VMMC instead of VQMMC in a function which should deal with the Bus
Voltage value.

> >
> >
> > 2.
> >
> > Is the regulator-gpio usage the right thing to do for vqmmc? In my case it is
> > not really driven by a gpio but by a pio from the sdhci device. In the binding,
> 
> What's a "pio"?
> 
> What do you mean by the it's driven from the sdhci device?
> 

Sorry I mean sdhci device from the SoC point of view, I should say
controller. So yes the signal is driven by the controller. 

> Is it the internal HW logic of the sdhci controller that manages the
> IO voltage? And this logic can be controlled via certain register bits
> in the SDHCI controller?
> 

Yes, it depends of the value of the '1.8V Signaling Enable' value in the
host control 2 register.

> > declaring the gpio is an option so I thought using this regulator fits my need.
> 
> In quite many cases it makes sense to model this though a gpio
> regulator. For example when you use a level shifter circuit. Those
> normally have gpio pin routed to control the voltage level output for
> the signals. For example switching between 1.8V and 2.9V.
> 

I agree, my concern is to know if I can consider it as a 'general' pio
since it is driven by the sdhci controller.


Regards

Ludovic
