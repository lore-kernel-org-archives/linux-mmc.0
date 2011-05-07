From: Per Forlin <per.forlin@linaro.org>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Sat, 7 May 2011 12:45:41 +0200
Message-ID: <BANLkTimrN_T-nGws6T6baLPV+sWtFYC6Bw@mail.gmail.com>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com>
	<201105031516.28907.arnd@arndb.de>
	<BANLkTi=74Mp1vWBt2F-sqqqkeNfP69+9vg@mail.gmail.com>
	<201105032202.42662.arnd@arndb.de>
	<BANLkTi=omboE=fh16KSAa__JyG=hARmw=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46478 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab1EGKpm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 7 May 2011 06:45:42 -0400
Received: by iyb14 with SMTP id 14so3239827iyb.19
        for <linux-mmc@vger.kernel.org>; Sat, 07 May 2011 03:45:41 -0700 (PDT)
In-Reply-To: <BANLkTi=omboE=fh16KSAa__JyG=hARmw=A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org

On 4 May 2011 21:13, Per Forlin <per.forlin@linaro.org> wrote:
> On 3 May 2011 22:02, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 03 May 2011 20:54:43 Per Forlin wrote:
>>> >> page_not_up_to_date:
>>> >> /* Get exclusive access to the page ... */
>>> >> error =3D lock_page_killable(page);
>>> > I looked at the code in do_generic_file_read(). lock_page_killabl=
e
>>> > waits until the current read ahead is completed.
>>> > Is it possible to configure the read ahead to push multiple read
>>> > request to the block device queue?add
>>
>> I believe sleeping in __lock_page_killable is the best possible scen=
ario.
>> Most cards I've seen work best when you use at least 64KB reads, so =
it will
>> be faster to wait there than to read smaller units.
>>
> Sleeping is ok but I don't wont the read execution to stop (mmc going
> to idle when there is actually more to read).
> I did an interesting discovery when I forced host mmc_req_size to 64k
> The reads now look like:
> dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D4k count=3D256
> =A0[mmc_queue_thread] req d955f9b0 blocks 32
> =A0[mmc_queue_thread] req =A0 (null) blocks 0
> =A0[mmc_queue_thread] req =A0 (null) blocks 0
> =A0[mmc_queue_thread] req d955f9b0 blocks 64
> =A0[mmc_queue_thread] req =A0 (null) blocks 0
> =A0[mmc_queue_thread] req d955f8d8 blocks 128
> =A0[mmc_queue_thread] req =A0 (null) blocks 0
> =A0[mmc_queue_thread] req d955f9b0 blocks 128
> =A0[mmc_queue_thread] req d955f800 blocks 128
> =A0[mmc_queue_thread] req d955f8d8 blocks 128
> =A0[do_generic_file_read] lock_page_killable-wait sec 0 nsec 7811230
> =A0[mmc_queue_thread] req d955fec0 blocks 128
> =A0[mmc_queue_thread] req d955f800 blocks 128
> =A0[do_generic_file_read] lock_page_killable-wait sec 0 nsec 7811492
> =A0[mmc_queue_thread] req d955f9b0 blocks 128
> =A0[mmc_queue_thread] req d967cd30 blocks 128
> =A0[do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810848
> =A0[mmc_queue_thread] req d967cc58 blocks 128
> =A0[mmc_queue_thread] req d967cb80 blocks 128
> =A0[do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810654
> =A0[mmc_queue_thread] req d967caa8 blocks 128
> =A0[mmc_queue_thread] req d967c9d0 blocks 128
> =A0[mmc_queue_thread] req d967c8f8 blocks 128
> =A0[do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810652
> =A0[mmc_queue_thread] req d967c820 blocks 128
> =A0[mmc_queue_thread] req d967c748 blocks 128
> =A0[do_generic_file_read] lock_page_killable-wait sec 0 nsec 7810952
> =A0[mmc_queue_thread] req d967c670 blocks 128
> =A0[mmc_queue_thread] req d967c598 blocks 128
> =A0[mmc_queue_thread] req d967c4c0 blocks 128
> =A0[mmc_queue_thread] req d967c3e8 blocks 128
> =A0[mmc_queue_thread] req =A0 (null) blocks 0
> =A0[mmc_queue_thread] req =A0 (null) blocks 0
> The mmc queue never runs empty until end of transfer.. The requests
> are 128 blocks (64k limit set in mmc host driver) compared to 256
> blocks before. This will not improve performance much since the
> transfer now are smaller than before. The latency is minimal but
> instead there extra number of transfer cause more mmc cmd overhead.
> I added prints to print the wait time in lock_page_killable too.
> I wonder if I can achieve a none empty mmc block queue without
> compromising the mmc host driver performance.
>
There is actually a performance increase from 16.5 MB/s to 18.4 MB/s
when lowering the max_req_size to 64k.
I run a dd test on a pandaboard using 2.6.39-rc5 kernel.

=46irst case when block queue gets empty after every request:
root@(none):/ dd if=3D/dev/mmcblk0p3 of=3D/dev/null bs=3D4k count=3D256=
00
25600+0 records in
25600+0 records out
104857600 bytes (100.0MB) copied, 6.061107 seconds, 16.5MB/s

Second case when modifying omap_hsmmc to force request size is to half
(128 instead of 256). This results in queue is never empty
dd if=3D/dev/mmcblk0p3 of=3D/dev/null bs=3D4k count=3D25600
25600+0 records in
25600+0 records out
104857600 bytes (100.0MB) copied, 5.423362 seconds, 18.4MB/s

Regards,
Per
