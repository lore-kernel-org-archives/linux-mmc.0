From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH] mmc: core: HS DDR switch, don't change timing before
 checking status
Date: Fri, 17 Mar 2017 16:14:18 +0100
Message-ID: <CAPDyKFqpX3ZQSxiZsMyei9K0v9eSqVSBC89_U2=VtokGSqtFfA@mail.gmail.com>
References: <98664253-9a68-fa59-7f17-438b0d522fe8@microchip.com> <20170310142117.6060-1-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36597 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdCQPXq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 11:23:46 -0400
Received: by mail-ua0-f178.google.com with SMTP id 72so45921761uaf.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 08:22:56 -0700 (PDT)
In-Reply-To: <20170310142117.6060-1-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: nicolas.ferre@microchip.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>

On 10 March 2017 at 15:21, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> From: Ludovic Desroches <ludovic.desroches@microchip.com>
>
> The commit e173f8911f09 mmc: core: Update CMD13 polling policy when
> switch to HS DDR mode in addition to fix the management of CRC error,
> changes the place where the DDR52 timing is set.
>
> Before this commit, the sequence was:
> - set width to 8 with MMC_HS timing
> - send the switch command
> - check the status
> - set width to 8 with MMC_DDR52 timing
> - send the switch command
> - check the status
> Now:
> - set width to 8 with MMC_HS timing
> - send the switch command
> - set width to 8 with MMC_DDR52 timing
> - check the status
>
> It may lead to get an error when checking the status with some devices.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/mmc/core/mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0fccca0..b837148 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1062,7 +1062,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>                            EXT_CSD_BUS_WIDTH,
>                            ext_csd_bits,
>                            card->ext_csd.generic_cmd6_time,
> -                          MMC_TIMING_MMC_DDR52,
> +                          0,
>                            true, true, true);
>         if (err) {
>                 pr_err("%s: switch to bus width %d ddr failed\n",
> @@ -1106,6 +1106,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>         if (err)
>                 err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>
> +       if (!err)
> +               mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> +
>         return err;
>  }
>
> --
> 2.9.0
>

We had other reports for similar problems. The following change fix
those issues, have you tried this out?

[PATCH] mmc: core: Restore parts of the polling policy when switch to HS/HS DDR
https://patchwork.kernel.org/patch/9515239/

Kind regards
Uffe
