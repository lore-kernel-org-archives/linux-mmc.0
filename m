From: Avri Altman <Avri.Altman@wdc.com>
Subject: RE: [PATCH] mmc: core: Fix size overflow for mmc partitions
Date: Mon, 4 Nov 2019 13:37:52 +0000
Message-ID: <MN2PR04MB6991B930872AB555EB56F16CFC7F0@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20191031011132.5947-1-bradleybolen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191031011132.5947-1-bradleybolen@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bradley Bolen <bradleybolen@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "info@metux.net" <info@metux.net>, "hongjiefang@asrmicro.com" <hongjiefang@asrmicro.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "yinbo.zhu@nxp.com" <yinbo.zhu@nxp.com>
List-Id: linux-mmc@vger.kernel.org

>=20
>=20
> With large eMMC cards, it is possible to create general purpose partition=
s that
> are bigger than 4GB.  The size member of the mmc_part struct is only an
> unsigned int which overflows for gp partitions larger than 4GB.  Change t=
his to a
> u64 to handle the overflow.
>=20
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
> ---
>  drivers/mmc/core/mmc.c   | 4 ++--
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> c8804895595f..4e89cf6524a1 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -297,7 +297,7 @@ static void mmc_manage_enhanced_area(struct
> mmc_card *card, u8 *ext_csd)
>         }
>  }
>=20
> -static void mmc_part_add(struct mmc_card *card, unsigned int size,
> +static void mmc_part_add(struct mmc_card *card, u64 size,
>                          unsigned int part_cfg, char *name, int idx, bool=
 ro,
>                          int area_type)
>  {
> @@ -345,7 +345,7 @@ static void mmc_manage_gp_partitions(struct
> mmc_card *card, u8 *ext_csd)
>                                 ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
>                         part_size *=3D (size_t)(hc_erase_grp_sz *
Need to adjust part_size as well.

Thanks,
Avri
>                                 hc_wp_grp_sz);
> -                       mmc_part_add(card, part_size << 19,
> +                       mmc_part_add(card, (u64)part_size << 19,
>                                 EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
>                                 "gp%d", idx, false,
>                                 MMC_BLK_DATA_AREA_GP); diff --git
> a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 9b6336ad3266..b59d35bb50ba 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -226,7 +226,7 @@ struct mmc_queue_req;
>   * MMC Physical partitions
>   */
>  struct mmc_part {
> -       unsigned int    size;   /* partition size (in bytes) */
> +       u64             size;   /* partition size (in bytes) */
>         unsigned int    part_cfg;       /* partition type */
>         char    name[MAX_MMC_PART_NAME_LEN];
>         bool    force_ro;       /* to make boot parts RO by default */
> --
> 2.17.1
