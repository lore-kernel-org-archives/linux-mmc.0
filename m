From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 20 Jan 2017 12:02:36 +0100
Message-ID: <CAPDyKFq9psGMnKUx+SM_QGt6OKoMHgNFop6ANagtLOLwsMTT8w@mail.gmail.com>
References: <20170118172502.13876-1-chris.brandt@renesas.com> <20170118172502.13876-3-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38467 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbdATLCi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 06:02:38 -0500
Received: by mail-wm0-f42.google.com with SMTP id r144so37775020wme.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2017 03:02:38 -0800 (PST)
In-Reply-To: <20170118172502.13876-3-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 18 January 2017 at 18:25, Chris Brandt <chris.brandt@renesas.com> wrote:
> In the case of a single clock source, you don't need names. However,
> if the controller has 2 clock sources, you need to name them correctly
> so the driver can find the 2nd one.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v2:
> * fix spelling and change wording
> * changed clock name from "carddetect" to "cd"
> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index a1650ed..90370cd 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -25,8 +25,29 @@ Required properties:
>                 "renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
>                 "renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
>
> +- clocks: Most controllers only have 1 clock source per channel. However, some
> +         have a second clock dedicated to card detection. If 2 clocks are
> +         specified, you must name them as "core" and "cd". If the controller
> +         only has 1 clock, naming is not required.

Could you please elaborate a bit on the card detection clock?

I guess that there is some kind of internal card detection logic
(native card detect) in the SDHI IP, which requires a separate clock
for it to work? Perhaps you can state that somehow?

> +
>  Optional properties:
>  - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
>  - pinctrl-names: should be "default", "state_uhs"
>  - pinctrl-0: should contain default/high speed pin ctrl
>  - pinctrl-1: should contain uhs mode pin ctrl
> +
> +Example showing 2 clocks:
> +       sdhi0: sd@e804e000 {
> +               compatible = "renesas,sdhi-r7s72100";
> +               reg = <0xe804e000 0x100>;
> +               interrupts = <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH
> +                             GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH
> +                             GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +
> +               clocks = <&mstp12_clks R7S72100_CLK_SDHI00>,
> +                        <&mstp12_clks R7S72100_CLK_SDHI01>;
> +               clock-names = "core", "cd";
> +               cap-sd-highspeed;
> +               cap-sdio-irq;
> +               status = "disabled";

The last line seems a bit odd to include in an example.

> +       };
> --
> 2.10.1
>
>

Kind regards
Uffe
