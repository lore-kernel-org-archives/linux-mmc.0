From: Corrado Zoccolo <czoccolo@gmail.com>
Subject: Re: question about IO-sched
Date: Wed, 18 Jul 2012 08:51:09 +0200
Message-ID: <CADX3swq9cfPtd3a1ibYWjQBiTMGzqYbS=KNTkdo1eW4LFxsJJA@mail.gmail.com>
References: <op.whbsn0qvn27o5l@gaoqiang-d1.corp.qihoo.net>
	<CADX3swpSAt9gdSgYihOJKs1=geQkmB04rCVTSgh=DEXQx7QPmQ@mail.gmail.com>
	<op.whg7fy00n27o5l@gaoqiang-d1.corp.qihoo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52117 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab2GRGvK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Jul 2012 02:51:10 -0400
In-Reply-To: <op.whg7fy00n27o5l@gaoqiang-d1.corp.qihoo.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gaoqiang <gaoqiangscut@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Sun, Jul 15, 2012 at 9:08 AM, gaoqiang <gaoqiangscut@gmail.com> wrot=
e:
>
> many thanks. but why the sys_read operation hangs on sync_page ? ther=
e are
> still
> many free memory.I mean ,the actually free memory,excluding the vario=
us
> kinds of
> caches or buffers.
http://kerneltrap.org/node/4941 explains sync_page:
>
> ->sync_page() is an awful misnomer. Usually, when page IO operation i=
s
> requested by calling ->writepage() or ->readpage(), file-system queue=
s
> IO request (e.g., disk-based file system may do this my calling
> submit_bio()), but underlying device driver does not proceed with thi=
s
> IO immediately, because IO scheduling is more efficient when there ar=
e
> multiple requests in the queue.
> Only when something really wants to wait for IO completion
> (wait_on_page_{locked,writeback}() are used to wait for read and writ=
e
> completion respectively) IO queue is processed. To do this
> wait_on_page_bit() calls ->sync_page() (see block_sync_page()---stand=
ard
> implementation of ->sync_page() for disk-based file systems).
> So, semantics of ->sync_page() are roughly "kick underlying storage
> driver to actually perform all IO queued for this page, and, maybe, f=
or
> other pages on this device too".

It is expected that sys_read will wait until the data is available for
the process.
If you don't want to wait (because you can do other stuff in the mean
time, including queuing other I/O operations), you can use aio_read.
The kernel will notify your process when the operation completes and
the data is available in memory.

Thanks,
Corrado

>
>
> =E5=9C=A8 Fri, 13 Jul 2012 22:15:31 +0800=EF=BC=8CCorrado Zoccolo <cz=
occolo@gmail.com> =E5=86=99=E9=81=93:
>
>> Hi,
>> the catch is that writes are "fire and forget", so they keep accumul=
ating
>> in the I/O sched, and there is always plenty of them to schedule (un=
less
>> you explicitly make sync writes).
>>
>> The reader, instead, waits for the result of each read operation bef=
ore
>> scheduling a new read, so there is at most one outstanding read, and=
 some
>> time nothing.
>>
>> The deadline scheduler is work conserving, meaning that it never lea=
ves
>> the
>> disk idle when there is work queued, and most of the time after an
>> operation completes, there is only write work queued, so you see muc=
h
>> more
>> writes being sent to the device.
>>
>> Only schedulers that delay writes waiting for reads (as Anticipatory=
 in
>> old
>> kernels, and now CFQ) can achieve higher read to write ratios.
>>
>> Cheers
>> Corrado
>>
>> On Thu, Jul 12, 2012 at 11:01 AM, gaoqiang <gaoqiangscut@gmail.com>
>> wrote:
>>
>>> Hi,all
>>>
>>>         I have long known that deadline is read-prefered. but a sim=
ple
>>> test gives the opposite result.
>>>
>>>         with two processes running at the same time,one for read an=
d one
>>> for write.actually,they did nothing bug IO operation.
>>>         while(true)
>>>         {
>>>                 read();
>>>         }
>>>         the other:
>>>         while(true)
>>>         {
>>>                 write();
>>>         }
>>>
>>>         with deadline IO-sched  and ext4 filesystem.as a result, re=
ad
>>> ratio was about below 3M/s.and write about 100M/s. I have tested bo=
th
>>> kernel-2.6.18 and kernel-2.6.32,getting the same result.
>>>
>>>         I add some debug information in the kernel and recompile,fo=
und
>>> that,it has little to do with IO-sched layer because read request
>>> dropped
>>> into deadline was 5% of write request .from /proc/<pid>/stack,the r=
ead
>>> process hands on sync_page most of the time.
>>>         what is the matter ? anyone help me ?
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at
>>> http://vger.kernel.org/**majordomo-info.html<http://vger.kernel.org=
/majordomo-info.html>
>>>
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>
>>
>>
>
>
> --
> =E4=BD=BF=E7=94=A8 Opera =E9=9D=A9=E5=91=BD=E6=80=A7=E7=9A=84=E7=94=B5=
=E5=AD=90=E9=82=AE=E4=BB=B6=E5=AE=A2=E6=88=B7=E7=A8=8B=E5=BA=8F: http:/=
/www.opera.com/mail/




--
_______________________________________________________________________=
___

dott. Corrado Zoccolo                          mailto:czoccolo@gmail.co=
m
PhD - Department of Computer Science - University of Pisa, Italy
-----------------------------------------------------------------------=
---
The self-confidence of a warrior is not the self-confidence of the aver=
age
man. The average man seeks certainty in the eyes of the onlooker and ca=
lls
that self-confidence. The warrior seeks impeccability in his own eyes a=
nd
calls that humbleness.
                               Tales of Power - C. Castaneda
