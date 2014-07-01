From: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>
Subject: Re: [RFC PATCH 1/1 v7]mmc: Support-FFU-for-eMMC-v5.0
Date: Tue, 1 Jul 2014 14:29:13 +0800
Message-ID: <CAC1bqKjbPqoyH1D1UYQ35trrPzQboYfkC+7tdkFFBYSijV_Oyw@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE648AFA7EE@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANEJEGu9PYi5DxuEWBwEHjUqWt2J-sEDZMKLwvZTUBdUnK=7XA@mail.gmail.com>
	<CANEJEGs2dAA0DSZfwYcV8nZn4Z1+MqAa0bJZocTZT5zjXe_dDQ@mail.gmail.com>
	<868uodnch6.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:41227 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbaGAG3O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jul 2014 02:29:14 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so7121129wiv.8
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jun 2014 23:29:13 -0700 (PDT)
In-Reply-To: <868uodnch6.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Grant Grundler <grundler@chromium.org>, "cjb@laptop.org" <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Olof Johansson <olofj@chromium.org>

Hi, Chris,
I think there are two reasons why doing FFU in kernel-space makes more sense.

First, some eMMC (according to extCSD[492] FFU_FEATURES) will need to
restart eMMC after FFU.

Second, if host want to vouch "atmoic" in FFU process, we need to call
mmc_claim_host API, and this API is the kernel-space code. I said "if"
is because eMMC vendors may take care this. So, host may not need to
worry about this.

Thanks,
Hsinhsiang

2014-07-01 8:34 GMT+08:00 Chris Ball <chris@printf.net>:
> Hi Grant, sorry about the delay.
>
> On Tue, Jul 01 2014, Grant Grundler wrote:
>> ping? Another week is past.
>>
>> I know you guys are busy with other stuff. But please at least publish
>> what you think the next steps for this patch are.
>>
>> This is a critical patch for supporting eMMC products and adding
>> additional support for other vendors. I'd like to continue working
>> with "upstream" and the lack of response in this case is making this
>> unnecessarily difficult.
>
> It's tough to merge a significant patch that you haven't tested and we
> haven't tested.  We could do it, though -- I'd like to hear what Ulf
> thinks.  Please could you give a quick explanation of why doing this
> in kernel-space makes more sense than using your mmc-utils version?
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <http://printf.net/>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
