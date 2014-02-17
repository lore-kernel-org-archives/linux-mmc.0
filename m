From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/3] mmc: core: Add DT bindings for eMMC high-speed DDR
 1.8/1.2V
Date: Mon, 17 Feb 2014 15:56:54 +0900
Message-ID: <5301B2B6.5060605@samsung.com>
References: <1392380829-8473-1-git-send-email-ulf.hansson@linaro.org>
 <1392380829-8473-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14535 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbaBQG4n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 01:56:43 -0500
In-reply-to: <1392380829-8473-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, devicetree@vger.kernel.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 02/14/2014 09:27 PM, Ulf Hansson wrote:
> Provide the option to configure these speed modes per host, for those
> host driver's that can't distinguish this in runtime.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |    2 ++
>  drivers/mmc/core/host.c                       |    4 ++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index bd2ce67..519d952 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -34,6 +34,8 @@ Optional properties:
>  - cap-power-off-card: powering off the card is safe
>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>  - full-pwr-cycle: full power cycle of the card is supported
> +- mmc-highspeed-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
> +- mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
>  
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 2644d91..d014127 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -439,6 +439,10 @@ int mmc_of_parse(struct mmc_host *host)
>  		host->pm_caps |= MMC_PM_KEEP_POWER;
>  	if (of_find_property(np, "enable-sdio-wakeup", &len))
>  		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
> +	if (of_find_property(np, "mmc-ddr-1_8v", &len))
> +		host->caps |= MMC_CAP_1_8V_DDR;
> +	if (of_find_property(np, "mmc-ddr-1_2v", &len))
> +		host->caps |= MMC_CAP_1_2V_DDR;
>  
>  	return 0;
>  
> 

