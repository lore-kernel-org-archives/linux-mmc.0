From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/3] ARM: dts: iwg20m: Add MMCIF0 support
Date: Thu, 13 Jul 2017 10:02:29 +0200
Message-ID: <20170713080228.GI5580@verge.net.au>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com>
 <1499853805-5915-4-git-send-email-chris.paterson2@renesas.com>
 <CAMuHMdXMFkXopGiLOVf0jDDQTKig-wFrgMOKrf14341h85kPNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49073 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdGMICd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2017 04:02:33 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdXMFkXopGiLOVf0jDDQTKig-wFrgMOKrf14341h85kPNw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Chris Paterson <chris.paterson2@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Biju Das <biju.das@bp.renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 12, 2017 at 01:52:49PM +0200, Geert Uytterhoeven wrote:
> Hi Chris,
> 
> On Wed, Jul 12, 2017 at 12:03 PM, Chris Paterson
> <chris.paterson2@renesas.com> wrote:
> > Define the iwg20m board dependent part of the MMCIF0 device node.
> >
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> >
> > diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > index 001ca91..ffce1b6 100644
> > --- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> > +++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
> 
> > +&pfc {
> > +       mmcif0_pins: mmc {
> > +               groups = "mmc_data8", "mmc_ctrl";
> 
> "mmc_data8" is not correct, as D6/D7 of the eMMC are not connected to GP6_28
> resp. GP6_29, but to GP6_6 resp. GP6_7.
> So it should be "mmc_data8_b".
> 
> Unfortunately the latter pin group isn't supported by the PFC driver yet.
> Cooking a patch...

The above notwithstanding I have applied this patch for v4.14.

This is under the assumption that:
a) the relevant (pfc) driver changes will appear in v4.14 and;
b) there is no regression introduced in having this change present
   without the driver changes

An implication of the above is that the new feature will not work
until both the driver and DTS changes are in the same tree. But that the
trees with each of those changes continue to work at least as well as they
did before.

Please test the devel branch that I push later today to make sure there
are no regressions.
