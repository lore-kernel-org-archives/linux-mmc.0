From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v2 2/2] mmc: core: fall back host->f_init if
 failing to init mmc card after resume
Date: Wed, 14 Sep 2016 11:18:15 +0200
Message-ID: <CAPDyKFpFeiBL3av9sFK2ah-_kGCdsDTZb275HjRbryFX9GRhcQ@mail.gmail.com>
References: <1473817868-27812-1-git-send-email-shawn.lin@rock-chips.com> <1473817868-27812-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38609 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbcINJSR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2016 05:18:17 -0400
Received: by mail-wm0-f45.google.com with SMTP id 1so18302375wmz.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Sep 2016 02:18:17 -0700 (PDT)
In-Reply-To: <1473817868-27812-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 14 September 2016 at 03:51, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> We observed the failure of initializing card after resume
> accidentally. It's hard to reproduce but we did get report from
> the suspend/resume test of our RK3399 mp test farm . Unfortunately,
> we still fail to figure out what was going wrong at that time.
> Also we can't achieve it by retrying the host->f_init without
> falling back it. But this patch will solve the problem as we could
> add some log there and see that we resume the mmc card successfully
> after falling back the host->f_init.
>
> I believe this is not a specific case for any host controllers as
> it's possible the f_init used for this time may fail to init the
> mmc for the next booting due to some unexpected signal interference
> ,etc. Given that, the fallback for host->f_init when booting improve
> the robustness. So this should be also beneficial to the resume case,
> not just for sloving one specific issue.

No, this becomes too much of hypothetical guesses. I don't like it, sorry!

Let me elaborate on why, by browsing my comments below.

>
> [   93.405085] mmc1: unexpected status 0x800900 after switch
> [   93.408474] mmc1: switch to bus width 1 failed
> [   93.408482] mmc1: mmc_select_hs200 failed, error -110
> [   93.408492] mmc1: error -110 during resume (card was removed?)
> [   93.408705] PM: resume of devices complete after 213.453 msecs
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> ---
>
> Changes in v2:
> - remove mmc_power_off
> - take f_min into consideration
>
>  drivers/mmc/core/mmc.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3486bc7..06bebc1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1963,6 +1963,7 @@ static int mmc_suspend(struct mmc_host *host)
>  static int _mmc_resume(struct mmc_host *host)
>  {
>         int err = 0;
> +       int i;
>
>         BUG_ON(!host);
>         BUG_ON(!host->card);
> @@ -1972,8 +1973,22 @@ static int _mmc_resume(struct mmc_host *host)
>         if (!mmc_card_suspended(host->card))
>                 goto out;
>
> -       mmc_power_up(host, host->card->ocr);
> -       err = mmc_init_card(host, host->card->ocr, host->card);
> +       /*
> +        * Let's try to fallback the host->f_init
> +        * if failing to init mmc card after resume.
> +        */
> +       for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> +               if (host->f_init < max(freqs[i], host->f_min))
> +                       continue;

Let's consider the following scenario:
host->f_min = 100kHz and host->f_init = 400kHz. Which means earlier
from mmc_rescan() when we first detected the card, we succeeded using
400kHz.

I assume that would be somewhat similar to your use-case, right?

In this example, we will hit the else clause and try to re-initialize
the card using 400 kHz...

> +               else
> +                       host->f_init = max(freqs[i], host->f_min);
> +
> +               mmc_power_up(host, host->card->ocr);

According to your description in the change log, I guess what you
experienced is that the first re-initialization attempt by using 400
kHz fails. That's why you want try out 300 kHz in the next loop
instead, right!?

Unfortunate, this doesn't work, as in mmc_power_up() we bail out
early, see pasted code snippet below.
-----
if (host->ios.power_mode == MMC_POWER_ON)
                return;
-----

So this change is actually completely wrong, as you will try to
re-initialize the with card in the second attempt with a totally
messed up ios setting created in the earlier attempt. It just can't
work.

> +               err = mmc_init_card(host, host->card->ocr, host->card);
> +               if (!err)
> +                       break;
> +       }
> +
>         mmc_card_clr_suspended(host->card);

So I was thinking a bit if we really need to achieve a more "robust" resume...

I think the only option would be to call mmc_reset() when we notice
that mmc_init_card() fails. I don't think we should need to change
host->f_init.

Moreover we should likely also check for MMC_CAP_NONREMOVABLE, as it's
only in those cases when a reset makes sense.

Now, if we intend to do this for mmc, we should do it for SD and SDIO as well.

Kind regards
Uffe
