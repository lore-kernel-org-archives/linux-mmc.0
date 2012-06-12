From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v7 1/3] mmc: core: Add packed command feature of eMMC4.5
Date: Tue, 12 Jun 2012 22:05:40 +0900
Message-ID: <000001cd489c$115f03b0$341d0b10$%jun@samsung.com>
References: <000601cd47ab$8ad77c50$a08674f0$%jun@samsung.com>
 <CANfBPZ9dwwAOBbXPqGV64k-sB-MzRtTO8x7tXnZBjtYN+V88XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15623 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab2FLNFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 09:05:42 -0400
In-reply-to: <CANfBPZ9dwwAOBbXPqGV64k-sB-MzRtTO8x7tXnZBjtYN+V88XQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'S, Venkatraman'" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>

S, Venkatraman <svenkatr@ti.com> wrote:
> On Mon, Jun 11, 2012 at 1:53 PM, Seungwon Jeon <tgih.jun@samsung.com>=
 wrote:
> > This patch adds packed command feature of eMMC4.5.
> > The maximum number for packing read(or write) is offered
> > and exception event relevant to packed command which is
> > used for error handling is enabled. If host wants to use
> > this feature, MMC_CAP2_PACKED_CMD should be set.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>=20
> Can you please post some clear performance benchmarks with your patch=
set ?
> Given that #merez claims to see a significant performance drop for
> reads, it will be
> good to compare notes.
> If it's not too much trouble, both CFQ and deadline scheduler figures
> would be useful, on a
> set of read only, write only and parallel read write usecases.
>=20
> I can also try to replicate your results if you can publish the exact
> configuration you used
> for testing (example: iozone parameters)
I'm checking the merez's result.
Currently packed command is effective on write.
When running packed write with iozone, there is 25% performance gains.
(ex: iozone -az -i0 -I -s 10m -f /target/test -e)

>=20
> > ---
> > =A0drivers/mmc/core/mmc.c =A0 | =A0 24 ++++++++++++++++++++++++
> > =A0include/linux/mmc/card.h | =A0 =A03 +++
> > =A0include/linux/mmc/host.h | =A0 =A04 ++++
> > =A0include/linux/mmc/mmc.h =A0| =A0 15 +++++++++++++++
> > =A04 files changed, 46 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 258b203..f9d54b0 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -516,6 +516,11 @@ static int mmc_read_ext_csd(struct mmc_card *c=
ard, u8 *ext_csd)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_t=
ag_unit_size =3D 0;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_writes =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_MAX_P=
ACKED_WRITES];
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.max_packed_reads =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_MAX_P=
ACKED_READS];
> > =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_sector_size =3D 5=
12;
> > =A0 =A0 =A0 =A0}
> > @@ -1246,6 +1251,25 @@ static int mmc_init_card(struct mmc_host *ho=
st, u32 ocr,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 if ((host->caps2 & MMC_CAP2_PACKED_CMD) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((card->ext_csd.max_p=
acked_writes > 0) ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (card->ext_csd.max_pa=
cked_reads > 0))) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_=
SET_NORMAL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_C=
SD_EXP_EVENTS_CTRL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_C=
SD_PACKED_EVENT_EN,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card-=
>ext_csd.generic_cmd6_time);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enabl=
ing packed event failed\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(card->host));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.packed_=
event_en =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.packed_=
event_en =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0if (!oldcard)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->card =3D card;
> >
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index d76513b..4aeb4e9 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -53,6 +53,9 @@ struct mmc_ext_csd {
> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0part_c=
onfig;
> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cache_=
ctrl;
> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rst_n_=
function;
> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_pac=
ked_writes;
> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0max_pac=
ked_reads;
> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0packed_=
event_en;
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0part_time; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* Units: ms */
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =
=A0 =A0 =A0 =A0 =A0 /* Units: 100ns */
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0generic_cmd6_tim=
e; =A0 =A0 =A0/* Units: 10ms */
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 0707d22..9d0d946 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -238,6 +238,10 @@ struct mmc_host {
> > =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0 =A0(1 << 7) =A0 =A0 =
=A0 =A0/* Use the broken voltage */
> > =A0#define MMC_CAP2_DETECT_ON_ERR (1 << 8) =A0 =A0 =A0 =A0/* On I/O=
 err check card removal */
> > =A0#define MMC_CAP2_HC_ERASE_SZ =A0 (1 << 9) =A0 =A0 =A0 =A0/* High=
-capacity erase size */
> > +#define MMC_CAP2_PACKED_RD =A0 =A0 (1 << 10) =A0 =A0 =A0 /* Allow =
packed read */
> > +#define MMC_CAP2_PACKED_WR =A0 =A0 (1 << 11) =A0 =A0 =A0 /* Allow =
packed write */
> > +#define MMC_CAP2_PACKED_CMD =A0 =A0(MMC_CAP2_PACKED_RD | \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MM=
C_CAP2_PACKED_WR) /* Allow packed commands */
> >
> > =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> > =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
> > diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> > index d425cab..254901a 100644
> > --- a/include/linux/mmc/mmc.h
> > +++ b/include/linux/mmc/mmc.h
> > @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
> > =A0#define R1_CURRENT_STATE(x) =A0 =A0((x & 0x00001E00) >> 9) /* sx=
, b (4 bits) */
> > =A0#define R1_READY_FOR_DATA =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* =
sx, a */
> > =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =
=A0 =A0 =A0 =A0/* sx, c */
> > +#define R1_EXP_EVENT =A0 =A0 =A0 =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/=
* sr, a */
> > =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =
=A0/* sr, c */
> >
> > =A0#define R1_STATE_IDLE =A00
> > @@ -274,6 +275,10 @@ struct _mmc_csd {
> > =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0=
/* W */
> > =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0=
/* R/W */
> > =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
> > +#define EXT_CSD_PACKED_FAILURE_INDEX =A0 35 =A0 =A0 =A0/* RO */
> > +#define EXT_CSD_PACKED_CMD_STATUS =A0 =A0 =A036 =A0 =A0 =A0/* RO *=
/
> > +#define EXT_CSD_EXP_EVENTS_STATUS =A0 =A0 =A054 =A0 =A0 =A0/* RO, =
2 bytes */
> > +#define EXT_CSD_EXP_EVENTS_CTRL =A0 =A0 =A0 =A056 =A0 =A0 =A0/* R/=
W, 2 bytes */
> > =A0#define EXT_CSD_DATA_SECTOR_SIZE =A0 =A0 =A0 61 =A0 =A0 =A0/* R =
*/
> > =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* =
R/W */
> > =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> > @@ -318,6 +323,8 @@ struct _mmc_csd {
> > =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /=
* RO, 4 bytes */
> > =A0#define EXT_CSD_TAG_UNIT_SIZE =A0 =A0 =A0 =A0 =A0498 =A0 =A0 /* =
RO */
> > =A0#define EXT_CSD_DATA_TAG_SUPPORT =A0 =A0 =A0 499 =A0 =A0 /* RO *=
/
> > +#define EXT_CSD_MAX_PACKED_WRITES =A0 =A0 =A0500 =A0 =A0 /* RO */
> > +#define EXT_CSD_MAX_PACKED_READS =A0 =A0 =A0 501 =A0 =A0 /* RO */
> > =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* =
RO */
> >
> > =A0/*
> > @@ -377,6 +384,14 @@ struct _mmc_csd {
> > =A0#define EXT_CSD_PWR_CL_4BIT_MASK =A0 =A0 =A0 0x0F =A0 =A0/* 8 bi=
t PWR CLS */
> > =A0#define EXT_CSD_PWR_CL_8BIT_SHIFT =A0 =A0 =A04
> > =A0#define EXT_CSD_PWR_CL_4BIT_SHIFT =A0 =A0 =A00
> > +
> > +#define EXT_CSD_PACKED_EVENT_EN =A0 =A0 =A0 =A0(1 << 3)
> > +
> > +#define EXT_CSD_PACKED_FAILURE (1 << 3)
> > +
> > +#define EXT_CSD_PACKED_GENERIC_ERROR =A0 (1 << 0)
> > +#define EXT_CSD_PACKED_INDEXED_ERROR =A0 (1 << 1)
> > +
> > =A0/*
> > =A0* MMC_SWITCH access modes
> > =A0*/
> > --
> > 1.7.0.4
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

