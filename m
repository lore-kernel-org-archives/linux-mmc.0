From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove unnecessary debug message
Date: Tue, 23 Dec 2014 21:51:41 +0900
Message-ID: <5499655D.1040809@samsung.com>
References: <1419336453-6411-1-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:50270 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbaLWMvn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Dec 2014 07:51:43 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NH100KTUD259U80@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 23 Dec 2014 21:51:41 +0900 (KST)
In-reply-to: <1419336453-6411-1-git-send-email-beomho.seo@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, 'Chris Ball' <chris@printf.net>

Plz CC'd the mmc maintainers and dw-mmc maintainers.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 12/23/2014 09:07 PM, Beomho Seo wrote:
> This patch remove unnecessary 'out of memory' message on dw mmc driver.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    4 +---
>  drivers/mmc/host/dw_mmc.c        |    4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index f936704..74eb081 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -230,10 +230,8 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>  	int ret;
>  
>  	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		dev_err(host->dev, "mem alloc failed for private data\n");
> +	if (!priv)
>  		return -ENOMEM;
> -	}
>  
>  	for (idx = 0; idx < ARRAY_SIZE(exynos_compat); idx++) {
>  		if (of_device_is_compatible(np, exynos_compat[idx].compatible))
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a1b80e5..6e4d864 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2546,10 +2546,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	u32 clock_frequency;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata) {
> -		dev_err(dev, "could not allocate memory for pdata\n");
> +	if (!pdata)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	/* find out number of slots supported */
>  	if (of_property_read_u32(dev->of_node, "num-slots",
> 

