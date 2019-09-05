From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
Date: Thu, 5 Sep 2019 16:47:40 -0700
Message-ID: <CAD=FV=UhA4pxui29k+SHygCYq+a3O8ELJCq7=6iVSUrnwvk8DQ@mail.gmail.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-6-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903142207.5825-6-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Matthias Kaehlcke <mka@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 3, 2019 at 7:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
> avoid reading the SDIO_CCCR_INTx register and instead immediately call the
> SDIO func's >irq_handler() callback.
>
> To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
> let's set the flag from inside sdio_signal_irq(), rather from
> sdio_run_irqs().

I'm having a hard time parsing the above statement...  Can you reword
and maybe I'll understand?


> Moreover, let's also reset the flag when the SDIO IRQ have
> been properly processed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Nice!  This looks like it addresses some of the things that came up in
the previous discussion [1] and should be a nice improvement.  From
re-reading that discussion that will probably change the behvaior
slightly (hopefully for the better) in the single-function case where
we might actually poll CCCR_INTx sometimes now.


> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index f75043266984..0962a4357d54 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>  {
>         struct mmc_card *card = host->card;
>         int i, ret, count;
> +       bool sdio_irq_pending = host->sdio_irq_pending;
>         unsigned char pending;
>         struct sdio_func *func;
>
> @@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
>         if (mmc_card_suspended(card))
>                 return 0;
>
> +       /* Clear the flag to indicate that we have processed the IRQ. */
> +       host->sdio_irq_pending = false;
> +
>         /*
>          * Optimization, if there is only 1 function interrupt registered
>          * and we know an IRQ was signaled then call irq handler directly.
>          * Otherwise do the full probe.
>          */
>         func = card->sdio_single_irq;
> -       if (func && host->sdio_irq_pending) {
> +       if (func && sdio_irq_pending) {
>                 func->irq_handler(func);
>                 return 1;
>         }
> @@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
>  {
>         mmc_claim_host(host);
>         if (host->sdio_irqs) {
> -               host->sdio_irq_pending = true;
>                 process_sdio_pending_irqs(host);
>                 if (host->ops->ack_sdio_irq)
>                         host->ops->ack_sdio_irq(host);
> @@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
>
>  void sdio_signal_irq(struct mmc_host *host)
>  {
> +       host->sdio_irq_pending = true;

Is this safe to do without claiming the host or any other type of
locking?  sdio_signal_irq() is called directly from the interrupt
handler on dw_mmc with no locks held at all.  Could we have races /
problems with weakly ordered memory?

Maybe I'm not understanding why this has to move.  It seems like it
would have been fine to leave this part in sdio_run_irqs() where it
was...


[1] https://lore.kernel.org/r/CAD=FV=XBVRsdiOD0vhgTvMXmqm=fzy9Bzd_x=E1TNPBsT_D-tQ@mail.gmail.com

-Doug

>         queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
>  }
>  EXPORT_SYMBOL_GPL(sdio_signal_irq);
> @@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
>                 if (ret)
>                         break;
>                 ret = process_sdio_pending_irqs(host);
> -               host->sdio_irq_pending = false;
>                 mmc_release_host(host);
>
>                 /*
> --
> 2.17.1
>
