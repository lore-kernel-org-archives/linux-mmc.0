From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: Resolve BKOPS compatability issue
Date: Mon, 02 Feb 2015 11:00:16 +0900
Message-ID: <54CEDA30.206@samsung.com>
References: <1422521383-11436-1-git-send-email-alexey.skidanov@sandisk.com>
 <54CB3237.2050207@samsung.com>
 <CAPDyKFrR2jne1C=R2phfesLMuZDhARiQgZxvkAcMHkMVrGXaiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:12212 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbbBBCAT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Feb 2015 21:00:19 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NJ400E9DG8H6S70@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 02 Feb 2015 11:00:17 +0900 (KST)
In-reply-to: <CAPDyKFrR2jne1C=R2phfesLMuZDhARiQgZxvkAcMHkMVrGXaiA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexey Skidanov <alexey.skidanov@sandisk.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>

Hi,

On 01/30/2015 07:25 PM, Ulf Hansson wrote:
> On 30 January 2015 at 08:26, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi, Alexey.
>>
>> On 01/29/2015 05:49 PM, Alexey Skidanov wrote:
>>> This patch is coming to fix compatibility issue of BKOPS_EN  field of EXT_CSD.
>>> In eMMC-5.1, BKOPS_EN was changed, and now it has two operational bits:
>>> Bit 0 - MANUAL_EN
>>> Bit 1 - AUTO_EN
>>> In previous eMMC revisions, only Bit 0 was supported.
>>
>> If "manual enable" is the same functionality with previous enable,
>> I think it doesn't need to change the name..
>> Just checking whether enable or not with Mask bit?
>>
>> If need to add the auto enable, only add the bkops_auto_en in future.
>> This is just my preference..and i don't read the spec since i don't have eMMC5.1 spec.
>>
>> If manual-enable is difference with previous enable, how about using bkops-manual-en?
> 
> According to information I have got around the eMMC 5.1 spec, the old
> value of MAN_EN will remain. That also means that bit will remain as
> one time programmable.
> 
> The new AUTO_EN bit, will be multiple writeable with value kept after
> power failure. But more importantly, the card seems to expect the host
> to disable AUTO_EN before power failure. In other words we need to
> disable AUTO_EN (if set) before entering system PM state an cutting
> power to the card.

Thanks for information.. I want to get this information,
I think auto_en bit can be used usefully.

Best Regards,
Jaehoon Chung

> 
> So, yes, we will have to deal with AUTO_EN sooner or later, thus I am
> kind of happy Alexey's patch, as is.
> 
> Kind regards
> Uffe
> 

