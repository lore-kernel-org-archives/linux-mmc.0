From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: try 1.8v signling in ddr mode if host and device
Date: Wed, 3 Sep 2014 09:21:27 +0200
Message-ID: <CAPDyKFqJ2o1nMR--bpk24+C7KC5+yADjt5OKJBj9XkNh9=pPFA@mail.gmail.com>
References: <20140815032806.GA19745@intel.com>
	<CAPDyKFpigfMvzV6t3f2C-hcvKgfa_jErSH=xLCqN4xG4X6zJ7w@mail.gmail.com>
	<17296D9F8FF2234F831FC3DF505A87A911B21734@shsmsx102.ccr.corp.intel.com>
	<CAL8zT=hEJDrtGjga9RG6B3xC5fw+Jj6Ppxzq379Qjra2mWRkoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:48436 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbaICHV3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 03:21:29 -0400
Received: by mail-la0-f50.google.com with SMTP id mc6so9222840lab.37
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 00:21:27 -0700 (PDT)
In-Reply-To: <CAL8zT=hEJDrtGjga9RG6B3xC5fw+Jj6Ppxzq379Qjra2mWRkoQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "chris@printf.org" <chris@printf.org>

On 2 September 2014 17:31, Jean-Michel Hautbois <jhautbois@gmail.com> wrote:
> 2014-08-15 10:36 GMT+02:00 Dong, Chuanxiao <chuanxiao.dong@intel.com>:
>>
>>
>>> -----Original Message-----
>>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>>> Sent: Friday, August 15, 2014 4:34 PM
>>> To: Dong, Chuanxiao
>>> Cc: linux-mmc; chris@printf.org
>>> Subject: Re: [PATCH v3] mmc: core: try 1.8v signling in ddr mode if host and
>>> device
>>>
>>> On 15 August 2014 05:28, Chuanxiao Dong <chuanxiao.dong@intel.com>
>>> wrote:
>>> > Even (e)MMC card can support 3.3v to 1.2v vccq in DDR, but not all
>>> > host controller can support this, like some of the SDHCI host which
>>> > connect to an eMMC device. Some of these host controller still needs
>>> > to use 1.8v vccq for supporting DDR mode.
>>> >
>>> > So the sequence will be:
>>> > if (host and device can both support 1.2v IO)
>>> >         use 1.2v IO;
>>> > else if (host and device can both support 1.8v IO)
>>> >         use 1.8v IO;
>>> > so if host and device can only support 3.3v IO, this is the last choice.
>>> >
>>> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
>>> > Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
>>>
>>> This looks good to me! But before I queue it for 3.18 I would appreciate if we
>>> could get some help in testing this for some various platforms, that support
>>> MMC DDR.
>>
>> Thanks a lot. BTW, this patch is already tested on Intel's platform which can support MMC DDR.
>
> This patch associated with vqmmc-supply and vmmc-supply in the DT is
> working for me too on i.MX6.
> JM

Thanks! Applied for next.

I took the liberty of updating the commit msg header to "mmc: core:
Fix sequence for I/O voltage in DDR mode for eMMC", to get a better
description of the patch.

I also added a tested by tag from "JM".

Please tell me if you have any concern with my changes.

Kind regards
Uffe
