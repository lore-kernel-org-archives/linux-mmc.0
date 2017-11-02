From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] sdhci-fujitsu: add support for setting the CMD_DAT_DELAY attribute
Date: Thu, 2 Nov 2017 10:49:42 +0000
Message-ID: <CAKv+Gu8nd7i+iaL-B55WbutGrOKaCsCdrQtFZgFs1TJaSqx-xw@mail.gmail.com>
References: <20171101002132.13500-1-ard.biesheuvel@linaro.org>
 <20171102000814.ih2ggtfpmfsx3xap@rob-hp-laptop> <CAKv+Gu8UPpsobJ_d4+OCdufSkLLhGdRFxPO92X3YKvnyBY5b7w@mail.gmail.com>
 <CAPDyKFpaKdvnwL98UZKzNmR+yXtWJL6hPDPfTXtY8nqmDRsomQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:43921 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755356AbdKBKtn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Nov 2017 06:49:43 -0400
Received: by mail-io0-f193.google.com with SMTP id 134so12958323ioo.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Nov 2017 03:49:43 -0700 (PDT)
In-Reply-To: <CAPDyKFpaKdvnwL98UZKzNmR+yXtWJL6hPDPfTXtY8nqmDRsomQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 2 November 2017 at 10:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 2 November 2017 at 01:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 2 November 2017 at 00:08, Rob Herring <robh@kernel.org> wrote:
>>> On Wed, Nov 01, 2017 at 12:21:32AM +0000, Ard Biesheuvel wrote:
>>>> The Socionext SynQuacer SoC inherits this IP from Fujitsu, but
>>>> requires the F_SDH30_CMD_DAT_DELAY bit to be set in the
>>>> F_SDH30_ESD_CONTROL control register.
>>>>
>>>> So let's add an optional property to this device's binding, and
>>>> set the attribute if it is present in the DT node.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>> ---
>>>>  Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt |  2 ++
>>>>  drivers/mmc/host/sdhci_f_sdh30.c                        | 18 +++++++++++++++++-
>>>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>>> index de2c53cff4f1..9ad02f743ad0 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>>> @@ -15,6 +15,8 @@ Required properties:
>>>>  Optional properties:
>>>>  - vqmmc-supply: phandle to the regulator device tree node, mentioned
>>>>    as the VCCQ/VDD_IO supply in the eMMC/SD specs.
>>>> +- cmd-dat-delay-select: boolean property indicating that this host requires
>>>> +  the CMD_DAT_DELAY control to be enabled.
>>>
>>> Needs a vendor prefix unless this is a standard SDHCI bit (in which
>>> case it should be documented in a common spot).
>>>
>>
>> I suspect this is a non-standard thing, so I'll add the fujitsu prefix. Ulf?
>
> This is specific to the Fujitsu variant.
>
> However, what puzzles me is why this bit is needed for the Socionext
> SynQuacer SoC, but not for other SoCs that uses this IP. That seems
> weird (probably wrong).
>
> Moreover, the F_SDH30_CMD_DAT_DELAY register define is already there,
> so I would rather suspect that it's something that did got fully
> implemented. In other words, I don't think you need a new DT binding,
> but rather try to implement it generically for the sdhci-f_sdh30
> driver. Do you think that will work?
>

Do you mean set it unconditionally? That works for me, but I have no
way of testing whether it still works on other SoCs that use this IP.
