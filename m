From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: bus: check suspend/resume hooks for bus_ops before calling
Date: Tue, 21 Jul 2015 13:09:54 +0200
Message-ID: <CAPDyKFo7ZXm8D1V6d94usmjFVx3_2jK=ELGR7kMdXCeAxzi-CA@mail.gmail.com>
References: <1436517526-19392-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33482 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585AbbGULJz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 07:09:55 -0400
Received: by qkdl129 with SMTP id l129so130075832qkd.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 04:09:54 -0700 (PDT)
In-Reply-To: <1436517526-19392-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10 July 2015 at 10:38, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> It needs to check suspend/resume hooks before calling them to avoid
> call trace during hibernation.

Could you elaborate more exactly what happens here, how do you trigger
this error.

Is this a bug fix?

>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  drivers/mmc/core/bus.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 972ff84..fc6b5e5 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -154,7 +154,8 @@ static int mmc_bus_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       ret = host->bus_ops->suspend(host);
> +       if (host->bus_ops->suspend)
> +               ret = host->bus_ops->suspend(host);
>         return ret;
>  }
>
> @@ -164,10 +165,12 @@ static int mmc_bus_resume(struct device *dev)
>         struct mmc_host *host = card->host;
>         int ret;
>
> -       ret = host->bus_ops->resume(host);
> -       if (ret)
> -               pr_warn("%s: error %d during resume (card was removed?)\n",
> -                       mmc_hostname(host), ret);
> +       if (host->bus_ops->resume) {
> +               ret = host->bus_ops->resume(host);
> +               if (ret)
> +                       pr_warn("%s: error %d during resume (card was removed?)\n",
> +                               mmc_hostname(host), ret);
> +       }
>
>         ret = pm_generic_resume(dev);
>         return ret;
> --
> 2.1.0.27.g96db324
>

Kind regards
Uffe
