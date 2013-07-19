From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-bcm-kona: Remove unneeded version.h
 inclusion
Date: Fri, 19 Jul 2013 13:31:03 -0700
Message-ID: <51E9A207.70306@broadcom.com>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:3771 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab3GSUbQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Jul 2013 16:31:16 -0400
In-Reply-To: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org

On 13-07-07 11:11 PM, Sachin Kamat wrote:
> version.h header inclusion is not necessary as detected by
> versioncheck.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/mmc/host/sdhci-bcm-kona.c |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 87175f9..bca6d55 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -24,7 +24,6 @@
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/of_gpio.h>
> -#include <linux/version.h>
>   #include <linux/mmc/slot-gpio.h>
>   
>   #include "sdhci-pltfm.h"
Acked-by: Christian Daudt <csd@broadcom.com>

  thanks,
    csd


