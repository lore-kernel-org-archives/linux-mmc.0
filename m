From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Date: Tue, 27 Feb 2018 21:51:05 +0800
Message-ID: <2994915e-18ff-1589-53b2-e726aa3fd872@rock-chips.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>, adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linus.walleij@linaro.org, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

ÔÚ 2018/2/27 19:33, Harish Jenny K N Ð´µÀ:
> From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> 
> Since RPMB area is accessible via special ioctl only and boot areas
> are unlikely to contain any partitions, exclude them all from listing
> in /proc/partitions. This will hide them from various user-level
> software (e.g. fdisk), thus avoiding unnecessary access attempts.
> 
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
> ---
>   drivers/mmc/core/block.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 20135a5..376e47e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2341,7 +2341,8 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>   	set_disk_ro(md->disk, md->read_only || default_ro);
>   	md->disk->flags = GENHD_FL_EXT_DEVT;
>   	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
> -		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
> +		md->disk->flags |= GENHD_FL_NO_PART_SCAN
> +				   | GENHD_FL_SUPPRESS_PARTITION_INFO;

I would prefer using GENHD_FL_HIDDEN instead of adding all these two
flags.

>   
>   	/*
>   	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
> 


-- 
Best Regards
Shawn Lin
