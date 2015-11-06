From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] mmc: sdhci: potentially bad behavior when using vmmc supply
Date: Fri, 6 Nov 2015 17:42:51 +0100
Message-ID: <CAPDyKFrNNyUrJemgA2OHL35EqpG74_1i9bCqkVkZZZMxNGrHgw@mail.gmail.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446825570-30029-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pierre.samat-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 6 November 2015 at 16:59, Ludovic Desroches
<ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
>
> I would like to have some feedback for these two patches. I have two questions.
>
> 1.
>
> To suppress the warnings telling me I have no vmmc and vqmmc supplies, I have
> added them and discovered that adding a vmmc supply involve only writing 1 in
> the Power Control Register involves enabling the SD Bus Power with a non valid
> value for the SD Bus Voltage. If the host controllers strictly follows the
> specification, it shall not enable SD Bus Power. So enough if it seems useless
> to configure SD Bus Voltage because we have an external regulator, do it.

I can't give you a detailed answer about the sdhci HW as I only have
limited knowledge.

What I can say is that people have been trying to fix all kind of
crazy corner cases by adding quirks and callbacks. This seems like yet
another one.

So, by turning sdhci into a set of library functions you could easier
pick and decide to what suites your particular variant. In this case
it seems like would have relied on using the external regulators to
control voltages, instead of some internal sdhci registers.

>
> By the way, I am curious to understand what is really the SD Bus Voltage. I
> mean talking about bus voltage makes me thinking more about vqmmc than vmmc.
> Is it only bad naming or do I miss something?
>
> From the specification, there is this figure:
>
>                     HOST
> ---------------------------------------------------
> | ------------        3.3V                        |       VDD
> | | Power SW |------------------------------------|----------
> | ------------   |              |                 |
> |       ---------|              |                 |
> |       |                       |                 |
> | --------------     ----------------------       |
> | | Ref. Volt. |-----| Regulator/Selector |       |
> | --------------     ----------------------       |
> |                    3.3V/1.8V  |                 |
> |                               |                 |
> |                               |---------------  |
> |                               |       |  |   |  |
> |                               |       R  R   _  |
> |                               |       |  |   _  |
> |                               |       |  |   |  |
> |                               |       |  |  /// |
> |                            -------    |  |      |       CLK
> |                            |     |----)--)------|----------
> |  -----------------------   |Multi|    |  |      |       CMD
> |  |Random Logic Circuits|---|Drive|----)---------|----------
> |  -----------------------   |I/O  |    |         |       DAT
> |                            |     |--------------|----------
> |                            -------              |
> ---------------------------------------------------
>
> In my mind vmmc is the 3.3V signal and vqmmc is the 3.3V/1.8V signal, so why
> talking about bus voltage?

"IO voltage", "bus voltage", "VQMMC", etc they all mean the same thing
to me. It's the voltage level of the signals going to the card.

>
>
> 2.
>
> Is the regulator-gpio usage the right thing to do for vqmmc? In my case it is
> not really driven by a gpio but by a pio from the sdhci device. In the binding,

What's a "pio"?

What do you mean by the it's driven from the sdhci device?

Is it the internal HW logic of the sdhci controller that manages the
IO voltage? And this logic can be controlled via certain register bits
in the SDHCI controller?

> declaring the gpio is an option so I thought using this regulator fits my need.

In quite many cases it makes sense to model this though a gpio
regulator. For example when you use a level shifter circuit. Those
normally have gpio pin routed to control the voltage level output for
the signals. For example switching between 1.8V and 2.9V.

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
