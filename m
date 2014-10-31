From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: davinci: Fix and simplify probe failure path
Date: Fri, 31 Oct 2014 10:35:22 +0100
Message-ID: <CAPDyKFo=-_35tYAFs5hjYRSkQmaJZBS_Jej51_AuMfKta-1hNw@mail.gmail.com>
References: <1414655193-16952-1-git-send-email-pramod.gurav@smartplayin.com>
	<CAPDyKFqFOb9L6WyFhLbSY-dQy_75YVUhTzVsBku1BKcEMmgpBg@mail.gmail.com>
	<CAMf-jSm-Fc6gcnSqB4cixjqZSQOrvSLaQ2hXqy1TZncFrjn8hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:56267 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544AbaJaJfX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Oct 2014 05:35:23 -0400
Received: by mail-qa0-f53.google.com with SMTP id n8so4913005qaq.26
        for <linux-mmc@vger.kernel.org>; Fri, 31 Oct 2014 02:35:22 -0700 (PDT)
In-Reply-To: <CAMf-jSm-Fc6gcnSqB4cixjqZSQOrvSLaQ2hXqy1TZncFrjn8hw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pramod Gurav <pramod.gurav.etc@gmail.com>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 30 October 2014 12:45, Pramod Gurav <pramod.gurav.etc@gmail.com> wrote:
> Thanks Ulf,
>
> On Thu, Oct 30, 2014 at 4:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 30 October 2014 08:46, Pramod Gurav <pramod.gurav@smartplayin.com> wrote:
>>> The sequence of resource release in probe failure path in this
>>> driver was wrong and needed fixes to cleanly unload the driver.
>>> This changes does the same by switching to managed resources and
>>> fixes return path to release resource in proper sequence.
>>>
>>> Cc: Chris Ball <chris@printf.net>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Cc: linux-mmc@vger.kernel.org
>>
>> Please remove these Ccs above from the commit message. It's not needed
>> when you anyway need to send the patches directly to these addresses.
> Will remove Cc.
>
>>
>>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>>> ---
> ..
>
>>>
>>>         host = mmc_priv(mmc);
>>>         host->mmc = mmc;        /* Important */
>>> @@ -1275,15 +1273,16 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>>>                 host->txdma = r->start;
>>>
>>>         host->mem_res = mem;
>>> -       host->base = ioremap(mem->start, mem_size);
>>> -       if (!host->base)
>>> -               goto out;
>>> +       host->base = devm_ioremap(&pdev->dev, mem->start, mem_size);
>>
>> I realized that you should use devm_ioremap_resource() instead. That
>> would simplify the code even more.
>>
> Yes, we could have used devm_ioremap_resource() but this driver stores
> the return from devm_request_mem_region() in host->mem_res and uses
> the same in the other part of drivers. Is there a way to work this
> around?

Isn't that the same value as "mem->start" ?

Kind regards
Uffe
