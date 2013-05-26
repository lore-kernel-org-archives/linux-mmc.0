From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Allow sdhci platform drivers to set quirks2 from platform data
Date: Sun, 26 May 2013 14:00:17 -0400
Message-ID: <8738t9liz2.fsf@octavius.laptop.org>
References: <1367332925-30671-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59320 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674Ab3EZSAV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 14:00:21 -0400
In-Reply-To: <1367332925-30671-1-git-send-email-alcooperx@gmail.com> (Al
	Cooper's message of "Tue, 30 Apr 2013 10:42:05 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Al,

On Tue, Apr 30 2013, Al Cooper wrote:
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c |    4 +++-
>  drivers/mmc/host/sdhci-pltfm.h |    1 +
>  2 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index 3145a78..e605509 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -149,8 +149,10 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
>  		host->ops = pdata->ops;
>  	else
>  		host->ops = &sdhci_pltfm_ops;
> -	if (pdata)
> +	if (pdata) {
>  		host->quirks = pdata->quirks;
> +		host->quirks2 = pdata->quirks2;
> +	}
>  	host->irq = platform_get_irq(pdev, 0);
>  
>  	if (!request_mem_region(iomem->start, resource_size(iomem),
> diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
> index 153b6c5..2940ee3 100644
> --- a/drivers/mmc/host/sdhci-pltfm.h
> +++ b/drivers/mmc/host/sdhci-pltfm.h
> @@ -18,6 +18,7 @@
>  struct sdhci_pltfm_data {
>  	struct sdhci_ops *ops;
>  	unsigned int quirks;
> +	unsigned int quirks2;
>  };
>  
>  struct sdhci_pltfm_host {

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
