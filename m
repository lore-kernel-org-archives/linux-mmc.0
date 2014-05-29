From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH 1/3] Documentation: Update Arasan SDHC documentation for
 the APM X-Gene SoC SDHC DTS binding
Date: Thu, 29 May 2014 11:54:52 -0700
Message-ID: <CAPw-ZTn_gN4k24JcWWnMSi5LgRdRm30=-BsNSVmx6ymN-2=GFw@mail.gmail.com>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
	<1400398918-1502-2-git-send-email-lho@apm.com>
	<20140519123230.GA3663@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:34560 "HELO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752268AbaE2Syx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 May 2014 14:54:53 -0400
Received: by mail-qg0-f52.google.com with SMTP id a108so2248536qge.25
        for <linux-mmc@vger.kernel.org>; Thu, 29 May 2014 11:54:52 -0700 (PDT)
In-Reply-To: <20140519123230.GA3663@leverpostej>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "chris@printf.net" <chris@printf.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "jcm@redhat.com" <jcm@redhat.com>, "patches@apm.com" <patches@apm.com>

Hi Mark,

>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 98ee2ab..8fc4cc4 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -8,14 +8,17 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>
>>  Required Properties:
>> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>> +                'xgene,arasan,sdhci-8.9a'
>
> "xgene" is not a vendor, nor is it documented as such.

I will change to "apm".

>
>>    - reg: From mmc bindings: Register location and length.
>> -  - clocks: From clock bindings: Handles to clock inputs.
>> -  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>>    - interrupts: Interrupt specifier
>>    - interrupt-parent: Phandle for the interrupt controller that services
>>                     interrupts for this device.
>>
>> +Optional Properties:
>> +  - clocks: From clock bindings: Handles to clock inputs.
>> +  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>
> Given that these used to be required, they are presumably still required
> in some cases?

>From the driver point of view, it is optional as it no longer requires
this. But from usage point of view, if an HW requires this to work
correctly, then it musts be provided.

>
> If we're going to alter these lines, it'd be nice to clean them up at
> the same time (a list is not a tuple, clocks aren't just phandles).
>

I will update this.

-Loc
