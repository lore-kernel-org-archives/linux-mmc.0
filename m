From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: fix __mmc_switch timeout caused by preempt
Date: Thu, 26 Nov 2015 22:17:41 +0100
Message-ID: <CAPDyKFoDARsM=oNp+HJYdxjLT06UsLePHQbjQ6FKbOWShgUoQA@mail.gmail.com>
References: <1448541369-23086-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:32911 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbbKZVRm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Nov 2015 16:17:42 -0500
Received: by ykdv3 with SMTP id v3so100224777ykd.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2015 13:17:41 -0800 (PST)
In-Reply-To: <1448541369-23086-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Minda Chen <Minda.Chen@csr.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>

On 26 November 2015 at 13:36, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> there is a time window between __mmc_send_status() and time_afer(),
> on some eMMC chip, the timeout_ms is only 10ms, if this thread was
> scheduled out during this period, then, even card has already changes
> to transfer state by the result of CMD13, this part of code also treat
> it to timeout error.
> So, need calculate timeout first, then call __mmc_send_status(), if
> already timeout and card still in programing state, then treat it to
> the real timeout error.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 1f44426..eba5295 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -489,6 +489,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         unsigned long timeout;
>         u32 status = 0;
>         bool use_r1b_resp = use_busy_signal;
> +       bool expired;
>
>         mmc_retune_hold(host);
>
> @@ -545,9 +546,23 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         timeout = jiffies + msecs_to_jiffies(timeout_ms);
>         do {
>                 if (send_status) {
> +                       /*
> +                        * Timeout if the device never leaves the program state.
> +                        * Due to the possibility of being preempted after
> +                        * sending the status command, check the expiration
> +                        * time first.
> +                        */
> +                       expired = time_after(jiffies, timeout);
>                         err = __mmc_send_status(card, &status, ignore_crc);
>                         if (err)
>                                 goto out;
> +                       if (expired &&
> +                           R1_CURRENT_STATE(status) == R1_STATE_PRG) {
> +                               pr_err("%s: Card stuck in programming state! %s\n",
> +                                      mmc_hostname(host), __func__);
> +                               err = -ETIMEDOUT;
> +                               goto out;
> +                       }

This "if" actually means we will start verifying the card state, even
when "MMC_CAP_WAIT_WHILE_BUSY && use_r1b_resp". I don't think we need
or should.

Instead let's move this code at its original place below. That also
means you indeed need to assign an initial value for "expired" to
"false" in the beginning of the function.

Apologize for not spotting this change in behaviour in v1.

>                 }
>                 if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
>                         break;
> @@ -563,14 +578,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                         mmc_delay(timeout_ms);
>                         goto out;
>                 }
> -
> -               /* Timeout if the device never leaves the program state. */
> -               if (time_after(jiffies, timeout)) {
> -                       pr_err("%s: Card stuck in programming state! %s\n",
> -                               mmc_hostname(host), __func__);
> -                       err = -ETIMEDOUT;
> -                       goto out;
> -               }
>         } while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
>
>         err = mmc_switch_status_error(host, status);
> --
> 1.8.1.1.dirty
>

Kind regards
Uffe
