From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH] mmc: wmt-sdmmc: Simplify wmt_set_sd_power implementation
Date: Sat, 05 Oct 2013 17:24:54 +1300
Message-ID: <524F9496.8080209@prisktech.co.nz>
References: <1380791080.30876.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:59557 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab3JEEYn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Oct 2013 00:24:43 -0400
In-Reply-To: <1380791080.30876.2.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 03/10/13 22:04, Axel Lin wrote:
> Simplify the code to set/clear BM_SD_OFF bit:
>
>            | power_inverted: 0  | power_inverted: 1
> -------------------------------------------------
> enable: 0 | SET BM_SD_OFF      | CLEAR BM_SD_OFF
> -------------------------------------------------
> enable: 1 | CLEAR BM_SD_OFF    | SET BM_SD_OFF
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/mmc/host/wmt-sdmmc.c | 30 ++++++++----------------------
>   1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 34231d5..57858ef 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -212,28 +212,14 @@ struct wmt_mci_priv {
>   
>   static void wmt_set_sd_power(struct wmt_mci_priv *priv, int enable)
>   {
> -	u32 reg_tmp;
> -	if (enable) {
> -		if (priv->power_inverted) {
> -			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
> -			writeb(reg_tmp | BM_SD_OFF,
> -			       priv->sdmmc_base + SDMMC_BUSMODE);
> -		} else {
> -			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
> -			writeb(reg_tmp & (~BM_SD_OFF),
> -			       priv->sdmmc_base + SDMMC_BUSMODE);
> -		}
> -	} else {
> -		if (priv->power_inverted) {
> -			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
> -			writeb(reg_tmp & (~BM_SD_OFF),
> -			       priv->sdmmc_base + SDMMC_BUSMODE);
> -		} else {
> -			reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
> -			writeb(reg_tmp | BM_SD_OFF,
> -			       priv->sdmmc_base + SDMMC_BUSMODE);
> -		}
> -	}
> +	u32 reg_tmp = readb(priv->sdmmc_base + SDMMC_BUSMODE);
> +
> +	if (enable ^ priv->power_inverted)
> +		reg_tmp &= ~BM_SD_OFF;
> +	else
> +		reg_tmp |= BM_SD_OFF;
> +
> +	writeb(reg_tmp, priv->sdmmc_base + SDMMC_BUSMODE);
>   }
>   
>   static void wmt_mci_read_response(struct mmc_host *mmc)
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Thanks Axel - much better code.

Regards
Tony Prisk
