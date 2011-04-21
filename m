From: Chris Ball <cjb@laptop.org>
Subject: Re: [patchv3 4/4] MMC: MMC boot partitions support.
Date: Wed, 20 Apr 2011 21:30:03 -0400
Message-ID: <m3tydsbdd0.fsf@pullcord.laptop.org>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-4-git-send-email-andreiw@motorola.com>
	<m31v0wcson.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58141 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530Ab1DUBZy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2011 21:25:54 -0400
In-Reply-To: <m31v0wcson.fsf@pullcord.laptop.org> (Chris Ball's message of
	"Wed, 20 Apr 2011 21:13:44 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arnd@arndb.de

Hi,

On Wed, Apr 20 2011, Chris Ball wrote:
> On Mon, Apr 11 2011, Andrei Warkentin wrote:
>> Allows device MMC boot partitions to be accessed. MMC partitions
>> are treated effectively as separate block devices on the same
>> MMC card.
>
> Booted this with a Sandisk SEM04G eMMC:
>
> [    2.469921] mmcblk0boot0: mmc2:0001 SEM04G partition 1 1.00 MiB
> [    2.475905] mmcblk0boot1: mmc2:0001 SEM04G partition 2 1.00 MiB
> [    2.489403]  mmcblk0boot1: unknown partition table
> [    2.495921]  mmcblk0boot0: unknown partition table
>
> I haven't set up any boot partitions explicitly, so I guess the two 1MiB
> boot partitions might be the factory-default setting.  Out of curiosity,
> does that match your experience with Sandisk eMMCs? 

Also, on inserting an external SD card I see:

[    2.485079] mmcblk0: mmc2:0001 SEM04G 3.68 GiB 
[    2.489681] mmcblk0boot0: mmc2:0001 SEM04G partition 1 1.00 MiB
[    2.495681] mmcblk0boot1: mmc2:0001 SEM04G partition 2 1.00 MiB
[    2.503756]  mmcblk0: p1 p2
[    2.509303]  mmcblk0boot1: unknown partition table
[    2.515343]  mmcblk0boot0: unknown partition table
[    4.828326] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsc
k is recommended
[    4.845214] EXT3-fs (mmcblk0p2): using internal journal
[    4.845223] EXT3-fs (mmcblk0p2): recovery complete
[    4.857131] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode
[   20.886514] mmc0: new high speed SDHC card at address d555
[   20.904282] mmcblk3: mmc0:d555 SD04G 3.79 GiB 
[   20.906926]  mmcblk3: p1

But I would have expected this to be mmcblk1 -- might the boot partitions
be using up mmcblk1/2 somehow?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
