From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 2/2] mmc: slot-gpio: Don't override con_id when request descriptor
Date: Thu, 12 Jan 2017 13:00:38 +0100
Message-ID: <CAPDyKFoRUoSbC9nt-y+Hp10uoxWFj3F3E0cZkrGJ9LCNM9ZL0Q@mail.gmail.com>
References: <20170102120525.178212-1-andriy.shevchenko@linux.intel.com> <20170102120525.178212-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:33183 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdALMAk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 07:00:40 -0500
Received: by mail-wj0-f180.google.com with SMTP id kq3so10240465wjc.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 04:00:40 -0800 (PST)
In-Reply-To: <20170102120525.178212-2-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 2 January 2017 at 13:05, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The caller may supply connection ID, index, or both. All combinations are
> possible and mmc framework should not make any assumption on what exactly
> caller wants.
>
> Remove con_id override conditionals in mmc_gpiod_request_ro() and
> mmc_gpiod_request_cd().
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/slot-gpio.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index babe591aea96..a8450a8701e4 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -235,9 +235,6 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>         struct gpio_desc *desc;
>         int ret;
>
> -       if (!con_id)
> -               con_id = ctx->cd_label;
> -
>         desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>         if (IS_ERR(desc))
>                 return PTR_ERR(desc);
> @@ -289,9 +286,6 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
>         struct gpio_desc *desc;
>         int ret;
>
> -       if (!con_id)
> -               con_id = ctx->ro_label;
> -
>         desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>         if (IS_ERR(desc))
>                 return PTR_ERR(desc);
> --
> 2.11.0
>
