From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: Fix size overflow for mmc partitions
Date: Mon, 18 Nov 2019 10:07:57 +0100
Message-ID: <CAPDyKFreYm3EsLO=e97RCOqaKJxkYJ+fqJcgskO7PtO15Tj4fQ@mail.gmail.com>
References: <20191117010045.4902-1-bradleybolen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191117010045.4902-1-bradleybolen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bradley Bolen <bradleybolen@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Hongjie Fang <hongjiefang@asrmicro.com>, Avri Altman <avri.altman@wdc.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "yinbo.zhu" <yinbo.zhu@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, 17 Nov 2019 at 02:00, Bradley Bolen <bradleybolen@gmail.com> wrote:
>
> With large eMMC cards, it is possible to create general purpose
> partitions that are bigger than 4GB.  The size member of the mmc_part
> struct is only an unsigned int which overflows for gp partitions larger
> than 4GB.  Change this to a u64 to handle the overflow.
>
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c   | 9 ++++-----
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c8804895595f..f6912ded652d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -297,7 +297,7 @@ static void mmc_manage_enhanced_area(struct mmc_card *card, u8 *ext_csd)
>         }
>  }
>
> -static void mmc_part_add(struct mmc_card *card, unsigned int size,
> +static void mmc_part_add(struct mmc_card *card, u64 size,
>                          unsigned int part_cfg, char *name, int idx, bool ro,
>                          int area_type)
>  {
> @@ -313,7 +313,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>  {
>         int idx;
>         u8 hc_erase_grp_sz, hc_wp_grp_sz;
> -       unsigned int part_size;
> +       u64 part_size;
>
>         /*
>          * General purpose partition feature support --
> @@ -343,8 +343,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>                                 (ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1]
>                                 << 8) +
>                                 ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3];
> -                       part_size *= (size_t)(hc_erase_grp_sz *
> -                               hc_wp_grp_sz);
> +                       part_size *= (hc_erase_grp_sz * hc_wp_grp_sz);
>                         mmc_part_add(card, part_size << 19,
>                                 EXT_CSD_PART_CONFIG_ACC_GP0 + idx,
>                                 "gp%d", idx, false,
> @@ -362,7 +361,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
>  static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  {
>         int err = 0, idx;
> -       unsigned int part_size;
> +       u64 part_size;
>         struct device_node *np;
>         bool broken_hpi = false;
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 9b6336ad3266..b59d35bb50ba 100644
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
>
