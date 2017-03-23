From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: sh_mmcif: Document r7s72100 DT bindings
Date: Thu, 23 Mar 2017 09:29:48 +0100
Message-ID: <CAPDyKFqEr2ydNZn72OiH0p5Awr8k3yBXrpApBRKpqmcQiePV=w@mail.gmail.com>
References: <20170322144209.31768-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34994 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932714AbdCWI3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2017 04:29:51 -0400
Received: by mail-ua0-f181.google.com with SMTP id q7so89549135uaf.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2017 01:29:49 -0700 (PDT)
In-Reply-To: <20170322144209.31768-1-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 22 March 2017 at 15:42, Chris Brandt <chris.brandt@renesas.com> wrote:
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v4:
> * added Reviewed-by and Acked-by
> v3:
> * added list of how many interrupts each SOC has
> v2:
> * added interrupt description
> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index e4ba92aa..c32dc5a 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -8,6 +8,7 @@ Required properties:
>
>  - compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
>    fallback. Examples with <soctype> are:
> +       - "renesas,mmcif-r7s72100" for the MMCIF found in r7s72100 SoCs
>         - "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
> @@ -17,6 +18,13 @@ Required properties:
>         - "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
>         - "renesas,mmcif-sh73a0" for the MMCIF found in sh73a0 SoCs
>
> +- interrupts: Some SoCs have only 1 shared interrupt, while others have either
> +  2 or 3 individual interrupts (error, int, card detect). Below is the number
> +  of interrupts for each SoC:
> +    1: r8a73a4, r8a7778, r8a7790, r8a7791, r8a7793, r8a7794
> +    2: r8a7740, sh73a0
> +    3: r7s72100
> +
>  - clocks: reference to the functional clock
>
>  - dmas: reference to the DMA channels, one per channel name listed in the
> --
> 2.10.1
>
>
