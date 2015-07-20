From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: block: don't use parameter prefix if built as module
Date: Mon, 20 Jul 2015 16:21:13 +0200
Message-ID: <CAPDyKFro3jVapPkbGrvPFSCN3eWrHbx3=vMwcGsZtcGCrFb7Qg@mail.gmail.com>
References: <1435145541-127393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35927 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932262AbbGTOVO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2015 10:21:14 -0400
Received: by qgy5 with SMTP id 5so73086107qgy.3
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2015 07:21:13 -0700 (PDT)
In-Reply-To: <1435145541-127393-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 24 June 2015 at 13:32, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> It's excessive to use prefix for the parameters when you do
>         modrpobe mmc-block mmcblk.perdev_minors=16
>
> Make this available only for built-in case.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied!

Kind regards
Uffe

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
> --
> 2.1.4
>
