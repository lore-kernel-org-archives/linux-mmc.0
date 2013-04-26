From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: clear INSTS register when initialize
Date: Fri, 26 Apr 2013 14:18:55 +0900
Message-ID: <517A0E3F.7030709@samsung.com>
References: <1366262497-22560-1-git-send-email-jy0922.shim@samsung.com>
 <002201ce4008$fe0e0210$fa2a0630$%jun@samsung.com>
 <51766112.7070806@samsung.com>
 <000601ce408b$e60a4e70$b21eeb50$%jun@samsung.com>
 <51774C0F.9040104@samsung.com> <51787CBA.80607@samsung.com>
 <5178E002.6010902@samsung.com>
 <000a01ce4235$e9c49ec0$bd4ddc40$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:20217 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab3DZFSm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Apr 2013 01:18:42 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MLU00EJFK2ZXTO0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 26 Apr 2013 14:18:40 +0900 (KST)
In-reply-to: <000a01ce4235$e9c49ec0$bd4ddc40$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Joonyoung Shim' <jy0922.shim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, will.newton@gmail.com

On 04/26/2013 01:24 PM, Seungwon Jeon wrote:
> On Thursday, April 25, 2013, Joonyoung Shim wrote:
>> On 04/25/2013 09:45 AM, Jaehoon Chung wrote:
>>> On 04/24/2013 12:05 PM, Joonyoung Shim wrote:
>>>> On 04/24/2013 10:34 AM, Seungwon Jeon wrote:
>>>>> On Tuesday, April 23, 2013, Jaehoon Chung wrote:
>>>>>> On 04/23/2013 06:57 PM, Seungwon Jeon wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Thursday, April 18, 2013, Joonyoung Shim wrote:
>>>>>>>> If pending interrupt for IDMAC exists when probe, it will call interrupt
>>>>>>>> handler unnecessarily.
>>>>>>>>
>>>>>>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>>>>>>>> ---
>>>>>>>>  drivers/mmc/host/dw_mmc.c |    3 +++
>>>>>>>>  1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>>>>>> index 323c502..b0057a2 100644
>>>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>>>> @@ -2192,6 +2192,7 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>>>>
>>>>>>>>  	/* Clear the interrupts for the host controller */
>>>>>>>>  	mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>>>>>>> +	mci_writel(host, IDSTS, 0xFFFFFFFF);
>>>>>>> 0x337 is correct for bits. Could you check the bit filed?
>>>> I feel it's better to use already existing defines than 0x337.
>>>>
>>>>>> I think that don't care which reset value used.
>>>>>> "It is recommended that you write 0xffff_ffff to the Raw Interrupt register @0x044 and IDSTS
>> @0x8C
>>>>>> in order to clear any pending interrupts before setting the int_enable bit."
>>>>>> This boot mode case is also used the 0xffff_ffff.
>>>> Jaehoon, can i get this sentence from which document?
>>> That comment is existed at "Synopsys DesignWare Cores mobile storage host databook".
>>> So we can use the 0xffff_ffff.
>>>
>>> Best Regards,
>>> Jaehoon Chung
>>>>> In case IDSTS all 32bit are not for interrupt status unlike RINTSTS.
>>>>> IDSTS[31:17] is reserved and IDSTS[16:0] also contains 'reserved' and 'read-only' field.
>>>>> Correct use would be needed.
>>
>> I know, but as Jaehoon said, it recommands to write 0xFFFFFFFF "Synopsys
>> DesignWare Cores mobile storage host databook" document, so i also think
>> it's ok.
>>
>> Nevertheless if you want to use strict bits set, i can modify it. What
>> is your idea?
> Jaehoon,
> Thank you for information. I also checked that description, 
> but I still feel it doesn't make sense a little bit.
> It seems that manual mentions both RINTSTS and IDSTS at a time while focusing the RINTSTS.
> In a general approach, it's expected to touch relevant fields.
Dear Seungwon,

I don't mind which reset value is used. Then we can use the define macro like IDSTS_RESET_VALUE.
It's important that reset the IDSTS register to prevent pending interrupt.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
>>
>> Thanks.
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

