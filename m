From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: amend using error interrupt status
Date: Wed, 1 Aug 2012 09:57:28 +0530
Message-ID: <CAGxe1ZH=NZ5ZC3SVjaxwoXa_5dZEQzCAzYxK40Sy2rYr4dCpBA@mail.gmail.com>
References: <006301cd6f7c$db537500$91fa5f00$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:61511 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2HAE13 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Aug 2012 00:27:29 -0400
Received: by vbbff1 with SMTP id ff1so6575244vbb.19
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jul 2012 21:27:28 -0700 (PDT)
In-Reply-To: <006301cd6f7c$db537500$91fa5f00$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>

On 1 August 2012 06:00, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> RINTSTS status includes masked interrupts as well as unmasked.
> data_status and cmd_status are set by value of RINTSTS in interrupt handler
> and tasklet finally uses it to decide whether error is happened or not.
> In addition, MINTSTS status is used for setting data_status in PIO.
> Masked error interrupt will not be handled and that status can be considered
> non-error case.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 72dc3cd..7baed45 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1547,12 +1547,11 @@ static void dw_mci_cmd_interrupt(struct dw_mci *host, u32 status)
>  static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  {
>         struct dw_mci *host = dev_id;
> -       u32 status, pending;
> +       u32 pending;
>         unsigned int pass_count = 0;
>         int i;
>
>         do {
> -               status = mci_readl(host, RINTSTS);
>                 pending = mci_readl(host, MINTSTS); /* read-only mask reg */
>
>                 /*
> @@ -1570,7 +1569,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>
>                 if (pending & DW_MCI_CMD_ERROR_FLAGS) {
>                         mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
> -                       host->cmd_status = status;
> +                       host->cmd_status = pending;
>                         smp_wmb();
>                         set_bit(EVENT_CMD_COMPLETE, &host->pending_events);
>                 }
> @@ -1578,7 +1577,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
>                         /* if there is an error report DATA_ERROR */
>                         mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
> -                       host->data_status = status;
> +                       host->data_status = pending;
>                         smp_wmb();
>                         set_bit(EVENT_DATA_ERROR, &host->pending_events);
>                         if (!(pending & (SDMMC_INT_DTO | SDMMC_INT_DCRC |
> @@ -1589,7 +1588,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>                 if (pending & SDMMC_INT_DATA_OVER) {
>                         mci_writel(host, RINTSTS, SDMMC_INT_DATA_OVER);
>                         if (!host->data_status)
> -                               host->data_status = status;
> +                               host->data_status = pending;
>                         smp_wmb();
>                         if (host->dir_status == DW_MCI_RECV_STATUS) {
>                                 if (host->sg != NULL)
> @@ -1613,7 +1612,7 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>
>                 if (pending & SDMMC_INT_CMD_DONE) {
>                         mci_writel(host, RINTSTS, SDMMC_INT_CMD_DONE);
> -                       dw_mci_cmd_interrupt(host, status);
> +                       dw_mci_cmd_interrupt(host, pending);
>                 }
>
>                 if (pending & SDMMC_INT_CD) {
> --
Looks good to me
Reviewed By:- Girish K S <girish.shivananjappa@linaro.org>

> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
