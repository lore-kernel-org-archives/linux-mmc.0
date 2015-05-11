From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Linux-kernel] [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I
 mode support
Date: Mon, 11 May 2015 15:01:01 +0100
Message-ID: <1431352861.4222.101.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
	 <CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
	 <554880C9.8080201@codethink.co.uk>
	 <CAPDyKFpv0BOX0mAvhZx9j5Gnayt__YTiUa8SxvcmsEcuazsg0w@mail.gmail.com>
	 <1430876333.4222.43.camel@xylophone.i.decadent.org.uk>
	 <CAPDyKFo7WsE2wTLZc0E9ANrZ1amVsL3n71oxCLFG0+QrF0xH_A@mail.gmail.com>
	 <1430920143.4222.74.camel@xylophone.i.decadent.org.uk>
	 <CAPDyKFq6pGmk5eiSLqEkVnQ1b5FVyVyXNfOmkFAm-x40v5jWZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq6pGmk5eiSLqEkVnQ1b5FVyVyXNfOmkFAm-x40v5jWZg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2015-05-11 at 10:54 +0200, Ulf Hansson wrote:
> On 6 May 2015 at 15:49, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> > On Wed, 2015-05-06 at 10:44 +0200, Ulf Hansson wrote:
> >> On 6 May 2015 at 03:38, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> >> > On Tue, 2015-05-05 at 10:47 +0200, Ulf Hansson wrote:
> >> >> On 5 May 2015 at 10:35, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >> >> > On 05/05/15 10:56, Ulf Hansson wrote:
> >> >> >> On 30 April 2015 at 14:32, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> >> >> >>> Implement voltage switch, supporting modes up to SDR-50.
> >> >> >>>
> >> >> >>> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
> >> >> >>>
> >> >> >>> This uses two voltage regulators, one external and one on the pfc.
> >> >> >>
> >> >> >> Why two? If there is a parent child relation ship, that should be
> >> >> >> handled through the regulator tree, right!? Please elaborate.
> >> >> >
> >> >> > The card main power is separate from the IO line voltages.
> >> >> >
> >> >> > To get to the high-speed, card power is left at 3.3V and the IO
> >> >> > voltage is changed to 1.8V.
> >> >> >
> >> >> > In the systems we have the power gate is separate from the controls
> >> >> > for the IO but not integrated into the MMC controller itself.
> >> >
> >> > In this case, there are *three* regulators:
> >> >
> >> > 1. External regulator for card power (VDD pin): "vmmc"
> >> > 2. External regulator for pull-up voltage for the data pins: "vqmmc"
> >>
> >> Is this really a regulator and not just about changing a pinctrl setting?
> >
> > Looking at the Lager board, the pull-up voltage appears to be controlled
> > by the external PMIC (DA9063), which is signalled using GPIOs (I don't
> > know why, when it's also connected to I2C).
> 
> Okay, thus we should have a regulator for it.
> 
> >
> >> The reason why I wonder, is because there are several other mmc host
> >> driver's the use a specific pinctrl state for this.
> >>
> >> > 3. Internal regulator for input(?) level on the data pins:
> >> >    "vqmmc_ref" (I'm open to suggestions of a better name)
> >
> > This one is implemented in the pinctrl (pfc) block.
> 
> I understand this as we should have a specific UHS pinctrl state,
> instead of a regulator. Right?

That was another option I considered, but I didn't see anything in the
pinctrl API that would allow changing the pin configuration dynamically.
(And sh_mobile_sdhi doesn't explicitly do anything with pinctrl at the
moment.)

Now that you mention pinctrl states, I can see that might be a good way
to handle this.  Since the states are identified by strings, does that
mean it's OK to add a driver-specific state such as "sh-pfc-1.8v" and
not add it to the common pinctrl headers?

Ben.


