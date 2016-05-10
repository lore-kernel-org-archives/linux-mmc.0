From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra30
Date: Tue, 10 May 2016 12:15:26 +0100
Message-ID: <5731C2CE.2030007@nvidia.com>
References: <1462806903-13860-1-git-send-email-jonathanh@nvidia.com>
 <1462864193.13327.2.camel@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462864193.13327.2.camel-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


On 10/05/16 08:09, Lucas Stach wrote:
> Hi Jon,
> 
> Am Montag, den 09.05.2016, 16:15 +0100 schrieb Jon Hunter:
>> Support for SD cards is not working on the Tegra30 Beaver board and
>> on
>> boot the following error message is seen if an SD card is present:
>>
>>  mmc0: error -110 whilst initialising SD card
>>
> Can you please tell me what kind of SD card you used and at which point
> in the initialization it is hanging? I've tested this change on Beaver
> and haven't seen any failures after I implemented the memcomppad
> calibration.

Yes it is an SDHC 4GB I believe. The board is remote and so I have not
seen the exact card. However, here are some more details from sysfs:

root@(none):/# cat /sys/class/mmc_host/mmc0/mmc0\:aaaa/name
SS04G
root@(none):/# cat /sys/class/mmc_host/mmc0/mmc0\:aaaa/csd
400e00325b5900001d8a7f800a404000
root@(none):/# cat /sys/class/mmc_host/mmc0/mmc0\:aaaa/cid
03534453533034478029b1301800f900
root@(none):/# cat /sys/class/mmc_host/mmc0/mmc0\:aaaa/oemid
0x5344
root@(none):/# cat /sys/class/mmc_host/mmc0/mmc0\:aaaa/manfid
0x000003
 
>> In addition to this, Tegra30 is also randomly hanging during system
>> suspend when entering and is caused by the Tegra SDHCI driver. 
> 
> I'll have a look at this soonish.

Thanks. I think I have mentioned this before, but I run a loop test
for example ...

count=0; while [ $count -lt 100 ]; do rtcwake -d rtc0 -m mem -s 3; echo
Suspend iteration $count; count=`expr $count + 1`; done

Cheers
Jon
