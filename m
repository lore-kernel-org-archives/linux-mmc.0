From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Mon, 24 Nov 2014 18:45:59 +0800
Message-ID: <CAOEd-H2qbWgaauX=phfFk8HQqHk9gff3m_uoZqc+4Gbc6LZ-Lg@mail.gmail.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<CAPDyKFqZyUT+sARZQ2ncusttDWn31uQf_H2eTtHOSCs2c8yO4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:35171 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbaKXKqB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 05:46:01 -0500
Received: by mail-la0-f46.google.com with SMTP id gd6so7298629lab.5
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 02:45:59 -0800 (PST)
In-Reply-To: <CAPDyKFqZyUT+sARZQ2ncusttDWn31uQf_H2eTtHOSCs2c8yO4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Andy Green <andy.green@linaro.org>, Patch Tracking <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

2014-11-24 17:54 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 21 November 2014 at 01:51, Vincent Yang
> <vincent.yang.fujitsu@gmail.com> wrote:
>> Hello,
>>
>>   Fujitsu have an sdhci IP which is implemented in a SoC we're
>> adding to mainline, the most recent series for that was sent
>> here:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304522.html
>>
>>   These patches are against v3.18-rc5 mainline and tested on
>> v3.18-rc5 integration tree.
>>
>>   We welcome any comment and advice about how to make any
>> improvements or better align them with upstream.
>
> Apparently, there's a dependency between this patchset and the upper
> one you refereed to. That's a problem.

This patchset does not require anything from the upper one I refereed to.
The only reason we mentioned it is to show that this sdhci IP driver will have
something using it shortly in the kernel.

>
> Preferably, try to remove the dependency and send all mmc patches to
> the mmc list. If that's not possible, you need to send these two
> patchsets as one instead.
>
>>
>> Thanks.
>>
>> Vincent Yang (4):
>>   mmc: sdhci: add a voltage switch callback function
>>   mmc: sdhci: add a quirk for tuning work around
>>   mmc: sdhci: add a quirk for single block transactions
>>   mmc: core: hold SD Clock before CMD11 during Signal
>
> The last one I consider as a separate fix for mmc core. I will apply
> it to my mmc tree.

Thanks!

Thank you and kind regards,
Vincent

>
> Thanks and kind regards
> Uffe
