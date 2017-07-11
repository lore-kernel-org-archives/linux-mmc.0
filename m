From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: remove unused sg_len variable
Date: Tue, 11 Jul 2017 16:44:40 +0200
Message-ID: <CAPDyKFoQKsc0dk+BPeDcajanpKe6CVyKsN9ScCC1T1JrGCji+Q@mail.gmail.com>
References: <1499330625-108840-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36467 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933184AbdGKOol (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:44:41 -0400
Received: by mail-qk0-f172.google.com with SMTP id p21so2653649qke.3
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:44:41 -0700 (PDT)
In-Reply-To: <1499330625-108840-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>

On 6 July 2017 at 10:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> We got a warning:
>
> drivers/mmc/host/atmel-mci.c:1086:15: warning: variable 'sg_len' set but
> not used [-Wunused-but-set-variable]
>
> Ideally we should check to see if sg_len is zero but looking
> into the code closely, I didn't find any possible to do that as
> atmci_start_request didn't even deploy any error handling for
> its host->prepare_data hook. So even we return error value for iflags
> like what other host drivers did, for instance, sdhci and dwmmc, it still
> need some extra work to improve the code.
>
> Just remove it to silent the warning, although it isn't perfect.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/atmel-mci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 97de2d3..53e30b0 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1083,7 +1083,6 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
>  atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
>  {
>         u32 iflags, tmp;
> -       unsigned int sg_len;
>         int i;
>
>         data->error = -EINPROGRESS;
> @@ -1108,8 +1107,8 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
>
>         /* Configure PDC */
>         host->data_size = data->blocks * data->blksz;
> -       sg_len = dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
> -                           mmc_get_dma_dir(data));
> +       dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
> +                  mmc_get_dma_dir(data));
>
>         if ((!host->caps.has_rwproof)
>             && (host->data->flags & MMC_DATA_WRITE)) {
> --
> 1.9.1
>
>
