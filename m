From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Linux-kernel] [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I
 mode support
Date: Wed, 06 May 2015 14:49:03 +0100
Message-ID: <1430920143.4222.74.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
	 <CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
	 <554880C9.8080201@codethink.co.uk>
	 <CAPDyKFpv0BOX0mAvhZx9j5Gnayt__YTiUa8SxvcmsEcuazsg0w@mail.gmail.com>
	 <1430876333.4222.43.camel@xylophone.i.decadent.org.uk>
	 <CAPDyKFo7WsE2wTLZc0E9ANrZ1amVsL3n71oxCLFG0+QrF0xH_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:56457 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbEFNtJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2015 09:49:09 -0400
In-Reply-To: <CAPDyKFo7WsE2wTLZc0E9ANrZ1amVsL3n71oxCLFG0+QrF0xH_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, 2015-05-06 at 10:44 +0200, Ulf Hansson wrote:
> On 6 May 2015 at 03:38, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> > On Tue, 2015-05-05 at 10:47 +0200, Ulf Hansson wrote:
> >> On 5 May 2015 at 10:35, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> >> > On 05/05/15 10:56, Ulf Hansson wrote:
> >> >> On 30 April 2015 at 14:32, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> >> >>> Implement voltage switch, supporting modes up to SDR-50.
> >> >>>
> >> >>> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
> >> >>>
> >> >>> This uses two voltage regulators, one external and one on the pfc.
> >> >>
> >> >> Why two? If there is a parent child relation ship, that should be
> >> >> handled through the regulator tree, right!? Please elaborate.
> >> >
> >> > The card main power is separate from the IO line voltages.
> >> >
> >> > To get to the high-speed, card power is left at 3.3V and the IO
> >> > voltage is changed to 1.8V.
> >> >
> >> > In the systems we have the power gate is separate from the controls
> >> > for the IO but not integrated into the MMC controller itself.
> >
> > In this case, there are *three* regulators:
> >
> > 1. External regulator for card power (VDD pin): "vmmc"
> > 2. External regulator for pull-up voltage for the data pins: "vqmmc"
> 
> Is this really a regulator and not just about changing a pinctrl setting?

Looking at the Lager board, the pull-up voltage appears to be controlled
by the external PMIC (DA9063), which is signalled using GPIOs (I don't
know why, when it's also connected to I2C).

> The reason why I wonder, is because there are several other mmc host
> driver's the use a specific pinctrl state for this.
> 
> > 3. Internal regulator for input(?) level on the data pins:
> >    "vqmmc_ref" (I'm open to suggestions of a better name)

This one is implemented in the pinctrl (pfc) block.

[...]
> >> 3) The voltage levels changes for vmmc shall be handled via the
> >> ->set_ios() callback.
> >
> > We don't support UHS-II so we never change the voltage of this
> > regulator.
> 
> That's not related to UHS-II. Voltage level negotiation for vmmc is
> done even for legacy mode cards.

I'm looking at "SD Specifications, Part 1, Physical Layer Simplified
Specifications, Version 4.10" and it seems clear from that, that only
UHS-II cards have a variable supply voltage.  Maybe that changed in a
later version?  Anyway, I don't have any board that can change the
supply voltage.

Ben.


