From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] arm64: dts: r8a77995: draak: enable SDHI2
Date: Fri, 17 Nov 2017 06:35:08 -0800
Message-ID: <20171117143507.yovg64u2znjwj4wh@verge.net.au>
References: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510759549-30404-4-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdXFMsvjMcbmBLCBL9+Ow1=cqQeosEd3hUygjhT_Z=L49w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXFMsvjMcbmBLCBL9+Ow1=cqQeosEd3hUygjhT_Z=L49w@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 16, 2017 at 10:43:35AM +0100, Geert Uytterhoeven wrote:
> Hi Uli,
> 
> On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > The single SDHI controller is connected to eMMC.
> >
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > @@ -32,6 +32,24 @@
> >                 /* first 128MB is reserved for secure area. */
> >                 reg = <0x0 0x48000000 0x0 0x18000000>;
> >         };
> > +
> > +       reg_1p8v: regulator0 {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "fixed-1.8V";
> > +               regulator-min-microvolt = <1800000>;
> > +               regulator-max-microvolt = <1800000>;
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +       };
> > +
> > +       reg_3p3v: regulator1 {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "fixed-3.3V";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               regulator-boot-on;
> > +               regulator-always-on;
> > +       };
> 
> As the eMMC is 1.8V only, I'll defer the review to the people looking
> into the need
> to specify the 3.3V pinctrl on other R-Car Gen3 boards.

I don't see any harm in describing the hardware present in DT.
