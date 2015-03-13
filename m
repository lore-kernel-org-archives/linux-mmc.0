From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sleep notification
Date: Fri, 13 Mar 2015 20:46:15 +0900
Message-ID: <5502CE07.2060002@samsung.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
 <CAPDyKFooK=F88mO+8T0o1WAS=a+NntJszt-fa9+Ddkh_LpJsQg@mail.gmail.com>
 <282CEDFCBC30114F83C499CB8F2ED5333F9FF93F@SACMBXIP01.sdcorp.global.sandisk.com>
 <CAPDyKFr2HoMveZ7t=U+CevXuO3hZmN-DivFKEaDnqpPtBYquWA@mail.gmail.com>
 <282CEDFCBC30114F83C499CB8F2ED5333FA0429D@SACMBXIP01.sdcorp.global.sandisk.com>
 <CAPDyKFqLUBYUx9XrhnMeUtf8HU_=4PH_4Vf7m8mM-CT63jG24Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:25578 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbCMLqR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 07:46:17 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NL500ESSFD3S360@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 13 Mar 2015 20:46:15 +0900 (KST)
In-reply-to: <CAPDyKFqLUBYUx9XrhnMeUtf8HU_=4PH_4Vf7m8mM-CT63jG24Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 03/12/2015 06:09 PM, Ulf Hansson wrote:
> [...]
> 
>>>> Also, I think we need to clarify one more point for this patch:
>>>> As was mentioned in commit message - Sleep_Notification can be interrupted
>>> by HPI.
>>>> This allows not blocking the host during the Sleep_Notification busy
>>>> time and allows accepting requests coming during this stage. Thus,
>>>> without having HPI supported, suspend/resume process might be
>>>> influenced by Sleep_Notification busy time, and this should not happen -
>>> suspend/resume should be done in very fast and not blocking manner.
>>>
>>> I fail to understand your comment here.
>>>
>>> Please tell me at what point(s) your think it make sense to issue the
>>> SLEEP_NOTIFICATION? If that is during the suspend phase, then a HPI request
>>> can't be triggered.
>>
>> I think SLEEP_NOTIFICATION should be issued on mmc_pm_notify() call,
>> on PM_SUSPEND_PREPARE case.
> 
> So, exactly why is that to prefer, comparing doing it in system PM
> ->suspend() callback?

Actually, i didn't know the benefit of this feature.

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

