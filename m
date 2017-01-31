From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [GIT PULL] Updates dw-mmc controller for next
Date: Tue, 31 Jan 2017 22:51:05 +0900
Message-ID: <47acd331-20aa-9f59-7b18-3f9849074188@samsung.com>
References: <CGME20170131035834epcas1p1de000eab0012b2f755a934f5eb277f77@epcas1p1.samsung.com>
 <640ec482-ddc0-fc21-b2eb-414ded64ad90@samsung.com>
 <CAPDyKFrTVYM_9aV_A2wipXiaZVt4ft_HpB6VPwDrVAAy2Q+DFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34483 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdAaNvO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 08:51:14 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKN02SO4D56EM60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 31 Jan 2017 22:51:06 +0900 (KST)
In-reply-to: <CAPDyKFrTVYM_9aV_A2wipXiaZVt4ft_HpB6VPwDrVAAy2Q+DFw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 01/31/2017 07:35 PM, Ulf Hansson wrote:
> On 31 January 2017 at 04:58, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Dear Ulf,
>>
>> Could you pull this patch on your next branch?
>>
>> The following changes since commit 2fb4d2ecbaa8596ea74408c251121099167ff2e8:
>>
>>   mmc: core/mmci: restore pre/post_req behaviour (2017-01-30 11:11:30 +0100)
>>
>> are available in the git repository at:
>>
>>   https://github.com/jh80chung/dw-mmc.git for-ulf
>>
>> for you to fetch changes up to 77e565420cb4f0d305aceb5378039dfb9b98e2b0:
>>
>>   mmc: dw_mmc: silent verbose log when calling from PM context (2017-01-31 11:12:20 +0900)
>>
>> ----------------------------------------------------------------
>> Shawn Lin (1):
>>       mmc: dw_mmc: silent verbose log when calling from PM context
>>
>>  drivers/mmc/host/dw_mmc.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> Best Regards,
>> Jaehoon Chung
> 
> Thanks Jaehoon, pulled into next!
> 
> BTW, I also added your sob-tag, as it seems like your forgotten that this time!?

Thanks! :)

> 
> Kind regards
> Uffe
> 
> 

