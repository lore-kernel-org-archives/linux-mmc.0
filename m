From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5 v2] mmc: shmobile: add renesas,sdhi-rcar-gen1/gen2 in
 DT compatible
Date: Thu, 7 Aug 2014 09:43:06 +0900
Message-ID: <20140807004303.GG32652@verge.net.au>
References: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
 <87oavy8k3v.wl%kuninori.morimoto.gx@gmail.com>
 <87mwbi8k1z.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55692 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbaHGAnK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Aug 2014 20:43:10 -0400
Content-Disposition: inline
In-Reply-To: <87mwbi8k1z.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Tue, Aug 05, 2014 at 06:48:42PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch adds DT compatible for Renesas R-Car Gen1/Gen2.
> Current driver has SoC level .compatible
> (r8a7778/r8a7779/r8a7790/r8a7791),
> but these can be match as generation level.

Is this compatibility explicitly documented anywhere?

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - update tmio_mmc.txt
> 
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt |    2 ++
>  drivers/mmc/host/sh_mobile_sdhi.c                  |    2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 6a2a116..51c05cf 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -11,6 +11,8 @@ optional bindings can be used.
>  
>  Required properties:
>  - compatible:	"renesas,sdhi-shmobile" - a generic sh-mobile SDHI unit
> +		"renesas,sdhi-rcar-gen1" - a generic R-Car Gen1 SDHI unit
> +		"renesas,sdhi-rcar-gen2" - a generic R-Car Gen2 SDHI unit
>  		"renesas,sdhi-sh7372" - SDHI IP on SH7372 SoC
>  		"renesas,sdhi-sh73a0" - SDHI IP on SH73A0 SoC
>  		"renesas,sdhi-r8a73a4" - SDHI IP on R8A73A4 SoC
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 91058da..cb3bb39 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -64,8 +64,10 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
>  	{ .compatible = "renesas,sdhi-sh73a0", .data = &sh_mobile_sdhi_of_cfg[0], },
>  	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
>  	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
> +	{ .compatible = "renesas,sdhi-rcar-gen1", .data = &of_rcar_gen1_compatible, },
>  	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
>  	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
> +	{ .compatible = "renesas,sdhi-rcar-gen2", .data = &of_rcar_gen2_compatible, },
>  	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
>  	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
>  	{},
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
