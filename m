From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Fix size overflow for mmc partitions
Date: Thu, 14 Nov 2019 12:12:01 +0100
Message-ID: <CAPDyKFokrmxu8CLOTVjtbzf3sMQcLahVqAtYP5X=wnqST5+Zdg@mail.gmail.com>
References: <1573097159-3914-1-git-send-email-bradleybolen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573097159-3914-1-git-send-email-bradleybolen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bradley Bolen <bradleybolen@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Avri Altman <avri.altman@wdc.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "yinbo.zhu" <yinbo.zhu@nxp.com>, Hongjie Fang <hongjiefang@asrmicro.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 7 Nov 2019 at 04:26, Bradley Bolen <bradleybolen@gmail.com> wrote:
>
> With large eMMC cards, it is possible to create general purpose
> partitions that are bigger than 4GB.  The size member of the mmc_part
> struct is only an unsigned int which overflows for gp partitions larger
> than 4GB.  Change this to a u64 to handle the overflow.
>
> Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
> ---
>  drivers/mmc/core/mmc.c   | 6 +++---
>  include/linux/mmc/card.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c880489..fc02124 100644
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

There is also a cast to a "size_t" while computing the part_size in
mmc_manage_gp_partitions(). Should we remove that as well?

[...]

Kind regards
Uffe
