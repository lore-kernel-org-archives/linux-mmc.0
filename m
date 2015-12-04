From: Daniel Lenski <dlenski@gmail.com>
Subject: Re: [BUG] mfd: rtsx_usb data corruption with SDCX microsd
Date: Fri, 4 Dec 2015 11:21:48 -0800
Message-ID: <CAOw_LSFRskOLSPW31DUpbYv8wsrH68wkmW=F7s2jCLsRvSLfsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35146 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbbLDTW3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2015 14:22:29 -0500
Received: by wmuu63 with SMTP id u63so74393232wmu.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2015 11:22:28 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On 21 October 2015 at 12:02, Ulf Hansson <ulf.hansson <at> linaro.org> wrote:

> On 20 October 2015 at 18:29, Marcus Overhagen <marcus.overhagen <at> gmail.com> wrote:
> > I tested again with a 4.2 kernel but the bug is still present and
> > happens more often. So far nobody has responded.
> > I don't know what to do, and whether it's related to usb, mmc or mfd.
> > Please advise.
>
> Sorry for the delay. I was hoping to get some input from Roger as me
> personally don't know much about this HW.
> I can't tell whether this is a regression or not. The rtsx_usb driver
> were added in Linux 3.16. Perhaps you can verify if this is a
> regression or not!?

I have been having a very similar problem, though in my case it *does*
happen with a 32 GB microSDHC card.

[    9.854751] mmc0: new ultra high speed SDR50 SDHC card at address aaaa
[    9.862897] mmcblk0: mmc0:aaaa SU32G 29.7 GiB
[  581.272899] mmcblk0: error -110 sending stop command, original cmd
response 0x900, card status 0x900

At first I thought the flash memory on the card had become corrupted,
but then realized that it still worked completely fine (a) when
booting Wind8 on the same system, (b) in an Android phone, and (c) in
a Rockbox MP3 player.

> > A 32 GB SDHC does not show data corruption with this card reader.

On my system, the error occurs _almost always_ when trying to access
my 32 GB microSDHC card, but never with 2 GB or 4 GB SD cards.

Running badblocks -n /dev/mmcblk0, it tells me that every single block
on the card is bad.

Per your suggestion, I booted a 3.16 kernel and encountered the exact
same errors.

> As I don't know the HW, I can just provide some guesses of how to narrow down the problem.
>
> If you re-build the kernel and make changes around which MMC_CAPS the host supports, you can try to narrow down the problem if it's related to speed modes.
>
> For example start by using *only* the following MMC_CAPS (updates to be made in rtsx_usb_init_host() - drivers/mmc/host/rtsx_usb.c):
>
> MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED | MMC_CAP_NEEDS_POLL
>
> ..and if no error, try add cap by cap to see what happens.
>
> Sorry, not being able to help you more - but at least this is a start!

Am I right that this has been moved to rtsx_usb_sdmmc in the most
recent kernels?
https://github.com/torvalds/linux/blob/HEAD/drivers/mmc/host/rtsx_usb_sdmmc.c#L1335

Thanks,
Dan
