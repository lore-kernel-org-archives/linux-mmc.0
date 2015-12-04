From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: core: fix __mmc_switch timeout caused by preempt
Date: Fri, 4 Dec 2015 15:56:30 +0100
Message-ID: <CAPDyKFqzekCOna5LUBNJRLQ-+7ryO57_B6=7ne3a9Vj6axF=yw@mail.gmail.com>
References: <1448846850-14585-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448846850-14585-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Stephen Boyd <sboyd@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Minda Chen <Minda.Chen@csr.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On 30 November 2015 at 02:27, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
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

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc_ops.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 1f44426..2c90635 100644
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
> @@ -545,6 +546,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         timeout = jiffies + msecs_to_jiffies(timeout_ms);
>         do {
>                 if (send_status) {
> +                       /*
> +                        * Due to the possibility of being preempted after
> +                        * sending the status command, check the expiration
> +                        * time first.
> +                        */
> +                       expired = time_after(jiffies, timeout);
>                         err = __mmc_send_status(card, &status, ignore_crc);
>                         if (err)
>                                 goto out;
> @@ -565,7 +572,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 }
>
>                 /* Timeout if the device never leaves the program state. */
> -               if (time_after(jiffies, timeout)) {
> +               if (expired && R1_CURRENT_STATE(status) == R1_STATE_PRG) {
>                         pr_err("%s: Card stuck in programming state! %s\n",
>                                 mmc_hostname(host), __func__);
>                         err = -ETIMEDOUT;
> --
> 1.8.1.1.dirty
>
