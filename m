From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: renesas_sdhi: provide example in
 bindings documentation
Date: Fri, 13 Oct 2017 13:19:20 +0200
Message-ID: <CAMuHMdVW-LPaDSLXaDwS_x2WmxZE5DnzvsuDPB71i5+su6rpNg@mail.gmail.com>
References: <20171013103812.30826-1-horms+renesas@verge.net.au> <20171013103812.30826-2-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20171013103812.30826-2-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Fri, Oct 13, 2017 at 12:38 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Provide an example of the usage of the DT bindings for TMIO
> in their documentation. The example given is for the r8a7790 (R-Car H1).

r8a7790 == R-Car H2?

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 54ef642f23a0..99be4e7e7391 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -43,3 +43,57 @@ Optional properties:
>  - pinctrl-names: should be "default", "state_uhs"
>  - pinctrl-0: should contain default/high speed pin ctrl
>  - pinctrl-1: should contain uhs mode pin ctrl
> +
> +Example: R8A7779 (R-Car H1) SDHI controller nodes

OK (r8a7779 == R-Car H1)

> +
> +       sdhi0: sd@ee100000 {
> +               compatible = "renesas,sdhi-r8a7790";

r8a7790 == R-Car H2?

> +               reg = <0 0xee100000 0 0x328>;
> +               interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;

r8a7790 == R-Car H2?

> +               dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
> +                      <&dmac1 0xcd>, <&dmac1 0xce>;
> +               dma-names = "tx", "rx", "tx", "rx";
> +               max-frequency = <195000000>;
> +               power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;

r8a7790 == R-Car H2?

> +               status = "disabled";
> +       };

etc...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
