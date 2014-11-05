From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] mmc: core: use mmc_send_status to check hw_reset
Date: Wed, 5 Nov 2014 10:44:42 +0100
Message-ID: <CAPDyKFoXO=RPuJ+VwfUVDqjaO232soOjBEUqq-SYMJTyY5qP3Q@mail.gmail.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
	<1415113626-30187-2-git-send-email-johanru@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:64529 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbaKEJon (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 04:44:43 -0500
Received: by mail-qa0-f46.google.com with SMTP id n8so205937qaq.33
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 01:44:42 -0800 (PST)
In-Reply-To: <1415113626-30187-2-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

On 4 November 2014 16:07, Johan Rudholm <johan.rudholm@axis.com> wrote:
> Signed-off-by: Johan Rudholm <johanru@axis.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c |   10 ++--------
>  1 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 7dc0c85..5d215ee 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2265,15 +2265,9 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
>
>         /* If the reset has happened, then a status command will fail */
>         if (check) {
> -               struct mmc_command cmd = {0};
> -               int err;
> +               u32 status;
>
> -               cmd.opcode = MMC_SEND_STATUS;
> -               if (!mmc_host_is_spi(card->host))
> -                       cmd.arg = card->rca << 16;
> -               cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
> -               err = mmc_wait_for_cmd(card->host, &cmd, 0);
> -               if (!err) {
> +               if (!mmc_send_status(card, &status)) {
>                         mmc_host_clk_release(host);
>                         return -ENOSYS;
>                 }
> --
> 1.7.2.5
>
