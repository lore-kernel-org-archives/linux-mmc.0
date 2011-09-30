From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: [PATCH v4] mmc : general purpose partition support.
Date: Fri, 30 Sep 2011 13:34:24 -0400
Message-ID: <CANz0V+474_SvriQmUWx9VJwAk-iggu-h+A1WH-zGPBJgLzJDAg@mail.gmail.com>
References: <1317397619-7091-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52871 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab1I3Re4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2011 13:34:56 -0400
In-Reply-To: <1317397619-7091-1-git-send-email-linkinjeon@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, linus.walleij@linaro.org, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf.Hansson@stericsson.com, stefan.xk.nilsson@stericsson.com, per.forlin@stericsson.com, johan.rudholm@stericsson.com

Hi Namjae,

Why don't you update card->nr_parts inside mmc_part_add? You're making
this too complicated. There
is also no need for the part_cfg array.

2011/9/30 Namjae Jeon <linkinjeon@gmail.com>:
> It allows gerneral purpose partitions in MMC Device.
> And I try to simpliy make mmc_blk_alloc_parts using mmc_part structur=
e suggested by Andrei Warkentin.
> After patching, we can see general purpose partitions like this.
>> cat /proc/partitions
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 0 847872 mmcblk0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 192 4096 mmcblk0gp3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 160 4096 mmcblk0gp2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 128 4096 mmcblk0gp1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 96 =C2=A01052672 mmcblk0gp0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 64 =C2=A01024 mmcblk0boot1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0179 32 =C2=A01024 mmcblk0boot0
>
> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
> ---

>
> +/* partition configuration array */
> +static const unsigned int part_cfg[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 0x1, =C2=A0 =C2=A00x2, =C2=A0 =C2=A00x4, =C2=A0=
 =C2=A00x5, =C2=A0 =C2=A00x6, =C2=A0 =C2=A07,
> +};
> +

No need. Plus this is obscure.

> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->ext_csd.boot=
_size =3D ext_csd[EXT_CSD_BOOT_MULT] << 17;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ext_csd[EXT_CS=
D_BOOT_MULT]) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 card->nr_parts =3D MMC_NUM_BOOT_PARTITION;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 for (idx =3D 0, part_num =3D 0;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 idx < MMC_NUM_BOOT_PARTITION; idx++=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_num++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_size =3D ext_csd[EXT_CSD_BOOT_=
MULT] << 17;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_part_add(card, part_size, part_=
cfg[idx],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "boot%d=
", idx, part_num, true);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

There is no need for part_num (you have idx for that). And there is no
need for passing the actual array
index either - that's why you have mmc_part_add: it will do
card->parts[card->nr_parts++] =3D new_part.

               if (ext_csd[EXT_CSD_BOOT_MULT]) {
                       for (idx =3D 0, part_num =3D 0;
                               idx < MMC_NUM_BOOT_PARTITION; idx++) {
                               part_size =3D ext_csd[EXT_CSD_BOOT_MULT]=
 << 17;
                               mmc_part_add(card, part_size,
EXT_CSD_PART_CONFIG_ACC_BOOT0 + idx,
                                       "boot%d", idx, true);
                       }
               }


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ext_csd[EXT_CS=
D_PARTITION_SUPPORT] & 0x1) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u8 hc_erase_grp_sz =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 u8 hc_wp_grp_sz =3D
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 card->ext_csd.enhanced_area_en =3D 1;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 card->nr_parts +=3D MMC_NUM_GP_PARTITION;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 for (part_num =3D 0, gp_size_mult =3D 143;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 idx < card->nr_parts;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 idx++, part_num++, gp_size_mult +=3D=
 3) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ext_csd[gp_size_mult] &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !ext_cs=
d[gp_size_mult + 1] &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !ext_cs=
d[gp_size_mult + 2])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_size =3D (ext_csd[gp_size_mult=
 + 2] << 16) +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ext_cs=
d[gp_size_mult + 1] << 8) +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_csd=
[gp_size_mult];
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_size *=3D (size_t)(hc_erase_gr=
p_sz *
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hc_wp_g=
rp_sz);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_size <<=3D 19;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_part_add(card, part_size, part_=
cfg[idx],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "gp%d",=
 idx, part_num, false);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

Same story: get rid of part_num, don't touch card->nr_parts, and get
rid of part_cfg array access.

                       card->ext_csd.enhanced_area_en =3D 1;
                       for (idx =3D 0, gp_size_mult =3D 143;
                               idx < MMC_NUM_GP_PARTITION;
                               idx++, gp_size_mult +=3D 3) {
                               if (!ext_csd[gp_size_mult] &&
                                       !ext_csd[gp_size_mult + 1] &&
                                       !ext_csd[gp_size_mult + 2])
                                       continue;
                               part_size =3D (ext_csd[gp_size_mult + 2]=
 << 16) +
                                       (ext_csd[gp_size_mult + 1] << 8)=
 +
                                       ext_csd[gp_size_mult];
                               part_size *=3D (size_t)(hc_erase_grp_sz =
*
                                       hc_wp_grp_sz);
                               part_size <<=3D 19;
                               mmc_part_add(card, part_size, idx +
EXT_CSD_PART_CONFIG_ACC_GP0,
                                       "gp%d", idx, false);
                       }
               }


>  /*
> + * This function fill contents in mmc_part.
> + */
> +static inline void mmc_part_add(struct mmc_card *card, unsigned int =
size,
> +       unsigned int part_cfg, char *name, int idx, int part_num, boo=
l ro)
> +{
> +       card->part[idx].size =3D size;
> +       card->part[idx].cookie =3D part_cfg;
> +       sprintf(card->part[idx].name, name, part_num);
> +       card->part[idx].force_ro =3D ro;
> +}

static inline void mmc_part_add(struct mmc_card *card, unsigned int siz=
e,
       unsigned int part_cfg, char *name, int idx, bool ro)
{
       card->part[card->nr_parts].size =3D size;
       card->part[card->nr_parts].cookie =3D part_cfg;
       sprintf(card->part[card->nr_parts].name, name, idx);
       card->part[card->nr_parts].force_ro =3D ro;
       card->nr_parts++;
}

> =C2=A0#define EXT_CSD_PART_CONFIG_ACC_MASK =C2=A0 (0x7)
> -#define EXT_CSD_PART_CONFIG_ACC_BOOT0 =C2=A0(0x1)
> -#define EXT_CSD_PART_CONFIG_ACC_BOOT1 =C2=A0(0x2)
>

I'd also keep the MMC_NUM_BOOT_PARTITION and MMC_NUM_GP_PARTITION defs
at the same location.

/* The number of MMC physical partitions
 * It consist of boot partitions(2), general purpose partitions(4) in M=
MC v4.4
 */
#define MMC_NUM_BOOT_PARTITION 2
#define MMC_NUM_GP_PARTITION   4

#define EXT_CSD_PART_CONFIG_ACC_BOOT0  (0x1)
#define EXT_CSD_PART_CONFIG_ACC_GP0       (0x4)

A
