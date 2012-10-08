From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: enable controller interrupt before calling mmc_start_host
Date: Mon, 8 Oct 2012 21:55:46 +0900
Message-ID: <CAGxe1ZFiqM-9Z1M8XZsG_=GHhGOu-jYgRicKaJ6OmLn5PVZkhQ@mail.gmail.com>
References: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58163 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab2JHMzr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Oct 2012 08:55:47 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so4110911vbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Oct 2012 05:55:46 -0700 (PDT)
In-Reply-To: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj CD <yuvaraj.cd@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, will.newton@imgtec.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, patches@linaro.org, Yuvaraj CD <yuvaraj.cd@samsung.com>

On 8 October 2012 17:59, Yuvaraj CD <yuvaraj.cd@gmail.com> wrote:
> As mmc_start_host is getting called before enabling the dw_mmc controller
> interrupt, there is a problem of missing the SDMMC_INT_CMD_DONE for the
> very first command sent by the sdio_reset.
> This problem occurs only when we disable MMC debugging i.e, MMC_DEBUG [=n].
> Hence this patch enables the dw_mmc controller interrupt before mmc_start_host.
>
> Signed-off-by: Yuvaraj CD <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a23af77..729c031 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2233,6 +2233,21 @@ int dw_mci_probe(struct dw_mci *host)
>         else
>                 host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
>
> +       /*
> +        * Enable interrupts for command done, data over, data empty, card det,
> +        * receive ready and error such as transmit, receive timeout, crc error
> +        */
> +       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +       mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> +                  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> +                  DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> +       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
> +
> +       dev_info(host->dev, "DW MMC controller at irq %d, "
> +                "%d bit host data width, "
> +                "%u deep fifo\n",
> +                host->irq, width, fifo_size);
> +
Makes sense
Reviewed By: Girish K S <girish.shivananjappa@linaro.org>
>         /* We need at least one slot to succeed */
>         for (i = 0; i < host->num_slots; i++) {
>                 ret = dw_mci_init_slot(host, i);
> @@ -2262,20 +2277,6 @@ int dw_mci_probe(struct dw_mci *host)
>         else
>                 host->data_offset = DATA_240A_OFFSET;
>
> -       /*
> -        * Enable interrupts for command done, data over, data empty, card det,
> -        * receive ready and error such as transmit, receive timeout, crc error
> -        */
> -       mci_writel(host, RINTSTS, 0xFFFFFFFF);
> -       mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
> -                  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> -                  DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
> -       mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
> -
> -       dev_info(host->dev, "DW MMC controller at irq %d, "
> -                "%d bit host data width, "
> -                "%u deep fifo\n",
> -                host->irq, width, fifo_size);
>         if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)
>                 dev_info(host->dev, "Internal DMAC interrupt fix enabled.\n");
>
> --
> 1.7.9.5
>
