From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2] Recognize CSD structure version 3
Date: Fri, 18 Jun 2010 17:57:22 +0800
Message-ID: <AANLkTinGblB_HbMdb421IHVuVAfJoAOx_TeyMCmEu-iX@mail.gmail.com>
References: <20100603042007.GA15347@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58003 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556Ab0FRJ5W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Jun 2010 05:57:22 -0400
Received: by iwn9 with SMTP id 9so891466iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jun 2010 02:57:22 -0700 (PDT)
In-Reply-To: <20100603042007.GA15347@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, adrian.hunter@nokia.com

Hi, Kyungmin

I have verified on marvell pxa688 platform for sandisk 4.4 emmc, it wor=
ks.
Thanks for sharing.

Thanks
zhangfei

On Thu, Jun 3, 2010 at 12:20 PM, Kyungmin Park <kmpark@infradead.org> w=
rote:
> The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structur=
e version 3
> and version 3 have to check the CSD_STRUCTURE byte in the EXT_CSD reg=
ister.
>
> Also fix EXT_CSD revision message.
>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89f7a25..95c4fb2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -114,17 +114,18 @@ static int mmc_decode_cid(struct mmc_card *card=
)
> =A0static int mmc_decode_csd(struct mmc_card *card)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_csd *csd =3D &card->csd;
> - =A0 =A0 =A0 unsigned int e, m, csd_struct;
> + =A0 =A0 =A0 unsigned int e, m;
> =A0 =A0 =A0 =A0u32 *resp =3D card->raw_csd;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * We only understand CSD structure v1.1 and v1.2.
> =A0 =A0 =A0 =A0 * v1.2 has extra information in bits 15, 11 and 10.
> + =A0 =A0 =A0 =A0* also support the for eMMC v4.4 & v4.41.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 csd_struct =3D UNSTUFF_BITS(resp, 126, 2);
> - =A0 =A0 =A0 if (csd_struct !=3D 1 && csd_struct !=3D 2) {
> + =A0 =A0 =A0 csd->structure =3D UNSTUFF_BITS(resp, 126, 2);
> + =A0 =A0 =A0 if (csd->structure =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: unrecognised CSD =
structure version %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
), csd_struct);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
), csd->structure);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> @@ -207,11 +208,22 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* Version is coded in the CSD_STRUCTURE byte in the EX=
T_CSD register */
> + =A0 =A0 =A0 if (card->csd.structure =3D=3D 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ext_csd_struct =3D ext_csd[EXT_CSD_=
STRUCTURE];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd_struct > 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: un=
recognised EXT_CSD structure "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "versio=
n %d\n", mmc_hostname(card->host),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd_struct);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0card->ext_csd.rev =3D ext_csd[EXT_CSD_REV];
> =A0 =A0 =A0 =A0if (card->ext_csd.rev > 5) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unrecognised EXT_C=
SD structure "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "version %d\n", mmc_hos=
tname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.rev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: unrecognised EXT_C=
SD revision %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host=
), card->ext_csd.rev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d02d2c6..c83c7a7 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -24,6 +24,7 @@ struct mmc_cid {
> =A0};
>
> =A0struct mmc_csd {
> + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 structure;
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 mmca_vsn;
> =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0cmdclass;
> =A0 =A0 =A0 =A0unsigned short =A0 =A0 =A0 =A0 =A0tacc_clks;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 8a49cbf..52ce988 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -254,6 +254,7 @@ struct _mmc_csd {
> =A0#define EXT_CSD_BUS_WIDTH =A0 =A0 =A0183 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_HS_TIMING =A0 =A0 =A0185 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_CARD_TYPE =A0 =A0 =A0196 =A0 =A0 /* RO */
> +#define EXT_CSD_STRUCTURE =A0 =A0 =A0194 =A0 =A0 /* RO */
> =A0#define EXT_CSD_REV =A0 =A0 =A0 =A0 =A0 =A0192 =A0 =A0 /* RO */
> =A0#define EXT_CSD_SEC_CNT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0212 =A0 =A0=
 /* RO, 4 bytes */
> =A0#define EXT_CSD_S_A_TIMEOUT =A0 =A0217
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
