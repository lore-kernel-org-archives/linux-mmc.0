From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] dw_mmc: ensure the ciu-reset
Date: Tue, 06 Sep 2011 09:36:00 +0900
Message-ID: <4E656AF0.60702@samsung.com>
References: <4E641A31.8070604@samsung.com>
 <CAFbHwiTSkcnXyy2igZd=WfozER1RmTwFdg=t=B87GzXU+nSwwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8868 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab1IFAfI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Sep 2011 20:35:08 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LR200FENS9I7M60@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Sep 2011 09:35:06 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LR2000UFSAIFRA0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Sep 2011 09:35:06 +0900 (KST)
In-reply-to: <CAFbHwiTSkcnXyy2igZd=WfozER1RmTwFdg=t=B87GzXU+nSwwQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Wonil Choi <wonil22.choi@samsung.com>

Hi Will

Will Newton wrote:

> On Mon, Sep 5, 2011 at 1:39 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 
> Hi Jaehoon,
> 
>> This patch ensured the CIU-reset.
>>
>> If data0 line is low, bit[9] in status register is set to 1.
>> Then we can know the card is busy.
>>
>> Using this bit in status register, we can ensure to reset the CIU correctly.
>> When card is busy and doing ciu-reset, seem like reset completed.
>> But actually didn't complete ciu-reset. because card is busy.
>>
>> So i think good whether check card busy or not before reset the ciu.
> 
> It looks like this isn't exactly what the patch does - the reset
> happens whether the card is busy or not, but if card data is busy then
> the reset may be re-issued.

the reset is happen regardless of the card is busy or not.
Maybe looks like the reset is completed. and no more issued the reset.
But when card is bus and reset completed, maybe next sequence didn't run.
(next sequence is maybe CMD0 issued)
This patch should be prevent not to run next sequence.

> 
> Is there some way to reproduce the issue in this patch? I can't find
> anything in the TRM that suggests that we need to issue the reset more
> than once.


i think this problem is similar to Software/Hardware restrictions.
(in spec, mentioned that have to check the bit[9] in status register before clock change)
Also in this case, to ensure that card is correctly running,
i think that need the more reset processing than once.

in the most case, maybe card status is not busy. then perform to reset only one-time

Best regards,
Jaehoon Chung

> Thanks,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


