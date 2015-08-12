From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] DT: mmc: sh_mmcif: document R8A779[34] support
Date: Wed, 12 Aug 2015 09:59:01 +0900
Message-ID: <20150812005901.GF15957@verge.net.au>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <28226759.dUa3lFkaxJ@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:32810 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbbHLA7D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Aug 2015 20:59:03 -0400
Content-Disposition: inline
In-Reply-To: <28226759.dUa3lFkaxJ@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Aug 12, 2015 at 01:57:45AM +0300, Sergei Shtylyov wrote:
> Renesas R8A7794 SoC also has the MMCIF controller...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This new compat string looks good to me.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> ---
> The patch is against Ulf Hansson's 'mmc.git'  repo's 'next' branch plus the
> patch I posted earlier today...
> 
> Changes in version 2:
> - deferred R8A7793 support to the patch posted earlier by Ulrich Hecht;

Perhaps it would be best to co-ordinate the R8A7793 and R8A7794
changes to avoid tedious conflicts.

> - fixed typo in the changelog.
> 
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> ===================================================================
> --- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -10,6 +10,7 @@ Required properties:
>  	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>  	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>  	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> +	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
>    followed by "renesas,sh-mmcif".
>  
>  - clocks: reference to the functional clock
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
