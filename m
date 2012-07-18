From: Eric Nelson <eric.nelson@boundarydevices.com>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Wed, 18 Jul 2012 07:54:43 -0700
Message-ID: <5006CE33.2040205@boundarydevices.com>
References: <5006571A.7060103@de.bosch.com> <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com> <50068696.8070408@de.bosch.com> <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com> <5006C40D.300@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59539 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2GROyr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 10:54:47 -0400
Received: by gglu4 with SMTP id u4so1637243ggl.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Jul 2012 07:54:46 -0700 (PDT)
In-Reply-To: <5006C40D.300@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, "Behme Dirk (CM-AI/PJ-CF32)" <Dirk.Behme@de.bosch.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 07/18/2012 07:11 AM, Knut Wohlrab wrote:
> On 07/18/2012 03:47 PM, Jassi Brar wrote:
>> On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
>>
>>> If a SD card is inserted at boot time, its "mmcblk0", the embedded
>>> MMC (eMMC) device "mmcblk1". This makes it difficult to give the kernel the
>>> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>>>
>> How about root=UUID=<eMMC-partition> ?
> Because we are talking about an embedded device, it is very difficult to get a
> UUID of a eMMC partition into kernel command line with U-Boot. Handling of UUID
> is also a big effort at board manufacturing.
>
> Startup speed is very important for us. Searching for UUID on several MMC/SD
> devices will significant slow down the boot process.
>
> This problem can occur on many devices with embedded MMC and removable SD, e.g.
> smart phones. So I think we should find an solution to define MMC scan order or
> device number/name in a device tree.
>

Isn't /dev/disk/by-path what you're after?

~$ ls -l /dev/disk/by-path/
lrwxrwxrwx    1 root     root           13 Jan  1 15:22 platform-mmc0:b368 -> 
../../mmcblk0
lrwxrwxrwx    1 root     root           15 Jan  1 15:22 platform-mmc0:b368-part1 
-> ../../mmcblk0p1
lrwxrwxrwx    1 root     root           15 Jan  1 15:22 platform-mmc0:b368-part2 
-> ../../mmcblk0p2
lrwxrwxrwx    1 root     root           15 Jan  1 15:22 platform-mmc0:b368-part3 
-> ../../mmcblk0p3
