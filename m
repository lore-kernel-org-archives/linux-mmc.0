From: Per Forlin <per.forlin@linaro.org>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Sun, 8 May 2011 18:23:24 +0200
Message-ID: <BANLkTinDByrdEKrzHPysSP8giHgqFyJWtw@mail.gmail.com>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com>
	<BANLkTi=omboE=fh16KSAa__JyG=hARmw=A@mail.gmail.com>
	<BANLkTimrN_T-nGws6T6baLPV+sWtFYC6Bw@mail.gmail.com>
	<201105081709.34416.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50942 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab1EHQXZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 12:23:25 -0400
Received: by iyb14 with SMTP id 14so3749374iyb.19
        for <linux-mmc@vger.kernel.org>; Sun, 08 May 2011 09:23:25 -0700 (PDT)
In-Reply-To: <201105081709.34416.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org

On 8 May 2011 17:09, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 07 May 2011, Per Forlin wrote:
>> > The mmc queue never runs empty until end of transfer.. The requests
>> > are 128 blocks (64k limit set in mmc host driver) compared to 256
>> > blocks before. This will not improve performance much since the
>> > transfer now are smaller than before. The latency is minimal but
>> > instead there extra number of transfer cause more mmc cmd overhead.
>> > I added prints to print the wait time in lock_page_killable too.
>> > I wonder if I can achieve a none empty mmc block queue without
>> > compromising the mmc host driver performance.
>> >
>> There is actually a performance increase from 16.5 MB/s to 18.4 MB/s
>> when lowering the max_req_size to 64k.
>> I run a dd test on a pandaboard using 2.6.39-rc5 kernel.
>
> I've noticed with a number of cards that using 64k writes is faster
> than any other size. What I could not figure out yet is whether this
> is a common hardware optimization for MS Windows (which always uses
> 64K I/O when it can), or if it's a software effect and we can actually
> make it go faster with Linux by tuning for other sizes.
>
Thanks for the tip I will keep that in mind.
In this case the increase in performance is due to parallel cache
handling. I did a test and set the mmc_max_req to 128k (same size as
the first test with low performance) and increase the read_ahead to
256k.
root@(none):/ echo 256 >
sys/devices/platform/omap/omap_hsmmc.0/mmc_host/mmc0/mmc0:80ca/block/mmcblk0/queue/read_ahead_kb
root@(none):/ dd if=/dev/mmcblk0p3 of=/dev/null bs=4k count=25600
25600+0 records in
25600+0 records out
104857600 bytes (100.0MB) copied, 5.138585 seconds, 19.5MB/s

Regards,
Per
