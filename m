From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 18 Apr 2012 14:12:41 +0530
Message-ID: <CANfBPZ9pq6=iNHuDBrwTj-_AwZa-BoGZsYP0FVBXb=9GKEF01g@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
 <CAKYAXd96A6yzaz-59y+79sgRaQuT3MpRBZKStJM4HQN3L-=h5A@mail.gmail.com>
 <4F8E1B98.1050803@samsung.com> <CAKYAXd9PNeEDZAC6JVfySRHH-yFhThOdCE92MiULWxw94-dZjw@mail.gmail.com>
 <CANfBPZ9_+n7gTd1Ny1xGPpDX9DJ4=aXeX7K8eogGBWg7vG527w@mail.gmail.com> <CAKYAXd_osDoHtCLq0k2JmrwmOzZhLqnAu7QkzYkyLGn4Px_inw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:52276 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751062Ab2DRInF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 04:43:05 -0400
Received: by bkuw5 with SMTP id w5so5135800bku.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 01:43:01 -0700 (PDT)
In-Reply-To: <CAKYAXd_osDoHtCLq0k2JmrwmOzZhLqnAu7QkzYkyLGn4Px_inw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Apr 18, 2012 at 1:53 PM, Namjae Jeon <linkinjeon@gmail.com> wro=
te:
> 2012/4/18 S, Venkatraman <svenkatr@ti.com>:
>> On Wed, Apr 18, 2012 at 10:15 AM, Namjae Jeon <linkinjeon@gmail.com>=
 wrote:
>>> 2012/4/18 Jaehoon Chung <jh80.chung@samsung.com>:
>>>> On 04/18/2012 09:20 AM, Namjae Jeon wrote:
>>>>
>>>>> 2012/4/17 Venkatraman S <svenkatr@ti.com>:
>>>>>> mmc_execute_hpi should send the HPI command only
>>>>>> once, only if the card is in PRG state.
>>>>>>
>>>>>> According to eMMC spec, the command's completion time is
>>>>>> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
>>>>>> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
>>>>>> defined to begin at the end of sending the command itself.
>>>>> Hi. Venkatraman.
>>>>> I can not find this words. " the command's completion time is not
>>>>> dependent on OUT_OF_INTERRUPT_TIME" .
>>>>> Would you inform me which page and which part you checked in spec=
ification ?
>>>>
>>>> Well, i know that timeout value is used the OUT_OF_INTERRUPT_TIME,=
 when interrupted by HPI.
>>>> It's my misunderstanding?
>>> I agree, I also understand with you. But we should hear Venkatraman=
's
>>> opinion from next reply.
>>> see the spec.
>>
>> That particular line was explicit, *emphasis* mine..
>> In Section 6.8.2 "OUT_OF_INTERRUPT_TIME defines the maximum time
>> between the *end* bit of CMD12/13, arg[0]=3D1 to the DAT0 release of=
 the
>> device."
>>
>> Which essentially means the timer should start after the HPI command
>> has been exchanged, and should normally end when the DAT0 line is
>> released (in other words, move out of PRG state).
>> You can see the same definition in Section 7.4.33
>>
>> The definition in 6.6.23, is partly confusing, for one it uses
>> OUT_OF_INTERRUPT_BUSY_TIME and not OUT_OF_INTERRUPT_TIME, and other,
>> it refers to the command being *interrupted by* HPI, not the HPI
>> command itself.
>>
>> Let me know if this explains it a bit better.
>>
>> Best regards,
>> Venkat.
> Hi. Venkat.
> You're right. OUT_OF_INTERRUPT_TIME is range between Busy line(Data0)
> released by device and end bit of CMD 12,13.
> and I would like you change some code in this patch.
> I think that break is better than goto. because it is not duplicated =
loop.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status) =3D=
=3D R1_STATE_TRAN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> you don't need to initialize cmd_timeout_ms value. because you can se=
e
> struct mmc_command cmd =3D {0}; code.
> + =A0 =A0 =A0 cmd.cmd_timeout_ms =3D 0;
>
> Thanks.
>

Great - thanks for your review and feedback. I'll post a new patch
after making the changes you
requested.
Regards,
Venkat.
