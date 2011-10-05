From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Support predefined multiple block transfers.
Date: Wed, 05 Oct 2011 17:19:34 +0900
Message-ID: <4E8C1316.2040507@samsung.com>
References: <001901cc7c42$00147c10$003d7430$%jun@samsung.com>
 <992253991.685205.1317054932934.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
 <001f01cc7cba$f1238560$d36a9020$%jun@samsung.com>
 <CANz0V+7xJF4h4XUGoL43odFyOpwcBmxgV18R-uR4oDaqV-9jJA@mail.gmail.com>
 <003101cc7db7$f203e350$d60ba9f0$%jun@samsung.com>
 <4E8BE4D7.1070308@samsung.com>
 <000c01cc8335$101b6d40$305247c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20658 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758002Ab1JEIUD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 04:20:03 -0400
In-reply-to: <000c01cc8335$101b6d40$305247c0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, "'Andrei E. Warkentin'" <andrey.warkentin@gmail.com>, 'Andrei Warkentin' <awarkentin@vmware.com>, 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, 'kgene kim' <kgene.kim@samsung.com>, 'dh han' <dh.han@samsung.com>, linux-mmc@vger.kernel.org

On 10/05/2011 05:02 PM, Seungwon Jeon wrote:

> Jaehoon Chung wrote:
>>
>> Hi Mr.Jeon
>>
>> One question...if we used predefined transfer, didn't send stop-command?
>> then i think that didn't need to enter this condition..how about this?
>>
>> In __dw_mci_start_reqeust() function(at your patch)
>>
>> if (mrq->stop)
>> 	host->stop_cmdr = dw_mci_prepare_command(slot->mmc, mrq->stop);
>>
>> If i misunderstood something, plz let me know...Thanks.
> Yes, predefined transfer doesn't send stop command normally.
> But if transfer error is occurred, stop command is required.

Thanks for your answer. i didn't look in detail.
your patch is worked when there is data->error, send stop command..right?

This patch looks good to me.

Best Regards,
Jaehoon Chung

> 
> Thank you for test.
> Best regards,
> Seungwon Jeon.
>>
>> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> On 09/28/2011 05:23 PM, Seungwon Jeon wrote:
>>
>>> Andrei Warkentin wrote:
>>>> 2011/9/26 Seungwon Jeon <tgih.jun@samsung.com>:
>>>>> Andrei Warkentin wrote:
>>>>>> Hi Seungwon,
>>>>>>
>>>>>> ----- Original Message -----
>>>>>>> From: "Seungwon Jeon" <tgih.jun@samsung.com>
>>>>>>> To: linux-mmc@vger.kernel.org
>>>>>>> Cc: "Chris Ball" <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org,
>>>>>> "kgene kim" <kgene.kim@samsung.com>, "dh han"
>>>>>>> <dh.han@samsung.com>, "Seungwon Jeon" <tgih.jun@samsung.com>
>>>>>>> Sent: Monday, September 26, 2011 7:46:59 AM
>>>>>>> Subject: [PATCH] mmc: dw_mmc: Support predefined multiple block
>>>>>> transfers.
>>>>>>>
>>>>>>> This patch adds the support for predefined multiple block read/write.
>>>>>>>
>>>>>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>>>>>
>>>>>> Without knowing much about dw_mmc host, your logic otherwise looks ok,
>>>>>> given what
>>>>>> I've previously done for SDHCI as far as CMD23/Auto-CMD23 enhancement.
>>>>>> Just curious, what eMMC cards did you test this on, and what
>>>> improvement
>>>>>> did you see?
>>>>>
>>>>> Thank you for review.
>>>>> As you done, predefined transfer is required for reliable writes and
>>>> eMMC4.5 feature.
>>>>> Sadly, I didn't gain an improvement in my case.
>>>>> (I don't know whether I can clarify the tested eMMC card, just one
>>>> sample.)
>>>>>
>>>>
>>>> So far I've seen some Sandisk cards have a noticeable real-life
>>>> improvement (30%) over
>>>> open-ended transfers.
>>>>
>>>> You might wish to try out https://github.com/andreiw/superalign to be
>>>> certain.
>>>
>>> I had already tested this patch with IOZONE, but I found no difference.
>>> Maybe a result depends on eMMC device.
>>> As your recommend, I applied above benchmark tool.
>>> Predefined transfer seems like a little better, but there is no
>> difference.
>>>
>>> Thanks.
>>> Seungwon Jeon.
>>>
>>>>
>>>> A
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


