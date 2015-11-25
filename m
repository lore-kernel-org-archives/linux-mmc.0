From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: core: Introduce MMC_CAP2_NO_SDIO cap
Date: Wed, 25 Nov 2015 14:37:21 +0100
Message-ID: <CAPDyKFqMgfgpoRA4kCvrZA5stCY_Xi4i=4LtVgzkEZt=KPeXhw@mail.gmail.com>
References: <1448450927-13682-1-git-send-email-carlo@caione.org>
	<1448450927-13682-4-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34127 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbbKYNhW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 08:37:22 -0500
Received: by ykfs79 with SMTP id s79so55967027ykf.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 05:37:21 -0800 (PST)
In-Reply-To: <1448450927-13682-4-git-send-email-carlo@caione.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, Daniel Drake <drake@endlessm.com>, Carlo Caione <carlo@endlessm.com>

On 25 November 2015 at 12:28, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> This patch introduce a new MMC_CAP2_NO_SDIO cap used to tell the mmc
> core to not send SDIO specific commands.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/mmc/core/core.c  | 7 +++++++
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2e8b24d..90b028e 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -204,6 +204,13 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>                 return;
>         }
>
> +       /* We do not support SDIO commands */
> +       if (mmc_is_io_op(mrq->cmd->opcode) && host->caps2 & MMC_CAP2_NO_SDIO) {
> +               mrq->cmd->error = -EINVAL;
> +               mmc_request_done(host, mrq);
> +               return;
> +       }

Instead of checking this in the "hot path", I suggest we deal with
this directly from mmc_rescan() sequence.

We only need to make sure that the relevant SDIO commands/functions
isn't called when MMC_CAP2_NO_SDIO is set, right?

For example, there are a call to sdio_reset() in mmc_rescan_try_freq()
which shouldn't be invoked.

> +
>         /*
>          * For sdio rw commands we must wait for card busy otherwise some
>          * sdio devices won't work properly.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 8673ffe..cf6d0bb 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -289,6 +289,7 @@ struct mmc_host {
>  #define MMC_CAP2_HSX00_1_2V    (MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>  #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)    /* No physical write protect pin, assume that card is always read-write */
> +#define MMC_CAP2_NO_SDIO       (1 << 19)       /* Do not send SDIO commands during initialization */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> --
> 2.5.0
>

According to what I propose, I don't think patch 1 and patch 2 are needed.

Kind regards
Uffe
