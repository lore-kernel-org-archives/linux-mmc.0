From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v10] mmc : general purpose partition support.
Date: Tue, 4 Oct 2011 23:49:13 +0530
Message-ID: <CANfBPZ_aet5iF2zQ6zaqX0cjVB4LUnq6wLcHh2t_WNst3zXKAA@mail.gmail.com>
References: <1317750317-4489-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317750317-4489-1-git-send-email-linkinjeon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, adrian.hunter@intel.com, linus.walleij@linaro.org, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf.Hansson@stericsson.com, stefan.xk.nilsson@stericsson.com, per.forlin@stericsson.com, johan.rudholm@stericsson.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 4, 2011 at 11:15 PM, Namjae Jeon <linkinjeon@gmail.com> wro=
te:
> It allows gerneral purpose partitions in MMC Device.
> And I try to simpliy make mmc_blk_alloc_parts using mmc_part structur=
e suggested by Andrei Warkentin.
> After patching, we can see general purpose partitions like this.
>> cat /proc/partitions
> =A0 =A0 =A0 =A0 =A0179 0 847872 mmcblk0
> =A0 =A0 =A0 =A0 =A0179 192 4096 mmcblk0gp3
> =A0 =A0 =A0 =A0 =A0179 160 4096 mmcblk0gp2
> =A0 =A0 =A0 =A0 =A0179 128 4096 mmcblk0gp1
> =A0 =A0 =A0 =A0 =A0179 96 =A01052672 mmcblk0gp0
> =A0 =A0 =A0 =A0 =A0179 64 =A01024 mmcblk0boot1
> =A0 =A0 =A0 =A0 =A0179 32 =A01024 mmcblk0boot0
>
> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
> ---
> =A0drivers/mmc/card/block.c | =A0 34 +++++++++++++++++------------
> =A0drivers/mmc/core/mmc.c =A0 | =A0 52 ++++++++++++++++++++++++++++++=
++++++++++++---
> =A0include/linux/mmc/card.h | =A0 34 +++++++++++++++++++++++++++++-
> =A0include/linux/mmc/mmc.h =A0| =A0 =A05 +++-
> =A04 files changed, 105 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 782d5f8..fb6f1e9 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1470,26 +1470,32 @@ static int mmc_blk_alloc_part(struct mmc_card=
 *card,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/* MMC Physical partition consist of two boot partitions and
> + * up to four general purpose partitions.
> + * For each partitions enabled in EXT_CSD
> + * The block device will allocated to provide access to the partitio=
n.
> + */
> +
> =A0static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_b=
lk_data *md)
> =A0{
> - =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int idx, ret =3D 0;
>
> =A0 =A0 =A0 =A0if (!mmc_card_mmc(card))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 if (card->ext_csd.boot_size && mmc_boot_partition_acces=
s(card->host)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk_alloc_part(card, md, EX=
T_CSD_PART_CONFIG_ACC_BOOT0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0card->ext_csd.boot_size >> 9,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0true,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"boot0");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk_alloc_part(card, md, EX=
T_CSD_PART_CONFIG_ACC_BOOT1,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0card->ext_csd.boot_size >> 9,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0true,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"boot1");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 for (idx =3D 0; idx < card->nr_parts; idx++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((idx =3D=3D 0 || idx =3D=3D 1) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !mmc_boot_partition_acc=
ess(card->host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->part[idx].size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mmc_blk_alloc_p=
art(card, md,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->p=
art[idx].part_cfg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->p=
art[idx].size >> 9,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->p=
art[idx].force_ro,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->p=
art[idx].name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return ret;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c632b1f..2f458a0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -239,7 +239,9 @@ static int mmc_get_ext_csd(struct mmc_card *card,=
 u8 **new_ext_csd)
> =A0*/
> =A0static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
> =A0{
> - =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 int err =3D 0, idx;
> + =A0 =A0 =A0 unsigned int part_size;
> + =A0 =A0 =A0 u8 hc_erase_grp_sz =3D 0, hc_wp_grp_sz =3D 0;
>
> =A0 =A0 =A0 =A0BUG_ON(!card);
>
> @@ -340,7 +342,14 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * There are two boot regions of equal=
 size, defined in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * multiples of 128K.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.boot_size =3D ext_csd[EXT=
_CSD_BOOT_MULT] << 17;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BOOT_MULT]) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (idx =3D 0; idx < M=
MC_NUM_BOOT_PARTITION; idx++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 part_si=
ze =3D ext_csd[EXT_CSD_BOOT_MULT] << 17;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_par=
t_add(card, part_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_PART_CONFIG_ACC_BOOT0 + idx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "boot%d", idx, true);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0card->ext_csd.raw_hc_erase_gap_size =3D
> @@ -362,9 +371,9 @@ static int mmc_read_ext_csd(struct mmc_card *card=
, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.raw_partition_support =3D=
 ext_csd[EXT_CSD_PARTITION_SUPPORT];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((ext_csd[EXT_CSD_PARTITION_SUPPORT=
] & 0x2) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ext_csd[EXT_CSD_PARTITION_ATT=
RIBUTE] & 0x1)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 hc_erase_grp_sz =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc_erase_grp_sz =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_cs=
d[EXT_CSD_HC_ERASE_GRP_SIZE];
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 hc_wp_grp_sz =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc_wp_grp_sz =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_cs=
d[EXT_CSD_HC_WP_GRP_SIZE];
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.enhanced=
_area_en =3D 1;
> @@ -393,6 +402,41 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.enhanced=
_area_offset =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.enhanced=
_area_size =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* General purpose partition feature =
support --
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If ext_csd have the size of genera=
l purpose partitions,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* set size, part_cfg, partition name=
 in mmc_part.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_PARTITION_SUPPORT] =
&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_PART_SUPPORT_PA=
RT_EN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.enhan=
ced_area_en !=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc_eras=
e_grp_sz =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hc_wp_g=
rp_sz =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.enhanced_area_en =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (idx =3D 0; idx < M=
MC_NUM_GP_PARTITION; idx++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ex=
t_csd[EXT_CSD_GP_SIZE_MULT + idx * 3] &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !ext_cs=
d[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1] &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !ext_cs=
d[EXT_CSD_GP_SIZE_MULT + idx * 3 + 2])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 part_si=
ze =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ext_cs=
d[EXT_CSD_GP_SIZE_MULT + idx * 3 + 2]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 << 16) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ext_cs=
d[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 << 8) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd=
[EXT_CSD_GP_SIZE_MULT + idx * 3];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 part_si=
ze *=3D (size_t)(hc_erase_grp_sz *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 hc_wp_grp_sz);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_par=
t_add(card, part_size << 19,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "gp%d", idx, false);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.sec_trim_mult =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_SEC_TR=
IM_MULT];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.sec_erase_mult =3D
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 5294ddf..0522627 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -12,6 +12,7 @@
>
> =A0#include <linux/mmc/core.h>
> =A0#include <linux/mod_devicetable.h>
> +#include <linux/genhd.h>
>
> =A0struct mmc_cid {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0manfid;
> @@ -64,7 +65,6 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enhanced_a=
rea_en; =A0 =A0 =A0 /* enable bit */
> =A0 =A0 =A0 =A0unsigned long long =A0 =A0 =A0enhanced_area_offset; =A0=
 /* Units: Byte */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0enhanced_area_size=
; =A0 =A0 /* Units: KB */
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0boot_size; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0/* in bytes */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_part=
ition_support; =A0/* 160 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_eras=
ed_mem_count; =A0 /* 181 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_ext_=
csd_structure; =A0/* 194 */
> @@ -158,6 +158,23 @@ struct sdio_func_tuple;
>
> =A0#define SDIO_MAX_FUNCS =A0 =A0 =A0 =A0 7
>
> +/* The number of MMC physical partitions
> + * It consist of boot partitions(2), general purpose partitions(4) i=
n MMC v4.4
> + */
> +#define MMC_NUM_BOOT_PARTITION 2
> +#define MMC_NUM_GP_PARTITION =A0 4
> +#define MMC_NUM_PHY_PARTITION =A06
> +
> +/*
> + * MMC Physical partitions
> + */
> +struct mmc_part {
> + =A0 =A0 =A0 unsigned int =A0 =A0size; =A0 /* partition size (in byt=
es) */
> + =A0 =A0 =A0 unsigned int =A0 =A0part_cfg; =A0 =A0 =A0 /* it used to=
 part_type */
> + =A0 =A0 =A0 char =A0 =A0name[DISK_NAME_LEN];
> + =A0 =A0 =A0 bool =A0 =A0force_ro; =A0 =A0 =A0 /* to make boot parts=
 RO by default */
> +};
> +
> =A0/*
> =A0* MMC device
> =A0*/
> @@ -219,9 +236,24 @@ struct mmc_card {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd_bus_speed; =A0 =
/* Bus Speed Mode set for the card */
>
> =A0 =A0 =A0 =A0struct dentry =A0 =A0 =A0 =A0 =A0 *debugfs_root;
> + =A0 =A0 =A0 struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physica=
l partitions */
> + =A0 =A0 =A0 unsigned int =A0 =A0nr_parts;
> =A0};
>
> =A0/*
> + * This function fill contents in mmc_part.
> + */
> +static inline void mmc_part_add(struct mmc_card *card, unsigned int =
size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int part_cfg, =
char *name, int idx, bool ro)
> +{
> + =A0 =A0 =A0 card->part[card->nr_parts].size =3D size;
> + =A0 =A0 =A0 card->part[card->nr_parts].part_cfg =3D part_cfg;
> + =A0 =A0 =A0 sprintf(card->part[card->nr_parts].name, name, idx);
> + =A0 =A0 =A0 card->part[card->nr_parts].force_ro =3D ro;
> + =A0 =A0 =A0 card->nr_parts++;
> +}
> +
> +/*
> =A0* =A0The world is not perfect and supplies us with broken mmc/sdio=
 devices.
> =A0* =A0For at least some of these bugs we need a work-around.
> =A0*/
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 50af227..ea558eb 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -270,6 +270,7 @@ struct _mmc_csd {
> =A0* EXT_CSD fields
> =A0*/
>
> +#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R/W =
*/
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 162 =A0 =A0 /* R/W =
*/
> @@ -313,7 +314,9 @@ struct _mmc_csd {
>
> =A0#define EXT_CSD_PART_CONFIG_ACC_MASK =A0 (0x7)
> =A0#define EXT_CSD_PART_CONFIG_ACC_BOOT0 =A0(0x1)
> -#define EXT_CSD_PART_CONFIG_ACC_BOOT1 =A0(0x2)
> +#define EXT_CSD_PART_CONFIG_ACC_GP0 =A0 =A0(0x4)
> +
> +#define EXT_CSD_PART_SUPPORT_PART_EN =A0 (0x1)
>
> =A0#define EXT_CSD_CMD_SET_NORMAL =A0 =A0 =A0 =A0 (1<<0)
> =A0#define EXT_CSD_CMD_SET_SECURE =A0 =A0 =A0 =A0 (1<<1)
> --
> 1.7.4.4
>

Stupid question - This will affect all MMC instances, right ? Doesn't
this constitute a ABI breakage for user space scripts ?
