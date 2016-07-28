From: Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH -next] mmc: sdhci-bcm-kona: fix error return code in
 sdhci_bcm_kona_probe()
Date: Thu, 28 Jul 2016 09:45:57 -0700
Message-ID: <f4099dac-99fb-00df-72d4-24ff4e52ed2f@broadcom.com>
References: <1469722664-15136-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36694 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932603AbcG1QqC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2016 12:46:02 -0400
Received: by mail-pf0-f177.google.com with SMTP id h186so23545158pfg.3
        for <linux-mmc@vger.kernel.org>; Thu, 28 Jul 2016 09:46:02 -0700 (PDT)
In-Reply-To: <1469722664-15136-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

Hi Wei,

On 7/28/2016 9:17 AM, Wei Yongjun wrote:
> In clk_set_rate() or clk_prepare_enable() error handling case, the
> error return code ret is not set, so sdhci_bcm_kona_probe() return
> 0 in those error cases.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/mmc/host/sdhci-bcm-kona.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index e5c634b..51dd2fd 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -253,12 +253,14 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>
> -	if (clk_set_rate(pltfm_priv->clk, host->mmc->f_max) != 0) {
> +	ret = clk_set_rate(pltfm_priv->clk, host->mmc->f_max);
> +	if (ret) {
>  		dev_err(dev, "Failed to set rate core clock\n");
>  		goto err_pltfm_free;
>  	}
>
> -	if (clk_prepare_enable(pltfm_priv->clk) != 0) {
> +	ret = clk_prepare_enable(pltfm_priv->clk);
> +	if (ret) {
>  		dev_err(dev, "Failed to enable core clock\n");
>  		goto err_pltfm_free;
>  	}
>

The above change looks good to me, thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>
