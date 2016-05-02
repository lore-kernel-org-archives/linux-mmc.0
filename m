From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] ARM: dts: r8a7793: Add MMCIF0
Date: Mon, 2 May 2016 10:00:58 +0200
Message-ID: <CAMuHMdX-KbrAR1potxTEYXzPYK1vFZWRLt6dGuJTm-jv3iR-HA@mail.gmail.com>
References: <1461945699-21324-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1461945699-21324-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulrich,

On Fri, Apr 29, 2016 at 6:01 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a7793.dtsi
> +++ b/arch/arm/boot/dts/r8a7793.dtsi
> @@ -543,6 +543,19 @@
>                 status = "disabled";
>         };
>
> +       mmcif0: mmcif@ee200000 {
> +               compatible = "renesas,mmcif-r8a7793", "renesas,sh-mmcif";
> +               reg = <0 0xee200000 0 0x80>;
> +               interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&mstp3_clks R8A7793_CLK_MMCIF0>;
> +               dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
> +               dma-names = "tx", "rx";
> +               power-domains = <&cpg_clocks>;

Although the above would still work, all other nodes have been updated to

        power-domains = <&sysc R8A7793_PD_ALWAYS_ON>;

> +               reg-io-width = <4>;
> +               status = "disabled";
> +               max-frequency = <97500000>;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
