From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: fix __mmc_switch timeout caused by preempt
Date: Fri, 27 Nov 2015 15:00:30 +0100
Message-ID: <CAPDyKFpLZn9t8ODE3_-6=QbaiC4Br+w98MDaqE3DTPmSRXw2xw@mail.gmail.com>
References: <1448588498-28652-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:36085 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbbK0OAb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Nov 2015 09:00:31 -0500
Received: by ykdr82 with SMTP id r82so118482118ykd.3
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2015 06:00:31 -0800 (PST)
In-Reply-To: <1448588498-28652-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Minda Chen <Minda.Chen@csr.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>

On 27 November 2015 at 02:41, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
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
>  drivers/mmc/core/mmc_ops.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 1f44426..371aa4b 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -489,6 +489,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         unsigned long timeout;
>         u32 status = 0;
>         bool use_r1b_resp = use_busy_signal;
> +       bool expired = false;
>
>         mmc_retune_hold(host);
>
> @@ -544,6 +545,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         /* Must check status to be sure of no errors. */
>         timeout = jiffies + msecs_to_jiffies(timeout_ms);
>         do {
> +               /*
> +                * Due to the possibility of being preempted after sending the
> +                * status command, check the expiration time first.
> +                */
> +               expired = time_after(jiffies, timeout);

The update of "expired" should have remained within the "if (send_status) {"

Please change that.

I realize that the entire __mmc_switch() function deserves a round of
re-factoring, as it's just too complicated to understand all what goes
on in here. That's another task though. :-)

> +
>                 if (send_status) {
>                         err = __mmc_send_status(card, &status, ignore_crc);
>                         if (err)
> @@ -565,12 +572,13 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 }
>
>                 /* Timeout if the device never leaves the program state. */
> -               if (time_after(jiffies, timeout)) {
> +               if (expired && R1_CURRENT_STATE(status) == R1_STATE_PRG) {
>                         pr_err("%s: Card stuck in programming state! %s\n",
>                                 mmc_hostname(host), __func__);
>                         err = -ETIMEDOUT;
>                         goto out;
>                 }
> +
>         } while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
>
>         err = mmc_switch_status_error(host, status);
> --
> 1.8.1.1.dirty
>

Kind regards
Uffe
