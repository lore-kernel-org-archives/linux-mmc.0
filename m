From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias
 configuration in dt
Date: Thu, 13 Jun 2013 17:29:28 +0200
Message-ID: <CACRpkdY6cZ+bT-C9Go3sZVw6ErQqTm0m9__uKQrkg4eUU1thHA@mail.gmail.com>
References: <20130523184045.GD13507@atomide.com>
	<1370546059-24181-1-git-send-email-balajitk@ti.com>
	<1370546059-24181-7-git-send-email-balajitk@ti.com>
	<CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com>
	<20130613095353.GX8164@atomide.com>
	<51B9DA30.1090308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44400 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782Ab3FMP33 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jun 2013 11:29:29 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so12305625ieb.16
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jun 2013 08:29:28 -0700 (PDT)
In-Reply-To: <51B9DA30.1090308@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Thu, Jun 13, 2013 at 4:41 PM, Balaji T K <balajitk@ti.com> wrote:

>[Me]
>>> This seem so intuitively wrong as it can possibly get, clearly this
>>> is regulator territory.
>
> It is not really a regulator, CONTROL_PBIAS_LITE is just a register
> in control module which configures pad/pin on SOC. In this case PBIAS cells
> are powered down before any voltage changes and after the external voltage
> supplied to VDDS_MMC of OMAP stabilizes pbias cells  is powered ON again
> with specific Voltage which is given to OMAP for MMC io pins

So there is some external actual regulator supplying the voltage
and then that is looped back in to the pads. (I understand this is
quite a common construction.)

Anyway since it is obviously removing and applying voltage to
the pins, I think this is more of a cascaded regulator.
We use regulators for simple light-switches and things you know.

We have generic pinconf options for things like current but not
voltage really. It's because in the case of pin current configuration
it's basically about how many driver stages (totempoles) you connect
to the output, which is very different from the voltages we're dealing
with here.

So I think these bits go into a regulator driver:

> BIT26 MMC1_PWRDNZ PWRDNZ control to MMC1 IO
> This bit is used to protect the MMC1 I/O cell when
> SDMMC1_VDDS is not stable.
> 0x0: Software must clear this bit when SDMMC1_VDDS
> changes.
> 0x1: Software must set this bit only when
> SDMMC1_VDDS is stable.
>
> BIT24 MMC1_PBIASLITE_SUPPLY_HI SUPPLY_HI_OUT from MMC1 PBIASLITE
> _OUT Read 0x0: SDMMC1_VDDS = 1.8V
> Read 0x1: SDMMC1_VDDS = 3V
>
> BIT23 MMC1_PBIASLITE_VMODE_ER VMODE ERROR from MMC1 PBIASLITE
> ROR Read 0x0: VMODE level is same as SUPPLY_HI_OUT
> Read 0x1: VMODE level is not same as
> SUPPLY_HI_OUT
>
> BIT22 MMC1_PBIASLITE_PWRDNZ PWRDNZ control to MMC1 PBIASLITE
> This bit is used to protect the MMC1_PBIAS cell (MMC1
> I/O cell associated) when SDMMC1_VDDS is not stable.
> 0x0: Software must clear this bit when SDMMC1_VDDS
> changes.
> 0x1: Software must set this bit only when
> SDMMC1_VDDS is stable.
>
> BIT21 MMC1_PBIASLITE_VMODE VMODE control to MMC1 PBIASLITE
> 0x0: SDMMC1_VDDS = 1.8V
> 0x1: SDMMC1_VDDS = 3V

This looks much more cascaded regulator control than
anything else to me.

> For OMAP2430, OMAP3430 It additionally has a bit for speed mode control
> which are set always (static config)

I guess you mean this:

> BIT2 PBIASSPEEDCTRL0 Speed Control for MMC I/O
> 0b0 => 26 MHz I/O max speed
> 0b1 => 52 MHz I/O max speed

This seems to belong to the MMC host driver.

It is common that registers contain indiviual bits that end up in
different subsystems. Speed mode seems to belong in the MMC
driver.

The infrastructure used to spread out responsibility across different
drivers from a common register range or even for certain bits in a
certain register, is regmap. Check for example mfd/syscon.c.

> BIT25 MMC1_PBIASLITE_HIZ_MODE HIZ_MODE from MMC1 PBIASLITE
> 0x0: PBIAS in normal operation mode
> 0x1: PBIAS output is in high impedence state

This is actually pin config. But if it makes sense it should also be
part of the MMC regulator driver.

> You mean regulator via pinctrl APIs, I think It will just move the code
> from omap_hsmmc to a new regulator file with it own init data for pinctrl.

No I'm not saying you should use pinctrl as a "back-end" for this.
I mean you shall instantiate a regulator and let the callback ops
vtable for that regulator poke these bits.

> Not sure if Regulator maintainer will agree to it.

I will respect Marks judgement on this for sure.

> Moreover what I needs is three different states 0V, 0 to 1.8V, 3 V to 3.3V
> not 0, 1.8V, 3V. plus pbias register fields got moved around between omap3,
> omap4
> and omap5, That was one of the reason for moving to pinctrl states.

The regulator framework supports selector tables just
like this.

Where the register fields are located does not matter.

>>> That the bits are
>>> in the middle of pinctrl things does not really matter.
>
> It thought pinctrl-single,bits in pinctrl-single.c is introduced
> precisely for such misc control register which has bit configuration
> affecting different module i/o pads.

No. If we go down that road *anything* that is connected to a
pad becomes part of the pinctrl subsystem, then pinctrl-single
becomes some kind of hardware abstraction or BIOS, and that
is *not* the intent. It is only supposed to deal with the bits
there that are 100% related to what pinctrl does, nothing else.

Yours,
Linus Walleij
