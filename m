From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH 1/2] mmc: core: Add packed command feature of eMMC4.5
Date: Wed, 2 Nov 2011 06:58:10 -0400
Message-ID: <CAGxe1ZG+3kFXMBqVyVBahM5PhgsYRn9crXgbtBs9FE7o6wFqMg@mail.gmail.com>
References: <1320220862-10403-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52431 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab1KBK6M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 06:58:12 -0400
In-Reply-To: <1320220862-10403-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Hi,

On 2 November 2011 04:01, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> This patch adds packed command feature of eMMC4.5.
> The maximum number for packing read(or write) is offered
> and exception event relevant to packed command which is
> used for error handling is enabled. If host wants to use
> this feature, MMC_CAP2_PACKED_CMD should be set.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/core/mmc.c =A0 | =A0 22 ++++++++++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A03 +++
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A0include/linux/mmc/mmc.h =A0| =A0 15 +++++++++++++++
> =A04 files changed, 41 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3627044..bf4fa6e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -487,6 +487,9 @@ static int mmc_read_ext_csd(struct mmc_card *card=
, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 1] << 8 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 2] << 16 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_CACHE_=
SIZE + 3] << 24;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_writes =3D ext=
_csd[EXT_CSD_MAX_PACKED_WRITES];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_reads =3D ext_=
csd[EXT_CSD_MAX_PACKED_READS];
> =A0 =A0 =A0 =A0}
>
> =A0out:
> @@ -1072,6 +1075,25 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.cache_ctrl =3D err ? 0 :=
 1;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_PACKED_CMD) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.max_pack=
ed_writes > 0) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.max_pack=
ed_reads > 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_EXP_EVENTS_CTRL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_PACKED_EVENT_EN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.generic_cmd6_time);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enablin=
g packed event failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.packed_ev=
ent_en =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.packed_ev=
ent_en =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (!oldcard)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->card =3D card;
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 415f2db..70ea3d6 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -52,6 +52,9 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0part_con=
fig;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cache_ct=
rl;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rst_n_fu=
nction;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_packe=
d_writes;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_packe=
d_reads;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packed_ev=
ent_en;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* Units: ms */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_time;=
 =A0 =A0 =A0/* Units: 10ms */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index a3ac9c4..d2e4210 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -242,6 +242,7 @@ struct mmc_host {
> =A0#define MMC_CAP2_CACHE_CTRL =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* Allo=
w cache control */
> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0 =A0/* Notify pow=
eroff supported */
> =A0#define MMC_CAP2_NO_MULTI_READ (1 << 3) =A0 =A0 =A0 =A0/* Multiblo=
ck reads don't work */
> +#define MMC_CAP2_PACKED_CMD =A0 =A0(1 << 4) =A0 =A0 =A0 =A0/* Allow =
packed command */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 0e71356..1b94c4f 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
> =A0#define R1_CURRENT_STATE(x) =A0 =A0((x & 0x00001E00) >> 9) /* sx, =
b (4 bits) */
> =A0#define R1_READY_FOR_DATA =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* sx=
, a */
> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* sx, c */
> +#define R1_EXP_EVENT =A0 =A0 =A0 =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* =
sr, a */
> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0=
/* sr, c */
>
> =A0#define R1_STATE_IDLE =A00
> @@ -273,6 +274,10 @@ struct _mmc_csd {
> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0/=
* W */
> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0/=
* R/W */
> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
> +#define EXT_CSD_PACKED_FAILURE_INDEX =A0 35 =A0 =A0 =A0/* RO */
> +#define EXT_CSD_PACKED_CMD_STATUS =A0 =A0 =A036 =A0 =A0 =A0/* RO */
> +#define EXT_CSD_EXP_EVENTS_STATUS =A0 =A0 =A054 =A0 =A0 =A0/* RO, 2 =
bytes */
> +#define EXT_CSD_EXP_EVENTS_CTRL =A0 =A0 =A0 =A056 =A0 =A0 =A0/* R/W,=
 2 bytes */
> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R/=
W */
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
> @@ -313,6 +318,8 @@ struct _mmc_csd {
> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /* =
RO, 4 bytes */
> +#define EXT_CSD_MAX_PACKED_WRITES =A0 =A0 =A0500 =A0 =A0 /* RO */
> +#define EXT_CSD_MAX_PACKED_READS =A0 =A0 =A0 501 =A0 =A0 /* RO */
> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* RO=
 */
>
> =A0/*
> @@ -364,6 +371,14 @@ struct _mmc_csd {
> =A0#define EXT_CSD_PWR_CL_4BIT_MASK =A0 =A0 =A0 0x0F =A0 =A0/* 8 bit =
PWR CLS */
> =A0#define EXT_CSD_PWR_CL_8BIT_SHIFT =A0 =A0 =A04
> =A0#define EXT_CSD_PWR_CL_4BIT_SHIFT =A0 =A0 =A00
> +
> +#define EXT_CSD_PACKED_EVENT_EN =A0 =A0 =A0 =A0(1 << 3)
> +
> +#define EXT_CSD_PACKED_FAILURE (1 << 3)
> +
> +#define EXT_CSD_PACKED_GENERIC_ERROR =A0 (1 << 0)
> +#define EXT_CSD_PACKED_INDEXED_ERROR =A0 (1 << 1)
> +
> =A0/*
> =A0* MMC_SWITCH access modes
> =A0*/
> --
> 1.7.0.4
>This patch gives some warnings and error, when checkpatch is run on th=
is.
yet to review more, will do once i return from Q4 connect
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
