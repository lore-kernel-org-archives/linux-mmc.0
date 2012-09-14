From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/2] mmc: core: pre-patch for next eMMC version
Date: Fri, 14 Sep 2012 18:38:03 +0900
Message-ID: <5052FAFB.7040201@samsung.com>
References: <5036C96A.7070300@samsung.com>
 <CAPDyKFqJynoS5d3EmnRi4CxmUyOMYBRzy2spDgUTfT=7+0Xg6Q@mail.gmail.com>
 <503C4A01.2030200@samsung.com>
 <CAPDyKFo0mwkbiQEc8cmPRu9AbB8mUQhuq4AWq=e03fUD1dfKHg@mail.gmail.com>
 <CAH9JG2XwdBao=L3KOxDOtbyhcTuq6rKUEpwWU9+zqhU3HeteQw@mail.gmail.com>
 <5052D8FD.1010900@samsung.com>
 <CAPDyKFo7Tgmo7sA7MAz64XgV2iaNT4hmjnT7wcoWoBQKkHrqng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32724 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab2INJiO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Sep 2012 05:38:14 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MAC0066G2RNTUM0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Sep 2012 18:38:12 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MAC009A02ROI690@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Sep 2012 18:38:12 +0900 (KST)
In-reply-to: <CAPDyKFo7Tgmo7sA7MAz64XgV2iaNT4hmjnT7wcoWoBQKkHrqng@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi Ulf,

I agreed your opinion.

Best Regards,
Jaehoon Chung

On 09/14/2012 06:34 PM, Ulf Hansson wrote:
> Hi Jaehoon,
> 
> For "mmc: core: prepare the next version of eMMC card" you may have my ack!
> 
> But not for "mmc: core: add the quirk for broken revision".
> The reason is simply that it is not needed right now and we don't know
> if it ever will be. So I suggest to skip this for now and we can get
> back to this later.
> 
> Kind regards
> Ulf Hansson
> 
> 
> On 14 September 2012 09:13, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Ulf and Chris,
>>
>> Could you have any opinion?
>> If you have no more, could you merge the patch for eMMC5.0?
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 08/29/2012 08:59 PM, Kyungmin Park wrote:
>>> Hi Ulf,
>>>
>>> On 8/29/12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> Hi Jaehoon,
>>>>
>>>> On 28 August 2012 06:33, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> Hi Ulf,
>>>>>
>>>>> This patch is to support eMMC5.0.(already discussing on eMMC5.0.)
>>>>> Revision value is defined the 0x7 into ext_csd register.(in eMMC5.0's
>>>>> case)
>>>>
>>>> Until the spec is really set we should not add some new code for this,
>>>> it does not make sense to kind of guess.
>>> It's not guess. it's determined and will be discussed at JEDEC soon.
>>>
>>> Revision 1.7 (for MMC V5.0)
>>>
>>> Thank you,
>>> Kyungmin Park
>>>>
>>>>>
>>>>> And case of Quirks is preparation patch to prevent the problem that should
>>>>> exist.
>>>>> That Quirks can also use for backward compatibility.
>>>>> (if card is greater version than eMMC4.5 and need to use only eMMC4.5
>>>>> feature?
>>>>>  then can use quirks and known_rev.)
>>>>
>>>> It is just speculations about potential problems with eMMC 5.0. I
>>>> think we can leave this to later, if/when we see a need for it.
>>>>
>>>> Kind regards
>>>> Ulf Hansson
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

