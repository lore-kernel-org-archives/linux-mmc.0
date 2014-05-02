From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/5][RESENT] mmc: SDHI: update sh_mobile_sdhi_of_data
 for r8a7790
Date: Sat, 03 May 2014 03:55:08 +0400
Message-ID: <5364305C.7090005@cogentembedded.com>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>	<878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com> <8738jdqo78.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <8738jdqo78.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 02/21/2014 03:55 AM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> This patch updates r8a7790 DT data to have SoC specific settings.

> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/mmc/host/sh_mobile_sdhi.c |   10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 38acf26..cfc37ec 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
[...]
> @@ -51,6 +52,12 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
>   	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>   };
>
> +static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
> +	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,

    Hm, I think SDHI0/1 still have the WP signal, only SDHI2 on Koelsch lacks 
it due to using micro-SD slot?..

WBR, Sergei

