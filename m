From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 18 Apr 2012 20:19:09 +0530
Message-ID: <CANfBPZ996rHZSw8zw9eqm0Lw9aoJLq8ukpHVa7vb6jtsPc04aw@mail.gmail.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
 <CAKYAXd96A6yzaz-59y+79sgRaQuT3MpRBZKStJM4HQN3L-=h5A@mail.gmail.com>
 <4F8E1B98.1050803@samsung.com> <CAKYAXd9PNeEDZAC6JVfySRHH-yFhThOdCE92MiULWxw94-dZjw@mail.gmail.com>
 <CANfBPZ9_+n7gTd1Ny1xGPpDX9DJ4=aXeX7K8eogGBWg7vG527w@mail.gmail.com>
 <CAKYAXd_osDoHtCLq0k2JmrwmOzZhLqnAu7QkzYkyLGn4Px_inw@mail.gmail.com>
 <CANfBPZ9pq6=iNHuDBrwTj-_AwZa-BoGZsYP0FVBXb=9GKEF01g@mail.gmail.com> <4F8EB96B.4080209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:51173 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751765Ab2DROtc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Apr 2012 10:49:32 -0400
Received: by bkcjm19 with SMTP id jm19so9902374bkc.39
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 07:49:30 -0700 (PDT)
In-Reply-To: <4F8EB96B.4080209@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Apr 18, 2012 at 6:24 PM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> On 04/18/2012 05:42 PM, S, Venkatraman wrote:
>
>> On Wed, Apr 18, 2012 at 1:53 PM, Namjae Jeon <linkinjeon@gmail.com> =
wrote:
>>> 2012/4/18 S, Venkatraman <svenkatr@ti.com>:
>>>> On Wed, Apr 18, 2012 at 10:15 AM, Namjae Jeon <linkinjeon@gmail.co=
m> wrote:
>>>>> 2012/4/18 Jaehoon Chung <jh80.chung@samsung.com>:
>>>>>> On 04/18/2012 09:20 AM, Namjae Jeon wrote:
>>>>>>
>>>>>>> 2012/4/17 Venkatraman S <svenkatr@ti.com>:
>>>>>>>> mmc_execute_hpi should send the HPI command only
>>>>>>>> once, only if the card is in PRG state.
>>>>>>>>
>>>>>>>> According to eMMC spec, the command's completion time is
>>>>>>>> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
>>>>>>>> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which i=
s
>>>>>>>> defined to begin at the end of sending the command itself.
>>>>>>> Hi. Venkatraman.
>>>>>>> I can not find this words. " the command's completion time is n=
ot
>>>>>>> dependent on OUT_OF_INTERRUPT_TIME" .
>>>>>>> Would you inform me which page and which part you checked in sp=
ecification ?
>>>>>>
>>>>>> Well, i know that timeout value is used the OUT_OF_INTERRUPT_TIM=
E, when interrupted by HPI.
>>>>>> It's my misunderstanding?
>>>>> I agree, I also understand with you. But we should hear Venkatram=
an's
>>>>> opinion from next reply.
>>>>> see the spec.
>>>>
>>>> That particular line was explicit, *emphasis* mine..
>>>> In Section 6.8.2 "OUT_OF_INTERRUPT_TIME defines the maximum time
>>>> between the *end* bit of CMD12/13, arg[0]=3D1 to the DAT0 release =
of the
>>>> device."
>>>>
>>>> Which essentially means the timer should start after the HPI comma=
nd
>>>> has been exchanged, and should normally end when the DAT0 line is
>>>> released (in other words, move out of PRG state).
>>>> You can see the same definition in Section 7.4.33
>>>>
>>>> The definition in 6.6.23, is partly confusing, for one it uses
>>>> OUT_OF_INTERRUPT_BUSY_TIME and not OUT_OF_INTERRUPT_TIME, and othe=
r,
>>>> it refers to the command being *interrupted by* HPI, not the HPI
>>>> command itself.
>>>>
>>>> Let me know if this explains it a bit better.
>>>>
>>>> Best regards,
>>>> Venkat.
>>> Hi. Venkat.
>>> You're right. OUT_OF_INTERRUPT_TIME is range between Busy line(Data=
0)
>>> released by device and end bit of CMD 12,13.
>>> and I would like you change some code in this patch.
>>> I think that break is better than goto. because it is not duplicate=
d loop.
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err && R1_CURRENT_STATE(status) =
=3D=3D R1_STATE_TRAN)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>
>>> you don't need to initialize cmd_timeout_ms value. because you can =
see
>>> struct mmc_command cmd =3D {0}; code.
>>> + =A0 =A0 =A0 cmd.cmd_timeout_ms =3D 0;
>>>
>>> Thanks.
>>>
>>
>> Great - thanks for your review and feedback. I'll post a new patch
>> after making the changes you
>
> Thanks for your explanation. it makes sense.
> If you resend the patch, i will test with your patch.
>
I've just sent it. Let me know if you require more details.

> Best Regards,
> Jaehoon Chung
>
>> requested.
>> Regards,
>> Venkat.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
