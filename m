From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: init desc in dw_mci_idmac_init
Date: Thu, 30 Apr 2015 22:13:30 +0800
Message-ID: <CABQgh9FVA+GPmz88UFr9j__h03RMa_tVM3zttwSaMFFUj82viw@mail.gmail.com>
References: <1430314316-15971-1-git-send-email-zhangfei.gao@linaro.org>
	<5541E13F.2070908@samsung.com>
	<5541E9C7.4010804@linaro.org>
	<CAELcNGSWV_EVECekLcnP=x992XO8=164bUcA=P=G28Ee0J6myg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33286 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbD3ONb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 10:13:31 -0400
Received: by wief7 with SMTP id f7so14211731wie.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 07:13:31 -0700 (PDT)
In-Reply-To: <CAELcNGSWV_EVECekLcnP=x992XO8=164bUcA=P=G28Ee0J6myg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fei Wang <w.f@huawei.com>, CPGS <cpgs@samsung.com>

On 30 April 2015 at 18:28, Jae hoon Chung <jh80.chung@gmail.com> wrote:
>
>
> 2015-04-30 17:37 GMT+09:00 zhangfei <zhangfei.gao@linaro.org>:
>>
>>
>>
>> On 04/30/2015 04:01 PM, Jaehoon Chung wrote:
>>>
>>> Hi.
>>>
>>> On 04/29/2015 10:31 PM, Zhangfei Gao wrote:
>>>>
>>>> Set 0 to des1 in 32bit case.
>>>> Otherwise the random value of des1 will be used in
>>>> dw_mci_translate_sglist: IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, length)
>>>
>>>
>>> I'm not understanding this comment.
>>> how does it use the IDMAC_64ADDR_SET_BUFFER1_SIZE(desc, length)?
>>
>>
>> p->des1 contains random value, coming from dmam_alloc_coherent in
>> dw_mci_init_dma
>>
>> In dw_mci_translate_sglist -> IDMAC_SET_BUFFER1_SIZE(desc, length);
>> #define IDMAC_SET_BUFFER1_SIZE(d, s) \
>>         ((d)->des1 = ((d)->des1 & 0x03ffe000) | ((s) & 0x1fff))
>>
> I think you need to change the commit message
> (IDMAC_SET_BUFFER1_SIZE instead of IDMAC_64ADDR_SET_BUFFER1_SIZE.
>
> You mentioned about desc1, but IDMAC_64ADDR_SET_BUFFER1_SIZE assign to
> desc2.

Yes, made mistake, will change the log.
