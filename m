From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 04/15] mmc: core: Check re-tuning before retrying
Date: Mon, 4 May 2015 15:30:59 +0200
Message-ID: <CAPDyKFqooH9AXbmGnA7ZBF+itpBpcgJqn3pWu+3PRJfzntOWZg@mail.gmail.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
	<1429531796-21987-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33912 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbbEDNa7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 09:30:59 -0400
Received: by qkgx75 with SMTP id x75so84587561qkg.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 May 2015 06:30:59 -0700 (PDT)
In-Reply-To: <1429531796-21987-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 20 April 2015 at 14:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Possibly a command is failing because re-tuning is needed.
> Use mmc_retune_recheck() to check re-tuning. At that point
> re-tuning is held, at least by the request, so
> mmc_retune_recheck() flags host->retune_now if the hold
> count is 1.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

This patch should probably be folded into patch3.

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a9936cb..08bf7e3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -434,6 +434,7 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
>                                                             host->areq);
>                                 break; /* return err */
>                         } else {
> +                               mmc_retune_recheck(host);
>                                 pr_info("%s: req failed (CMD%u): %d, retrying...\n",
>                                         mmc_hostname(host),
>                                         cmd->opcode, cmd->error);
> @@ -483,6 +484,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
>                     mmc_card_removed(host->card))
>                         break;
>
> +               mmc_retune_recheck(host);
> +
>                 pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
>                          mmc_hostname(host), cmd->opcode, cmd->error);
>                 cmd->retries--;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
