From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: RE: [PATCH V2] mmc: core: Don't return an error for CD/WP GPIOs when
 GPIOLIB is unset
Date: Mon, 14 Sep 2015 10:26:24 +0000
Message-ID: <3e4cf4972318430e89c00ca485c2cc76@bgmail103.nvidia.com>
References: <1442225935-24155-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4297 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097AbbINK0a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 06:26:30 -0400
In-Reply-To: <1442225935-24155-1-git-send-email-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Marcus Overhagen <marcus.overhagen@gmail.com>, Venu Byravarasu <vbyravarasu@nvidia.com>

ACKed-by: Venu Byravarasu <vbyravarasu@nvidia.com>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Ulf Hansson
> Sent: Monday, September 14, 2015 3:49 PM
> To: linux-mmc@vger.kernel.org; Ulf Hansson
> Cc: Michal Simek; Marcus Overhagen; Venu Byravarasu
> Subject: [PATCH V2] mmc: core: Don't return an error for CD/WP GPIOs
> when GPIOLIB is unset
> 
> When CONFIG_GPIOLIB is unset, its stubs will return -ENOSYS. That means
> when the mmc core parses DT for CD/WP GPIOs via mmc_of_parse(), -
> ENOSYS becomes propagated to the caller. Typically this means that the mmc
> host driver fails to probe.
> 
> As the CD/WP GPIOs are already treated as optional, let's extend that to
> cover the case when CONFIG_GPIOLIB is unset.
> 
> Reported-by: Michal Simek <michal.simek@xilinx.com>
> Fixes: 16b23787fc70 ("mmc: sdhci-of-arasan: Call OF parsing for MMC")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Corrected error code check.
> 
> ---
>  drivers/mmc/core/host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> abd933b..5466f25 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -457,7 +457,7 @@ int mmc_of_parse(struct mmc_host *host)
>  					   0, &cd_gpio_invert);
>  		if (!ret)
>  			dev_info(host->parent, "Got CD GPIO\n");
> -		else if (ret != -ENOENT)
> +		else if (ret != -ENOENT && ret != -ENOSYS)
>  			return ret;
> 
>  		/*
> @@ -481,7 +481,7 @@ int mmc_of_parse(struct mmc_host *host)
>  	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0,
> &ro_gpio_invert);
>  	if (!ret)
>  		dev_info(host->parent, "Got WP GPIO\n");
> -	else if (ret != -ENOENT)
> +	else if (ret != -ENOENT && ret != -ENOSYS)
>  		return ret;
> 
>  	if (of_property_read_bool(np, "disable-wp"))
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
