From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: block: Move duplicate check
Date: Wed, 14 Jun 2017 20:22:52 +0800
Message-ID: <e31ca826-8391-55b0-4a9b-f5ff0b0c5882@rock-chips.com>
References: <20170614114851.17146-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:46223 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbdFNMW7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2017 08:22:59 -0400
In-Reply-To: <20170614114851.17146-1-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com

Hi Linus,

On 2017/6/14 19:48, Linus Walleij wrote:
> mmc_blk_ioctl() calls either mmc_blk_ioctl_cmd() or
> mmc_blk_ioctl_multi_cmd() and each of these make the same
> check. Factor it into the first call and save one chunk
> of duplicate code.
>

Probably you still cannot save the check like what this patch
does. Refer to commit,

83c742c344c08 ("mmc: block: fix ABI regression of mmc_blk_ioctl")

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/block.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1ce6012ce3c1..c80bee4a9cff 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -566,14 +566,6 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>  	int err = 0, ioc_err = 0;
>  	struct request *req;
>
> -	/*
> -	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> -	 * whole block device, not on a partition.  This prevents overspray
> -	 * between sibling partitions.
> -	 */
> -	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> -		return -EPERM;
> -
>  	idata = mmc_blk_ioctl_copy_from_user(ic_ptr);
>  	if (IS_ERR(idata))
>  		return PTR_ERR(idata);
> @@ -626,14 +618,6 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>  	__u64 num_of_cmds;
>  	struct request *req;
>
> -	/*
> -	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> -	 * whole block device, not on a partition.  This prevents overspray
> -	 * between sibling partitions.
> -	 */
> -	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> -		return -EPERM;
> -
>  	if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
>  			   sizeof(num_of_cmds)))
>  		return -EFAULT;
> @@ -700,6 +684,14 @@ static int mmc_blk_ioctl_multi_cmd(struct block_device *bdev,
>  static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>  	unsigned int cmd, unsigned long arg)
>  {
> +	/*
> +	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
> +	 * whole block device, not on a partition.  This prevents overspray
> +	 * between sibling partitions.
> +	 */
> +	if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
> +		return -EPERM;
> +
>  	switch (cmd) {
>  	case MMC_IOC_CMD:
>  		return mmc_blk_ioctl_cmd(bdev,
>


-- 
Best Regards
Shawn Lin

