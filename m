From: Simon Horman <horms@verge.net.au>
Subject: Re: [v2,9/9] ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50
Date: Wed, 6 Apr 2016 16:13:44 +0900
Message-ID: <20160406071344.GB1606@verge.net.au>
References: <1459525479-20842-10-git-send-email-wsa@the-dreams.de>
 <20160406005616.GA7135@verge.net.au>
 <CAMuHMdX8CYgdOPodapDppNq5LPdorgmf9sJvaZ9GkNJGxKxZwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58237 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbcDFHNt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2016 03:13:49 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdX8CYgdOPodapDppNq5LPdorgmf9sJvaZ9GkNJGxKxZwQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>

On Wed, Apr 06, 2016 at 08:38:02AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Apr 6, 2016 at 2:56 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Apr 01, 2016 at 05:44:39PM +0200, Wolfram Sang wrote:
> >> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >>
> >> Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.
> >
> > For some reason which I am entirely unsure of git didn't apply this cleanly
> > so I did so manually. Please double check that the following is correct.
> >
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Subject: [PATCH] ARM: shmobile: r8a7790: lager: Enable UHS-I SDR-50
> >
> > Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.
> >
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm/boot/dts/r8a7790-lager.dts | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> > index aa6ca92a9485..75fc8d1cb7e3 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -346,11 +346,25 @@
> >         sdhi0_pins: sd0 {
> >                 renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
> >                 renesas,function = "sdhi0";
> 
> How come you still have "renesas,*" pinctrl properties?
> Applied to wrong branch?

Yes, its  branch thing. This is applied to the dt-for-v4.7 branch.
The cleanup is in the cleanup-for-v4.7 branch. I didn't realise that
until after my previous post.

> > +               power-source = <3300>;
> > +       };
> > +
> > +       sdhi0_pins_uhs: sd0_uhs {
> > +               groups = "sdhi0_data4", "sdhi0_ctrl";
> > +               function = "sdhi0";
> 
> Pinctrl properties with and without prefixes must not be combined in a single
> preprocessed DTS (and in the overlays).

Thanks! I will re-arrange by branches accordingly.
