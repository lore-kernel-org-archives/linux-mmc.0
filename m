From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: msm: Boost controller core clock
Date: Fri, 26 Jun 2015 14:34:55 +0300
Message-ID: <558D38DF.1080201@linaro.org>
References: <1435317417-369-1-git-send-email-ivan.ivanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35448 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbFZLe6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2015 07:34:58 -0400
Received: by wiga1 with SMTP id a1so15081196wig.0
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jun 2015 04:34:57 -0700 (PDT)
In-Reply-To: <1435317417-369-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 06/26/2015 02:16 PM, Ivan T. Ivanov wrote:
> Ensure SDCC is working with maximum clock otherwise card
> detection could be extremely slow, up to 7 seconds.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4a09f76..b2556bc 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -489,6 +489,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		goto pclk_disable;
>  	}
> 
> +	/* Vote for maximum clock rate for maximum performance */
> +	ret = clk_set_rate(msm_host->clk, INT_MAX);
> +	if (ret)
> +		dev_warn(&pdev->dev, "core clock boost falied\n");

failed?

Otherwise looks good to me.

> +
>  	ret = clk_prepare_enable(msm_host->clk);
>  	if (ret)
>  		goto pclk_disable;
> --
> 1.9.1
> 

