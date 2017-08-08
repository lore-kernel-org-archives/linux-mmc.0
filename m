From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] omap/hsmmc: constify dev_pm_ops
Date: Tue, 8 Aug 2017 13:34:10 +0200
Message-ID: <CAPDyKFrSTG5yWwfJfbZzBTTqsLAitbXQ_5C-Nkg-Htmr_K7NpQ@mail.gmail.com>
References: <1502190857-3762-1-git-send-email-doug.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34702 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752104AbdHHLeM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2017 07:34:12 -0400
Received: by mail-qk0-f176.google.com with SMTP id u139so17714506qka.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2017 04:34:11 -0700 (PDT)
In-Reply-To: <1502190857-3762-1-git-send-email-doug.lkml@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Wilson <doug.lkml@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Wilson <doug.wilson@gmail.com>

On 8 August 2017 at 13:14, Doug Wilson <doug.lkml@gmail.com> wrote:
> dev_pm_ops is not supposed to change at runtime. Marking it
> constant.
>
> Signed-off-by: Doug Wilson <doug.wilson@gmail.com>

This doesn't apply on my next branch, please re-base it.

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 04ff3c9..a280c7f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2322,7 +2322,7 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
>         return 0;
>  }
>
> -static struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
> +static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
>         SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
>         .runtime_suspend = omap_hsmmc_runtime_suspend,
>         .runtime_resume = omap_hsmmc_runtime_resume,
> --
> 2.7.4
>
