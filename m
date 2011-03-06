From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] mmc: subtract boot sectors from disk size for eMMC 4.3+ devices
Date: Sat, 5 Mar 2011 21:35:51 -0600
Message-ID: <AANLkTikeQs_eVHYc8vA8+m5tSHRDLnE3Xf9b5yWRj4p=@mail.gmail.com>
References: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:54267 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab1CFDfz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2011 22:35:55 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p263a8g1003151
	for <linux-mmc@vger.kernel.org>; Sat, 5 Mar 2011 22:36:08 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p263a7xD003140
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 5 Mar 2011 22:36:08 -0500 (EST)
Received: by vxb39 with SMTP id 39so3932887vxb.15
        for <linux-mmc@vger.kernel.org>; Sat, 05 Mar 2011 19:35:52 -0800 (PST)
In-Reply-To: <1299327344-12462-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>, Colin Cross <ccross@android.com>
Cc: Chris Ball <cjb@laptop.org>, Gary King <gking@nvidia.com>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Mar 5, 2011 6:16 AM, "Linus Walleij" <linus.walleij@stericsson.com> wrote:
> This patch is a squash of patches from Gary King and Ulf
> Hansson done in Android trees, hopefully fixing the issue properly.
>
> The csd sector count reported by eMMC 4.3+ cards includes the boot
> partition size; subtract this from the size reported to the disk
> since the boot partition is inaccessible.
>
> Signed-off-by: Gary King <gking@nvidia.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> drivers/mmc/core/mmc.c | 7 +++++++
> include/linux/mmc/mmc.h | 1 +
> 2 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 14e95f3..03c3283 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -255,6 +255,13 @@ static int mmc_read_ext_csd(struct mmc_card *card)
> /* Cards with density > 2GiB are sector addressed */
> if (card->ext_csd.sectors > (2u * 1024 * 1024 * 1024) / 512)
> mmc_card_set_blockaddr(card);
> +
> + if (card->ext_csd.sectors) {
> + unsigned boot_sectors;
> + /* size is in 256K chunks, i.e. 512 sectors each */
> + boot_sectors = ext_csd[EXT_CSD_BOOT_SIZE_MULTI] * 512;
> + card->ext_csd.sectors -= boot_sectors;
> + }
> }
>
> switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 264ba54..4516fc1 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -267,6 +267,7 @@ struct _mmc_csd {
> #define EXT_CSD_HC_WP_GRP_SIZE 221 /* RO */
> #define EXT_CSD_ERASE_TIMEOUT_MULT 223 /* RO */
> #define EXT_CSD_HC_ERASE_GRP_SIZE 224 /* RO */
> +#define EXT_CSD_BOOT_SIZE_MULTI 226 /* RO */
> #define EXT_CSD_SEC_TRIM_MULT 229 /* RO */
> #define EXT_CSD_SEC_ERASE_MULT 230 /* RO */
> #define EXT_CSD_SEC_FEATURE_SUPPORT 231 /* RO */
> --
> 1.7.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

+Colin Cross

I think Colin mentioned the emmc spec doesn't subtract the boot
sectors, just that some out of spec devices do... (sounds like another
use for mmc blk quirks)

(I really hope this gets sent as plain text)
Thanks,
A
