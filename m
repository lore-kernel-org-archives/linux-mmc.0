From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] DT: mmc: sh_mmcif: fix "compatible" property text
Date: Wed, 12 Aug 2015 09:56:28 +0900
Message-ID: <20150812005628.GE15957@verge.net.au>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1643858.nkRxsQo3O3@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:32785 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbbHLA4a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Aug 2015 20:56:30 -0400
Content-Disposition: inline
In-Reply-To: <1643858.nkRxsQo3O3@wasted.cogentembedded.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

Hi Sergei,

On Wed, Aug 12, 2015 at 01:37:28AM +0300, Sergei Shtylyov wrote:
> The "compatible" property text contradicts even the example given in the MMCIF
> binding document itself;  moreover, the Renesas MMCIF driver only matches on
> the generic "compatible" string and doesn't look for the SoC specific strings
> at all. Thus describe "renesas,sh-mmcif" as a fallback value.
> 
> Fixes: b4c27763d749 ("mmc: sh_mmcif: Document DT bindings")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I don't believe this file is the appropriate place to describe
best-practice for the ordering of compatible strings which must surely be
documented elsewhere.

> ---
> The patch is against Ulf Hansson's 'mmc.git' repo's 'fixes' and 'next' branches.
> 
> Changes in version 2:
> - kept the SoC specific "compatible" property values mandatory and made the
>   generic string a fallback.
> 
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> ===================================================================
> --- mmc.orig/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ mmc/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -10,7 +10,7 @@ Required properties:
>  	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>  	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>  	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> -	- "renesas,sh-mmcif" for the generic MMCIF
> +  followed by "renesas,sh-mmcif".
>  
>  - clocks: reference to the functional clock
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
