From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: core: Fix the HPI execution sequence
Date: Wed, 18 Apr 2012 21:54:03 +0900
Message-ID: <4F8EB96B.4080209@samsung.com>
References: <1334670334-18050-1-git-send-email-svenkatr@ti.com>
 <CAKYAXd96A6yzaz-59y+79sgRaQuT3MpRBZKStJM4HQN3L-=h5A@mail.gmail.com>
 <4F8E1B98.1050803@samsung.com>
 <CAKYAXd9PNeEDZAC6JVfySRHH-yFhThOdCE92MiULWxw94-dZjw@mail.gmail.com>
 <CANfBPZ9_+n7gTd1Ny1xGPpDX9DJ4=aXeX7K8eogGBWg7vG527w@mail.gmail.com>
 <CAKYAXd_osDoHtCLq0k2JmrwmOzZhLqnAu7QkzYkyLGn4Px_inw@mail.gmail.com>
 <CANfBPZ9pq6=iNHuDBrwTj-_AwZa-BoGZsYP0FVBXb=9GKEF01g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48805 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab2DRMyW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 08:54:22 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M2O009EVEI0X120@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 18 Apr 2012 21:54:20 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M2O00GIEEIJ5P50@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 18 Apr 2012 21:54:20 +0900 (KST)
In-reply-to: <CANfBPZ9pq6=iNHuDBrwTj-_AwZa-BoGZsYP0FVBXb=9GKEF01g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Namjae Jeon <linkinjeon@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 04/18/2012 05:42 PM, S, Venkatraman wrote:

> On Wed, Apr 18, 2012 at 1:53 PM, Namjae Jeon <linkinjeon@gmail.com> wrote:
>> 2012/4/18 S, Venkatraman <svenkatr@ti.com>:
>>> On Wed, Apr 18, 2012 at 10:15 AM, Namjae Jeon <linkinjeon@gmail.com> wrote:
>>>> 2012/4/18 Jaehoon Chung <jh80.chung@samsung.com>:
>>>>> On 04/18/2012 09:20 AM, Namjae Jeon wrote:
>>>>>
>>>>>> 2012/4/17 Venkatraman S <svenkatr@ti.com>:
>>>>>>> mmc_execute_hpi should send the HPI command only
>>>>>>> once, only if the card is in PRG state.
>>>>>>>
>>>>>>> According to eMMC spec, the command's completion time is
>>>>>>> not dependent on OUT_OF_INTERRUPT_TIME. Only the transition
>>>>>>> out of PRG STATE is guarded by OUT_OF_INTERRUPT_TIME - which is
>>>>>>> defined to begin at the end of sending the command itself.
>>>>>> Hi. Venkatraman.
>>>>>> I can not find this words. " the command's completion time is not
>>>>>> dependent on OUT_OF_INTERRUPT_TIME" .
>>>>>> Would you inform me which page and which part you checked in specification ?
>>>>>
>>>>> Well, i know that timeout value is used the OUT_OF_INTERRUPT_TIME, when interrupted by HPI.
>>>>> It's my misunderstanding?
>>>> I agree, I also understand with you. But we should hear Venkatraman's
>>>> opinion from next reply.
>>>> see the spec.
>>>
>>> That particular line was explicit, *emphasis* mine..
>>> In Section 6.8.2 "OUT_OF_INTERRUPT_TIME defines the maximum time
>>> between the *end* bit of CMD12/13, arg[0]=1 to the DAT0 release of the
>>> device."
>>>
>>> Which essentially means the timer should start after the HPI command
>>> has been exchanged, and should normally end when the DAT0 line is
>>> released (in other words, move out of PRG state).
>>> You can see the same definition in Section 7.4.33
>>>
>>> The definition in 6.6.23, is partly confusing, for one it uses
>>> OUT_OF_INTERRUPT_BUSY_TIME and not OUT_OF_INTERRUPT_TIME, and other,
>>> it refers to the command being *interrupted by* HPI, not the HPI
>>> command itself.
>>>
>>> Let me know if this explains it a bit better.
>>>
>>> Best regards,
>>> Venkat.
>> Hi. Venkat.
>> You're right. OUT_OF_INTERRUPT_TIME is range between Busy line(Data0)
>> released by device and end bit of CMD 12,13.
>> and I would like you change some code in this patch.
>> I think that break is better than goto. because it is not duplicated loop.
>> +               if (!err && R1_CURRENT_STATE(status) == R1_STATE_TRAN)
>> +                       goto out;
>>
>> you don't need to initialize cmd_timeout_ms value. because you can see
>> struct mmc_command cmd = {0}; code.
>> +       cmd.cmd_timeout_ms = 0;
>>
>> Thanks.
>>
> 
> Great - thanks for your review and feedback. I'll post a new patch
> after making the changes you

Thanks for your explanation. it makes sense.
If you resend the patch, i will test with your patch.

Best Regards,
Jaehoon Chung

> requested.
> Regards,
> Venkat.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


