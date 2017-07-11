From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: android-goldfish: remove logically dead code in goldfish_mmc_irq()
Date: Tue, 11 Jul 2017 16:43:18 +0200
Message-ID: <CAPDyKFrsvJjd4OP8u+tCmHj-tifUWibhV42HQ-9eGs1TiFmVdQ@mail.gmail.com>
References: <20170628135515.GA5462@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170628135515.GA5462@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 June 2017 at 15:55, Gustavo A. R. Silva <garsilva@embeddedor.com> wrote:
> Local variable transfer_error is assigned to a constant value and
> it is never updated again.
>
> Remove this variable and the dead code it guards.
>
> Addresses-Coverity-ID: 1222110
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/android-goldfish.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
> index 5b3e1c9..63fe509 100644
> --- a/drivers/mmc/host/android-goldfish.c
> +++ b/drivers/mmc/host/android-goldfish.c
> @@ -290,7 +290,6 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
>         u16 status;
>         int end_command = 0;
>         int end_transfer = 0;
> -       int transfer_error = 0;
>         int state_changed = 0;
>         int cmd_timeout = 0;
>
> @@ -322,9 +321,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
>         if (end_command)
>                 goldfish_mmc_cmd_done(host, host->cmd);
>
> -       if (transfer_error)
> -               goldfish_mmc_xfer_done(host, host->data);
> -       else if (end_transfer) {
> +       if (end_transfer) {
>                 host->dma_done = 1;
>                 goldfish_mmc_end_of_data(host, host->data);
>         } else if (host->data != NULL) {
> @@ -347,8 +344,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *dev_id)
>                 mmc_detect_change(host->mmc, 0);
>         }
>
> -       if (!end_command && !end_transfer &&
> -           !transfer_error && !state_changed && !cmd_timeout) {
> +       if (!end_command && !end_transfer && !state_changed && !cmd_timeout) {
>                 status = GOLDFISH_MMC_READ(host, MMC_INT_STATUS);
>                 dev_info(mmc_dev(host->mmc),"spurious irq 0x%04x\n", status);
>                 if (status != 0) {
> --
> 2.5.0
>
