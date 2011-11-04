From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring]
 mode for dw_mmc
Date: Fri, 04 Nov 2011 10:43:21 +0900
Message-ID: <4EB34339.4060809@samsung.com>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
 <4E8BBD76.9020001@samsung.com>
 <CANYdXnpe0prpdJcYpi3yVqCecugwZ1999c2u2u6ffjXjSeCDnw@mail.gmail.com>
 <m2obwt8ju2.fsf@bob.laptop.org>
 <CAFbHwiSahkGOd4EfYiKY-T9Segn9Nn4qSMA591SFRmMmKY67VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56341 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754460Ab1KDBnq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2011 21:43:46 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LU4006IC4SDU0C0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Nov 2011 10:43:29 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LU400H0A4SH6B80@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 04 Nov 2011 10:43:29 +0900 (KST)
In-reply-to: <CAFbHwiSahkGOd4EfYiKY-T9Segn9Nn4qSMA591SFRmMmKY67VQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org

On 11/04/2011 12:18 AM, Will Newton wrote:

> On Thu, Nov 3, 2011 at 12:35 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Thu, Nov 03 2011, Shashidhar Hiremath wrote:
>>> Hi Chris,
>>>   Can this patch be accepted by criteria that its an additional
>>> feature supported by the hardware and hence good to have the support
>>> in the driver.Also note the patch has been tested.
>>
>> I think Will and James should make the call on that.
>>
>> My own opinion is that it's not usually a good idea to merge code that
>> increases complexity for no performance gain; if the feature is actually
>> important, someone should find a way to finish it and measure a
>> performance gain (the gain can be in any of bandwidth, memory, or
>> lower CPU utilization) with it, to prove that the change is worthwhile.
> 
> I'm inclined to agree. I don't want to feel like I am blocking
> inclusion of anyone's hard work, but unless there is a clear advantage
> for one option over the other I can't see a good reason for merging
> it. At present it adds a question to the Kconfig that is pretty much
> impossible for the user to answer (do I turn this feature on or off?
> what is the advantage of choosing each option?).


Maybe, i think we didn't achieve the any advantage with this patch.
But i understood that shashidhar's hardware is only supported dual buffer descriptor.
So he want to merge this patch. If that is not reason, i also think that didn't need to 
merge. I didn't see that improve the performance...memory/CPU utilization..

Regards,
Jaehoon Chung

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


