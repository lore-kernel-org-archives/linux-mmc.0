From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: card: modify mmc_getgeo function
Date: Wed, 21 Sep 2011 14:52:08 -0400
Message-ID: <m2ty8520fb.fsf@bob.laptop.org>
References: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43811 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752871Ab1IUSwP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:52:15 -0400
In-Reply-To: <1316516929-26694-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Tue, 20 Sep 2011 16:38:49 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi,

On Tue, Sep 20 2011, Girish K S wrote:
> In the earlier code the cylinder, sector and head are assigned
> independently. Current patch generates the cylinder number
> with the values of sector and head.
> This patch only makes they cylinder value to be dependent on
> the sector and head.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
>  drivers/mmc/card/block.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 1ff5486..bebb13b 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -226,9 +226,10 @@ static int mmc_blk_release(struct gendisk *disk, fmode_t mode)
>  static int
>  mmc_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>  {
> -	geo->cylinders = get_capacity(bdev->bd_disk) / (4 * 16);
>  	geo->heads = 4;
>  	geo->sectors = 16;
> +	geo->cylinders = get_capacity(bdev->bd_disk) /
> +		(geo->heads * geo->sectors);
>  	return 0;
>  }

Thanks, pushed to mmc-next for 3.2 with a reworded commit message:

Author: Girish K S <girish.shivananjappa@linaro.org>
Date:   Tue Sep 20 16:38:49 2011 +0530

    mmc: card: Remove duplicated constants

    Reuse heads/sectors instead of duplicating them in the cylinders
    calculation.

    Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
    Signed-off-by: Chris Ball <cjb@laptop.org>                    

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
