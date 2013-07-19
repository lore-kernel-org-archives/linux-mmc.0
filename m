From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-bcm-kona: Remove redundant use
 of_match_ptr
Date: Fri, 19 Jul 2013 13:31:14 -0700
Message-ID: <51E9A212.2000703@broadcom.com>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
 <1373263914-18050-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:1608 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab3GSUbZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Jul 2013 16:31:25 -0400
In-Reply-To: <1373263914-18050-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On 13-07-07 11:11 PM, Sachin Kamat wrote:
> sdhci_bcm_kona_of_match structure is always compiled in. Hence
> of_match_ptr macro is not necessary.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/mmc/host/sdhci-bcm-kona.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index bca6d55..d7a44ae 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -335,7 +335,7 @@ static struct platform_driver sdhci_bcm_kona_driver = {
>   		.name	= "sdhci-kona",
>   		.owner	= THIS_MODULE,
>   		.pm	= SDHCI_PLTFM_PMOPS,
> -		.of_match_table = of_match_ptr(sdhci_bcm_kona_of_match),
> +		.of_match_table = sdhci_bcm_kona_of_match,
>   	},
>   	.probe		= sdhci_bcm_kona_probe,
>   	.remove		= __exit_p(sdhci_bcm_kona_remove),
Acked-by: Christian Daudt <csd@broadcom.com>

  thanks,
    csd

