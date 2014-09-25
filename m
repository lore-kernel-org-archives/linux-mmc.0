From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/6] mmc: It is not an error for the card to be removed
 while suspended
Date: Thu, 25 Sep 2014 10:27:11 +0200
Message-ID: <CAPDyKFr2=Buo3xSsEPX-GhAtfMRP_VDAxXUppEKMeDLBDd2xEg@mail.gmail.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
	<1411502430-25535-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:43613 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaIYI1M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Sep 2014 04:27:12 -0400
Received: by mail-qc0-f173.google.com with SMTP id r5so2508949qcx.18
        for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2014 01:27:11 -0700 (PDT)
In-Reply-To: <1411502430-25535-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 23 September 2014 22:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
> A removable card can be removed while it is runtime suspended.
> Do not print an error message.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  drivers/mmc/core/sd.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ce11d89..1d827eb 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1804,7 +1804,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
>                 return 0;
>
>         err = _mmc_resume(host);
> -       if (err)
> +       if (err && (err != -ENOMEDIUM || (host->caps & MMC_CAP_NONREMOVABLE)))

The check for NONREMOVABLE cap shouldn't be needed!? I mean -ENOMEDIUM
can't be set for such devices anyway.

>                 pr_err("%s: error %d doing aggessive resume\n",
>                         mmc_hostname(host), err);
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 2591388..28089b3 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1178,7 +1178,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
>                 return 0;
>
>         err = _mmc_sd_resume(host);
> -       if (err)
> +       if (err && (err != -ENOMEDIUM || (host->caps & MMC_CAP_NONREMOVABLE)))

Same comment as above.

>                 pr_err("%s: error %d doing aggessive resume\n",
>                         mmc_hostname(host), err);
>
> --
> 1.8.3.2
>

Kind regards
Uffe
