From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/4] mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7791
Date: Wed, 12 Feb 2014 17:38:37 +0900
Message-ID: <20140212083834.GC28329@verge.net.au>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
 <87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
 <8738joao5o.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8738joao5o.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Feb 11, 2014 at 09:35:50PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch updates r8a7791 DT data to have SoC specific settings.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>


> ---
> >> Chris
> 
> I add this patch to my previous
> "Re: mmc: sh_mobile_sdhi: DT update for R-Car" patch-set as [5/4]
> Please let me know if you want re-send these patch-set again
> 
>  drivers/mmc/host/sh_mobile_sdhi.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 1622b03..d54169f 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -65,6 +65,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
>  	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
>  	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
>  	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
> +	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
> -- 
> 1.7.9.5
> 
