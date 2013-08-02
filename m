From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-bcm2835: Staticize bcm2835_sdhci_get_min_clock
Date: Fri, 2 Aug 2013 14:19:56 +0530
Message-ID: <CAK9yfHzTsYQvLNpd4=TquhHK5p9er0CRK45JhoBn=Ebz5k1ieQ@mail.gmail.com>
References: <1372228021-28895-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:39003 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442Ab3HBIt5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 04:49:57 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so813045oag.11
        for <linux-mmc@vger.kernel.org>; Fri, 02 Aug 2013 01:49:56 -0700 (PDT)
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
Chris,

Any comments on this patch?


-- 
With warm regards,
Sachin
