From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RESENT PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl
Date: Wed, 9 Mar 2016 10:50:26 +0000
Message-ID: <56DFFFF2.5050508@nvidia.com>
References: <1457333940-13076-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1457333940-13076-1-git-send-email-shawn.lin@rock-chips.com>
Sender: stable-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seshagiri Holi <sholi@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 07/03/16 06:59, Shawn Lin wrote:
> We should return -EINVAL if cmd is not MMC_IOC_CMD or MMC_IOC_MULTI_CMD,
> otherwise blkdev_roset will return -EPERM.
> 
> Android-adb calls make_block_device_writable with ioctl(BLKROSET), which
> will return error, make remount failed:
> remount of /system failed;
> couldn't make block device writable: Operation not permitted

I think you should elaborate here why the behaviour between -EINVAL and
-EPERM is different as they are both errors. In other words, add your
comment about how the ADB code is checking for a supported command.

> openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system", O_RDONLY) = 3
> ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not permitted)
> 
> Fixes: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/card/block.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 47bc87d..170f099 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -688,6 +688,9 @@ cmd_err:
>  static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>  	unsigned int cmd, unsigned long arg)
>  {
> +	if (cmd != MMC_IOC_CMD && cmd != MMC_IOC_MULTI_CMD)
> +		return -EINVAL;
> +
>  	/*
>  	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>  	 * whole block device, not on a partition.  This prevents overspray

The change is fine with me, but I agree with Seshagiri's comment that
instead of the above, move the following test to the mmc_blk_ioctl_cmd
and mmc_blk_ioctl_multi_cmd functions:

if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
                return -EPERM;

There is a case statement that then would return -EINVAL if the command
is not supported.

If you look at V3 of the patch "mmc: block: Add new ioctl to send multi
commands" [0] this is how we had it and only in V4 (the final version)
did we move it.

Cheers
Jon

[0] http://marc.info/?l=linux-mmc&m=144224289716299&w=2
