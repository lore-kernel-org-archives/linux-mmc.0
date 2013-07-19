From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-bcm-kona: Remove unneeded version.h inclusion
Date: Fri, 19 Jul 2013 16:40:55 +0530
Message-ID: <CAK9yfHzQyhNRYeenfMriODHXoo8Adj9nsE=Shob-o5gaF10DSw@mail.gmail.com>
References: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:58926 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3GSLK4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jul 2013 07:10:56 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so5171368obc.16
        for <linux-mmc@vger.kernel.org>; Fri, 19 Jul 2013 04:10:55 -0700 (PDT)
In-Reply-To: <1373263914-18050-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: csd@broadcom.com, cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

On 8 July 2013 11:41, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> version.h header inclusion is not necessary as detected by
> versioncheck.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/sdhci-bcm-kona.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 87175f9..bca6d55 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -24,7 +24,6 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> -#include <linux/version.h>
>  #include <linux/mmc/slot-gpio.h>
>
>  #include "sdhci-pltfm.h"
> --
> 1.7.9.5
>

Ping on this series.

-- 
With warm regards,
Sachin
