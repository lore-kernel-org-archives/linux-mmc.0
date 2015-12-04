From: Daniel Lenski <dlenski@gmail.com>
Subject: Re: [BUG] mfd: rtsx_usb data corruption with SDCX microsd
Date: Fri, 4 Dec 2015 12:34:11 -0800
Message-ID: <CAOw_LSFCY6mTKykBNpjdVoFu5B33nD2hdf9-4NigOXz22UZK-w@mail.gmail.com>
References: <CAOw_LSFRskOLSPW31DUpbYv8wsrH68wkmW=F7s2jCLsRvSLfsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35430 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbbLDUew (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2015 15:34:52 -0500
Received: by wmuu63 with SMTP id u63so76398584wmu.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2015 12:34:51 -0800 (PST)
In-Reply-To: <CAOw_LSFRskOLSPW31DUpbYv8wsrH68wkmW=F7s2jCLsRvSLfsg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On Fri, Dec 4, 2015 at 11:21 AM, Daniel Lenski <dlenski@gmail.com> wrote:
> On 21 October 2015 at 12:02, Ulf Hansson <ulf.hansson <at> linaro.org> wrote:
>> As I don't know the HW, I can just provide some guesses of how to narrow down the problem.
>>
>> If you re-build the kernel and make changes around which MMC_CAPS the host supports, you can try to narrow down the problem if it's related to speed modes.
>>
>> For example start by using *only* the following MMC_CAPS (updates to be made in rtsx_usb_init_host() - drivers/mmc/host/rtsx_usb.c):
>>
>> MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED | MMC_CAP_NEEDS_POLL
>
>> ..and if no error, try add cap by cap to see what happens.

Hi Ulf,
Thanks! I had success with this approach :-)

I started with the stock Ubuntu 4.2.0-21 kernel, and rebuilt ONLY the
rtsx_usb and rtsx_usb_sdmmc modules:

$ uname -a
Linux dlenski-ultra 4.2.0-21-generic #25-Ubuntu SMP Wed Dec 2 18:42:25
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
$ make -C /lib/modules/`uname -r`/build M=$PWD drivers/mfd/rtsx_usb.ko
$ make -C /lib/modules/`uname -r`/build M=$PWD
drivers/mmc/host/rtsx_usb_sdmmc.ko

First I tried disabling SDR50 only. Looks like SDR25 is a no-go for
this card. I get the same errors as with SDR50 (-110):

[ 4441.001959] mmc0: new ultra high speed SDR25 SDHC card at address aaaa
[ 4441.002292] mmcblk0: mmc0:aaaa SU32G 29.7 GiB
[ 4441.006009]  mmcblk0:
[ 4441.678714] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900

Next, I disabled SDR25 as well. SDR12 *seems* to work fine at first,
although I get a different error in dmesg immediately when the card is
detected (-32), and then start to get a blizzard of error (-110) when
I try to copy lots of files to the card.

[ 4583.052995] mmc0: new ultra high speed SDR12 SDHC card at address aaaa
[ 4583.053304] mmcblk0: mmc0:aaaa SU32G 29.7 GiB
[ 4583.055852]  mmcblk0:
[ 4583.328276] FAT-fs (mmcblk0): Volume was not properly unmounted.
Some data may be corrupt. Please run fsck.
[ 4691.924909] mmcblk0: error -32 sending stop command, original cmd
response 0x900, card status 0xc00
[ 4695.869462] mmcblk0: error -32 sending stop command, original cmd
response 0x900, card status 0xc00
[ 4709.745164] FAT-fs (mmcblk0): Volume was not properly unmounted.
Some data may be corrupt. Please run fsck.
[ 5082.557400] mmcblk0: error -110 sending status command, retrying
[ 5083.158663] mmcblk0: error -110 sending status command, aborting

Finally, I disabled SDR12 as well. And now the card works just fine:

mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
          MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
          /* MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50 |*/
          MMC_CAP_NEEDS_POLL;

[ 5196.200933] mmc0: new high speed SDHC card at address aaaa
[ 5196.201239] mmcblk0: mmc0:aaaa SU32G 29.7 GiB
[ 5196.203600]  mmcblk0:
[ 5196.462521] FAT-fs (mmcblk0): Volume was not properly unmounted.
Some data may be corrupt. Please run fsck.

In conclusion... it seems that the kernel is attempting to drive this
card faster than it can actually work. What I'm trying to figure out
now:
- How does the kernel attempt to figure out the capability of a given
SD card? Where is that in the kernel source tree?
- Is it possible to make the list of supported caps a module
parameter, to more easily throttle high-speed modes that don't work
with a particular card?

Thanks,
Dan
