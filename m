From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v7 1/3] mmc: core: Add packed command feature of eMMC4.5
Date: Tue, 12 Jun 2012 09:51:11 +0530
Message-ID: <CANfBPZ9dwwAOBbXPqGV64k-sB-MzRtTO8x7tXnZBjtYN+V88XQ@mail.gmail.com>
References: <000601cd47ab$8ad77c50$a08674f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:33207 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129Ab2FLEVf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Jun 2012 00:21:35 -0400
Received: by bkwj10 with SMTP id j10so4509387bkw.4
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jun 2012 21:21:32 -0700 (PDT)
In-Reply-To: <000601cd47ab$8ad77c50$a08674f0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, Maya Erez <merez@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>

On Mon, Jun 11, 2012 at 1:53 PM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> This patch adds packed command feature of eMMC4.5.
> The maximum number for packing read(or write) is offered
> and exception event relevant to packed command which is
> used for error handling is enabled. If host wants to use
> this feature, MMC_CAP2_PACKED_CMD should be set.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Can you please post some clear performance benchmarks with your patchse=
t ?
Given that #merez claims to see a significant performance drop for
reads, it will be
good to compare notes.
If it's not too much trouble, both CFQ and deadline scheduler figures
would be useful, on a
set of read only, write only and parallel read write usecases.

I can also try to replicate your results if you can publish the exact
configuration you used
for testing (example: iozone parameters)

> ---
> =A0drivers/mmc/core/mmc.c =A0 | =A0 24 ++++++++++++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A03 +++
> =A0include/linux/mmc/host.h | =A0 =A04 ++++
> =A0include/linux/mmc/mmc.h =A0| =A0 15 +++++++++++++++
> =A04 files changed, 46 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 258b203..f9d54b0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -516,6 +516,11 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_tag=
_unit_size =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_writes =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_MAX_PAC=
KED_WRITES];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_reads =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_MAX_PAC=
KED_READS];
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_sector_size =3D 512=
;
> =A0 =A0 =A0 =A0}
> @@ -1246,6 +1251,25 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_PACKED_CMD) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((card->ext_csd.max_pac=
ked_writes > 0) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.max_pack=
ed_reads > 0))) {
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
> index d76513b..4aeb4e9 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -53,6 +53,9 @@ struct mmc_ext_csd {
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
> index 0707d22..9d0d946 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,6 +238,10 @@ struct mmc_host {
> =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0 =A0(1 << 7) =A0 =A0 =A0=
 =A0/* Use the broken voltage */
> =A0#define MMC_CAP2_DETECT_ON_ERR (1 << 8) =A0 =A0 =A0 =A0/* On I/O e=
rr check card removal */
> =A0#define MMC_CAP2_HC_ERASE_SZ =A0 (1 << 9) =A0 =A0 =A0 =A0/* High-c=
apacity erase size */
> +#define MMC_CAP2_PACKED_RD =A0 =A0 (1 << 10) =A0 =A0 =A0 /* Allow pa=
cked read */
> +#define MMC_CAP2_PACKED_WR =A0 =A0 (1 << 11) =A0 =A0 =A0 /* Allow pa=
cked write */
> +#define MMC_CAP2_PACKED_CMD =A0 =A0(MMC_CAP2_PACKED_RD | \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_=
CAP2_PACKED_WR) /* Allow packed commands */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d425cab..254901a 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
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
> @@ -274,6 +275,10 @@ struct _mmc_csd {
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
> =A0#define EXT_CSD_DATA_SECTOR_SIZE =A0 =A0 =A0 61 =A0 =A0 =A0/* R */
> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R/=
W */
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> @@ -318,6 +323,8 @@ struct _mmc_csd {
> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /* =
RO, 4 bytes */
> =A0#define EXT_CSD_TAG_UNIT_SIZE =A0 =A0 =A0 =A0 =A0498 =A0 =A0 /* RO=
 */
> =A0#define EXT_CSD_DATA_TAG_SUPPORT =A0 =A0 =A0 499 =A0 =A0 /* RO */
> +#define EXT_CSD_MAX_PACKED_WRITES =A0 =A0 =A0500 =A0 =A0 /* RO */
> +#define EXT_CSD_MAX_PACKED_READS =A0 =A0 =A0 501 =A0 =A0 /* RO */
> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* RO=
 */
>
> =A0/*
> @@ -377,6 +384,14 @@ struct _mmc_csd {
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
>
>
