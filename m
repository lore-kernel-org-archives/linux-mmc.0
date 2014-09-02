From: Jean-Michel Hautbois <jhautbois@gmail.com>
Subject: Re: [PATCH v3] mmc: core: try 1.8v signling in ddr mode if host and device
Date: Tue, 2 Sep 2014 17:31:56 +0200
Message-ID: <CAL8zT=hEJDrtGjga9RG6B3xC5fw+Jj6Ppxzq379Qjra2mWRkoQ@mail.gmail.com>
References: <20140815032806.GA19745@intel.com> <CAPDyKFpigfMvzV6t3f2C-hcvKgfa_jErSH=xLCqN4xG4X6zJ7w@mail.gmail.com>
 <17296D9F8FF2234F831FC3DF505A87A911B21734@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:43610 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbaIBPcM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 11:32:12 -0400
Received: by mail-oi0-f51.google.com with SMTP id v63so4549481oia.38
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 08:32:11 -0700 (PDT)
In-Reply-To: <17296D9F8FF2234F831FC3DF505A87A911B21734@shsmsx102.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "chris@printf.org" <chris@printf.org>

2014-08-15 10:36 GMT+02:00 Dong, Chuanxiao <chuanxiao.dong@intel.com>:
>
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Friday, August 15, 2014 4:34 PM
>> To: Dong, Chuanxiao
>> Cc: linux-mmc; chris@printf.org
>> Subject: Re: [PATCH v3] mmc: core: try 1.8v signling in ddr mode if host and
>> device
>>
>> On 15 August 2014 05:28, Chuanxiao Dong <chuanxiao.dong@intel.com>
>> wrote:
>> > Even (e)MMC card can support 3.3v to 1.2v vccq in DDR, but not all
>> > host controller can support this, like some of the SDHCI host which
>> > connect to an eMMC device. Some of these host controller still needs
>> > to use 1.8v vccq for supporting DDR mode.
>> >
>> > So the sequence will be:
>> > if (host and device can both support 1.2v IO)
>> >         use 1.2v IO;
>> > else if (host and device can both support 1.8v IO)
>> >         use 1.8v IO;
>> > so if host and device can only support 3.3v IO, this is the last choice.
>> >
>> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
>> > Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
>>
>> This looks good to me! But before I queue it for 3.18 I would appreciate if we
>> could get some help in testing this for some various platforms, that support
>> MMC DDR.
>
> Thanks a lot. BTW, this patch is already tested on Intel's platform which can support MMC DDR.

This patch associated with vqmmc-supply and vmmc-supply in the DT is
working for me too on i.MX6.
JM
