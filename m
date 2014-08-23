From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] mmc: sunxi: Declare ERASE capability
Date: Sat, 23 Aug 2014 16:11:23 +0200
Message-ID: <53F8A10B.5090607@redhat.com>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22239 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbaHWOMK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 23 Aug 2014 10:12:10 -0400
In-Reply-To: <1408541960-14788-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, david.lanzendoerfer@o2s.ch

Hi,

On 08/20/2014 03:39 PM, Chen-Yu Tsai wrote:
> Declare ERASE capability so we can use filesystems with the discard
> option and the fstrim tool.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Good one:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 024f67c..7bf5c1c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -990,7 +990,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>  	/* 400kHz ~ 50MHz */
>  	mmc->f_min		=   400000;
>  	mmc->f_max		= 50000000;
> -	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> +	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> +				  MMC_CAP_ERASE;
>  
>  	ret = mmc_of_parse(mmc);
>  	if (ret)
> 
