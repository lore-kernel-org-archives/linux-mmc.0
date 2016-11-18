From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Fri, 18 Nov 2016 15:31:14 +0100
Message-ID: <CAPDyKFrjmQCN=YckNTrQtLNk3pCsCt5PFxRdqpk5rEqCHWh1bw@mail.gmail.com>
References: <CGME20161118062929epcas2p35fff280ed75b50d35c3194514c7e0d8d@epcas2p3.samsung.com>
 <1479450555-19047-1-git-send-email-jun.nie@linaro.org> <2205472e-963f-319b-6523-76a4f486cafe@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37886 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbcKRObR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 09:31:17 -0500
Received: by mail-wm0-f52.google.com with SMTP id t79so41174429wmt.0
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2016 06:31:16 -0800 (PST)
In-Reply-To: <2205472e-963f-319b-6523-76a4f486cafe@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, xie.baoyou@zte.com.cn, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc <linux-mmc@vger.kernel.org>

On 18 November 2016 at 07:52, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Jun,
>
> On 11/18/2016 03:29 PM, Jun Nie wrote:
>> Add intial support to DW MMC host on ZTE SoC. It include platform
>> specific wrapper driver and workarounds for fifo quirk.
>>
>> Patches are prepared based on latest dw mmc runtime change:
>>    https://github.com/jh80chung/dw-mmc.git for-ulf
>
> Applied on my dwmmc repository.
> I have applied your patches, after modifying some conflict and subject prefix as "dw_mmc*".
> And added Shawn's reviewed-by tags. Thanks!

[...]

>> Jun Nie (5):
>>   mmc: dt-bindings: add ZTE ZX296718 MMC bindings

Don't forget to make sure DT bindings get acked. I don't think I have
seen that happening for this change, unless I missed it of course.

[...]

Kind regards
Uffe
