From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 13/13] mmc: mmci: Enable support for busy detection for
 ux500 variant
Date: Wed, 12 Feb 2014 14:20:05 +0100
Message-ID: <CAPDyKFpNToUSXSYuXnqPJ0_Thvx663gvsKAJSv2=0ibcPnFxFQ@mail.gmail.com>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
	<1391035085-2747-14-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:63589 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaBLNUG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2014 08:20:06 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so15314273qcx.35
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2014 05:20:05 -0800 (PST)
In-Reply-To: <1391035085-2747-14-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <jrudholm@gmail.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 29 January 2014 23:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The ux500 variants have HW busy detection support, which is indicated
> by the busy_detect flag. For these variants let's enable the
> MMC_CAP_WAIT_WHILE_BUSY flag and add the support for it.
>
> The mmc core will provide the RSP_BUSY command flag for those requests
> we should care about busy detection. Regarding the max_busy_timeout,
> the HW don't support busy detection timeouts so at this initial step
> let's make it simple and set it to zero to indicate we are able to
> support any timeout.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Johan Rudholm <jrudholm@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hi Russell,

Just wanted to know if you were happy with this patch.

I would prefer if we could let Chris carry this patch, since there are
a dependency. Are you fine with that?

Kind regards
Ulf Hansson


> ---
>  drivers/mmc/host/mmci.c |   51 +++++++++++++++++++++++++++++++++++++++--------
>  drivers/mmc/host/mmci.h |    2 ++
>  2 files changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1a4b153..9976a90 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -921,6 +921,29 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>  {
>         void __iomem *base = host->base;
>         bool sbc = (cmd == host->mrq->sbc);
> +       bool busy_resp = host->variant->busy_detect &&
> +                       (cmd->flags & MMC_RSP_BUSY);
> +
> +       /* Check if we need to wait for busy completion. */
> +       if (host->busy_status && (status & MCI_ST_CARDBUSY))
> +               return;
> +
> +       /* Enable busy completion if needed and supported. */
> +       if (!host->busy_status && busy_resp &&
> +               !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
> +               (readl(base + MMCISTATUS) & MCI_ST_CARDBUSY)) {
> +               writel(readl(base + MMCIMASK0) | MCI_ST_BUSYEND,
> +                       base + MMCIMASK0);
> +               host->busy_status = status & (MCI_CMDSENT|MCI_CMDRESPEND);
> +               return;
> +       }
> +
> +       /* At busy completion, mask the IRQ and complete the request. */
> +       if (host->busy_status) {
> +               writel(readl(base + MMCIMASK0) & ~MCI_ST_BUSYEND,
> +                       base + MMCIMASK0);
> +               host->busy_status = 0;
> +       }
>
>         host->cmd = NULL;
>
> @@ -1139,14 +1162,19 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                         status &= ~MCI_IRQ1MASK;
>                 }
>
> +               /*
> +                * We intentionally clear the MCI_ST_CARDBUSY IRQ here (if it's
> +                * enabled) since the HW seems to be triggering the IRQ on both
> +                * edges while monitoring DAT0 for busy completion.
> +                */
>                 status &= readl(host->base + MMCIMASK0);
>                 writel(status, host->base + MMCICLEAR);
>
>                 dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
>
>                 cmd = host->cmd;
> -               if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|
> -                             MCI_CMDRESPEND) && cmd)
> +               if ((status|host->busy_status) & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|
> +                       MCI_CMDSENT|MCI_CMDRESPEND) && cmd)
>                         mmci_cmd_irq(host, cmd, status);
>
>                 data = host->data;
> @@ -1155,6 +1183,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>                               MCI_DATABLOCKEND) && data)
>                         mmci_data_irq(host, data, status);
>
> +               /* Don't poll for busy completion in irq context. */
> +               if (host->busy_status)
> +                       status &= ~MCI_ST_CARDBUSY;
> +
>                 ret = 1;
>         } while (status);
>
> @@ -1504,12 +1536,6 @@ static int mmci_probe(struct amba_device *dev,
>                 goto clk_disable;
>         }
>
> -       if (variant->busy_detect) {
> -               mmci_ops.card_busy = mmci_card_busy;
> -               mmci_write_datactrlreg(host, MCI_ST_DPSM_BUSYMODE);
> -       }
> -
> -       mmc->ops = &mmci_ops;
>         /*
>          * The ARM and ST versions of the block have slightly different
>          * clock divider equations which means that the minimum divider
> @@ -1543,6 +1569,15 @@ static int mmci_probe(struct amba_device *dev,
>         mmc->caps = plat->capabilities;
>         mmc->caps2 = plat->capabilities2;
>
> +       if (variant->busy_detect) {
> +               mmci_ops.card_busy = mmci_card_busy;
> +               mmci_write_datactrlreg(host, MCI_ST_DPSM_BUSYMODE);
> +               mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
> +               mmc->max_busy_timeout = 0;
> +       }
> +
> +       mmc->ops = &mmci_ops;
> +
>         /* We support these PM capabilities. */
>         mmc->pm_caps = MMC_PM_KEEP_POWER;
>
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index 168bc72..b008ace 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -139,6 +139,7 @@
>  /* Extended status bits for the ST Micro variants */
>  #define MCI_ST_SDIOITMASK      (1 << 22)
>  #define MCI_ST_CEATAENDMASK    (1 << 23)
> +#define MCI_ST_BUSYEND         (1 << 24)
>
>  #define MMCIMASK1              0x040
>  #define MMCIFIFOCNT            0x048
> @@ -186,6 +187,7 @@ struct mmci_host {
>         u32                     pwr_reg;
>         u32                     clk_reg;
>         u32                     datactrl_reg;
> +       u32                     busy_status;
>         bool                    vqmmc_enabled;
>         struct mmci_platform_data *plat;
>         struct variant_data     *variant;
> --
> 1.7.9.5
>
