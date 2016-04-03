From: Peter Hurley <peter@hurleysoftware.com>
Subject: [bisect] Merge tag 'mmc-v4.6' of
 git://git.linaro.org/people/ulf.hansson/mmc (was [GIT PULL] MMC for v.4.6)
Date: Sat, 2 Apr 2016 19:56:05 -0700
Message-ID: <57008645.4070808@hurleysoftware.com>
References: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36176 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcDCC4J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Apr 2016 22:56:09 -0400
Received: by mail-pf0-f180.google.com with SMTP id e128so97452833pfe.3
        for <linux-mmc@vger.kernel.org>; Sat, 02 Apr 2016 19:56:09 -0700 (PDT)
In-Reply-To: <CAPDyKFqM1ffAdj7jVJmcPW2Wxy88Mhx_UrAzyuXpKSJg1yUPdg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 03/21/2016 05:59 AM, Ulf Hansson wrote:
> Hi Linus,
> 
> Here's the PR for MMC v4.6.
> 
> Details about the highlights are as usual found in the signed tag.
> 
> Please pull this in!
> 
> Kind regards
> Ulf Hansson
> 
> 
> The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:
> 
>   Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/ulf.hansson/mmc.git tags/mmc-v4.6
> 
> for you to fetch changes up to 64e5cd723120643a4c8bef0880a03a60161d3ccb:
> 
>   mmc: sdhci-of-at91: fix wake-up issue when using runtime pm
> (2016-03-18 09:12:32 +0100)

This merge commit e531cdf50a8a0fb7a4d51c06e52097bd01e9bf7c
Merge: 4526b71 64e5cd7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Mar 21 14:35:52 2016 -0700

    Merge tag 'mmc-v4.6' of git://git.linaro.org/people/ulf.hansson/mmc
    
    Pull MMC updates from Ulf Hansson:
    ...

is fingered by git bisect as the cause for a mashup of mmc block devices
on a Beaglebone Black:

[    2.916209] mmc1: new high speed MMC card at address 0001
[    2.923755] mmcblk0: mmc1:0001 MMC04G 3.60 GiB
[    2.929479] mmcblk0boot0: mmc1:0001 MMC04G partition 1 2.00 MiB
[    2.936821] tps65217 0-0024: TPS65217 ID 0xe version 1.2
[    2.942270] mmcblk0boot1: mmc1:0001 MMC04G partition 2 2.00 MiB
[    2.949388]  mmcblk0: p1 p2
[    2.950031] mmc0: new high speed SDHC card at address e624
[    2.961118] mmcblk1: mmc0:e624 SU08G 7.40 GiB
[    2.967047] at24 0-0050: 32768 byte 24c256 EEPROM, writable, 1 bytes/write
[    2.974190]  mmcblk1: p1 p2

Note how mmc1 => mmcblk0 and mmc0 => mmcblk1.

This produces a failure to boot as the wrong partition is mounted as
root (/dev/mmcblk0p2 is now on the wrong mmc).

The bisect tried all the mmc tree patches which were all good.
I double-checked by cloning the mmc tree and building both mmc-v4.6
and v4.5-rc6, and both tested good.

I interpret that to mean some change in mmc + some new behavior elsewhere
for v4.6 is causing this. Any ideas?

Regards,
Peter Hurley


