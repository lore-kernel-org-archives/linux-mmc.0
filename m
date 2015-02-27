From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH] mmc: mkfs takes hours on some combinations of eMMC device
 and host controller
Date: Fri, 27 Feb 2015 10:39:53 -0500
Message-ID: <CAOGqxeX5d77cA4eaxgMGwauRrgKz8yw3sn_yrGduLS3+3KVQ6Q@mail.gmail.com>
References: <1424901359-6309-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:40686 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbbB0Pjz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 10:39:55 -0500
Received: by labgd6 with SMTP id gd6so18363189lab.7
        for <linux-mmc@vger.kernel.org>; Fri, 27 Feb 2015 07:39:53 -0800 (PST)
In-Reply-To: <1424901359-6309-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Al Cooper <alcooperx@gmail.com>

I understand. For an API that accepts sectors that are not erase block
aligned the correct answer really is 1 sector for this eMMC/Host
controller combination. Unfortunately this hangs mkfs.ext4 for about
10 hours. Have there been any other suggested solutions?

On Wed, Feb 25, 2015 at 4:55 PM, Al Cooper <alcooperx@gmail.com> wrote:
> mkfs.ext4 will erase the entire partition on the eMMC device before
> writing the actual filesystem. The number of blocks erased on each
> erase eMMC command is determined at run time based on the max erase
> or trim time specified by the EXT_CSD in the eMMC device and the max eMMC
> command timeout supported by the host controller. The routine in the
> kernel that calculates the max number of blocks specified per command
> returns 1 with some combinations of host controllers with a short max
> command timeout and eMMC devices with long max erase or trim time.
> This will end up requiring over 8 million erase sequences on a 4GB
> eMMC partition and will take many hours.
>
> For example, on a host controller with a 50MHz timeout clock
> specified in the Host CAPS register and an eMMC device
> with a TRIM Multiplier of 6 specified in the EXT_CSD we get
> 2^27/50000000=2.68 secs for a max command timeout and 6*.300=1.8 secs
> for a trim operation which only allows 1 per trim command. The problem
> seems to be in mmc_do_calc_max_discard() which does it's calculations
> based on erase blocks but converts to and returns write blocks
> (2MB blocks to 512 bytes blocks for a typical eMMC device) unless
> the value is 1 in which case it just returns the 1. The routine also
> subtracts 1 from the max calculation before converting from erase to
> write blocks which should not be needed.
>
> This change will convert all non-zero max calculations from erase
> to write blocks and will no longer subtract 1 from the erase block
> max before converting to write blocks. This allow mkfs.ext4 to run
> in 30 secs instead of >10 hours.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/core/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 23f10f7..1b61ac0 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2231,16 +2231,13 @@ static unsigned int mmc_do_calc_max_discard(struct mmc_card *card,
>         if (!qty)
>                 return 0;
>
> -       if (qty == 1)
> -               return 1;
> -
>         /* Convert qty to sectors */
>         if (card->erase_shift)
> -               max_discard = --qty << card->erase_shift;
> +               max_discard = qty << card->erase_shift;
>         else if (mmc_card_sd(card))
>                 max_discard = qty;
>         else
> -               max_discard = --qty * card->erase_size;
> +               max_discard = qty * card->erase_size;
>
>         return max_discard;
>  }
> --
> 1.9.0.138.g2de3478
>
