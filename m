From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH v2] mmc: tmio: Fix timeout value for command request
Date: Mon, 20 Jul 2015 08:03:19 +0300
Message-ID: <CALq1K=JbgNGpik6jTXvd+JHzRP9HGFhgu9PgDC3bE_ftBG1FSQ@mail.gmail.com>
References: <1437323999-7938-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33384 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbGTFDk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2015 01:03:40 -0400
Received: by wgmn9 with SMTP id n9so121466407wgm.0
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jul 2015 22:03:39 -0700 (PDT)
In-Reply-To: <1437323999-7938-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian.molton@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

On Sun, Jul 19, 2015 at 7:39 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Fix the problem which timeout occurs at the time of command request with
> several cards.
Hi Yoshihiro,
I afraid that I missed the answer to my concern about such cards [1].
It is good to write this information in commit message and/or comment
in the code.

It is extremely valuable to know which cards are required x2.5 timeout increase.

[1] http://www.spinics.net/lists/linux-mmc/msg32295.html

>
> The timeout value was insufficient as a verification of several cards,
> so it was changed 5 seconds from 2 seconds.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on mmc-next branch of Ulf Hansson's mmc tree.
>
> v2 [Yoshihiro Kaneko]
> * As suggested by Wolfram Sang
> - use a definition instead of a magic value
>
>  drivers/mmc/host/tmio_mmc_pio.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index e3dcf31..a10fde4 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -83,6 +83,8 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
>         return --host->sg_len;
>  }
>
> +#define CMDREQ_TIMEOUT 5000
> +
>  #ifdef CONFIG_MMC_DEBUG
>
>  #define STATUS_TO_TEXT(a, status, i) \
> @@ -230,7 +232,7 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>          */
>         if (IS_ERR_OR_NULL(mrq)
>             || time_is_after_jiffies(host->last_req_ts +
> -               msecs_to_jiffies(2000))) {
> +               msecs_to_jiffies(CMDREQ_TIMEOUT))) {
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 return;
>         }
> @@ -818,7 +820,7 @@ static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         ret = tmio_mmc_start_command(host, mrq->cmd);
>         if (!ret) {
>                 schedule_delayed_work(&host->delayed_reset_work,
> -                                     msecs_to_jiffies(2000));
> +                                     msecs_to_jiffies(CMDREQ_TIMEOUT));
>                 return;
>         }
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
