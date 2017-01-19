From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC] mmc: mxs-mmc: Implement CMD23 support
Date: Thu, 19 Jan 2017 12:46:50 +0100
Message-ID: <CAPDyKFp8ooKfMBYj_fDmpvSeg1ANNRHRudTOtaTzYhSXA7t3gA@mail.gmail.com>
References: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35226 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdASLqx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 06:46:53 -0500
Received: by mail-wm0-f41.google.com with SMTP id r126so285968169wmr.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 03:46:53 -0800 (PST)
In-Reply-To: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: =?UTF-8?B?SsO2cmcgS3JhdXNl?= <joerg.krause@embedded.rocks>, Marek Vasut <marex@denx.de>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <lw@karo-electronics.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 14 January 2017 at 18:29, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch implements support for multiblock transfers bounded
> by SET_BLOCK_COUNT (CMD23) on the MXS MMC host driver.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mxs-mmc.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index c8b8ac6..add1e70 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -153,7 +153,11 @@ static void mxs_mmc_request_done(struct mxs_mmc_host *host)
>                 }
>         }
>
> -       if (data) {
> +       if (cmd == mrq->sbc) {
> +               /* Finished CMD23, now send actual command. */
> +               mxs_mmc_start_cmd(host, mrq->cmd);
> +               return;
> +       } else if (data) {
>                 dma_unmap_sg(mmc_dev(host->mmc), data->sg,
>                              data->sg_len, ssp->dma_dir);
>                 /*
> @@ -166,7 +170,7 @@ static void mxs_mmc_request_done(struct mxs_mmc_host *host)
>                         data->bytes_xfered = 0;
>
>                 host->data = NULL;
> -               if (mrq->stop) {
> +               if (data->stop && (data->error || !mrq->sbc)) {
>                         mxs_mmc_start_cmd(host, mrq->stop);
>                         return;
>                 }
> @@ -495,7 +499,11 @@ static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>         WARN_ON(host->mrq != NULL);
>         host->mrq = mrq;
> -       mxs_mmc_start_cmd(host, mrq->cmd);
> +
> +       if (mrq->sbc)
> +               mxs_mmc_start_cmd(host, mrq->sbc);
> +       else
> +               mxs_mmc_start_cmd(host, mrq->cmd);
>  }
>
>  static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> @@ -642,7 +650,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>         /* set mmc core parameters */
>         mmc->ops = &mxs_mmc_ops;
>         mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
> -                   MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL;
> +                   MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23;
>
>         host->broken_cd = of_property_read_bool(np, "broken-cd");
>
> --
> 1.7.9.5
>
