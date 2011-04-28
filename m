From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] RFC: mmc: subtract boot sectors from disk size on quirky cards
Date: Thu, 28 Apr 2011 14:08:02 -0500
Message-ID: <BANLkTinX9_Hc3pH4Yz2Qt0DfFF6hPbSeFg@mail.gmail.com>
References: <1303988314-30316-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:58607 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932208Ab1D1TIE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2011 15:08:04 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3SJ617x008646
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 15:06:01 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3SIx521004866
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 15:06:00 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so3222569wwb.3
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2011 12:08:02 -0700 (PDT)
In-Reply-To: <1303988314-30316-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Gary King <gking@nvidia.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Colin Cross <ccross@android.com>

On Thu, Apr 28, 2011 at 5:58 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The csd sector count reported by some problematic eMMC 4.3+ cards
> includes the boot partition size; subtract this from the size
> reported to the disk since the boot partition is inaccessible.
>
> Cc: Gary King <gking@nvidia.com>
> Cc: Ulf Hansson <ulf.hansson@stericsson.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Andrei Warkentin <andreiw@motorola.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> GARY: can you provide the VID+PID numbers for the problematic
> card, so we can handle this properly?
> ---
> =A0drivers/mmc/core/mmc.c =A0 =A0| =A0 13 +++++++++++++
> =A0drivers/mmc/core/quirks.c | =A0 =A03 +++
> =A0include/linux/mmc/card.h =A0| =A0 =A01 +
> =A0include/linux/mmc/mmc.h =A0 | =A0 =A01 +
> =A04 files changed, 18 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 772d0d0..0833d15 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -255,6 +255,19 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Cards with density > 2GiB are secto=
r addressed */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (card->ext_csd.sectors > (2u * 1024=
 * 1024 * 1024) / 512)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_set_blockaddr=
(card);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Some cards require that you remove=
 the boot sectors from the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* total amount of sectors on the car=
d. This is not defined
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* by the spec so needs to be a per-c=
ard quirk.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.sectors &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->quirks & MMC_QUIRK_SUBTR=
ACT_BOOTSECS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned boot_sectors;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* size is in 128K chun=
ks, i.e. 256 sectors each */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 boot_sectors =3D ext_cs=
d[EXT_CSD_BOOT_SIZE_MULTI] * 256;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.sectors -=
=3D boot_sectors;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE=
_MASK) {
> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
> index 11118b74..fb1f528 100644
> --- a/drivers/mmc/core/quirks.c
> +++ b/drivers/mmc/core/quirks.c
> @@ -64,6 +64,9 @@ static const struct mmc_fixup mmc_fixup_methods[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_quirk_for_sdio_devices, MMC_QUIRK_=
BROKEN_CLK_GATING },
> =A0 =A0 =A0 =A0{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0remove_quirk, MMC_QUIRK_BROKEN_CLK_GAT=
ING },
> + =A0 =A0 =A0 /* TODO: fill in problematic card VID/PID here */
> + =A0 =A0 =A0 { 0x0000, 0x0000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_quirk, MMC_QUIRK_SUBTRACT_BOOTSECS =
},
> =A0 =A0 =A0 =A0{ 0 }
> =A0};
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index adb4888..f860eea 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -125,6 +125,7 @@ struct mmc_card {
> =A0#define MMC_QUIRK_NONSTD_SDIO =A0(1<<2) =A0 =A0 =A0 =A0 =A0/* non-=
standard SDIO card attached */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* (missing CIA registers) */
> =A0#define MMC_QUIRK_BROKEN_CLK_GATING (1<<3) =A0 =A0 /* clock gating=
 the sdio bus will make card fail */
> +#define MMC_QUIRK_SUBTRACT_BOOTSECS (1<<4) =A0 =A0 /* remove any boo=
t sectors from the sector allocation pool */
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 /* erase size in sectors */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_shift; =A0 =A0=
/* if erase unit is power 2 */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 264ba54..4516fc1 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -267,6 +267,7 @@ struct _mmc_csd {
> =A0#define EXT_CSD_HC_WP_GRP_SIZE =A0 =A0 =A0 =A0 221 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_ERASE_TIMEOUT_MULT =A0 =A0 223 =A0 =A0 /* RO */
> =A0#define EXT_CSD_HC_ERASE_GRP_SIZE =A0 =A0 =A0224 =A0 =A0 /* RO */
> +#define EXT_CSD_BOOT_SIZE_MULTI =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0226 =A0=
 =A0 /* RO */
> =A0#define EXT_CSD_SEC_TRIM_MULT =A0 =A0 =A0 =A0 =A0229 =A0 =A0 /* RO=
 */
> =A0#define EXT_CSD_SEC_ERASE_MULT =A0 =A0 =A0 =A0 230 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_SEC_FEATURE_SUPPORT =A0 =A0231 =A0 =A0 /* RO */

Linus,

The right place for this would now be the block.c quirks table.
Assuming issue actually exists. Additionally, your changes to
mmc.c are not required (size is already correctly fetched there).

A
