From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 1/1]mmc: implemented eMMC4.4 enhanced area feature
Date: Thu, 20 Jan 2011 16:12:48 +0000
Message-ID: <20110120161248.GA11774@void.printf.net>
References: <20110120075556.GA23566@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110120075556.GA23566@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

Hi Chuanxiao,

On Thu, Jan 20, 2011 at 03:55:56PM +0800, Chuanxiao Dong wrote:
> Enhanced area feature is a new feature defined in eMMC4.4 standard. T=
his
> kind of area can help to improve the performance.
>=20
> MMC driver will read out the enhanced area offset and size and add th=
em
> to be device attributes. The feature enabling should be done in manuf=
actory.
> To use this feature, bit ERASE_GRP_DEF should also be set.
>=20
> Documentation/ABI/testing/sysfs-devices-mmc described the two new att=
ributes
>=20
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-mmc |   19 ++++++
>  drivers/mmc/core/mmc.c                      |   80 +++++++++++++++++=
++++++++++
>  include/linux/mmc/card.h                    |    3 +
>  include/linux/mmc/mmc.h                     |    3 +
>  4 files changed, 105 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-mmc
>=20
> diff --git a/Documentation/ABI/testing/sysfs-devices-mmc b/Documentat=
ion/ABI/testing/sysfs-devices-mmc
> new file mode 100644
> index 0000000..6e759ae
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-mmc
> @@ -0,0 +1,19 @@
> +What:		/sys/devices/.../mmc_host/mmcX/mmcX:XXXX/enhanced_area_offset
> +Date:		January 2011
> +Contact:	Chuanxiao Dong <chuanxiao.dong@intel.com>
> +Description:
> +		Enhanced area is a new feature defined in eMMC4.4 standard.eMMC4.4=
 or
> +		later card can support such feature. This kind of area can help to
> +		improve the card performance. If the feature is enabled, this attr=
ibute
> +		will indicate the start address of enhanced data area. If not, thi=
s
> +		attribute will be -EINVAL. Unit Byte. Format decimal.
> +
> +What:		/sys/devices/.../mmc_host/mmcX/mmcX:XXXX/enhanced_area_size
> +Date:		January 2011
> +Contact:	Chuanxiao Dong <chuanxiao.dong@intel.com>
> +Description:
> +		Enhanced area is a new feature defined in eMMC4.4 standard. eMMC4.=
4 or
> +		later card can support such feature. This kind of area can help to
> +		improve the card performance. If the feature is enabled, this attr=
ibute
> +		will indicate the size of enhanced data area. If not, this attribu=
te
> +		will be -EINVAL. Unit KByte. Format decimal.

This is still wrapped at > 80 columns.

> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 16006ef..5ab44bb 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -302,6 +302,48 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d)
>  	}
> =20
>  	if (card->ext_csd.rev >=3D 4) {
> +		/*
> +		 * Enhanced area feature support
> +		 * check whether eMMC card has the Enhanced area enabled.
> +		 * if so, export enhanced area offset and size to
> +		 * user by adding sysfs interface
> +		 */
> +		if ((ext_csd[EXT_CSD_PARTITION_SUPPORT] & 0x2) &&
> +				(ext_csd[EXT_CSD_PARTITION_ATTRIBUTE] & 0x1)) {
> +			u8 hc_erase_grp_sz =3D
> +				ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
> +			u8 hc_wp_grp_sz =3D
> +				ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
> +			/*
> +			 * set a flag to identify whether the enhanced
> +			 * user data is enabled
> +			 */
> +			card->ext_csd.enhanced_area_en =3D 1;
> +			/*
> +			 * calculate the enhanced data area offset, unit B
> +			 */
> +			card->ext_csd.enhanced_area_offset =3D
> +				(ext_csd[139] << 24) + (ext_csd[138] << 16) +
> +				(ext_csd[137] << 8) + ext_csd[136];
> +			if (mmc_card_blockaddr(card))
> +				card->ext_csd.enhanced_area_offset <<=3D 9;
> +			/*
> +			 * calculate the enhanced data area size, unit KB
> +			 */
> +			card->ext_csd.enhanced_area_size =3D
> +				(ext_csd[142] << 16) + (ext_csd[141] << 8) +
> +				ext_csd[140];
> +			card->ext_csd.enhanced_area_size *=3D
> +				(size_t)(hc_erase_grp_sz * hc_wp_grp_sz);
> +			card->ext_csd.enhanced_area_size <<=3D 9;
> +		} else {
> +			/*
> +			 * If not enabled enhanced area, disable these
> +			 * device attributes
> +			 */
> +			card->ext_csd.enhanced_area_offset =3D -EINVAL;
> +			card->ext_csd.enhanced_area_size =3D -EINVAL;
> +		}
>  		card->ext_csd.sec_trim_mult =3D
>  			ext_csd[EXT_CSD_SEC_TRIM_MULT];
>  		card->ext_csd.sec_erase_mult =3D
> @@ -336,6 +378,9 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid=
);
>  MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
>  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
> +MMC_DEV_ATTR(enhanced_area_offset, "%lld\n",
> +		card->ext_csd.enhanced_area_offset);
> +MMC_DEV_ATTR(enhanced_area_size, "%d\n", card->ext_csd.enhanced_area=
_size);
> =20
>  static struct attribute *mmc_std_attrs[] =3D {
>  	&dev_attr_cid.attr,
> @@ -349,6 +394,8 @@ static struct attribute *mmc_std_attrs[] =3D {
>  	&dev_attr_name.attr,
>  	&dev_attr_oemid.attr,
>  	&dev_attr_serial.attr,
> +	&dev_attr_enhanced_area_offset.attr,
> +	&dev_attr_enhanced_area_size.attr,
>  	NULL,
>  };
> =20
> @@ -484,6 +531,39 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
>  	}
> =20
>  	/*
> +	 * If enhanced_area_en is TRUE, host need to enable
> +	 * ERASE_GRP_DEF bit.
> +	 * ERASE_GRP_DEF bit will be lost every time
> +	 * after a reset or power off.
> +	 */
> +	if (card->ext_csd.enhanced_area_en) {
> +		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				EXT_CSD_ERASE_GROUP_DEF, 1);
> +
> +		if (err && err !=3D -EBADMSG)
> +			goto free_card;
> +
> +		if (err) {
> +			err =3D 0;
> +			/*
> +			 * Just disable enhanced area off & sz
> +			 * will try to enable ERASE_GROUP_DEF
> +			 * during next time reinit
> +			 */
> +			card->ext_csd.enhanced_area_offset =3D -EINVAL;
> +			card->ext_csd.enhanced_area_size =3D -EINVAL;
> +		} else {
> +			card->ext_csd.erase_group_def =3D 1;
> +			/*
> +			 * enable ERASE_GRP_DEF successfully.
> +			 * This will affect the erase size, so
> +			 * here need to reset erase size
> +			 */
> +			mmc_set_erase_size(card);
> +		}
> +	}
> +
> +	/*
>  	 * Activate high speed (if supported)
>  	 */
>  	if ((card->ext_csd.hs_max_dtr !=3D 0) &&
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 8ce0827..736697f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -54,6 +54,9 @@ struct mmc_ext_csd {
>  	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
>  	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
>  	unsigned int		trim_timeout;		/* In milliseconds */
> +	bool			enhanced_area_en;	/* enhanced area en */
> +	loff_t		enhanced_area_offset;	/* enhanced area addr */
> +	size_t		enhanced_area_size;		/* enhanced area size */

Now enhanced_area_en is aligned correctly, but the other two aren't.

This adds a warning:

drivers/mmc/core/mmc.c: In function =E2=80=98mmc_enhanced_area_size_sho=
w=E2=80=99:
drivers/mmc/core/mmc.c:383:261: warning: format =E2=80=98%d=E2=80=99 ex=
pects type =E2=80=98int=E2=80=99,
but argument 3 has type =E2=80=98size_t=E2=80=99

If you really want size_t, you should use %zu for it -- see
Documentation/printk-formats.txt.  (Declaring it as unsigned int would
work fine too.)

Oh, and let's mention the units of _offset and _size in the comment in
card.h.

>  };
> =20
>  struct sd_scr {
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 612301f..264ba54 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -253,6 +253,8 @@ struct _mmc_csd {
>   * EXT_CSD fields
>   */
> =20
> +#define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
> +#define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
>  #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
>  #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
>  #define EXT_CSD_BUS_WIDTH		183	/* R/W */
> @@ -262,6 +264,7 @@ struct _mmc_csd {
>  #define EXT_CSD_CARD_TYPE		196	/* RO */
>  #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
>  #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
> +#define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
>  #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
>  #define EXT_CSD_HC_ERASE_GRP_SIZE	224	/* RO */
>  #define EXT_CSD_SEC_TRIM_MULT		229	/* RO */

Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
