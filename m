From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] ARM: dts: r8a7793: Add SDHI controllers
Date: Thu, 21 Apr 2016 14:55:06 +0200
Message-ID: <CAMuHMdUQh0OnJhJ6RCH_MzDnOLd_ni_tEi4jC=KDewqTMQX7-w@mail.gmail.com>
References: <1460995377-11478-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1460995377-11478-2-git-send-email-ulrich.hecht+renesas@gmail.com>
	<20160421032733.GE11116@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160421032733.GE11116@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 21, 2016 at 5:27 AM, Simon Horman <horms@verge.net.au> wrote:
>
> We are back to one DMA controller this week so I updated your patch and
> queued up the following.
>
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Date: Mon, 18 Apr 2016 18:02:56 +0200
> Subject: [PATCH] ARM: dts: r8a7793: Add SDHI controllers
>
> Same as on r8a7791.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7793.dtsi | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
> index fc552629ed4a..a93d509732a8 100644
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -507,6 +507,39 @@
>                 reg = <0 0xe6060000 0 0x250>;
>         };
>
> +       sdhi0: sd@ee100000 {
> +               compatible = "renesas,sdhi-r8a7793";
> +               reg = <0 0xee100000 0 0x328>;
> +               interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&mstp3_clks R8A7793_CLK_SDHI0>;
> +               dmas = <&dmac0 0xcd>, <&dmac0 0xce>;
> +               dma-names = "tx", "rx", "tx", "rx";

If you drop the last two dma values, you should drop the last two
dma-names values, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
