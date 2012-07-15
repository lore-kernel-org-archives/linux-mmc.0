From: gaoqiang <gaoqiangscut@gmail.com>
Subject: Re: question about IO-sched
Date: Sun, 15 Jul 2012 15:08:12 +0800
Message-ID: <op.whg7fy00n27o5l@gaoqiang-d1.corp.qihoo.net>
References: <op.whbsn0qvn27o5l@gaoqiang-d1.corp.qihoo.net>
 <CADX3swpSAt9gdSgYihOJKs1=geQkmB04rCVTSgh=DEXQx7QPmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38804 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2GOHKG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Jul 2012 03:10:06 -0400
In-Reply-To: <CADX3swpSAt9gdSgYihOJKs1=geQkmB04rCVTSgh=DEXQx7QPmQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Corrado Zoccolo <czoccolo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

many thanks. but why the sys_read operation hangs on sync_page ? there =
are =20
still
many free memory.I mean ,the actually free memory,excluding the various=
 =20
kinds of
caches or buffers.


=D4=DA Fri, 13 Jul 2012 22:15:31 +0800=A3=ACCorrado Zoccolo <czoccolo@g=
mail.com> =20
=D0=B4=B5=C0:

> Hi,
> the catch is that writes are "fire and forget", so they keep accumula=
ting
> in the I/O sched, and there is always plenty of them to schedule (unl=
ess
> you explicitly make sync writes).
>
> The reader, instead, waits for the result of each read operation befo=
re
> scheduling a new read, so there is at most one outstanding read, and =
some
> time nothing.
>
> The deadline scheduler is work conserving, meaning that it never leav=
es =20
> the
> disk idle when there is work queued, and most of the time after an
> operation completes, there is only write work queued, so you see much=
 =20
> more
> writes being sent to the device.
>
> Only schedulers that delay writes waiting for reads (as Anticipatory =
in =20
> old
> kernels, and now CFQ) can achieve higher read to write ratios.
>
> Cheers
> Corrado
>
> On Thu, Jul 12, 2012 at 11:01 AM, gaoqiang <gaoqiangscut@gmail.com> =20
> wrote:
>
>> Hi,all
>>
>>         I have long known that deadline is read-prefered. but a simp=
le
>> test gives the opposite result.
>>
>>         with two processes running at the same time,one for read and=
 one
>> for write.actually,they did nothing bug IO operation.
>>         while(true)
>>         {
>>                 read();
>>         }
>>         the other:
>>         while(true)
>>         {
>>                 write();
>>         }
>>
>>         with deadline IO-sched  and ext4 filesystem.as a result, rea=
d
>> ratio was about below 3M/s.and write about 100M/s. I have tested bot=
h
>> kernel-2.6.18 and kernel-2.6.32,getting the same result.
>>
>>         I add some debug information in the kernel and recompile,fou=
nd
>> that,it has little to do with IO-sched layer because read request =20
>> dropped
>> into deadline was 5% of write request .from /proc/<pid>/stack,the re=
ad
>> process hands on sync_page most of the time.
>>         what is the matter ? anyone help me ?
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" =20
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  =20
>> http://vger.kernel.org/**majordomo-info.html<http://vger.kernel.org/=
majordomo-info.html>
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
>


--=20
=CA=B9=D3=C3 Opera =B8=EF=C3=FC=D0=D4=B5=C4=B5=E7=D7=D3=D3=CA=BC=FE=BF=CD=
=BB=A7=B3=CC=D0=F2: http://www.opera.com/mail/
