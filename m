From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [PATCH 6/9] mmc: sdhci: host: add new f_sdh30
Date: Fri, 21 Nov 2014 09:18:45 +0800
Message-ID: <CAOEd-H097p4mQ-L0NxReFpNADG2ymqpvg5jgiWG4W5G+3H-vcw@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1416487081-25467-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<CAL_JsqKDVgpBBW7j1skOU4moF0tvh1j6Fm6jaE5JoP04OU07uw@mail.gmail.com>
	<CAOEd-H0_YGHobKu08pMr3A4EpqBdtpBcCZu5PoVY_SZ=GBg-3w@mail.gmail.com>
	<CAL_JsqKe_NA_mQ1MVMntXMjFGP6nGvnpWb8gvBEzRZuZ+aMf1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:53367 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbaKUBSr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 20:18:47 -0500
In-Reply-To: <CAL_JsqKe_NA_mQ1MVMntXMjFGP6nGvnpWb8gvBEzRZuZ+aMf1g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "chris@printf.net" <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Green <andy.green@linaro.org>, Linaro Patches <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>

2014-11-21 2:18 GMT+08:00 Rob Herring <robherring2@gmail.com>:
> On Thu, Nov 20, 2014 at 10:59 AM, Vincent Yang
> <vincent.yang.fujitsu@gmail.com> wrote:
>> 2014-11-20 23:22 GMT+08:00 Rob Herring <robherring2@gmail.com>:
>>> On Thu, Nov 20, 2014 at 6:38 AM, Vincent Yang
>>> <vincent.yang.fujitsu@gmail.com> wrote:
>>>> This patch adds new host controller driver for
>>>> Fujitsu SDHCI controller f_sdh30.
>>>>
>>>> Signed-off-by: Andy Green <andy.green@linaro.org>
>>>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>>>> Signed-off-by: Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>
>>>> ---
>>>>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 +++
>>>>  drivers/mmc/host/Kconfig                           |   9 +
>>>>  drivers/mmc/host/Makefile                          |   1 +
>>>>  drivers/mmc/host/sdhci_f_sdh30.c                   | 319 +++++++++++++++++++++
>>>>  4 files changed, 364 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>>>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>>> new file mode 100644
>>>> index 0000000..a1e0b64
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>>>> @@ -0,0 +1,35 @@
>>>> +* Fujitsu SDHCI controller
>>>> +
>>>> +This file documents differences between the core properties in mmc.txt
>>>> +and the properties used by the sdhci_f_sdh30 driver.
>>>> +
>>>> +Required properties:
>>>> +- compatible: "fujitsu,mb86s70-sdh30"
>>>
>>> It would be nice to have sdhci in the name to indicate it is an SDHCI
>>> controller.
>>
>> Yes, we will update it to "fujitsu,sdhci-f-sdh30"
>> Thanks for your review!
>
> Not really what I had in mind as you are then dropping the chip name.
> Perhaps "fujitsu,mb86s70-sdhci-3.0". Is 3.0 the SD spec version or IP
> version? If the former, I think I'd drop it as IIRC that is available
> in a register.

We will update it to "fujitsu,mb86s70-sdhci-3.0" as you suggest
because 3.0 is IP version
Thanks for your review!

Vincent

>
> Rob
