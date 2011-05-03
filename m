From: Per Forlin <per.forlin@linaro.org>
Subject: Re: mmc blkqueue is empty even if there are pending reads in do_generic_file_read()
Date: Tue, 3 May 2011 20:54:43 +0200
Message-ID: <BANLkTi=74Mp1vWBt2F-sqqqkeNfP69+9vg@mail.gmail.com>
References: <BANLkTinhK_K1oSJDEoqD6EQK8Qy5Wy3v+g@mail.gmail.com>
	<201105031516.28907.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43186 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab1ECSyp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2011 14:54:45 -0400
Received: by iwn34 with SMTP id 34so323115iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 03 May 2011 11:54:44 -0700 (PDT)
In-Reply-To: <201105031516.28907.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org

On 3 May 2011 15:16, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 April 2011, Per Forlin wrote:
>
>> For reads on the other hand it look like this
>> root@(none):/ dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D4k count=3D25=
6
>> 256+0 records in
>> 256+0 records out
>> root@(none):/ dmesg
>> [mmc_queue_thread] req d954cec0 blocks 32
>> [mmc_queue_thread] req =A0 (null) blocks 0
>> [mmc_queue_thread] req =A0 (null) blocks 0
>> [mmc_queue_thread] req d954cec0 blocks 64
>> [mmc_queue_thread] req =A0 (null) blocks 0
>> [mmc_queue_thread] req d954cde8 blocks 128
>> [mmc_queue_thread] req =A0 (null) blocks 0
>> [mmc_queue_thread] req d954cec0 blocks 256
>> [mmc_queue_thread] req =A0 (null) blocks 0
>
>> There are never more than one read request in the mmc block queue. A=
ll
>> the mmc request preparations will be serialized and the cost for thi=
s
>> is roughly 10% lower bandwidth (verified on ARM platforms ux500 and
>> Pandaboard).
>
> After some offline discussions, I went back to look at your mail, and=
 I think
> the explanation is much simpler than you expected:
>
> You have only a single process reading blocks synchronously, so the r=
ound
> trip goes all the way to user space. The block layer does some readah=
ead,
> so it will start reading 32 blocks instead of just 8 (4KB) for the fi=
rst
> read, but then the user process just sits waiting for data. After the
> mmc driver has finished reading the entire 32 blocks, the user needs =
a
> little time to read them from the page cache in 4 KB chunks (8 syscal=
ls),
> during which the block layer has no clue about what the user wants to=
 do
> next.
>
> The readahead scales up to 256 blocks, but there is still only one re=
ader,
> so you never have additional requests in the queue.
>
> Try running multiple readers in parallel, e.g.
>
> for i in 1 2 3 4 5 ; do
> =A0 =A0 =A0 =A0dd if=3D/dev/mmcblk0 bs=3D16k count=3D256 iflag=3Ddire=
ct skip=3D$[$i * 1024] &
> done
Yes you are right about this. If I run with multiple read threads
there are multiple request waiting in the mmc block queue.

>> page_not_up_to_date:
>> /* Get exclusive access to the page ... */
>> error =3D lock_page_killable(page);
> I looked at the code in do_generic_file_read(). lock_page_killable
> waits until the current read ahead is completed.
> Is it possible to configure the read ahead to push multiple read
> request to the block device queue?add
When I first looked at this I used dd if=3D/dev/mmcblk0 of=3D/dev/null =
bs=3D1M count=3D4
If bs is larger than read ahead, this will make the execution loop in
do_generic_file_read() reading 512 until 1M is read. The second time
in this loop it will wait on lock_page_killable.

If bs=3D16k the execution wont stuck at lock_page_killable.


>
>
> =A0 =A0 =A0 =A0Arnd
>
Thanks,
Per
