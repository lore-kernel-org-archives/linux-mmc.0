From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 09/21] mmc: sdhci: Include leds.h
Date: Tue, 10 Jan 2017 10:32:32 +0200
Message-ID: <eb601944-0c6c-c657-c2e9-398b1a9a6848@intel.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030266AbdAJIho (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Jan 2017 03:37:44 -0500
In-Reply-To: <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

On 30/12/16 14:47, Ulf Hansson wrote:
> Don't rely on host.h to include the mmc.h header, but instead include it
> explicitly because the driver depends on it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Apart from commit message:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0b66f21..a10a7b6 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -17,6 +17,7 @@
>  #include <linux/compiler.h>
>  #include <linux/types.h>
>  #include <linux/io.h>
> +#include <linux/leds.h>
>  
>  #include <linux/mmc/host.h>
>  
> 

