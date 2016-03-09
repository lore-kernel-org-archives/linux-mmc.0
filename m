From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: [RESENT PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl
Date: Wed, 9 Mar 2016 21:51:29 +0800
Message-ID: <56E02A61.6010003@kernel-upstream.org>
References: <1457333940-13076-1-git-send-email-shawn.lin@rock-chips.com>
 <56DFFFF2.5050508@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:53673 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763AbcCIOCu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2016 09:02:50 -0500
In-Reply-To: <56DFFFF2.5050508@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@kernel-upstream.org, Seshagiri Holi <sholi@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 2016/3/9 18:50, Jon Hunter wrote:
>
> On 07/03/16 06:59, Shawn Lin wrote:
>> We should return -EINVAL if cmd is not MMC_IOC_CMD or MMC_IOC_MULTI_CMD,
>> otherwise blkdev_roset will return -EPERM.
>>
>> Android-adb calls make_block_device_writable with ioctl(BLKROSET), which
>> will return error, make remount failed:
>> remount of /system failed;
>> couldn't make block device writable: Operation not permitted
>
> I think you should elaborate here why the behaviour between -EINVAL and
> -EPERM is different as they are both errors. In other words, add your
> comment about how the ADB code is checking for a supported command.

yep. So if need to send v2 after comment from Ulf, I will add more into
commit-msg.

>
>> openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system", O_RDONLY) = 3
>> ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not permitted)
>>
>> Fixes: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi commands")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/card/block.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 47bc87d..170f099 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -688,6 +688,9 @@ cmd_err:
>>   static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>>   	unsigned int cmd, unsigned long arg)
>>   {
>> +	if (cmd != MMC_IOC_CMD && cmd != MMC_IOC_MULTI_CMD)
>> +		return -EINVAL;
>> +
>>   	/*
>>   	 * The caller must have CAP_SYS_RAWIO, and must be calling this on the
>>   	 * whole block device, not on a partition.  This prevents overspray
>
> The change is fine with me, but I agree with Seshagiri's comment that
> instead of the above, move the following test to the mmc_blk_ioctl_cmd
> and mmc_blk_ioctl_multi_cmd functions:
>
> if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>                  return -EPERM;
>

right, and both are ok to me :).
Adding this check for mmc_blk_ioctl_cmd and mmc_blk_ioctl_multi_cmd
respectively may also looks like we produce two some code sections that 
do the same thing.

I think it depends on how Ulf want the solution to be? Let's wait for
Ulf' comment.

> There is a case statement that then would return -EINVAL if the command
> is not supported.
>
> If you look at V3 of the patch "mmc: block: Add new ioctl to send multi
> commands" [0] this is how we had it and only in V4 (the final version)
> did we move it.

yes, I read V3 and V4 both to see how the patch was going. Thanks for
sharing it.

>
> Cheers
> Jon
>
> [0] http://marc.info/?l=linux-mmc&m=144224289716299&w=2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

