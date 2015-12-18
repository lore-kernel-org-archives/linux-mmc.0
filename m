From: Alex Ballas <alex@ballas.org>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Sat, 19 Dec 2015 00:55:44 +0200
Message-ID: <CAONpWdsHJEHjedfQrjXru0fETRL3NfXG6cyoQAYtLYAKb5i-2Q@mail.gmail.com>
References: <CAONpWdsteBnqTcFbKpcOQFueyeJJWEmn9DJitD43f59xV8sDyg@mail.gmail.com>
	<BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
	<BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAPDyKFotgz3czCs8XaXwC4kT53Lp0h=n03OUMtO6BUTwTnDYzQ@mail.gmail.com>
	<BY2PR04MB18432C804C263313D2349C848FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAONpWdvo+b=Y26zsCYsHFHjJ+8yAnYfoJOsirdS-he2s1unDgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34968 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbLRWzp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Dec 2015 17:55:45 -0500
Received: by mail-oi0-f52.google.com with SMTP id l9so38379041oia.2
        for <linux-mmc@vger.kernel.org>; Fri, 18 Dec 2015 14:55:45 -0800 (PST)
In-Reply-To: <CAONpWdvo+b=Y26zsCYsHFHjJ+8yAnYfoJOsirdS-he2s1unDgg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Guo <peter.guo@bayhubtech.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "adam8157@gmail.com" <adam8157@gmail.com>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>

Hello Peter & Uffe,

I tested the patch with the latest mainline kernel and it played nicely.
@Uffe how should we move forward with this?

Kind Regards,
Alex

On Fri, Dec 18, 2015 at 12:43 PM, Alex Ballas <alex@ballas.org> wrote:
> Hello Uffe, Peter,
>
> Thank you both. I'll try out Peter's patch to see if it's addressing
> the issue and we can work through it based on Uffe's guidelines.
>
> Kind Regards,
> Alex
>
> On Fri, Dec 18, 2015 at 11:39 AM, Peter Guo <peter.guo@bayhubtech.com> wrote:
>> Hi Ulf,
>>
>> Thanks for your reply.
>>
>> So currently the problem is SDHCI_TRANS_DMA bit need to be cleared before send Non DMA SD/MMC command for some of our host,
>> Could you please give me any suggestion on what kind of code modification you can accept?
>>
>>
>> BR
>> Peter.Guo
>>
>>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Friday, December 18, 2015 4:52 PMT
>> To: Peter Guo
>> Cc: Alex Ballas; adam8157@gmail.com; linux-mmc@VGER.KERNEL.ORG
>> Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader doesn't work
>>
>> On 18 December 2015 at 04:14, Peter Guo <peter.guo@bayhubtech.com> wrote:
>>> Hi Alex & Adam,
>>>
>>> I have send the patch. Please check it.
>>> Attachment is the patch file.
>>
>> Thanks Peter for helping out!
>>
>> Although I would appreciate if you don't send patches as attachments.
>>
>> Moreover, even if the patch can be used to check whether it solves the problem - I won't accept it as is.
>> The reason is simply that I don't allow any more quirks/callbacks to be added for SDHCI.
>>
>> Kind regards
>> Uffe
