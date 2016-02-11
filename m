From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] Revert "mmc: block: don't use parameter prefix if built
 as module"
Date: Thu, 11 Feb 2016 16:57:57 +0100
Message-ID: <CAPDyKFp=yU1uSHxpPXO5rq4VGZc2VtJepgYNfzSoomgED4g5mw@mail.gmail.com>
References: <1455206051-8633-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455206051-8633-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 11 February 2016 at 16:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> This reverts commit 829b6962f7e3cfc06f7c5c26269fd47ad48cf503.
>
> Revert this change as it causes a sysfs path to change and therefore
> introduces and ABI regression. More precisely Android's vold is not being
> able to access /sys/module/mmcblk/parameters/perdev_minors any more, since
> the path becomes changed to: "/sys/module/mmc_block/..."
>
> Fixes: 829b6962f7e3 ("mmc: block: don't use parameter prefix if built as
> module")
> Reported-by: John Stultz <john.stultz@linaro.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

John, I noticed your regression report. Thanks!

I decided to send this patch and I have already queued it for fixes.

Sorry for not thinking clear when I applied the earlier patch.

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 951641a..fe207e5 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -47,13 +47,10 @@
>  #include "queue.h"
>
>  MODULE_ALIAS("mmc:block");
> -
> -#ifdef KERNEL
>  #ifdef MODULE_PARAM_PREFIX
>  #undef MODULE_PARAM_PREFIX
>  #endif
>  #define MODULE_PARAM_PREFIX "mmcblk."
> -#endif
>
>  #define INAND_CMD38_ARG_EXT_CSD  113
>  #define INAND_CMD38_ARG_ERASE    0x00
> --
> 1.9.1
>
