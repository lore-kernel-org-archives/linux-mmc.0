From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-bcm2835: Staticize bcm2835_sdhci_get_min_clock
Date: Tue, 23 Jul 2013 09:09:08 +0530
Message-ID: <CAK9yfHypQorRf4rvm-YtO4bawNuvivOJg-y3J7D862Hh=WMgOw@mail.gmail.com>
References: <1372228021-28895-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57603 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3GWDjJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2013 23:39:09 -0400
Received: by mail-pb0-f53.google.com with SMTP id xb12so7777397pbc.40
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2013 20:39:09 -0700 (PDT)
In-Reply-To: <1372228021-28895-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, swarren@wwwdotorg.org, sachin.kamat@linaro.org

On 26 June 2013 11:57, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'bcm2835_sdhci_get_min_clock' is used only in this file.
> Make it static.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/sdhci-bcm2835.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index 0584a1c..36fa2df 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -119,7 +119,7 @@ static u8 bcm2835_sdhci_readb(struct sdhci_host *host, int reg)
>         return byte;
>  }
>
> -unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
> +static unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
>  {
>         return MIN_FREQ;
>  }
> --
> 1.7.9.5
>

Ping..

-- 
With warm regards,
Sachin
