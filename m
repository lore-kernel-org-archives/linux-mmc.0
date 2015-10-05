From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Mon, 5 Oct 2015 12:56:42 +0200
Message-ID: <CAPDyKFrZNzFoQmrMFYBoX7KysgX_+EzcpuRhGYyY+eBLEOfhcw@mail.gmail.com>
References: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35928 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbbJEK4n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 06:56:43 -0400
Received: by wicgb1 with SMTP id gb1so113580754wic.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2015 03:56:42 -0700 (PDT)
In-Reply-To: <1443960253-4082-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

On 4 October 2015 at 14:04, Barry Song <21cnbao@gmail.com> wrote:
> From: Weijun Yang <york.yang@csr.com>
>
> As SD Specifications Part1 Physical Layer Specification Version
> 3.01 says, CMD19 tuning is available for unlocked cards in transfer
> state of 1.8V signaling mode. The small difference between v3.00
> and 3.01 spec means that CMD19 tuning is also available for DDR50
> mode.
>
> Signed-off-by: Weijun Yang <york.yang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks, applied for next - although with some minor changes as described below.

> ---
>  drivers/mmc/core/sd.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 4e7366a..eaf8cb3 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -628,9 +628,24 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>          * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
>          */
>         if (!mmc_host_is_spi(card->host) &&
> -           (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
> -            card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
> +               (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
> +                card->sd_bus_speed == UHS_DDR50_BUS_SPEED ||
> +                card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
>                 err = mmc_execute_tuning(card);
> +
> +               /*
> +                * As SD Specifications Part1 Physical Layer Specification Version
> +                * 3.01 says, CMD19 tuning is available for unlocked cards in transfer
> +                * state of 1.8V signaling mode. The small difference between v3.00
> +                * and 3.01 spec means that CMD19 tuning is also available for DDR50
> +                * mode.
> +                */

Checkpatch warned about long lines, so I changed them.

> +               if (err && (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {

Removed a pair of unnecessary parentheses for this if statement.

> +                       pr_warn("%s: ddr50 tuning failed\n", mmc_hostname(card->host));
> +                       err = 0;
> +               }
> +       }
> +
>  out:
>         kfree(status);
>
> --
> 1.9.1
>

Kind regards
Uffe
