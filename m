From: Mateusz Nowak <mateusz.nowak@linux.intel.com>
Subject: Re: [PATCH 09/21] mmc: sdhci: Include leds.h
Date: Fri, 30 Dec 2016 14:35:39 +0100
Message-ID: <59d6e628-3553-5811-1fd4-a92359347085@linux.intel.com>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
 <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56892 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753938AbcL3Nfn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Dec 2016 08:35:43 -0500
In-Reply-To: <1483102054-1752-10-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

On 12/30/2016 13:47, Ulf Hansson wrote:
> Don't rely on host.h to include the mmc.h header, but instead include it
> explicitly because the driver depends on it.
You refer in description to header file (mmc.h) not related to this patch.

>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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

Regards,
Mateusz.
