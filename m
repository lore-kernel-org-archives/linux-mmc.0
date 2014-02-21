From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 5/5][RESENT] mmc: SDHI: update sh_mobile_sdhi_of_data
 for r8a7791
Date: Fri, 21 Feb 2014 16:36:27 +0400
Message-ID: <5307484B.5040500@cogentembedded.com>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>	<878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com> <871tyxqo6v.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <871tyxqo6v.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 21-02-2014 4:55, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> This patch updates r8a7791 DT data to have SoC specific settings.

    It doesn't update R8A7791 DT data, it adds the DT support for R8A7791. 
Please fix the changelog.

> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/mmc/host/sh_mobile_sdhi.c |    1 +
>   1 file changed, 1 insertion(+)

> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index cfc37ec..91058da 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -67,6 +67,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
>   	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
>   	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
>   	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
> +	{ .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);

WBR, Sergei

