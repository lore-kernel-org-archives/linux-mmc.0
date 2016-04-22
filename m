From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] ARM: dts: r8a7793: Add MMCIF0
Date: Fri, 22 Apr 2016 10:20:18 +1000
Message-ID: <20160422002017.GC25416@verge.net.au>
References: <1460995360-11417-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdW0uJZU947gXR0QVYOUFYH2K0fvuhBaD+rd8=RuvTVq-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW0uJZU947gXR0QVYOUFYH2K0fvuhBaD+rd8=RuvTVq-A@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 21, 2016 at 02:52:09PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 18, 2016 at 6:02 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > Same as on r8a7794.
> 
> r8a7791?
> 
> > --- a/arch/arm/boot/dts/r8a7793.dtsi
> > +++ b/arch/arm/boot/dts/r8a7793.dtsi
> > @@ -510,6 +510,19 @@
> >                 reg = <0 0xe6060000 0 0x250>;
> >         };
> >
> > +       mmcif0: mmcif@ee200000 {
> > +               compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
> > +               reg = <0 0xee200000 0 0x80>;
> > +               interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
> 
> s/0/GIC_SPI/
> 
> > +               clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
> > +               dmas = <&dmac0 0xd1>, <&dmac0 0xd2>,
> > +                      <&dmac1 0xd1>, <&dmac1 0xd2>;
> > +               dma-names = "tx", "rx", "tx", "rx";
> > +               power-domains = <&cpg_clocks>;
> > +               reg-io-width = <4>;
> > +               status = "disabled";
> 
> max-frequency = <97500000>;?
> 
> It's always a good idea to compare r8a7791.dts and r8a7793.dtsi
> after s/r8a779[13]/r8a779x/...
> 
> > +       };

Thanks Geert,

it looks like I was a little hasty in queueing up this patch.
I have dropped it for now. 

Ulrich,

please address the feedback and repost.

Thanks
