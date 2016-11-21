From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Mon, 21 Nov 2016 10:22:02 +0900
Message-ID: <1b5c053e-b869-de84-3428-8c3d95927307@samsung.com>
References: <CGME20161118062929epcas2p35fff280ed75b50d35c3194514c7e0d8d@epcas2p3.samsung.com>
 <1479450555-19047-1-git-send-email-jun.nie@linaro.org>
 <2205472e-963f-319b-6523-76a4f486cafe@samsung.com>
 <CAPDyKFrjmQCN=YckNTrQtLNk3pCsCt5PFxRdqpk5rEqCHWh1bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49642 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbcKUBWI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2016 20:22:08 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGY012RBX4TUL20@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 21 Nov 2016 10:22:05 +0900 (KST)
In-reply-to: <CAPDyKFrjmQCN=YckNTrQtLNk3pCsCt5PFxRdqpk5rEqCHWh1bw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, xie.baoyou@zte.com.cn, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc <linux-mmc@vger.kernel.org>

Hi Ulf,

On 11/18/2016 11:31 PM, Ulf Hansson wrote:
> On 18 November 2016 at 07:52, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Jun,
>>
>> On 11/18/2016 03:29 PM, Jun Nie wrote:
>>> Add intial support to DW MMC host on ZTE SoC. It include platform
>>> specific wrapper driver and workarounds for fifo quirk.
>>>
>>> Patches are prepared based on latest dw mmc runtime change:
>>>    https://github.com/jh80chung/dw-mmc.git for-ulf
>>
>> Applied on my dwmmc repository.
>> I have applied your patches, after modifying some conflict and subject prefix as "dw_mmc*".
>> And added Shawn's reviewed-by tags. Thanks!
> 
> [...]
> 
>>> Jun Nie (5):
>>>   mmc: dt-bindings: add ZTE ZX296718 MMC bindings
> 
> Don't forget to make sure DT bindings get acked. I don't think I have
> seen that happening for this change, unless I missed it of course.

Thanks for noticing this. I will wait for DT guy's acked.

Best Regards,
Jaehoon Chung

> 
> [...]
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

