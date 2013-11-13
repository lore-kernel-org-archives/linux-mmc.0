From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH V2] sdhci: only reprogram retuning timer when flag is set
Date: Wed, 13 Nov 2013 13:02:05 +0800
Message-ID: <CAA+hA=S37Ee3WhGh=k50V9EFvkd_NsnNH9vhie5z-gBfZT9NsQ@mail.gmail.com>
References: <1383821960-2533-1-git-send-email-arend@broadcom.com>
	<1384163395-27038-1-git-send-email-arend@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34272 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3KMFCF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Nov 2013 00:02:05 -0500
Received: by mail-qa0-f46.google.com with SMTP id j7so3487087qaq.5
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2013 21:02:05 -0800 (PST)
In-Reply-To: <1384163395-27038-1-git-send-email-arend@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Arend,

On Mon, Nov 11, 2013 at 5:49 PM, Arend van Spriel <arend@broadcom.com> wrote:
> When the host->tuning_count is zero it means that the
> retuning is disabled. This is checked on the first
> run of sdhci_execute_tuning() by the if statement below:
>
>         if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuning_count &&
>             (host->tuning_mode == SDHCI_TUNING_MODE_1)) {
>
> So only when tuning_count is non-zero it will set the host
> flag SDHCI_USING_RETUNING_TIMER. The else statement is only
> for re-programming the timer, which means that flag must be
> set. Because that is not checked the else statement is executed
> in the first run when tuning_count is zero.
>
> This was seen on a host controller which indicated
> SDHCI_TUNING_MODE_1 (0) and tuning_count being zero. Suspect
> that (one of) these registers is not properly set.
>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> This patch applies to the mmc-next branch.
>
> V2:
> - add more explanation to the commit message
> - check host flag SDHCI_USING_RETUNING_TIMER
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bd8a098..5974599 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2014,7 +2014,7 @@ out:
>                         host->tuning_count * HZ);
>                 /* Tuning mode 1 limits the maximum data length to 4MB */
>                 mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
> -       } else {
> +       } else if (host->flags & SDHCI_USING_RETUNING_TIMER) {
>                 host->flags &= ~SDHCI_NEEDS_RETUNING;
>                 /* Reload the new initial value for timer */
>                 if (host->tuning_mode == SDHCI_TUNING_MODE_1)

I wonder if we could also remove this line?
It looks to me it's not neccesary to check the tuning_mode again since
we already check the flag
above and SDHCI_TUNING_MODE_1 seems like the prerequisite of
SDHCI_USING_RETUNING_TIMER.

Regards
Dong Aisheng

> --
> 1.7.10.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
