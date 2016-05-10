From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmc: Fix partition switch timeout for some eMMCs
Date: Tue, 10 May 2016 12:28:53 +0200
Message-ID: <CAPDyKFoW3jie9GGHUbMZYEbU5McmLzihJHJkoByVhctkRVD9+Q@mail.gmail.com>
References: <1462425148-18167-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37787 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbcEJK2y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 06:28:54 -0400
Received: by mail-wm0-f47.google.com with SMTP id a17so19188969wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 03:28:54 -0700 (PDT)
In-Reply-To: <1462425148-18167-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 5 May 2016 at 07:12, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Some eMMCs set the partition switch timeout too low.
>
> Now typically eMMCs are considered a critical component (e.g. because
> they store the root file system) and consequently are expected to be
> reliable.  Thus we can neglect the use case where eMMCs can't switch
> reliably and we might want a lower timeout to facilitate speedy
> recovery.
>
> Although we could employ a quirk for the cards that are affected (if
> we could identify them all), as described above, there is little
> benefit to having a low timeout, so instead simply set a minimum
> timeout.
>
> The minimum is set to 300ms somewhat arbitrarily - the examples that
> have been seen had a timeout of 10ms but were sometimes taking 60-70ms.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f99c47e003fe..d4d1b77c1c1e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -333,6 +333,9 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>         }
>  }
>
> +/* Minimum partition switch timeout in milliseconds */
> +#define MMC_MIN_PART_SWITCH_TIME       300
> +
>  /*
>   * Decode extended CSD.
>   */
> @@ -397,6 +400,10 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>
>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
> +               /* Some eMMC set the value too low so set a minimum */
> +               if (card->ext_csd.part_time &&
> +                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> +                       card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
>
>                 /* Sleep / awake timeout in 100ns units */
>                 if (sa_shift > 0 && sa_shift <= 0x17)
> --
> 1.9.1
>
