From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Date: Mon, 24 Nov 2014 17:59:53 +0530
Message-ID: <CAJe_ZhfvMCE4vxu76j2TBFZC90=tKm+yo+-Gf1WJq5oQT5_P+g@mail.gmail.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<CAPDyKFqZyUT+sARZQ2ncusttDWn31uQf_H2eTtHOSCs2c8yO4A@mail.gmail.com>
	<CAOEd-H2qbWgaauX=phfFk8HQqHk9gff3m_uoZqc+4Gbc6LZ-Lg@mail.gmail.com>
	<CAPDyKFruGDj5z5+i6FLT2YHhKPvY6wFE98dBQYsJroCNST_fyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:39779 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbaKXM3y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Nov 2014 07:29:54 -0500
Received: by mail-qg0-f50.google.com with SMTP id i50so3387459qgf.37
        for <linux-mmc@vger.kernel.org>; Mon, 24 Nov 2014 04:29:53 -0800 (PST)
In-Reply-To: <CAPDyKFruGDj5z5+i6FLT2YHhKPvY6wFE98dBQYsJroCNST_fyw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vincent Yang <vincent.yang.fujitsu@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Andy Green <andy.green@linaro.org>, Patch Tracking <patches@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>

On 24 November 2014 at 17:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 24 November 2014 at 11:45, Vincent Yang
> <vincent.yang.fujitsu@gmail.com> wrote:
>> 2014-11-24 17:54 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>> On 21 November 2014 at 01:51, Vincent Yang
>>> <vincent.yang.fujitsu@gmail.com> wrote:
>>>> Hello,
>>>>
>>>>   Fujitsu have an sdhci IP which is implemented in a SoC we're
>>>> adding to mainline, the most recent series for that was sent
>>>> here:
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304522.html
>>>>
>>>>   These patches are against v3.18-rc5 mainline and tested on
>>>> v3.18-rc5 integration tree.
>>>>
>>>>   We welcome any comment and advice about how to make any
>>>> improvements or better align them with upstream.
>>>
>>> Apparently, there's a dependency between this patchset and the upper
>>> one you refereed to. That's a problem.
>>
>> This patchset does not require anything from the upper one I refereed to.
>
> No, but the upper depends on this patchset.
>
> Why can't you send the mmc patches separately in one patchset? That's
> would be easier to handle and review.
>
To be clear, the arch patchset introduces support for a new Fujitsu's
platform and has a sdhci controller driver named sdhci_f_sdh30.c which
will use 'general' improvements introduced by this patchset.

I would think the controller driver has more dependency on ARCH than
this patchset. IOW, sdhci_f_sdh30.c can't get upstream without arch
patches but this patchset can without the sdhci_f_sdh30.c driver.  Is
that not so?

Thanks
Jassi
