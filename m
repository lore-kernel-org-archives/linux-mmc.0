From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Tue, 29 Sep 2015 12:22:13 +0200
Message-ID: <CAPDyKFp7hMgPxvJVgYUgRXqTBbWkO-spd7T+c6EkuAMk9rqfeg@mail.gmail.com>
References: <1443410618-14763-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34534 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921AbbI2KWO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Sep 2015 06:22:14 -0400
Received: by wicfx3 with SMTP id fx3so143033487wic.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Sep 2015 03:22:13 -0700 (PDT)
In-Reply-To: <1443410618-14763-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

On 28 September 2015 at 05:23, Barry Song <21cnbao@gmail.com> wrote:
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
> ---
>  drivers/mmc/core/sd.c    | 19 +++++++++++++++++--
>  drivers/mmc/host/sdhci.c |  1 +

Sorry for not pointing out this is the first round, but I would rather
split @subject patch into two parts.
One for core and one for sdhci, as it then becomes obvious that sdhci
will start using the option to do tuning for DDR50 mode.

>  2 files changed, 18 insertions(+), 2 deletions(-)
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
> +               if (err && (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
> +                       pr_warn("%s: ddr50 tuning failed\n", mmc_hostname(card->host));
> +                       err = 0;
> +               }
> +       }
> +
>  out:
>         kfree(status);
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 64b7fdb..382810d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1915,6 +1915,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 break;
>
>         case MMC_TIMING_UHS_SDR104:
> +       case MMC_TIMING_UHS_DDR50:
>                 break;
>
>         case MMC_TIMING_UHS_SDR50:
> --
> 1.9.1
>

Kind regards
Uffe
