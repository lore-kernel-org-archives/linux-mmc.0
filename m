From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 07/10] mmc: omap_hsmmc: consolidate flush posted writes
 for HSMMC IRQs
Date: Tue, 21 Aug 2012 20:51:41 +0530
Message-ID: <CANrkHUZLHO4nPvd37AaO43F37uCKB1LnsRxBOia5R3osF1ONvw@mail.gmail.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
	<1345229550-8672-8-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1345229550-8672-8-git-send-email-svenkatr@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org

On Sat, Aug 18, 2012 at 12:22 AM, Venkatraman S <svenkatr@ti.com> wrote:
> Flushing spurious IRQs from HSMMC IP is done twice in
> omap_hsmmc_irq and omap_hsmmc_do_irq.

spurious IRQ is flushed in start of omap_hsmmc_do_irq
and irq acked at the end of omap_hsmmc_do_irq

> Consolidate them to one location.

if you wanted to consolidated ...

>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4bc55ac..20453c8 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -969,15 +969,6 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>         struct mmc_data *data;
>         int end_cmd = 0, end_trans = 0;
>
> -       if (!host->req_in_progress) {

just do a return from here

> -               do {
> -                       OMAP_HSMMC_WRITE(host->base, STAT, status);
> -                       /* Flush posted write */
> -                       status = OMAP_HSMMC_READ(host->base, STAT);
> -               } while (status & INT_EN_MASK);
> -               return;
> -       }
> -
>         data = host->data;
>         dev_vdbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>
> @@ -1028,8 +1019,6 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>                 }
>         }
>
> -       OMAP_HSMMC_WRITE(host->base, STAT, status);
> -
>         if (end_cmd || ((status & CC) && host->cmd))
>                 omap_hsmmc_cmd_done(host, host->cmd);
>         if ((end_trans || (status & TC)) && host->mrq)
> @@ -1045,11 +1034,13 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
>         int status;
>
>         status = OMAP_HSMMC_READ(host->base, STAT);
> -       do {
> +       while (status & INT_EN_MASK && host->req_in_progress) {

and remove the check for host->req_in_progress
I think do while loop can be retained as it will get executed once anyway.

>                 omap_hsmmc_do_irq(host, status);
> +

>                 /* Flush posted write */

comment is misplaced

> +               OMAP_HSMMC_WRITE(host->base, STAT, status);
>                 status = OMAP_HSMMC_READ(host->base, STAT);
> -       } while (status & INT_EN_MASK);
> +       }
>
>         return IRQ_HANDLED;
>  }
> --
> 1.7.11.1.25.g0e18bef
>
