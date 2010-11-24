From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v1 3/4]enable HPI for supported card
Date: Wed, 24 Nov 2010 13:02:52 +0900
Message-ID: <AANLkTikANxzp6ut=gKT+KdFYMupP32sDPYP3AtJJaFFm@mail.gmail.com>
References: <20101123084450.GD17754@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59502 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0KXECy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2010 23:02:54 -0500
In-Reply-To: <20101123084450.GD17754@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org, alan@linux.intel.com, arjan@linux.intel.com, hang.yuan@intel.com

On Tue, Nov 23, 2010 at 5:44 PM, Chuanxiao Dong
<chuanxiao.dong@intel.com> wrote:
> From 78d7ca58fe6ea3b850ee3682a3552e16fc9faa15 Mon Sep 17 00:00:00 200=
1
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Date: Tue, 23 Nov 2010 12:09:57 +0800
> Subject: [PATCH 3/4] mmc: Enabled HPI feature
>
> HPI feature is a new feature in eMMC4.41 standard. It will be
> used to interrupt background operations and low priority
> foreground operations
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> =A0drivers/mmc/core/mmc.c =A0 | =A0 32 ++++++++++++++++++++++++++++++=
++
> =A0include/linux/mmc/card.h | =A0 =A02 ++
> =A0include/linux/mmc/mmc.h =A0| =A0 =A02 ++
> =A03 files changed, 36 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 471ed82..c3f8e24 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -318,6 +318,20 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_cs=
d[EXT_CSD_BKOPS_EN];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card support =
HPI */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi =3D 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_en =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd=
[EXT_CSD_HPI_MGMT];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_cmd =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd=
[EXT_CSD_HPI_FEATURES] & 0x2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.hpi_=
cmd !=3D MMC_SEND_STATUS) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (card->ext_csd.hpi_cmd !=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0MMC_STOP_TRANSMISSION)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.hpi =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.hpi_en =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
> @@ -510,6 +524,24 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* enable HPI feature if eMMC card support
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->ext_csd.hpi) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!card->ext_csd.hpi_en) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card=
, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_HPI_MGMT, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EB=
ADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fr=
ee_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.hpi_en =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.bkops_en =3D 1;
                           should card->ext_csd.hpi_en =3D 1;

Thank you,
Kyungmin Park
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Activate high speed (if supported)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4142ab5..efb2c56 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -57,6 +57,8 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0bkops:1; /* backgr=
ound support bit */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0bkops_en:1; /* bac=
kground enable bit */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_en:1; /* HPI e=
nable bit */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi:1; /* HPI suppo=
rt bit */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; /* cmd use=
d to for HPI */
> =A0};
>
> =A0struct sd_scr {
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index ef85e90..ab1eb41 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -252,6 +252,7 @@ struct _mmc_csd {
> =A0* EXT_CSD fields
> =A0*/
>
> +#define EXT_CSD_HPI_MGMT =A0 =A0 =A0 =A0 =A0 =A0 =A0 161 =A0 =A0 /* =
R/W */
> =A0#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 /=
* R/W */
> =A0#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /* =
W */
> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0175=
 =A0 =A0 /* R/W */
> @@ -270,6 +271,7 @@ struct _mmc_csd {
> =A0#define EXT_CSD_SEC_FEATURE_SUPPORT =A0 =A0231 =A0 =A0 /* RO */
> =A0#define EXT_CSD_TRIM_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0232 =A0 =A0 /=
* RO */
> =A0#define EXT_CSD_BKOPS_SUPPORT =A0502 =A0 =A0 /* RO */
> +#define EXT_CSD_HPI_FEATURES =A0 503 =A0 =A0 /* RO */
>
> =A0/*
> =A0* EXT_CSD field definitions
> --
> 1.6.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
