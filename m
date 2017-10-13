From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: renesas_sdhi: add R-Car Gen[123]
 fallback compatibility strings
Date: Fri, 13 Oct 2017 13:22:20 +0200
Message-ID: <CAMuHMdUwD-fc7bsGiHkP=3G+D=pFziELMNK7rheipCKQ43aHug@mail.gmail.com>
References: <20171013103812.30826-1-horms+renesas@verge.net.au> <20171013103812.30826-3-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171013103812.30826-3-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 13, 2017 at 12:38 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add fallback compatibility strings for R-Car Gen 1, 2 and 3.
>
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, f.e. Gen 1 and 2. But beyond that its not clear what the relationship
> between IP blocks might be. For example, I believe that r8a7790 is older
> than r8a7791 but that doesn't imply that the latter is a descendant of the
> former or vice versa.
>
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
>
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme being adopted for
> drivers for Renesas SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt

> @@ -47,7 +57,7 @@ Optional properties:
>  Example: R8A7779 (R-Car H1) SDHI controller nodes

Ah, so "R8A7790 (R-Car H2)" was intended in the previous patch...

>
>         sdhi0: sd@ee100000 {
> -               compatible = "renesas,sdhi-r8a7790";
> +               compatible = "renesas,sdhi-r8a7790", "renesas,rcar-gen2-sdhi";
>                 reg = <0 0xee100000 0 0x328>;
>                 interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
>                 clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
