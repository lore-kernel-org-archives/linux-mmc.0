From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v2 1/4]enable background operations for supported eMMC card
Date: Mon, 6 Dec 2010 10:12:10 +0900
Message-ID: <AANLkTikPAmpJq7Q7riDPGq5UkhAa9cuXRW7kjuNGv6oB@mail.gmail.com>
References: <20101203121338.GB18655@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41029 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0LFBMM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Dec 2010 20:12:12 -0500
In-Reply-To: <20101203121338.GB18655@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, akpm@linux-foundation.org, arjan@linux.intel.com, alan@linux.intel.com

<Tested-by: Kyungmin Park <kyungmin.park@samsung.com>

Note that I'm not yet see any performance improvements :)

On Fri, Dec 3, 2010 at 9:13 PM, Chuanxiao Dong <chuanxiao.dong@intel.co=
m> wrote:
> From 984adc755cf2f7966a89e510a50f085e314fe347 Mon Sep 17 00:00:00 200=
1
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Date: Mon, 22 Nov 2010 16:31:12 +0800
> Subject: [PATCH 1/4] mmc: Enabled background operations feature if eM=
MC card supports
>
> Background operations is a new feature defined in eMMC4.41 standard.
> Since this feature is opertional for eMMC card, so driver only enable
> for those eMMC card which supports this feature
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> =A0drivers/mmc/core/mmc.c =A0 | =A0 26 ++++++++++++++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A02 ++
> =A0include/linux/mmc/mmc.h =A0| =A0 =A03 +++
> =A03 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 77f93c3..471ed82 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -310,6 +310,14 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_SEC_FE=
ATURE_SUPPORT];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.trim_timeout =3D 300 *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_TRIM_M=
ULT];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* detect whether the eMMC card support=
 BKOPS */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x=
1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_en =
=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd=
[EXT_CSD_BKOPS_EN];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
> @@ -484,6 +492,24 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* enable BKOPS if eMMC card supports.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->ext_csd.bkops) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!card->ext_csd.bkops_en) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card=
, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BKOPS_EN, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EB=
ADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fr=
ee_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.bkops_en =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.bkops_en =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Activate high speed (if supported)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8ce0827..9b755cb 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -54,6 +54,8 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_trim_mult; =A0=
/* Secure trim multiplier =A0*/
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_erase_mult; /*=
 Secure erase multiplier */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0trim_timeout; =A0 =
=A0 =A0 =A0 =A0 /* In milliseconds */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0bkops:1; /* backgro=
und support bit */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0bkops_en:1; /* back=
ground enable bit */
> =A0};
>
> =A0struct sd_scr {
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 956fbd8..14f7813 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -251,6 +251,8 @@ struct _mmc_csd {
> =A0* EXT_CSD fields
> =A0*/
>
> +#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 /* =
R/W */
> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /* W =
*/
> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0175=
 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_ERASED_MEM_CONT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0181=
 =A0 =A0 /* RO */
> =A0#define EXT_CSD_BUS_WIDTH =A0 =A0 =A0 =A0 =A0 =A0 =A0183 =A0 =A0 /=
* R/W */
> @@ -266,6 +268,7 @@ struct _mmc_csd {
> =A0#define EXT_CSD_SEC_ERASE_MULT =A0 =A0 =A0 =A0 230 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_SEC_FEATURE_SUPPORT =A0 =A0231 =A0 =A0 /* RO */
> =A0#define EXT_CSD_TRIM_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0232 =A0 =A0 /=
* RO */
> +#define EXT_CSD_BKOPS_SUPPORT =A0502 =A0 =A0 /* RO */
>
> =A0/*
> =A0* EXT_CSD field definitions
> --
> 1.6.6.1
>
>
