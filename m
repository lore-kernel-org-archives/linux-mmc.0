From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Linux-kernel] [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I
 mode support
Date: Wed, 06 May 2015 02:38:53 +0100
Message-ID: <1430876333.4222.43.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397136.5802.44.camel@xylophone.i.decadent.org.uk>
	 <CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
	 <554880C9.8080201@codethink.co.uk>
	 <CAPDyKFpv0BOX0mAvhZx9j5Gnayt__YTiUa8SxvcmsEcuazsg0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpv0BOX0mAvhZx9j5Gnayt__YTiUa8SxvcmsEcuazsg0w@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2015-05-05 at 10:47 +0200, Ulf Hansson wrote:
> On 5 May 2015 at 10:35, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > On 05/05/15 10:56, Ulf Hansson wrote:
> >> On 30 April 2015 at 14:32, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> >>> Implement voltage switch, supporting modes up to SDR-50.
> >>>
> >>> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
> >>>
> >>> This uses two voltage regulators, one external and one on the pfc.
> >>
> >> Why two? If there is a parent child relation ship, that should be
> >> handled through the regulator tree, right!? Please elaborate.
> >
> > The card main power is separate from the IO line voltages.
> >
> > To get to the high-speed, card power is left at 3.3V and the IO
> > voltage is changed to 1.8V.
> >
> > In the systems we have the power gate is separate from the controls
> > for the IO but not integrated into the MMC controller itself.

In this case, there are *three* regulators:

1. External regulator for card power (VDD pin): "vmmc"
2. External regulator for pull-up voltage for the data pins: "vqmmc"
3. Internal regulator for input(?) level on the data pins:
   "vqmmc_ref" (I'm open to suggestions of a better name)

> Okay, that's what I was expecting and hoping for :-)
> 
> Then you need to rework $subject patch according to below.
> 
> 1) Use mmc_regulator_get_supply() to fetch both the I/O voltage
> regulator (vqmmc) and the main power regulator (vmmc).

We already do that.

> Your "vqmmc_ref" regulator should thus be renamed to "vmmc".

No, we have one of those already.

> 2) The vmmc regulator should not be handled from the
> ->start_signal_voltage_switch() callback, since it's only vqmmc
> voltage levels that should be changed from there.

It isn't.

> 3) The voltage levels changes for vmmc shall be handled via the
> ->set_ios() callback.

We don't support UHS-II so we never change the voltage of this
regulator.

Ben.

> I suggest you go and have a look in drivers/mmc/host/mmci.c, that
> should provide you with a good inspiration.
> 
> Kind regards
> Uffe


