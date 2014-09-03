From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Enable boot partition access from DT
Date: Wed, 3 Sep 2014 11:09:02 +0200
Message-ID: <CAPDyKFrnF4biUGkLgkzz2RNdY1yLp2_bfvoWMM55yx-_TG6ENw@mail.gmail.com>
References: <1409672977-26972-1-git-send-email-jean-michel.hautbois@vodalys.com>
	<CAPDyKFrwCzQJvbpbue4T=HWLmbq5sZOP3RXwiupKvXe71uboUw@mail.gmail.com>
	<5406D942.4080405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58814 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbaICJJE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 05:09:04 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so32103lbi.19
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 02:09:02 -0700 (PDT)
In-Reply-To: <5406D942.4080405@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Peter Griffin <peter.griffin@linaro.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, h80.chung@samsung.com, Chris Ball <chris@printf.net>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

On 3 September 2014 11:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 09/03/2014 11:30 AM, Ulf Hansson wrote:
>> On 2 September 2014 17:49, Jean-Michel Hautbois
>> <jean-michel.hautbois@vodalys.com> wrote:
>>> This property is useful when we don't want to access boot partitions on eMMC
>>>
>>> Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>
>>> ---
>>>  Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
>>>  drivers/mmc/host/sdhci-esdhc-imx.c            | 8 ++++++++
>>>  include/linux/platform_data/mmc-esdhc-imx.h   | 1 +
>>>  3 files changed, 10 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>>> index 431716e..59cc854 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>>> @@ -40,6 +40,7 @@ Optional properties:
>>>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>>>  - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
>>>  - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
>>> +- no-boot-part : when preset, tells to access boot partitions
>>>
>>>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>>>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index ccec0e3..439e663 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -942,6 +942,11 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>>>         if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
>>>                 boarddata->delay_line = 0;
>>>
>>> +       if (of_find_property(np, "no-boot-part", NULL))
>>> +               boarddata->access_boot_part = false;
>>> +       else
>>> +               boarddata->access_boot_part = true;
>>> +
>>>         return 0;
>>>  }
>>>  #else
>>> @@ -1119,6 +1124,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>>         }
>>>
>>> +       if (!boarddata->access_boot_part)
>>> +               host->mmc->caps2 |= MMC_CAP2_BOOTPART_NOACC;
>>> +
>>
>> Hmm, I don't think MMC_CAP2_BOOTPART_NOACC should have a DT binding.
>> Does it describe the hardware in some form?
>>
>> Actually I would like to question why MMC_CAP2_BOOTPART_NOACC exists
>> at all. If there are cards that don't supports the BOOT area,
>> shouldn't we have a card quirk for it instead of a host cap? Maybe
>> Adrian Hunter, how originally wrote the patch for adding
>> MMC_CAP2_BOOTPART_NOACC, could help me understand the reasons behind
>> it!?
>
> It was added because platform firmware was able to prevent access to the
> boot partitions (for security I think), so attempts to access them would
> fail messily.  It was not related to any specific card.

Adrian, appreciate your clarification. After all it seems like adding
a DT binding for it should be appropriate.

Kind regards
Uffe
