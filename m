From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 07/15] mmc: sd: report correct speed and capacity of
 uhs cards
Date: Fri, 6 May 2011 06:39:24 -0400
Message-ID: <BANLkTinm0o4ehPNkv58PqW0g8C5QbVwC6Q@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-8-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61120 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1EFKjZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:39:25 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so3291153vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:39:24 -0700 (PDT)
In-Reply-To: <1304578151-1775-8-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> Since only UHS-I cards respond with S18A set in response to ACMD41,
> we set the card as ultra-high-speed after successfull initialization.
> We need to decide whether a card is SDXC based on the C_SIZE field
> of CSDv2.0 register. According to Physical Layer spec v3.01, the
> minimum value of C_SIZE for SDXC card is 00FFFFh.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/core/bus.c =A0 | =A0 11 ++++++++---
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 10 +++++++++-
> =A0include/linux/mmc/card.h | =A0 =A07 +++++++
> =A03 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index d6d62fd..393d817 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -274,8 +274,12 @@ int mmc_add_card(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case MMC_TYPE_SD:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D "SD";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_blockaddr(card))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D "SDHC";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_blockaddr(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_ext_capaci=
ty(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D=
 "SDXC";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D=
 "SDHC";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case MMC_TYPE_SDIO:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D "SDIO";
> @@ -299,7 +303,8 @@ int mmc_add_card(struct mmc_card *card)
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "%s: new %s%s%s card =
at address %04x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->hos=
t),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_highspeed(card=
) ? "high speed " : "",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sd_card_uhs(card) ?=
 "ultra high speed " :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_card_highspeed(car=
d) ? "high speed " : ""),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_ddr_mode(card=
) ? "DDR " : "",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type, card->rca);
> =A0 =A0 =A0 =A0}
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 9270d82..ee32dd8 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -130,7 +130,7 @@ static int mmc_decode_csd(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case 1:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is a block-addressed SDHC car=
d. Most
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is a block-addressed SDHC or =
SDXC card. Most
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * interesting fields are unused and h=
ave fixed
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * values. To avoid getting tripped by=
 buggy cards,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * we assume those fixed values oursel=
ves.
> @@ -144,6 +144,11 @@ static int mmc_decode_csd(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0e =3D UNSTUFF_BITS(resp, 96, 3);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->max_dtr =A0 =A0 =A0=3D tran_exp[e=
] * tran_mant[m];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->cmdclass =A0 =A0 =3D UNSTUFF_BITS=
(resp, 84, 12);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 csd->c_size =A0 =A0 =A0 =3D UNSTUFF_BIT=
S(resp, 48, 22);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SDXC cards have a minimum C_SIZE of =
0x00FFFF */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (csd->c_size >=3D 0xFFFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_ext_capaci=
ty(card);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m =3D UNSTUFF_BITS(resp, 48, 22);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0csd->capacity =A0 =A0 =3D (1 + m) << 1=
0;
> @@ -917,6 +922,9 @@ static int mmc_sd_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_sd_init_uhs_card(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Card is an ultra-high-speed card */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sd_card_set_uhs(card);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Attempt to change to high-speed (if=
 supported)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 47b5ad3..d8dffc9 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -30,6 +30,7 @@ struct mmc_csd {
> =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0cmdclass;
> =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0tacc_clks;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0tacc_ns;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0c_size;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0r2w_factor;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0max_dtr;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0erase_size; =A0 =A0=
 =A0 =A0 =A0 =A0 /* In sectors */
> @@ -158,6 +159,8 @@ struct mmc_card {
> =A0#define MMC_STATE_HIGHSPEED =A0 =A0(1<<2) =A0 =A0 =A0 =A0 =A0/* ca=
rd is in high speed mode */
> =A0#define MMC_STATE_BLOCKADDR =A0 =A0(1<<3) =A0 =A0 =A0 =A0 =A0/* ca=
rd uses block-addressing */
> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 /* card is =
in high speed mode */
> +#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/* card is in ultra high speed mode */
> +#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0 =A0/=
* card is SDXC */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* allo=
w SDIO FN0 writes outside of the VS CCCR range */
> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur_=
blksize */
> @@ -293,12 +296,16 @@ static inline void __maybe_unused remove_quirk(=
struct mmc_card *card, int data)
> =A0#define mmc_card_highspeed(c) =A0((c)->state & MMC_STATE_HIGHSPEED=
)
> =A0#define mmc_card_blockaddr(c) =A0((c)->state & MMC_STATE_BLOCKADDR=
)
> =A0#define mmc_card_ddr_mode(c) =A0 ((c)->state & MMC_STATE_HIGHSPEED=
_DDR)
> +#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
> +#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>
> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D MM=
C_STATE_PRESENT)
> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READON=
LY)
> =A0#define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_HIGHS=
PEED)
> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOCK=
ADDR)
> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIGHSP=
EED_DDR)
> +#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIGHS=
PEED)
> +#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SDXC)
>
> =A0static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
> =A0{
> --
> 1.7.1
>
>
