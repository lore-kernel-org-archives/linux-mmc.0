From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mmc: MMC 4.4 DDR support
Date: Sat, 10 Jul 2010 14:29:50 +0900
Message-ID: <AANLkTikYJEtdEsSgWTmy6zaqa5QZB-SdU5LDh8zHIHnl@mail.gmail.com>
References: <1278658780-26397-1-git-send-email-hanumath.prasad@stericsson.com>
	<AANLkTikHqhx4k-DPGh-Ub13eS02nPuUJniv66sCBF4J1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47529 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab0GJF3v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Jul 2010 01:29:51 -0400
In-Reply-To: <AANLkTikHqhx4k-DPGh-Ub13eS02nPuUJniv66sCBF4J1@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hanumath Prasad <hanumath.prasad@stericsson.com>
Cc: linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, linux-mmc@vger.kernel.org

On Sat, Jul 10, 2010 at 2:28 PM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> Hi,
>
> Looks good to me except where's use the MMC_DDR_MODE. why do you set
> brq.data.flags |=3D MMC_DDR_MODE?
>
> Now my SDHCI host don't support eMMC 4.4 but the end of july I can te=
st it.
=46ixing eMMC 4.4 means DDR features at host.
>
> Thank you,
> Kyungmin Park
>
> On Fri, Jul 9, 2010 at 3:59 PM, Hanumath Prasad
> <hanumath.prasad@stericsson.com> wrote:
>> Add support for Dual Data Rate MMC cards as defined in the 4.4
>> specification.
>>
>> Cc: linux-mmc@vger.kernel.org
>> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>> Signed-off-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 10 +++++++---
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 37 +++++++++++++++++++++++++++++=
++++++--
>> =A0include/linux/mmc/card.h | =A0 =A05 +++++
>> =A0include/linux/mmc/core.h | =A0 =A01 +
>> =A0include/linux/mmc/host.h | =A0 =A04 ++++
>> =A0include/linux/mmc/mmc.h =A0| =A0 11 +++++++++--
>> =A06 files changed, 61 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index cb9fbc8..4eb84eb 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -299,7 +299,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq=
, struct request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0readcmd =3D MMC_READ_=
SINGLE_BLOCK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writecmd =3D MMC_WRIT=
E_BLOCK;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_ddr_mode(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq.data.flags |=3D MM=
C_DDR_MODE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rq_data_dir(req) =3D=3D READ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.cmd.opcode =3D re=
adcmd;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq.data.flags |=3D M=
MC_DATA_READ;
>> @@ -569,8 +570,11 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, st=
ruct mmc_card *card)
>> =A0 =A0 =A0 =A0struct mmc_command cmd;
>> =A0 =A0 =A0 =A0int err;
>>
>> - =A0 =A0 =A0 /* Block-addressed cards ignore MMC_SET_BLOCKLEN. */
>> - =A0 =A0 =A0 if (mmc_card_blockaddr(card))
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Block-addressed and ddr mode supported cards
>> + =A0 =A0 =A0 =A0* ignore MMC_SET_BLOCKLEN.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (mmc_card_blockaddr(card) || mmc_card_ddr_mode(card=
))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>>
>> =A0 =A0 =A0 =A0mmc_claim_host(card->host);
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 89f7a25..1d33503 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -227,6 +227,21 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd)
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYP=
E_MASK) {
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
>> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 52000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CA=
RD_TYPE_DDR_52;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_1_2V | EXT_CSD_CARD_TYPE_52=
 |
>> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 52000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CA=
RD_TYPE_DDR_1_2V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 case EXT_CSD_CARD_TYPE_DDR_1_8V | EXT_CSD_CARD_TYPE_52=
 |
>> + =A0 =A0 =A0 =A0 =A0 =A0EXT_CSD_CARD_TYPE_26:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hs_max_dtr =3D 52000000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.card_type =3D EXT_CSD_CA=
RD_TYPE_DDR_1_8V;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0case EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hs_max_dtr =3D 52000000=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> @@ -444,6 +459,18 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 =A0mmc_set_clock(host, max_dtr);
>>
>> =A0 =A0 =A0 =A0/*
>> + =A0 =A0 =A0 =A0* Activate DDR50 mode (if supported).
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (mmc_card_highspeed(card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((card->ext_csd.card_type & EXT_CSD=
_CARD_TYPE_DDR_1_8V)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->caps & (MMC_=
CAP_1_8V_DDR)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_set_ddr_mode(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if ((card->ext_csd.card_type & EX=
T_CSD_CARD_TYPE_DDR_1_2V)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (host->caps & (MMC_=
CAP_1_2V_DDR)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_set_ddr_mode(card);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 * Activate wide bus (if supported).
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
>> @@ -451,10 +478,16 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned ext_csd_bit, bus_width;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->caps & MMC_CAP_8_BIT_DATA) =
{
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd_bit =3D EXT_CS=
D_BUS_WIDTH_8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_ddr_mode(=
card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_cs=
d_bit =3D EXT_CSD_DDR_BUS_WIDTH_8;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_cs=
d_bit =3D EXT_CSD_BUS_WIDTH_8;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_width =3D MMC_BUS=
_WIDTH_8;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd_bit =3D EXT_CS=
D_BUS_WIDTH_4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_ddr_mode(=
card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_cs=
d_bit =3D EXT_CSD_DDR_BUS_WIDTH_4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_cs=
d_bit =3D EXT_CSD_BUS_WIDTH_4;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_width =3D MMC_BUS=
_WIDTH_4;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index d02d2c6..7d0aca8 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -44,6 +44,7 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sa_timeout; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: 100ns */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sectors;
>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0card_type;
>> =A0};
>>
>> =A0struct sd_scr {
>> @@ -97,6 +98,8 @@ struct mmc_card {
>> =A0#define MMC_STATE_READONLY =A0 =A0 (1<<1) =A0 =A0 =A0 =A0 =A0/* c=
ard is read-only */
>> =A0#define MMC_STATE_HIGHSPEED =A0 =A0(1<<2) =A0 =A0 =A0 =A0 =A0/* c=
ard is in high speed mode */
>> =A0#define MMC_STATE_BLOCKADDR =A0 =A0(1<<3) =A0 =A0 =A0 =A0 =A0/* c=
ard uses block-addressing */
>> +#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 =A0/* card i=
s in high speed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* dual data rate mode */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
>> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* all=
ow SDIO FN0 writes outside of the VS CCCR range */
>> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur=
_blksize */
>> @@ -129,11 +132,13 @@ struct mmc_card {
>> =A0#define mmc_card_present(c) =A0 =A0((c)->state & MMC_STATE_PRESEN=
T)
>> =A0#define mmc_card_readonly(c) =A0 ((c)->state & MMC_STATE_READONLY=
)
>> =A0#define mmc_card_highspeed(c) =A0((c)->state & MMC_STATE_HIGHSPEE=
D)
>> +#define mmc_card_ddr_mode(c) =A0 ((c)->state & MMC_STATE_HIGHSPEED_=
DDR)
>> =A0#define mmc_card_blockaddr(c) =A0((c)->state & MMC_STATE_BLOCKADD=
R)
>>
>> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D M=
MC_STATE_PRESENT)
>> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READO=
NLY)
>> =A0#define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_HIGH=
SPEED)
>> +#define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIGHSPE=
ED_DDR)
>> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOC=
KADDR)
>>
>> =A0static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index e4898e9..b31e47a 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -107,6 +107,7 @@ struct mmc_data {
>> =A0#define MMC_DATA_WRITE (1 << 8)
>> =A0#define MMC_DATA_READ =A0(1 << 9)
>> =A0#define MMC_DATA_STREAM =A0 =A0 =A0 =A0(1 << 10)
>> +#define MMC_DDR_MODE =A0 =A0(1 << 11)
>>
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0bytes_xfered;
>>
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index f65913c..c775290 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -155,6 +155,10 @@ struct mmc_host {
>> =A0#define MMC_CAP_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* Can the host be disabled */
>> =A0#define MMC_CAP_NONREMOVABLE =A0 (1 << 8) =A0 =A0 =A0 =A0/* Nonre=
movable e.g. eMMC */
>> =A0#define MMC_CAP_WAIT_WHILE_BUSY =A0 =A0 =A0 =A0(1 << 9) =A0 =A0 =A0=
 =A0/* Waits while card is busy */
>> +#define MMC_CAP_1_8V_DDR =A0 =A0 =A0 =A0(1 << 10) =A0 =A0 =A0 /* ca=
n support */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* DDR mode at 1.8V */
>> +#define MMC_CAP_1_2V_DDR =A0 =A0 =A0 =A0(1 << 11) =A0 =A0 =A0 /* ca=
n support */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* DDR mode at 1.2V */
>>
>> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>>
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 8a49cbf..fc446de 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -268,11 +268,18 @@ struct _mmc_csd {
>>
>> =A0#define EXT_CSD_CARD_TYPE_26 =A0 (1<<0) =A0/* Card can run at 26M=
Hz */
>> =A0#define EXT_CSD_CARD_TYPE_52 =A0 (1<<1) =A0/* Card can run at 52M=
Hz */
>> -#define EXT_CSD_CARD_TYPE_MASK 0x3 =A0 =A0 /* Mask out reserved and=
 DDR bits */
>> +#define EXT_CSD_CARD_TYPE_MASK 0xF =A0 =A0 /* Mask out reserved bit=
s */
>> +#define EXT_CSD_CARD_TYPE_DDR_1_8V =A0(1<<2) =A0 /* Card can run at=
 52MHz */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* DDR mode @1.8V or 3V I/O */
>> +#define EXT_CSD_CARD_TYPE_DDR_1_2V =A0(1<<3) =A0 /* Card can run at=
 52MHz */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* DDR mode @1.2V I/O */
>> +#define EXT_CSD_CARD_TYPE_DDR_52 =A0 =A0 =A0 (EXT_CSD_CARD_TYPE_DDR=
_1_8V =A0\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | EXT_CSD_CARD_TYPE_DDR_1_2V)
>>
>> -#define EXT_CSD_BUS_WIDTH_1 =A0 =A00 =A0 =A0 =A0 /* Card is in 1 bi=
t mode */
>> =A0#define EXT_CSD_BUS_WIDTH_4 =A0 =A01 =A0 =A0 =A0 /* Card is in 4 =
bit mode */
>> =A0#define EXT_CSD_BUS_WIDTH_8 =A0 =A02 =A0 =A0 =A0 /* Card is in 8 =
bit mode */
>> +#define EXT_CSD_DDR_BUS_WIDTH_4 =A0 =A05 =A0 =A0/* Card is in 4 bit=
 DDR mode */
>> +#define EXT_CSD_DDR_BUS_WIDTH_8 =A0 =A06 =A0 =A0/* Card is in 8 bit=
 DDR mode */
>>
>> =A0/*
>> =A0* MMC_SWITCH access modes
>> --
>> 1.6.3.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
