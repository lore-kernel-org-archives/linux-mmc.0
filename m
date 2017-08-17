From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] dt-bindings: mmc: sh_mmcif: Document r8a7745 DT bindings
Date: Thu, 17 Aug 2017 10:14:06 +0200
Message-ID: <20170817081406.GE26170@verge.net.au>
References: <1502816007-30186-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:52007 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdHQIOI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Aug 2017 04:14:08 -0400
Content-Disposition: inline
In-Reply-To: <1502816007-30186-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Paterson <chris.paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>

On Tue, Aug 15, 2017 at 05:53:27PM +0100, Fabrizio Castro wrote:
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index 703e18c..5ff1e12 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -12,6 +12,7 @@ Required properties:
>  	- "renesas,mmcif-r8a73a4" for the MMCIF found in r8a73a4 SoCs
>  	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>  	- "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
> +	- "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
>  	- "renesas,mmcif-r8a7778" for the MMCIF found in r8a7778 SoCs
>  	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>  	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
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
