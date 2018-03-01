From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH] mmc: card: Don't show eMMC RPMB and BOOT areas in
 /proc/partitions
Date: Thu, 1 Mar 2018 11:04:58 +0530
Message-ID: <7e4ff9cf-f2f3-68b0-c903-fc6f2fc0c7c7@mentor.com>
References: <1519731229-19141-1-git-send-email-harish_kandiga@mentor.com>
 <14AC9066-4BA9-478D-9F67-2A29D69E6011@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14AC9066-4BA9-478D-9F67-2A29D69E6011@wdc.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@wdc.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On Tuesday 27 February 2018 08:28 PM, Alex Lemberg wrote:
> Hi Andrew,
>
> While RPMB partition requires special IOCTL, the boot partition is only requires "switch partition", which is not unusual operation in eMMC.
> Why to prevent users access boot partition?
>
> Thanks,
> Alex 

The main intention of the patch was to not have RPMB device in /proc/partitions. Boot partitions are also unlikely to have any partitioning, so it made sense to treat them the same way as RPMB and not list in /proc/partitions.
Now I see that RPMB is converted to a character device and this change may not be required for RPMB.

Correct me if I am wrong. Also any comments are welcome.

Thanks,
Harish Jenny K N
