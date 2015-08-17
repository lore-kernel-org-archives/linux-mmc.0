From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
Date: Mon, 17 Aug 2015 19:11:15 +0200
Message-ID: <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37508 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbbHQRLP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 13:11:15 -0400
Received: by igui7 with SMTP id i7so60278523igu.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2015 10:11:15 -0700 (PDT)
In-Reply-To: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Weijun Yang <york.yang@csr.com>, Barry Song <Baohua.Song@csr.com>

On 11 August 2015 at 10:41, Barry Song <21cnbao@gmail.com> wrote:
> From: Weijun Yang <york.yang@csr.com>
>
> As SD Specifications Part1 Physical Layer Specification Version
> 3.01 says, CMD19 tuning is available for unlocked cards in transfer
> state of 1.8V signaling mode. The small difference between v3.00
> and 3.01 spec means that CMD19 tuning is also available for DDR50
> mode.

So what happens with cards following the 3.0 spec version, those
doesn't need to support the tuning CMD right? Perhaps that needs to be
addressed in this patch well!?

Kind regards
Uffe

>
> Signed-off-by: Weijun Yang <york.yang@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/mmc/core/sd.c    | 1 +
>  drivers/mmc/host/sdhci.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 4e7366a..a1ed24d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -629,6 +629,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>          */
>         if (!mmc_host_is_spi(card->host) &&
>             (card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
> +            card->sd_bus_speed == UHS_DDR50_BUS_SPEED ||
>              card->sd_bus_speed == UHS_SDR104_BUS_SPEED))
>                 err = mmc_execute_tuning(card);
>  out:
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1dbe932..812c19b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1891,6 +1891,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
