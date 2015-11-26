From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: core: fix __mmc_switch timeout caused by preempt
Date: Thu, 26 Nov 2015 12:56:08 +0100
Message-ID: <CAPDyKFqWnZV6qaXb-mwXW-V=m0bJbi5+unJxPSTpkdT=coXZ3A@mail.gmail.com>
References: <1448506309-18163-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1448506309-18163-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Minda Chen <Minda.Chen-kQvG35nSl+M@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 26 November 2015 at 03:51, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> there is a time window between __mmc_send_status() and time_afer(),
> on some eMMC chip, the timeout_ms is only 10ms, if this thread was
> scheduled out during this period, then, even card has already changes
> to transfer state by the result of CMD13, this part of code also treat
> it to timeout error.
> So, need calculate timeout first, then call __mmc_send_status(), if
> already timeout and card still in programing state, then treat it to
> the real timeout error.
>
> Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/mmc/core/mmc_ops.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 1f44426..0add634 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -489,6 +489,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         unsigned long timeout;
>         u32 status = 0;
>         bool use_r1b_resp = use_busy_signal;
> +       bool expired = false;

No need to assign an initial value.

>
>         mmc_retune_hold(host);
>
> @@ -544,10 +545,22 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         /* Must check status to be sure of no errors. */
>         timeout = jiffies + msecs_to_jiffies(timeout_ms);
>         do {
> +               /* Timeout if the device never leaves the program state.

Please start mutli-row comment with an empty line.

> +                * must check it firstly to avoid problem caused by preempt.

Please rephrase this to:

Due to the possibility of being preempted after sending the status
command, check the expiration time first.

> +                */
> +               expired = time_after(jiffies, timeout);

I think we can move this inside the below "if (send_status) {"
.. but of course before sending the status command.

> +
>                 if (send_status) {
>                         err = __mmc_send_status(card, &status, ignore_crc);
> -                       if (err)
> +                       if (err) {
>                                 goto out;
> +                       } else if (expired &&

You may use a new "if" statement instead of an "else if", due to the
above "goto out".

> +                                  R1_CURRENT_STATE(status) == R1_STATE_PRG) {
> +                               pr_err("%s: Card stuck in programming state! %s\n",
> +                                      mmc_hostname(host), __func__);
> +                               err = -ETIMEDOUT;
> +                               goto out;
> +                       }
>                 }
>                 if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
>                         break;
> @@ -563,14 +576,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
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
