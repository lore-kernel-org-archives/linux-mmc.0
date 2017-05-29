From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: bcm2835: fix potential null pointer dereferences
Date: Mon, 29 May 2017 16:42:45 +0200
Message-ID: <CAPDyKFo2+YL=nk=SmTKG1gPwVPWaOTth++1WUqRXL2+meZ72pg@mail.gmail.com>
References: <20170525114638.Horde.wq7PLKWCg8CwLM5WiWj1Obm@gator4166.hostgator.com>
 <20170525170455.GA6904@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170525170455.GA6904@embeddedgus>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 25 May 2017 at 19:04, Gustavo A. R. Silva <garsilva@embeddedor.com> wrote:
> Null check at line 1165: if (mrq->cmd), implies that mrq->cmd might
> be NULL.
> Add null checks before dereferencing pointer mrq->cmd in order to avoid
> any potential NULL pointer dereference.
>
> Addresses-Coverity-ID: 1408740
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Changes in v2:
>  Change subject to make it clear the patch is bcm2835 related.
>
>  drivers/mmc/host/bcm2835.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 1f343a4..abba9a2 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1172,7 +1172,10 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
>                 dev_err(dev, "unsupported block size (%d bytes)\n",
>                         mrq->data->blksz);
> -               mrq->cmd->error = -EINVAL;
> +
> +               if (mrq->cmd)
> +                       mrq->cmd->error = -EINVAL;
> +
>                 mmc_request_done(mmc, mrq);
>                 return;
>         }
> @@ -1194,7 +1197,10 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                         readl(host->ioaddr + SDCMD) & SDCMD_CMD_MASK,
>                         edm);
>                 bcm2835_dumpregs(host);
> -               mrq->cmd->error = -EILSEQ;
> +
> +               if (mrq->cmd)
> +                       mrq->cmd->error = -EILSEQ;
> +
>                 bcm2835_finish_request(host);
>                 mutex_unlock(&host->mutex);
>                 return;
> @@ -1207,7 +1213,7 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                         if (!host->use_busy)
>                                 bcm2835_finish_command(host);
>                 }
> -       } else if (bcm2835_send_command(host, mrq->cmd)) {
> +       } else if (mrq->cmd && bcm2835_send_command(host, mrq->cmd)) {
>                 if (host->data && host->dma_desc) {
>                         /* DMA transfer starts now, PIO starts after irq */
>                         bcm2835_start_dma(host);
> --
> 2.5.0
>
