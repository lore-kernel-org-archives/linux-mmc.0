From: John Stultz <john.stultz@linaro.org>
Subject: Re: [RESENT PATCH] mmc: block: fix ABI regression of mmc_blk_ioctl
Date: Wed, 9 Mar 2016 14:55:17 +0700
Message-ID: <CANcMJZAONMxfht8W5oGR7nnNvw9ac9hpDKekvcXbo6UM20auQw@mail.gmail.com>
References: <1457333940-13076-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1457333940-13076-1-git-send-email-shawn.lin@rock-chips.com>
Sender: stable-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Seshagiri Holi <sholi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 7, 2016 at 1:59 PM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> We should return -EINVAL if cmd is not MMC_IOC_CMD or MMC_IOC_MULTI_CMD,
> otherwise blkdev_roset will return -EPERM.
>
> Android-adb calls make_block_device_writable with ioctl(BLKROSET), which
> will return error, make remount failed:
> remount of /system failed;
> couldn't make block device writable: Operation not permitted
>
> openat(AT_FDCWD, "/dev/block/platform/ff420000.dwmmc/by-name/system", O_RDONLY) = 3
> ioctl(3, BLKROSET, 0)  = -1 EPERM (Operation not permitted)
>
> Fixes: a5f5774c55a2 ("mmc: block: Add new ioctl to send multi commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>


Ulf,
   We're hitting this as well, and Shawn's patch seems to fix it for me.

Tested-by: John Stultz <john.stultz@linaro.org>

Thanks Shawn!
-john
