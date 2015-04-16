From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 07/15] mmc: core: Hold re-tuning while bkops ongoing
Date: Thu, 16 Apr 2015 11:27:52 +0200
Message-ID: <CAPDyKFp0266csi73LPMenigqu+tf1V_yMD6F+sqYy8noaSUKxw@mail.gmail.com>
References: <1429017146-15981-1-git-send-email-adrian.hunter@intel.com>
	<1429017146-15981-8-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:36353 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbbDPJ1x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 05:27:53 -0400
Received: by qcpm10 with SMTP id m10so2917689qcp.3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2015 02:27:52 -0700 (PDT)
In-Reply-To: <1429017146-15981-8-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 14 April 2015 at 15:12, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hold re-tuning during bkops to prevent
> it from conflicting with the busy state.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index dbd7a77..4a42174 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -316,6 +316,8 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>         } else {
>                 timeout = 0;
>                 use_busy_signal = false;
> +               /* Hold re-tuning for ongoing bkops */
> +               mmc_retune_hold(card->host);
>         }

I would rather change the behaviour to always hold re-tune, no matter
of "use_busy_signal".
Then don't release re-tune if it's an ongoing BKOPS.

I do understand the hold/release you added in __mmc_switch() will
cover this, but I think this code becomes more clear if you change to
my proposal.

>
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -324,6 +326,9 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>         if (err) {
>                 pr_warn("%s: Error %d starting bkops\n",
>                         mmc_hostname(card->host), err);
> +               /* bkops not ongoing, so release re-tuning */
> +               if (!use_busy_signal)
> +                       mmc_retune_release(card->host);
>                 goto out;
>         }
>
> @@ -749,6 +754,7 @@ int mmc_stop_bkops(struct mmc_card *card)
>          */
>         if (!err || (err == -EINVAL)) {
>                 mmc_card_clr_doing_bkops(card);
> +               mmc_retune_release(card->host);
>                 err = 0;
>         }
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Kind regards
Uffe
