From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH v4 1/4]enable HW reset capbility
Date: Thu, 9 Dec 2010 14:24:25 +0900
Message-ID: <AANLkTimv5f43mgtubgps_rgiHXa3=NGRb4kNrps8ViJn@mail.gmail.com>
References: <20101201124900.GB5421@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62750 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab0LIFY1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2010 00:24:27 -0500
In-Reply-To: <20101201124900.GB5421@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, arjan@linux.intel.com, alan@linux.intel.com, akpm@linux-foundation.org

On Wed, Dec 1, 2010 at 9:49 PM, Chuanxiao Dong <chuanxiao.dong@intel.co=
m> wrote:
> From d3be0b4fe8e8a40294830dfd8d0543d1e957fd29 Mon Sep 17 00:00:00 200=
1
> From: Chuanxiao Dong <chuanxiao.dong@intel.com>
> Date: Wed, 1 Dec 2010 19:14:02 +0800
> Subject: [PATCH 1/4] enable HW reset caps of MMC card if card support=
s
>
> HW reset capbility enable bit is byte 162 in card EXT_CSD
> register, only version4.4 card or later can support to enable
> this feature.
>
> HW reset feature can be used to reset eMMC card when occures
> timeout errors during read/write/erase.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
> =A0drivers/mmc/core/mmc.c =A0 | =A0 29 +++++++++++++++++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A01 +
> =A0include/linux/mmc/mmc.h =A0| =A0 =A01 +
> =A03 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 77f93c3..85cc7f6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -310,6 +310,10 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_SEC_FE=
ATURE_SUPPORT];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.trim_timeout =3D 300 *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_TRIM_M=
ULT];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* check Hardware reset cap
Check hardware.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rst =3D ext_csd[EXT_CSD_R=
ST];
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
> @@ -484,6 +488,31 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* eMMC4.4 version card has HW reset capbility.
capability.
> + =A0 =A0 =A0 =A0* Enable this feature here:
> + =A0 =A0 =A0 =A0* RST_N_FUNCTION register is W/R, one time programma=
ble
Use RST_n_FUNCTION as spec.
> + =A0 =A0 =A0 =A0* or readable.
> + =A0 =A0 =A0 =A0* So need to enable this register only once after po=
wer on
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->csd.mmca_vsn >=3D CSD_SPEC_VER_4 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rev >=3D =
4 &&
it should be card->ext_csd.rev >=3D 5 since 4 is obsolete.

Thank you,
Kyungmin Park
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rst =3D=3D=
 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_RST, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: switch to rst enable "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"failed %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(card->host), err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rst =3D 1=
;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Activate high speed (if supported)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8ce0827..ebee676 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -54,6 +54,7 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_trim_mult; =A0=
/* Secure trim multiplier =A0*/
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sec_erase_mult; /*=
 Secure erase multiplier */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0trim_timeout; =A0 =
=A0 =A0 =A0 =A0 /* In milliseconds */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0rst; /* hardware re=
set enable bit */
> =A0};
>
> =A0struct sd_scr {
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 956fbd8..b7ab0da 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -251,6 +251,7 @@ struct _mmc_csd {
> =A0* EXT_CSD fields
> =A0*/
>
> +#define EXT_CSD_RST =A0 =A0 =A0 =A0 =A0 =A0162 =A0 =A0 /* onetime pr=
ogrammable R/W */
> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0175=
 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_ERASED_MEM_CONT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0181=
 =A0 =A0 /* RO */
> =A0#define EXT_CSD_BUS_WIDTH =A0 =A0 =A0 =A0 =A0 =A0 =A0183 =A0 =A0 /=
* R/W */
> --
> 1.6.6.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
