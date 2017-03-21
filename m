From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: always get number of taps
Date: Tue, 21 Mar 2017 11:09:24 +0100
Message-ID: <CAPDyKFr3_awg=zzTD9rm_BUb=1PC=nAamq4HWE9wtCDvhARMDg@mail.gmail.com>
References: <20170317090450.18593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33073 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756389AbdCUKJn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 06:09:43 -0400
Received: by mail-vk0-f51.google.com with SMTP id d188so88833273vka.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2017 03:09:25 -0700 (PDT)
In-Reply-To: <20170317090450.18593-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On 17 March 2017 at 10:04, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
>
> Current code gets number of taps only once and keeps the value. This is
> not correct, we need to obtain it every time before executing tuning,
> so remove the outer if-block.
>
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> [wsa: extracted from a larger patch and reworded commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe



> ---
>  drivers/mmc/host/tmio_mmc_pio.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 5b01d22932cdbf..a2d92f10501bdd 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -815,16 +815,14 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct tmio_mmc_host *host = mmc_priv(mmc);
>         int i, ret = 0;
>
> -       if (!host->tap_num) {
> -               if (!host->init_tuning || !host->select_tuning)
> -                       /* Tuning is not supported */
> -                       goto out;
> +       if (!host->init_tuning || !host->select_tuning)
> +               /* Tuning is not supported */
> +               goto out;
>
> -               host->tap_num = host->init_tuning(host);
> -               if (!host->tap_num)
> -                       /* Tuning is not supported */
> -                       goto out;
> -       }
> +       host->tap_num = host->init_tuning(host);
> +       if (!host->tap_num)
> +               /* Tuning is not supported */
> +               goto out;
>
>         if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
>                 dev_warn_once(&host->pdev->dev,
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
