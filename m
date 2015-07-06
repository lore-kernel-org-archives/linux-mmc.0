From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/1] mmc: block: don't use parameter prefix if built as
 module
Date: Mon, 06 Jul 2015 15:23:23 +0300
Message-ID: <1436185403.10819.0.camel@linux.intel.com>
References: <1435145541-127393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60503 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbbGFMXZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Jul 2015 08:23:25 -0400
In-Reply-To: <1435145541-127393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org

On Wed, 2015-06-24 at 14:32 +0300, Andy Shevchenko wrote:
> It's excessive to use prefix for the parameters when you do
> 	modrpobe mmc-block mmcblk.perdev_minors=16
> 
> Make this available only for built-in case.

Any comments on this?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/card/block.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c9c3d20..b94540b 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -47,10 +47,13 @@
>  #include "queue.h"
>  
>  MODULE_ALIAS("mmc:block");
> +
> +#ifdef KERNEL
>  #ifdef MODULE_PARAM_PREFIX
>  #undef MODULE_PARAM_PREFIX
>  #endif
>  #define MODULE_PARAM_PREFIX "mmcblk."
> +#endif
>  
>  #define INAND_CMD38_ARG_EXT_CSD  113
>  #define INAND_CMD38_ARG_ERASE    0x00

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
