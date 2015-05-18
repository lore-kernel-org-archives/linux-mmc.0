From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH 5/6] ARM: shmobile: lager: Set sdhi and mmcif clock rates
Date: Mon, 18 May 2015 20:48:44 +0100
Message-ID: <1431978524.22824.6.camel@codethink.co.uk>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
	 <1431822574.4222.172.camel@xylophone.i.decadent.org.uk>
	 <CAMuHMdWN1EPdq+TAdtZ5wW+G2r5he55SnjYEsHDg6T3-=n6r=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWN1EPdq+TAdtZ5wW+G2r5he55SnjYEsHDg6T3-=n6r=g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On Sun, 2015-05-17 at 10:13 +0200, Geert Uytterhoeven wrote:
> On Sun, May 17, 2015 at 2:29 AM, Ben Hutchings
> <ben.hutchings@codethink.co.uk> wrote:
> > From: Ben Dooks <ben.dooks@codethink.co.uk>
> >
> > [bwh: Fold in fix from Ian Molton]
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > ---
> >  arch/arm/boot/dts/r8a7790-lager.dts |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> > index aaa4f258e279..343ec0ccc8df 100644
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -413,6 +413,11 @@
> >         vmmc-supply = <&fixedregulator3v3>;
> >         bus-width = <8>;
> >         non-removable;
> > +
> > +       assigned-clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
> > +       assigned-clock-rates = <97500000>;
> > +       max-frequency = <50000000>;
> 
> Are all these properties Lager-specific, or r8a7790-specific?
> If the latter, they belong in r8a7790.dtsi.
> Same comment for the other nodes.

The clock assignments are not specific to Lager so they probably belong
in r8a7790.dtsi; the dividers are configurable and could be
board-specific.

The board design could conceivably limit the usable frequency to below
the chip's maximum, though presumably that won't usually happen.
Currently the clk-rcar-gen2 driver only configures the dividers for
sdhi{0,1}.  That leaves the rest of them effectively controlled by the
board's firmware.

Ben.


