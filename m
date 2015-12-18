From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: It is not an error for the card to be removed while suspended
Date: Fri, 18 Dec 2015 10:54:55 +0100
Message-ID: <CAPDyKFoxvsNOyt4LObmX5sH++kLCUp1cjdtGSy-MTStQ5W0rKA@mail.gmail.com>
References: <1450101087-24391-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33696 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbLRJy4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2015 04:54:56 -0500
Received: by mail-yk0-f171.google.com with SMTP id 140so51813505ykp.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2015 01:54:56 -0800 (PST)
In-Reply-To: <1450101087-24391-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 14 December 2015 at 14:51, Adrian Hunter <adrian.hunter@intel.com> wrote:
> A card can be removed while it is runtime suspended.
> Do not print an error message.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  drivers/mmc/core/sd.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 549c56e8cf6b..bf49e44571f2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1935,7 +1935,7 @@ static int mmc_runtime_resume(struct mmc_host *host)
>         int err;
>
>         err = _mmc_resume(host);
> -       if (err)
> +       if (err && err != -ENOMEDIUM)
>                 pr_err("%s: error %d doing runtime resume\n",
>                         mmc_hostname(host), err);
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 8f3b46a56b3d..f2b164b214ae 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1158,7 +1158,7 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
>         int err;
>
>         err = _mmc_sd_resume(host);
> -       if (err)
> +       if (err && err != -ENOMEDIUM)
>                 pr_err("%s: error %d doing runtime resume\n",
>                         mmc_hostname(host), err);
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
