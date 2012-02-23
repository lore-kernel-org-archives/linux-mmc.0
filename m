From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Thu, 23 Feb 2012 11:21:07 +0900
Message-ID: <4F45A293.6060608@samsung.com>
References: <4F190E26.4040909@samsung.com> <4F44F792.2000304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:63559 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2BWCVS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Feb 2012 21:21:18 -0500
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LZT0084LQHH0680@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Feb 2012 11:21:10 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LZT00738QJ9RG40@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 23 Feb 2012 11:21:10 +0900 (KST)
In-reply-to: <4F44F792.2000304@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

On 02/22/2012 11:11 PM, Adrian Hunter wrote:

> On 20/01/12 08:48, Jaehoon Chung wrote:
>> Enable eMMC background operations (BKOPS) feature.
>>
>> If URGENT_BKOPS is set after a response, note that BKOPS
>> are required. After all I/O requests are finished, run
>> BKOPS if required. Should read/write operations be requested
>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>> and then service the request.
> 
> You are leaving bkops running and releasing the host.  Won't
> that cause problems for other entry points to mmc services
> e.g. system suspend (cache control, sleep etc), ioctl, sysfs,
> etc

I see. i will complement for your review.
Didn't you have the other comment?

Best Regards,
Jaehoon Chung

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


