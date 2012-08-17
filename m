From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] omap-hsmmc: Implementation of i761 errata
Date: Fri, 17 Aug 2012 22:58:34 +0530
Message-ID: <CANfBPZ9NqZGN1LPNu+5DVWdkut2AL3O_8TWtWhBTufpdRZYZ_Q@mail.gmail.com>
References: <1345219546-6646-1-git-send-email-semen.protsenko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:33214 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758086Ab2HQR24 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Aug 2012 13:28:56 -0400
Received: by pbbrp8 with SMTP id rp8so3655665pbb.29
        for <linux-mmc@vger.kernel.org>; Fri, 17 Aug 2012 10:28:54 -0700 (PDT)
In-Reply-To: <1345219546-6646-1-git-send-email-semen.protsenko@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Semen Protsenko <semen.protsenko@ti.com>
Cc: linux-omap@vger.kernel.org, Volodymyr Ryazantsev <x0153367@ti.com>, Viswanath Puttagunta <vishp@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>

On Fri, Aug 17, 2012 at 9:35 PM, Semen Protsenko <semen.protsenko@ti.com> wrote:
> Errata description:
> Due to a bad behavior of an internal signal, the Card Error interrupt bit
> MMCHS_STAT[28] CERR may not be set sometimes when an error occurred in the
> card response.
>
> Workaround:
> After responses of type R1/R1b for all cards and responses of type R5/R5b/R6
> for SD and SDIO cards, software must read two registers: MMCHS_RSP10 and
> MMCHS_CSRE. When a MMCHS_CSRE[i] bit is set to 1, if the corresponding bit at
> the same position in the response MMCHS_RSP10[i] is set to 1, the host
> controller indicates a card error and software should proceed in the same way
> as if a CERR interrupt would have been detected in the MMCHS_STAT register.
>
> Note:
> This errata is applicable for omap44xx.
>
> Signed-off-by: Semen Protsenko <semen.protsenko@ti.com>

The implementation looks fine, but can we simply not set the errata
flag and make this as default
behaviour ? I suppose the documented behaviour with CSRE and RSP10 is
independent of the
errata..

Also, please send it to the linux-mmc list as well.

> ---
>  drivers/mmc/host/omap_hsmmc.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 3a09f93..17803de 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -34,6 +34,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/mmc.h>
> +#include <linux/mmc/card.h>
>  #include <linux/io.h>
>  #include <linux/semaphore.h>
>  #include <linux/gpio.h>
> @@ -47,6 +48,7 @@
>  /* OMAP HSMMC Host Controller Registers */
>  #define OMAP_HSMMC_SYSCONFIG   0x0010
>  #define OMAP_HSMMC_SYSSTATUS   0x0014
> +#define OMAP_HSMMC_CSRE                0x0024
>  #define OMAP_HSMMC_CON         0x002C
>  #define OMAP_HSMMC_BLK         0x0104
>  #define OMAP_HSMMC_ARG         0x0108
> @@ -117,6 +119,9 @@
>  #define OMAP_MMC_MAX_CLOCK     52000000
>  #define DRIVER_NAME            "omap_hsmmc"
>
> +/* Errata definitions */
> +#define OMAP_HSMMC_ERRATA_I761 BIT(0)
> +
>  /*
>   * One controller can have multiple slots, like on some omap boards using
>   * omap.c controller driver. Luckily this is not currently done on any known
> @@ -177,6 +182,7 @@ struct omap_hsmmc_host {
>         int                     reqs_blocked;
>         int                     use_reg;
>         int                     req_in_progress;
> +       unsigned int            errata;
>         struct omap_hsmmc_next  next_data;
>
>         struct  omap_mmc_platform_data  *pdata;
> @@ -857,6 +863,23 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
>         omap_hsmmc_start_command(host, data->stop, NULL);
>  }
>
> +static int
> +omap_hsmmc_errata_i761(struct omap_hsmmc_host *host, struct mmc_command *cmd)
> +{
> +       u32 rsp10, csre;
> +
> +       if ((cmd->flags & MMC_RSP_R1) == MMC_RSP_R1
> +                       || (host->mmc->card && (mmc_card_sd(host->mmc->card)
> +                       || mmc_card_sdio(host->mmc->card))
> +                       && (cmd->flags & MMC_RSP_R5))) {
> +               rsp10 = OMAP_HSMMC_READ(host->base, RSP10);
> +               csre = OMAP_HSMMC_READ(host->base, CSRE);
> +               return rsp10 & csre;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Notify the core about command completion
>   */
> @@ -1046,6 +1069,17 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
>                 }
>         }
>
> +       /* Errata i761 */
> +       if ((host->errata & OMAP_HSMMC_ERRATA_I761) && host->cmd
> +                       && omap_hsmmc_errata_i761(host, host->cmd)) {
> +               /* Do the same as for CARD_ERR case */
> +               dev_dbg(mmc_dev(host->mmc), "Ignoring card err CMD%d\n",
> +                               host->cmd->opcode);
> +               end_cmd = 1;
> +               if (host->data)
> +                       end_trans = 1;
> +       }
> +
>         OMAP_HSMMC_WRITE(host->base, STAT, status);
>
>         if (end_cmd || ((status & CC) && host->cmd))
> @@ -1829,6 +1863,10 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
>         host->power_mode = MMC_POWER_OFF;
>         host->next_data.cookie = 1;
>
> +       host->errata = 0;
> +       if (cpu_is_omap44xx())
> +               host->errata |= OMAP_HSMMC_ERRATA_I761;
> +
>         platform_set_drvdata(pdev, host);
>
>         mmc->ops        = &omap_hsmmc_ops;
> --
> 1.7.10.4
>
