From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sh_mmcif: Document r8a7743 DT bindings
Date: Thu, 13 Jul 2017 12:06:03 +0200
Message-ID: <CAPDyKFq1m6WEk-Hr9cm8L5EM3k1bXx-+bUXyosfh9SMDW39vhg@mail.gmail.com>
References: <1499853805-5915-1-git-send-email-chris.paterson2@renesas.com> <1499853805-5915-2-git-send-email-chris.paterson2@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1499853805-5915-2-git-send-email-chris.paterson2@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Paterson <chris.paterson2@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Biju Das <biju.das@bp.renesas.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 12 July 2017 at 12:03, Chris Paterson <chris.paterson2@renesas.com> wrote:
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index c32dc5a..703e18c 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -11,6 +11,7 @@ Required properties:
>         - "renesas,mmcif-r7s72100" for the MMCIF found in r7s72100 SoCs
>         - "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
> +       - "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
>         - "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> @@ -21,7 +22,7 @@ Required properties:
>  - interrupts: Some SoCs have only 1 shared interrupt, while others have either
>    2 or 3 individual interrupts (error, int, card detect). Below is the number
>    of interrupts for each SoC:
> -    1: r8a73a4, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
> +    1: r8a73a4, r8a7743, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
>      2: r8a7740, sh73a0
>      3: r7s72100
>
> --
> 1.9.1
>

Thanks, applied for next!

Kind regards
Uffe
