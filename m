From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [RFC 2/3] mmc: dw_mmc: move the platform specific init call
Date: Tue, 20 Aug 2013 20:34:34 +0900
Message-ID: <001e01ce9d99$3e4bb870$bae32950$%jun@samsung.com>
References: <1376894176-2702-1-git-send-email-yuvaraj.cd@samsung.com>
 <1376894176-2702-2-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53537 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab3HTLeg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Aug 2013 07:34:36 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRT0084HUTD3WI0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 20 Aug 2013 20:34:34 +0900 (KST)
In-reply-to: <1376894176-2702-2-git-send-email-yuvaraj.cd@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>, cjb@laptop.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, thomas.ab@samsung.com
Cc: 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>

Hi Yuvaraj,

This change affects dw_mci_socfpga_parse_dt of socfpga.
It should be considered.

Thanks,
Seungwon Jeon

On Mon, August 19, 2013, Yuvaraj Kumar C D wrote:
> Current platform specific private data initialisation call
> dw_mci_exynos_priv_init can be used to do platform specific
> initialisation of SMU and others in future.So the drv_data->init
> call has moved to dw_mci_probe.
> 
> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-pltfm.c |    7 -------
>  drivers/mmc/host/dw_mmc.c       |    9 +++++++++
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index ee52556..a570da4 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -38,7 +38,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>  {
>  	struct dw_mci *host;
>  	struct resource	*regs;
> -	int ret;
> 
>  	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
>  	if (!host)
> @@ -58,12 +57,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
>  	if (IS_ERR(host->regs))
>  		return PTR_ERR(host->regs);
> 
> -	if (drv_data && drv_data->init) {
> -		ret = drv_data->init(host);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	platform_set_drvdata(pdev, host);
>  	return dw_mci_probe(host);
>  }
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ee5f167..0c0cada 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2222,6 +2222,15 @@ int dw_mci_probe(struct dw_mci *host)
>  		host->bus_hz = clk_get_rate(host->ciu_clk);
>  	}
> 
> +	if (drv_data && drv_data->init) {
> +		ret = drv_data->init(host);
> +		if (ret) {
> +			dev_err(host->dev,
> +				"implementation specific init failed\n");
> +			goto err_clk_ciu;
> +		}
> +	}
> +
>  	if (drv_data && drv_data->setup_clock) {
>  		ret = drv_data->setup_clock(host);
>  		if (ret) {
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

