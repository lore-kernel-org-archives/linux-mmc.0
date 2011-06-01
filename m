From: Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: Corruption on shutdown outside the current partition
Date: Wed, 1 Jun 2011 16:27:58 +0000 (UTC)
Message-ID: <is5pae$4ag$1@dough.gmane.org>
References: <is0f6q$45g$1@dough.gmane.org>
 <1C97D3C8-E4B8-4FC5-9E02-E067DAF2EC02@dilger.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:47232 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757490Ab1FAQ2M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2011 12:28:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1QRoHD-00012M-1T
	for linux-mmc@vger.kernel.org; Wed, 01 Jun 2011 18:28:11 +0200
Received: from ram94-11-88-187-113-157.fbx.proxad.net ([88.187.113.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2011 18:28:11 +0200
Received: from romain.izard.pro by ram94-11-88-187-113-157.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2011 18:28:11 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

On 2011-05-30, Andreas Dilger <adilger@dilger.ca> wrote:

>> If I use a hardware reset method instead of the kernel syscall, by
>> triggering a watchdog with interrupts locked, or doing a power cycle
>> with a testing machine, the problem does not happen. This led me to
>> think it could be a software failure, rather than the hardware failure I
>> was expecting. After activating the traces in the mmc subsystem, I
>> finally managed to catch write commands to an area outside the partition
>> being tested, which means that the problem is really due to software.
>
> Why don't you dump a stack at that point to see what is causing the
> write? Also, blktrace might be helpful to determine what caused the block
> to be written.

I tried that, unfortunately the asynchronous I/O framework led me to
have the stack of the mmc worker thread, instead of the stack of the
request originator. But it was a good first step, since it gave me an
error marker, and made me notice that the problem is much more common
than I thought. It was only hidden due to the fact that the writes
fell in unused areas of my boot partition.

Since blktrace lives in userspace, it is liable to be destroyed during
the reboot process, and give me only partial information. But I finally
found what I wanted: by writing 1 to /proc/sys/vm/block_dump, I am able
to see the original requests that led to the commands in the system log.

>From what I see now, it seems that the problem comes from a race
condition on shutdown between pending file system operations on one
side, and partition removal on the other side. It seems that the
partition can be removed, and yet some pending requests are still valid,
and are handled with the partition offset equal to 0. This leads to
the corruptions I am observing.

I have yet to figure the events leading to this, and find a correction,
since all this is happening in a part I'm not familiar of.

> Another possibility (I'm not very familiar with MMC hardware, so could
> be bogus) is that the partitions don't align to the hardware/erase
> block size of the underlying device, and a "legitimate" write to one
> partition is causing a read-modify-write into a region of another
> partition, but this isn't being handled correctly?
>

I also had alignment problems, but it only impacted performance, not
correctness.


Thanks for your help,
-- 
Romain Izard

