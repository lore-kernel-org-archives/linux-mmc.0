From: Matthias Kaehlcke <matthias.list@kaehlcke.net>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Thu, 19 Jul 2012 16:08:10 +0200
Message-ID: <20120719140810.GE16016@darwin>
References: <5006571A.7060103@de.bosch.com>
 <CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>
 <50068696.8070408@de.bosch.com>
 <CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>
 <5006C40D.300@de.bosch.com>
 <5006CE33.2040205@boundarydevices.com>
 <5006D361.2070705@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from a83-160-107-163.adsl.xs4all.nl ([83.160.107.163]:60702 "EHLO
	d4rwin.no-ip.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GSOQE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 10:16:04 -0400
Content-Disposition: inline
In-Reply-To: <5006D361.2070705@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Cc: Eric Nelson <eric.nelson@boundarydevices.com>, Jassi Brar <jaswinder.singh@linaro.org>, "Behme Dirk (CM-AI/PJ-CF32)" <Dirk.Behme@de.bosch.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

El Wed, Jul 18, 2012 at 05:16:49PM +0200 Knut Wohlrab ha dit:

> On 07/18/2012 04:54 PM, Eric Nelson wrote:
> >On 07/18/2012 07:11 AM, Knut Wohlrab wrote:
> >>On 07/18/2012 03:47 PM, Jassi Brar wrote:
> >>>On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
> >>>
> >>>>If a SD card is inserted at boot time, its "mmcblk0", the embedded
> >>>>MMC (eMMC) device "mmcblk1". This makes it difficult to give the kernel the
> >>>>correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
> >>>>
> >>>How about root=UUID=<eMMC-partition> ?
> >>Because we are talking about an embedded device, it is very difficult to get a
> >>UUID of a eMMC partition into kernel command line with U-Boot. Handling of UUID
> >>is also a big effort at board manufacturing.
> >>
> >>Startup speed is very important for us. Searching for UUID on several MMC/SD
> >>devices will significant slow down the boot process.
> >>
> >>This problem can occur on many devices with embedded MMC and removable SD, e.g.
> >>smart phones. So I think we should find an solution to define MMC scan order or
> >>device number/name in a device tree.
> >>
> >Isn't /dev/disk/by-path what you're after?
> >
> >~$ ls -l /dev/disk/by-path/
> >lrwxrwxrwx    1 root     root           13 Jan  1 15:22 platform-mmc0:b368 ->
> >../../mmcblk0
> >lrwxrwxrwx    1 root     root           15 Jan  1 15:22 platform-mmc0:b368-part1
> >-> ../../mmcblk0p1
> >lrwxrwxrwx    1 root     root           15 Jan  1 15:22 platform-mmc0:b368-part2
> >-> ../../mmcblk0p2
> >lrwxrwxrwx    1 root     root           15 Jan  1 15:22 platform-mmc0:b368-part3
> >-> ../../mmcblk0p3
> No, because we have to know which will be the name of the root
> device _before_ we start the kernel. In our embedded device we start
> the kernel with a bootloader (U-Boot) and pass the root device with
> the kernel command line parameter "root=/dev/mmcblk0p1". That is not
> possible if we do not know what will be the name of the root device
> (mmcblk0 or mmcblk1) when kernel try to mount it.

what you can do is let u-boot pass the mmc channel of the boot device,
launch a tiny init from initramfs to perform the resolution to
/dev/mmcblkXpY (for example through /sys/class/mmc_host/...), mount
the real rootfs and exec the real init

best regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Amsterdam

   Usually when people are sad, they don't do anything. They just cry over
     their condition. But when they get angry, they bring about a change
                              (Malcolm X)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
