From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Wed, 18 Apr 2012 14:42:25 +0900
Message-ID: <CAKYAXd9QfEEJLQGG6PJgnNyyXP4D2Sa-PqhiZ=dDdQv50z76+A@mail.gmail.com>
References: <1334082412-2821-1-git-send-email-subhashj@codeaurora.org>
	<87pqbfv3e1.fsf@laptop.org>
	<000201cd174a$f3019b80$d904d280$@codeaurora.org>
	<000301cd1d22$57444d40$05cce7c0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33371 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab2DRFm1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 01:42:27 -0400
In-Reply-To: <000301cd1d22$57444d40$05cce7c0$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi. Subhash.

Would you share which option you used in LMDD, iozone test ?

Thanks.

2012/4/18 Subhash Jadavani <subhashj@codeaurora.org>:
> Hi Chris,
>
>> -----Original Message-----
>> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
>> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
>> Sent: Wednesday, April 11, 2012 12:22 AM
>> To: 'Chris Ball'
>> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org
>> Subject: RE: [PATCH v1 1/1] mmc: block: replace __blk_end_request() =
with
>> blk_end_request()
>>
>>
>>
>> > -----Original Message-----
>> > From: Chris Ball [mailto:cjb@laptop.org]
>> > Sent: Wednesday, April 11, 2012 12:08 AM
>> > To: Subhash Jadavani
>> > Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org
>> > Subject: Re: [PATCH v1 1/1] mmc: block: replace __blk_end_request(=
)
>> > with
>> > blk_end_request()
>> >
>> > Hi,
>> >
>> > On Tue, Apr 10 2012, Subhash Jadavani wrote:
>> > > This patch replaces all __blk_end_request() calls with
>> > > blk_end_request() and __blk_end_request_all() calls with
>> > > blk_end_request_all().
>> > >
>> > > Testing done: 20 process concurrent read/write on sd card and eM=
MC.
>> > > Ran this test for almost a day on multicore system and no errors
>> > > observed.
>> >
>> > Is there a measurable improvement in throughput or latency that yo=
u
>> > can
>> show
>> > data for?
>>
>> This change was not meant for improving MMC throughput; it's basical=
ly
> about
>> becoming fair to other threads/interrupts in the system. By holding =
spin
> lock
>> and interrupts disabled for longer duration, we won't allow other
>> threads/interrupts to run at all.
>> Actually slight performance degradation at file system level can be
> expected as
>> we are not holding the spin lock during blk_update_bidi_request() wh=
ich
> means
>> our mmcqd thread may get preempted for other high priority thread or=
 any
>> interrupt in the system.
>>
>>
>> These are performance numbers (100MB file write) with eMMC running i=
n
>> DDR
>> mode:
>>
>> Without this patch:
>> =C2=A0 =C2=A0 =C2=A0 Name of the Test =C2=A0 =C2=A0 =C2=A0 =C2=A0Val=
ue =C2=A0 Unit
>> =C2=A0 =C2=A0 =C2=A0 LMDD Read Test =C2=A053.79 =C2=A0 MBPS
>> =C2=A0 =C2=A0 =C2=A0 LMDD Write Test 18.86 =C2=A0 MBPS
>> =C2=A0 =C2=A0 =C2=A0 IOZONE =C2=A0Read Test =C2=A0 =C2=A0 =C2=A0 51.=
65 =C2=A0 MBPS
>> =C2=A0 =C2=A0 =C2=A0 IOZONE =C2=A0Write Test =C2=A0 =C2=A0 =C2=A024.=
36 =C2=A0 MBPS
>>
>> With this patch:
>>
>> =C2=A0 =C2=A0 =C2=A0 Name of the Test =C2=A0 =C2=A0 =C2=A0 =C2=A0Val=
ue =C2=A0 Unit
>> =C2=A0 =C2=A0 =C2=A0 LMDD Read Test =C2=A052.94 =C2=A0 MBPS
>> =C2=A0 =C2=A0 =C2=A0 LMDD Write Test 16.70 =C2=A0 MBPS
>> =C2=A0 =C2=A0 =C2=A0 IOZONE =C2=A0Read Test =C2=A0 =C2=A0 =C2=A0 52.=
08 =C2=A0 MBPS
>> =C2=A0 =C2=A0 =C2=A0 IOZONE =C2=A0Write Test =C2=A0 =C2=A0 =C2=A023.=
29 =C2=A0 MBPS
>>
>> Read numbers are fine. Write numbers are bit down (especially LMDD w=
rite),
>> may be because write requests normally have large transfer size and =
which
>> means there are chances that while mmcq is executing
>> blk_update_bidi_request(), it may get interrupted by interrupts or o=
ther
> high
>> priority thread.
>
> Any thoughts/suggestions on this patch and numbers?
>
> Regards,
> Subhash
>>
>> Regards,
>> Subhash
>>
>> >
>> > Thanks,
>> >
>> > - Chris.
>> > --
>> > Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
>> > One Laptop Per Child
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-=
msm"
> in the
>> body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
