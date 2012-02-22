From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Wed, 22 Feb 2012 16:16:22 +0900
Message-ID: <4F449646.8020908@samsung.com>
References: <4F190E26.4040909@samsung.com>
 <CAKLKtzcoOXJoZX7E87u-yfbYMCz26y3KWmqn-dA-UkJ=HiYW7A@mail.gmail.com>
 <4F3B1D69.8060308@samsung.com>
 <6c3f05d8d59e75411f3284e8344e0bdd.squirrel@www.codeaurora.org>
 <CAELcNGTfqtduibsaXTE-a1GRe=9cHEMeEZB5cxtSnG+ufvFFUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:60086 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab2BVHQZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Feb 2012 02:16:25 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZS00CNP9H4CGR0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 22 Feb 2012 16:16:23 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZS008QH9JAP0H0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 22 Feb 2012 16:16:23 +0900 (KST)
In-reply-to: <CAELcNGTfqtduibsaXTE-a1GRe=9cHEMeEZB5cxtSnG+ufvFFUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Saugata Das <saugata.das@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hi Konstantin

I didn't see the level-3, but have seen the level-2.
URGENT_BKOPS should be triggered when the levels is either 2 or 3.
So maybe you can see the URGENT_BKOPS with level-2.

Best Regards,
Jaehoon Chung

On 02/21/2012 11:21 PM, Jae hoon Chung wrote:

> 2012/2/21 Konstantin Dorfman <kdorfman@codeaurora.org>:
>> Hello Jaehoon,
>> I'm testing your patch and will post review soon.
>> Have you ever seen urgent BKOPS triggered?
>> I have BUGON() on such event and till now never seen it.
> Hi Konstantin..
> Actually, i didn't urgent BKOPS(level-3), but i have seen the level-2.
> I think that maybe eMMC4.41 is triggered the urgent BKOPS with level-2.
> (Now, i didn't see the spec, tomorrow i will check this.)
> Thanks for testing..and i will wait for your review..
> 
> Best Regards,
> Jaehoon Chung
>>
>> --
>> Konstantin Dorfman
>> Consultant for Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


