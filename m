From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESENT PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl
Date: Wed, 16 Mar 2016 10:21:38 +0100
Message-ID: <CAPDyKFohBpddtpDAUandycUDYp0VtJM1TAuHeSWMpVbTA2skig@mail.gmail.com>
References: <1457333940-13076-1-git-send-email-shawn.lin@rock-chips.com>
	<56DFFFF2.5050508@nvidia.com>
	<56E02A61.6010003@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <56E02A61.6010003@kernel-upstream.org>
Sender: stable-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@kernel-upstream.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Shawn Lin <shawn.lin@rock-chips.com>, Seshagiri Holi <sholi@nvidia.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 March 2016 at 14:51, Shawn Lin <shawn.lin@kernel-upstream.org> wrote:
> On 2016/3/9 18:50, Jon Hunter wrote:
>>
>>
>> On 07/03/16 06:59, Shawn Lin wrote:
>>>
>>> We should return -EINVAL if cmd is not MMC_IOC_CMD or MMC_IOC_MULTI_CMD,
>>> otherwise blkdev_roset will return -EPERM.
>>>
>>> Android-adb calls make_block_device_writable with ioctl(BLKROSET), which
>>> will return error, make remount failed:
>>> remount of /system failed;
>>> couldn't make block device writable: Operation not permitted
>>
>>
>> I think you should elaborate here why the behaviour between -EINVAL and
>> -EPERM is different as they are both errors. In other words, add your
>> comment about how the ADB code is checking for a supported command.
>
>
> yep. So if need to send v2 after comment from Ulf, I will add more into
> commit-msg.
>
>
>>
>>> openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system",
>>> O_RDONLY) = 3
>>> ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not permitted)
>>>
>>> Fixes: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi commands")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>
>>>   drivers/mmc/card/block.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 47bc87d..170f099 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -688,6 +688,9 @@ cmd_err:
>>>   static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
>>>         unsigned int cmd, unsigned long arg)
>>>   {
>>> +       if (cmd != MMC_IOC_CMD && cmd != MMC_IOC_MULTI_CMD)
>>> +               return -EINVAL;
>>> +
>>>         /*
>>>          * The caller must have CAP_SYS_RAWIO, and must be calling this
>>> on the
>>>          * whole block device, not on a partition.  This prevents
>>> overspray
>>
>>
>> The change is fine with me, but I agree with Seshagiri's comment that
>> instead of the above, move the following test to the mmc_blk_ioctl_cmd
>> and mmc_blk_ioctl_multi_cmd functions:
>>
>> if ((!capable(CAP_SYS_RAWIO)) || (bdev != bdev->bd_contains))
>>                  return -EPERM;
>>
>
> right, and both are ok to me :).
> Adding this check for mmc_blk_ioctl_cmd and mmc_blk_ioctl_multi_cmd
> respectively may also looks like we produce two some code sections that do
> the same thing.
>
> I think it depends on how Ulf want the solution to be? Let's wait for
> Ulf' comment.
>

I believe I prefer Jon/Seshagiri suggestions for this. It makes the
code a bit more readable.

Please send a v2 addressing their comments.

Kind regards
Uffe
