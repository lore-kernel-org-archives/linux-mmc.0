From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/2] mmc: core: Run handlers for pending SDIO interrupts
 on resume
Date: Thu, 29 Aug 2019 10:44:17 -0700
Message-ID: <CAD=FV=UhKCKzj7W+LGAGuzukCsOag1meHk4dW7=XQF21KeS_pg@mail.gmail.com>
References: <20190828214620.66003-1-mka@chromium.org> <20190828214620.66003-2-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828214620.66003-2-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Aug 28, 2019 at 2:46 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> With commit 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs
> when the card is suspended") SDIO interrupts are dropped if they
> occur while the card is suspended. Dropping the interrupts can cause
> problems after resume with cards that remain powered during suspend
> and preserve their state. These cards may end up in an inconsistent
> state since the event that triggered the interrupt is never processed
> and remains pending. One example is the Bluetooth function of the
> Marvell 8997, SDIO is broken on resume (for both Bluetooth and WiFi)
> when processing of a pending HCI event is skipped.
>
> For cards that remained powered during suspend check on resume if
> SDIO interrupts are pending, and trigger interrupt processing if
> needed.
>
> Fixes: 83293386bc95 ("mmc: core: Prevent processing SDIO IRQs when the card is suspended")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/mmc/core/sdio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 8dd8fc32ecca..a6b4742a91c6 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -975,6 +975,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
>  static int mmc_sdio_resume(struct mmc_host *host)
>  {
>         int err = 0;
> +       u8 pending = 0;
>
>         /* Basic card reinitialization. */
>         mmc_claim_host(host);
> @@ -1009,6 +1010,14 @@ static int mmc_sdio_resume(struct mmc_host *host)
>         /* Allow SDIO IRQs to be processed again. */
>         mmc_card_clr_suspended(host->card);
>
> +       if (!mmc_card_keep_power(host))
> +               goto skip_pending_irqs;
> +
> +       if (!sdio_get_pending_irqs(host, &pending) &&
> +           pending != 0)
> +               sdio_signal_irq(host);
> +
> +skip_pending_irqs:
>         if (host->sdio_irqs) {

nit: I'd prefer to avoid the "goto" if possible.  Using "goto" to
handle unwinding during error handling always makes good sent to me,
but here you're not doing unwinding--you're just using the "goto" as
an unstructured "if".  I'd rather just see:

  if (mmc_card_keep_power(host) &&
      !sdio_get_pending_irqs(host, &pending) && pending != 0)
          sdio_signal_irq(host);

Other than that this patch seems sane to me though (obviously) the
person you'd need to convince is Ulf.  ;-)

-Doug
