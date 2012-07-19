From: gaoqiang <gaoqiangscut@gmail.com>
Subject: Re: question about IO-sched
Date: Thu, 19 Jul 2012 17:12:42 +0800
Message-ID: <op.whorvghdn27o5l@gaoqiang-d1.corp.qihoo.net>
References: <op.whbsn0qvn27o5l@gaoqiang-d1.corp.qihoo.net>
 <CADX3swpSAt9gdSgYihOJKs1=geQkmB04rCVTSgh=DEXQx7QPmQ@mail.gmail.com>
 <op.whg7fy00n27o5l@gaoqiang-d1.corp.qihoo.net>
 <CADX3swq9cfPtd3a1ibYWjQBiTMGzqYbS=KNTkdo1eW4LFxsJJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:49539 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860Ab2GSJMu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 05:12:50 -0400
In-Reply-To: <CADX3swq9cfPtd3a1ibYWjQBiTMGzqYbS=KNTkdo1eW4LFxsJJA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Corrado Zoccolo <czoccolo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

thanks very much.

=D4=DA Wed, 18 Jul 2012 14:51:09 +0800=A3=ACCorrado Zoccolo <czoccolo@g=
mail.com> =20
=D0=B4=B5=C0:

> On Sun, Jul 15, 2012 at 9:08 AM, gaoqiang <gaoqiangscut@gmail.com> wr=
ote:
>>
>> many thanks. but why the sys_read operation hangs on sync_page ? the=
re =20
>> are
>> still
>> many free memory.I mean ,the actually free memory,excluding the vari=
ous
>> kinds of
>> caches or buffers.
> http://kerneltrap.org/node/4941 explains sync_page:
>>
>> ->sync_page() is an awful misnomer. Usually, when page IO operation =
is
>> requested by calling ->writepage() or ->readpage(), file-system queu=
es
>> IO request (e.g., disk-based file system may do this my calling
>> submit_bio()), but underlying device driver does not proceed with th=
is
>> IO immediately, because IO scheduling is more efficient when there a=
re
>> multiple requests in the queue.
>> Only when something really wants to wait for IO completion
>> (wait_on_page_{locked,writeback}() are used to wait for read and wri=
te
>> completion respectively) IO queue is processed. To do this
>> wait_on_page_bit() calls ->sync_page() (see block_sync_page()---stan=
dard
>> implementation of ->sync_page() for disk-based file systems).
>> So, semantics of ->sync_page() are roughly "kick underlying storage
>> driver to actually perform all IO queued for this page, and, maybe, =
for
>> other pages on this device too".
>
> It is expected that sys_read will wait until the data is available fo=
r
> the process.
> If you don't want to wait (because you can do other stuff in the mean
> time, including queuing other I/O operations), you can use aio_read.
> The kernel will notify your process when the operation completes and
> the data is available in memory.
>
> Thanks,
> Corrado
>
>>
>>
>> =D4=DA Fri, 13 Jul 2012 22:15:31 +0800=A3=ACCorrado Zoccolo =20
>> <czoccolo@gmail.com> =D0=B4=B5=C0:
>>
>>> Hi,
>>> the catch is that writes are "fire and forget", so they keep =20
>>> accumulating
>>> in the I/O sched, and there is always plenty of them to schedule =20
>>> (unless
>>> you explicitly make sync writes).
>>>
>>> The reader, instead, waits for the result of each read operation be=
fore
>>> scheduling a new read, so there is at most one outstanding read, an=
d =20
>>> some
>>> time nothing.
>>>
>>> The deadline scheduler is work conserving, meaning that it never le=
aves
>>> the
>>> disk idle when there is work queued, and most of the time after an
>>> operation completes, there is only write work queued, so you see mu=
ch
>>> more
>>> writes being sent to the device.
>>>
>>> Only schedulers that delay writes waiting for reads (as Anticipator=
y in
>>> old
>>> kernels, and now CFQ) can achieve higher read to write ratios.
>>>
>>> Cheers
>>> Corrado
>>>
>>> On Thu, Jul 12, 2012 at 11:01 AM, gaoqiang <gaoqiangscut@gmail.com>
>>> wrote:
>>>
>>>> Hi,all
>>>>
>>>>         I have long known that deadline is read-prefered. but a si=
mple
>>>> test gives the opposite result.
>>>>
>>>>         with two processes running at the same time,one for read a=
nd =20
>>>> one
>>>> for write.actually,they did nothing bug IO operation.
>>>>         while(true)
>>>>         {
>>>>                 read();
>>>>         }
>>>>         the other:
>>>>         while(true)
>>>>         {
>>>>                 write();
>>>>         }
>>>>
>>>>         with deadline IO-sched  and ext4 filesystem.as a result, r=
ead
>>>> ratio was about below 3M/s.and write about 100M/s. I have tested b=
oth
>>>> kernel-2.6.18 and kernel-2.6.32,getting the same result.
>>>>
>>>>         I add some debug information in the kernel and recompile,f=
ound
>>>> that,it has little to do with IO-sched layer because read request
>>>> dropped
>>>> into deadline was 5% of write request .from /proc/<pid>/stack,the =
read
>>>> process hands on sync_page most of the time.
>>>>         what is the matter ? anyone help me ?
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe =20
>>>> linux-kernel"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at
>>>> http://vger.kernel.org/**majordomo-info.html<http://vger.kernel.or=
g/majordomo-info.html>
>>>>
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>
>>>
>>>
>>
>>
>> --
>> =CA=B9=D3=C3 Opera =B8=EF=C3=FC=D0=D4=B5=C4=B5=E7=D7=D3=D3=CA=BC=FE=BF=
=CD=BB=A7=B3=CC=D0=F2: http://www.opera.com/mail/
>
>
>
>
> --
> _____________________________________________________________________=
_____
>
> dott. Corrado Zoccolo                          mailto:czoccolo@gmail.=
com
> PhD - Department of Computer Science - University of Pisa, Italy
> ---------------------------------------------------------------------=
-----
> The self-confidence of a warrior is not the self-confidence of the =20
> average
> man. The average man seeks certainty in the eyes of the onlooker and =
=20
> calls
> that self-confidence. The warrior seeks impeccability in his own eyes=
 and
> calls that humbleness.
>                                Tales of Power - C. Castaneda


--=20
=CA=B9=D3=C3 Opera =B8=EF=C3=FC=D0=D4=B5=C4=B5=E7=D7=D3=D3=CA=BC=FE=BF=CD=
=BB=A7=B3=CC=D0=F2: http://www.opera.com/mail/
