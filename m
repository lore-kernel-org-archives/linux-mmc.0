From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 5/7] mmc: dw_mmc: remove the unnecessary function.
Date: Thu, 6 Mar 2014 08:32:19 +0100
Message-ID: <CAPDyKFrgm_2FrpTmyLfpbs5xovdYGEaVFe+XBn8O8syE-6wPpg@mail.gmail.com>
References: <5313EABD.3010804@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:57434 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaCFHcU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Mar 2014 02:32:20 -0500
Received: by mail-qc0-f176.google.com with SMTP id m20so2425393qcx.7
        for <linux-mmc@vger.kernel.org>; Wed, 05 Mar 2014 23:32:19 -0800 (PST)
In-Reply-To: <5313EABD.3010804@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>

On 3 March 2014 03:36, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Remove unnecessary function.
> This function didn't re-use anywhere.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
> Changelog V4:
>         - None
> Changelog V3:
>         - None
> Changelog V2:
>         - None
>
>  drivers/mmc/host/dw_mmc.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index ac16308..1418d33 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -235,12 +235,6 @@ err:
>  }
>  #endif /* defined(CONFIG_DEBUG_FS) */
>
> -static void dw_mci_set_timeout(struct dw_mci *host)
> -{
> -       /* timeout (maximum) */
> -       mci_writel(host, TMOUT, 0xffffffff);
> -}
> -
>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>         struct mmc_data *data;
> @@ -861,7 +855,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>
>         data = cmd->data;
>         if (data) {
> -               dw_mci_set_timeout(host);
> +               mci_writel(host, TMOUT, 0xFFFFFFFF);
>                 mci_writel(host, BYTCNT, data->blksz*data->blocks);
>                 mci_writel(host, BLKSIZ, data->blksz);
>         }
> --
> 1.7.9.5
