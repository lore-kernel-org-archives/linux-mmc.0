From: Seshagiri Holi <sholi@nvidia.com>
Subject: RE: [PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl
Date: Mon, 7 Mar 2016 11:46:28 +0000
Message-ID: <870544d2b7024a37a4d7964db9cf3125@bgmail102.nvidia.com>
References: <1457331857-4953-1-git-send-email-shawn.lin@rock-chips.com>
 <4aa8686868a640499a9313f4a77ddc46@bgmail102.nvidia.com>
 <56DD2AE9.7000708@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8784 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbcCGLqf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2016 06:46:35 -0500
In-Reply-To: <56DD2AE9.7000708@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "shawn.lin@kernel-upstream.org" <shawn.lin@kernel-upstream.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-mmc <linux-mmc@vger.kernel.org>

thanks for the details.

Maybe fix from my view is, that the check in function mmc_blk_ioctl(), should move to respective function mmc_blk_ioctl_cmd and mmc_blk_ioctl_multi_cmd.

if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
                return -EPERM;

I think Ulf Hansson can take a final call.



-----Original Message-----
From: Shawn Lin [mailto:shawn.lin@rock-chips.com] 
Sent: Monday, March 07, 2016 12:47 PM
To: Seshagiri Holi; Ulf Hansson
Cc: shawn.lin@rock-chips.com; shawn.lin@kernel-upstream.org; Jonathan Hunter; linux-mmc
Subject: Re: [PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl

On 2016/3/7 15:04, Seshagiri Holi wrote:
> Hi Shawn,
> 	I am not sure how why blkdev_roset is iocl function call  is landing in mmc_blk_ioctl. Could it be a IOCTL mapping issue ?
> Regards
> Seshagiri
>

Really no.
blkdev_ioctl-> case BLKROSET ->
blkdev_roset -> __blkdev_driver_ioctl ->disk->fops->ioctl

If mmc_blk_ioctl return -EINVAL, that will fails the check of !is_unrecognized_ioctl. Then the code will continue to work. But commit: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi commands") changes the behaviour to check the cmd(BLKROSET) with CAP_SYS_RAWIO firstly. So blkdev_ioctl finally get -EPERM instead of -EINVAL. So the result you can find:

remount of /system failed;
couldn't make block device writable: Operation not permitted

openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system",
O_RDONLY) = 3 ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not permitted)

>
> -----Original Message-----
> From: Shawn Lin [mailto:shawn.lin@rock-chips.com]
> Sent: Monday, March 07, 2016 11:54 AM
> To: Ulf Hansson
> Cc: Seshagiri Holi; Jonathan Hunter; Shawn Lin; 
> stable@vger.kernel.org; #@263.net; 4.4.x@263.net
> Subject: [PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl
>
> We should return -EINVAL if cmd is not MMC_IOC_CMD or MMC_IOC_MULTI_CMD, otherwise blkdev_roset will return -EPERM.
>
> Android-adb calls make_block_device_writable with ioctl(BLKROSET), which will return error, make remount failed:
> remount of /system failed;
> couldn't make block device writable: Operation not permitted
>
> openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system", 
> O_RDONLY) = 3 ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not 
> permitted)
>
> Fixes: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi 
> commands")
> Cc: <stable@vger.kernel.org> # 4.4.x
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>   drivers/mmc/card/block.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index 
> 47bc87d..170f099 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -688,6 +688,9 @@ cmd_err:
>   static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>   	unsigned int cmd, unsigned long arg)
>   {
> +	if (cmd != MMC_IOC_CMD && cmd != MMC_IOC_MULTI_CMD)
> +		return -EINVAL;
> +
>   	/*
>   	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>   	 * whole block device, not on a partition.  This prevents overspray
> --
> 2.3.7
>
>
> ----------------------------------------------------------------------
> ------------- This email message is for the sole use of the intended 
> recipient(s) and may contain confidential information.  Any 
> unauthorized review, use, disclosure or distribution is prohibited.  
> If you are not the intended recipient, please contact the sender by 
> reply email and destroy all copies of the original message.
> ----------------------------------------------------------------------
> -------------
>
>
>


--
Best Regards
Shawn Lin

