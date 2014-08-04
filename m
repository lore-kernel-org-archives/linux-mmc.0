From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/11] ARM: shmobile: r8a7790: Reference DMA channels in
 SDHI DT nodes
Date: Mon, 4 Aug 2014 11:01:28 +0200
Message-ID: <CAMuHMdWZxNWDBc+NyrmJ1DaME+JycuZwB+wpEDgaDdkw6Bv3Qw@mail.gmail.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1405464321-4723-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1405464321-4723-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 16, 2014 at 12:45 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Add references to the transmit and receive DMA channels in the four
> SDHI nodes.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

but see below for a question (this also applies to other members of the R-Car
Gen 2 family)...

> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 465008a..2ea3b2a 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi

> @@ -406,6 +410,8 @@
>                 reg = <0 0xee140000 0 0x100>;
>                 interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
>                 clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
> +               dmas = <&dmac0 0xc1>, <&dmac0 0xc2>;
> +               dma-names = "tx", "rx";
>                 cap-sd-highspeed;
>                 status = "disabled";
>         };
> @@ -415,6 +421,8 @@
>                 reg = <0 0xee160000 0 0x100>;
>                 interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
>                 clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
> +               dmas = <&dmac0 0xd3>, <&dmac0 0xd4>;
> +               dma-names = "tx", "rx";
>                 cap-sd-highspeed;
>                 status = "disabled";
>         };

SDHI2 and SDHI3 actually have 2 sets of 2 (TX and RX) DMA channels:
the normal one, and the "C2" one. However, I didn't get any wiser about this
"C2" by browsing through the docs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
