From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 08/21] mmc: sdhci-cadence: Include mmc.h
Date: Tue, 10 Jan 2017 10:35:58 +0200
Message-ID: <ee2e5594-f5a2-a1cb-cac2-bf2b1ec2e885@intel.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-9-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27472 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030266AbdAJIlL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Jan 2017 03:41:11 -0500
In-Reply-To: <1483102054-1752-9-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 30/12/16 14:47, Ulf Hansson wrote:
> Don't rely on host.h to include the mmc.h header, but instead include it
> explicitly because the driver depends on it.
> 
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 4b0ecb9..31e786d 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -17,6 +17,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
>  
>  #include "sdhci-pltfm.h"
>  
> 

