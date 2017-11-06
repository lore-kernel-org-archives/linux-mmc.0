From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] sdhci-fujitsu: add support for setting the CMD_DAT_DELAY attribute
Date: Mon, 6 Nov 2017 10:46:30 +0000
Message-ID: <CAKv+Gu_oSuk3=d2T2NFFm3M3MfABCCaZwnaTH8ijG6O1TSZN6w@mail.gmail.com>
References: <20171101002132.13500-1-ard.biesheuvel@linaro.org>
 <20171102000814.ih2ggtfpmfsx3xap@rob-hp-laptop> <CAKv+Gu8UPpsobJ_d4+OCdufSkLLhGdRFxPO92X3YKvnyBY5b7w@mail.gmail.com>
 <CAPDyKFpaKdvnwL98UZKzNmR+yXtWJL6hPDPfTXtY8nqmDRsomQ@mail.gmail.com>
 <CAKv+Gu8nd7i+iaL-B55WbutGrOKaCsCdrQtFZgFs1TJaSqx-xw@mail.gmail.com>
 <CAPDyKFpKe-TaUeuWdenGf9tHV8+UkGkkdcp8Z+Yu9Q-haHsYsA@mail.gmail.com>
 <CAKR0VNJ0xzRebUEZprRfQVp1LGjPG4khyumSYKsRtxCPTGkxYQ@mail.gmail.com>
 <CAKR0VN+ATuiOdZ+n=t=h+Ru5WdzRfyq-41t0P8J=4LAUFGo+dA@mail.gmail.com> <CAPDyKFp92YTqGNZ8s4mGQOpbmbEKxj9vpL0tj0rB-RbirWKCjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:51907 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdKFKqb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2017 05:46:31 -0500
Received: by mail-io0-f170.google.com with SMTP id b186so15176842iof.8
        for <linux-mmc@vger.kernel.org>; Mon, 06 Nov 2017 02:46:31 -0800 (PST)
In-Reply-To: <CAPDyKFp92YTqGNZ8s4mGQOpbmbEKxj9vpL0tj0rB-RbirWKCjw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vincent Yang <vincent.cw.yang@gmail.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, Vincent Yang <vincent.yang@socionext.com>

On 6 November 2017 at 07:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>>>
>>>>> Do you mean set it unconditionally? That works for me, but I have no
>>>>
>>>> Yes.
>>>>
>>>>> way of testing whether it still works on other SoCs that use this IP.
>>>>
>>>> Me neither!
>>>
>>> Hi all, I can not yet get contact with IP owner because it is a
>>> holiday in Japan.
>>> Around two years ago, F_SDH30_CMD_DAT_DELAY was a new feature of this IP.
>>> I will update the latest information as soon as I get it.
>>>
>> I got a response from IP owner.
>> He explains F_SDH30_CMD_DAT_DELAY is intended to adjust signal timing of
>> CMD/DAT lines, and it is necessary to change its value according to
>> SoC/board design.
>> So he advises us to make F_SDH30_CMD_DAT_DELAY adjustable by a DT binding.
>>
>> Kind regards
>> Vincent
>>
>>>>
>>>> Apparently there are no DTS in the kernel git that uses the
>>>> "fujitsu,mb86s70-sdhci-3.0".
>>>
>>> Around two years ago, sdhci_f_sdh30_driver was a portion for mb86s70 SoC
>>> patch series, but finally the patch series did not fully go upstream.
>>>
>
> Vincent, thanks for all the help in this!
>
> Ard, one thing, could you please split the DT doc change into a
> separate patch, preceding the change that actually do the parsing of
> the new binding.
>

Will do. Thanks.
