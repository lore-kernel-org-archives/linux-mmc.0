From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings
Date: Tue, 22 Aug 2017 13:14:55 +0200
Message-ID: <CAPDyKFoPm8H8r1tnG0+HtGe_L2afMZw6_-eFOC_H4u8eO7Qbbg@mail.gmail.com>
References: <1502816007-30186-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1502816007-30186-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Paterson <chris.paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 15 August 2017 at 18:53, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index 703e18c..5ff1e12 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -12,6 +12,7 @@ Required properties:
>         - "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
> +       - "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
>         - "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> @@ -22,7 +23,7 @@ Required properties:
>  - interrupts: Some SoCs have only 1 shared interrupt, while others have either
>    2 or 3 individual interrupts (error, int, card detect). Below is the number
>    of interrupts for each SoC:
> -    1: r8a73a4, r8a7743, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
> +    1: r8a73a4, r8a7743, r8a7745, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
>      2: r8a7740, sh73a0
>      3: r7s72100
>
> --
> 2.7.4
>
