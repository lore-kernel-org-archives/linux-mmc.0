From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-bcm-kona: Staticize
 sdhci_bcm_kona_card_event
Date: Fri, 19 Jul 2013 13:31:24 -0700
Message-ID: <51E9A21C.3020309@broadcom.com>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
 <1373263914-18050-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:1608 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614Ab3GSUbf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Jul 2013 16:31:35 -0400
In-Reply-To: <1373263914-18050-3-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On 13-07-07 11:11 PM, Sachin Kamat wrote:
> sdhci_bcm_kona_card_event is referenced only in this file.
> Make it static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/mmc/host/sdhci-bcm-kona.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index d7a44ae..f59f332 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -161,7 +161,7 @@ static int sdhci_bcm_kona_sd_card_emulate(struct sdhci_host *host, int insert)
>   /*
>    * SD card interrupt event callback
>    */
> -void sdhci_bcm_kona_card_event(struct sdhci_host *host)
> +static void sdhci_bcm_kona_card_event(struct sdhci_host *host)
>   {
>   	if (mmc_gpio_get_cd(host->mmc) > 0) {
>   		dev_dbg(mmc_dev(host->mmc),
Acked-by: Christian Daudt <csd@broadcom.com>

  thanks,
    csd

