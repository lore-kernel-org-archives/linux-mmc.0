From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC] improve mmc init sequence
Date: Thu, 17 Mar 2016 19:55:57 +0900
Message-ID: <56EA8D3D.3080502@samsung.com>
References: <56EA2758.7090200@rock-chips.com>
 <CAPDyKFq3PWHZpzi4CyPU4WYHdRXK7QVQW7+Ekf+2AkWxey971g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59627 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935694AbcCQK4A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2016 06:56:00 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O4602V7CJPA0710@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Mar 2016 19:55:58 +0900 (KST)
In-reply-to: <CAPDyKFq3PWHZpzi4CyPU4WYHdRXK7QVQW7+Ekf+2AkWxey971g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 03/17/2016 07:43 PM, Ulf Hansson wrote:
> On 17 March 2016 at 04:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> Hello Ulf,
>>         I notice we add MMC_CAP2_NO_SDIO to avoid sending sdio commands
>> during initialization. So that means we can use it to improve mmc init
>> sequence if a specific board use one slot just for emmc or sd. But I realize
>> that we can move a step further to add more cap2 like NO_SD/
>> NO_MMC in order to reduce the boot time. Does that make sense? If the
>> answer is *yes*, I am happy to push some patches for it since I have
>> been doing it on my local tree and testing for a long time.
> 
> I am not against it, so please go ahead!
> 
> Although, you need to give some proof of the amount of saved boot time
> (or better the decreased initialization time of a couple of different
> cards).

I have already tested with similar sequence..I have remembered there is a benefit for decreasing the booting time.
But i didn't remember how much time is decreased...because it wast too long time ago.

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
> 

