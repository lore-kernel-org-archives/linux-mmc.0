From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [Linux-kernel] [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I
 mode support
Date: Mon, 11 May 2015 10:54:43 +0200
Message-ID: <CAPDyKFq6pGmk5eiSLqEkVnQ1b5FVyVyXNfOmkFAm-x40v5jWZg@mail.gmail.com>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	<1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
	<CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
	<554880C9.8080201@codethink.co.uk>
	<CAPDyKFpv0BOX0mAvhZx9j5Gnayt__YTiUa8SxvcmsEcuazsg0w@mail.gmail.com>
	<1430876333.4222.43.camel@xylophone.i.decadent.org.uk>
	<CAPDyKFo7WsE2wTLZc0E9ANrZ1amVsL3n71oxCLFG0+QrF0xH_A@mail.gmail.com>
	<1430920143.4222.74.camel@xylophone.i.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430920143.4222.74.camel@xylophone.i.decadent.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 May 2015 at 15:49, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> On Wed, 2015-05-06 at 10:44 +0200, Ulf Hansson wrote:
>> On 6 May 2015 at 03:38, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>> > On Tue, 2015-05-05 at 10:47 +0200, Ulf Hansson wrote:
>> >> On 5 May 2015 at 10:35, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> >> > On 05/05/15 10:56, Ulf Hansson wrote:
>> >> >> On 30 April 2015 at 14:32, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>> >> >>> Implement voltage switch, supporting modes up to SDR-50.
>> >> >>>
>> >> >>> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
>> >> >>>
>> >> >>> This uses two voltage regulators, one external and one on the pfc.
>> >> >>
>> >> >> Why two? If there is a parent child relation ship, that should be
>> >> >> handled through the regulator tree, right!? Please elaborate.
>> >> >
>> >> > The card main power is separate from the IO line voltages.
>> >> >
>> >> > To get to the high-speed, card power is left at 3.3V and the IO
>> >> > voltage is changed to 1.8V.
>> >> >
>> >> > In the systems we have the power gate is separate from the controls
>> >> > for the IO but not integrated into the MMC controller itself.
>> >
>> > In this case, there are *three* regulators:
>> >
>> > 1. External regulator for card power (VDD pin): "vmmc"
>> > 2. External regulator for pull-up voltage for the data pins: "vqmmc"
>>
>> Is this really a regulator and not just about changing a pinctrl setting?
>
> Looking at the Lager board, the pull-up voltage appears to be controlled
> by the external PMIC (DA9063), which is signalled using GPIOs (I don't
> know why, when it's also connected to I2C).

Okay, thus we should have a regulator for it.

>
>> The reason why I wonder, is because there are several other mmc host
>> driver's the use a specific pinctrl state for this.
>>
>> > 3. Internal regulator for input(?) level on the data pins:
>> >    "vqmmc_ref" (I'm open to suggestions of a better name)
>
> This one is implemented in the pinctrl (pfc) block.

I understand this as we should have a specific UHS pinctrl state,
instead of a regulator. Right?

[...]

Kind regards
Uffe
