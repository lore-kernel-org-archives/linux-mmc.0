Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AA22765FA;
	Sat,  6 Sep 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148914; cv=none; b=WiWSs9Jgq58W9tGMaL25h/KRBPFIGXfQPQ7bEHAmI1yosnn/DD3NUDHTM1uR+VOhroQNpjTtviXBkf7wqBkfCUipnj7ef22hi5X0eXitdFbQC4gNwqW3I2iDPNFrbYQ5Vd04rxAwZ10iUlKV6AzVpH2LWqxW67jg2OOjB1Rz2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148914; c=relaxed/simple;
	bh=nPjCBzrBNpRP9OaHFbynxxMry+uuL0gIW9ps7glHvks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FK8E/9SDHUO6JOKoUJGhPF9l5Ny02UPOvfAAcOFZzvdFXoPD7dJCNwiYKLwu+/XJm47h0ELXoZERPAYkYcSL8+XFGsJcK1tOLsrsq3XxoaD1Bx34Xh2iKkkF1thveUct+h7bsWNEIr4twtuiQEpW4GZNdeNsiZGxgiaXey/w9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehKavIMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehKavIMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1DBC4CEE7;
	Sat,  6 Sep 2025 08:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757148913;
	bh=nPjCBzrBNpRP9OaHFbynxxMry+uuL0gIW9ps7glHvks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ehKavIMOUs3X7TueydCEcIt3h+4EHzHOsL09nTAa2F5PbbEGGM8b3oedK1mNr+ude
	 dzY8v+weZ8UmZXGd1iVnsqm+ZiJB0WmjClms73S57goQd48jMLKNrNwH7EUbRZidyi
	 st6MZiyTBT5vdNtJIA81N9wAEe8lehfC3QAJqmLcd454/iQSW739bydZHIz26nfJmi
	 uyHxR5Bh34im/9mNclDdQSE6/GbjwRSOtkXXjOcHzjlvF7dH7mo+/cPpkoH8rtbdtu
	 DPgk/Qw2T3UWJlpDofWuzrWRZsOz1/3PzY2uDJbM8Vkk2KXYZf9xScGXeaGwgfB+RM
	 k49oDxekv21Gg==
Message-ID: <5d3802bc-68e8-43a8-8dfa-14d5b2b9e624@kernel.org>
Date: Sat, 6 Sep 2025 10:55:10 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-omap: convert text based binding
 to json schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com>
 <56bcea70-6180-443b-8c9b-f5d2a129c73f@kernel.org>
 <cded96da-fdb5-4a50-9382-8f9f19589ce8@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <cded96da-fdb5-4a50-9382-8f9f19589ce8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/09/2025 10:43, Charan Pedumuru wrote:
> 
> 
> On 28-05-2025 13:30, Krzysztof Kozlowski wrote:
>> On 23/05/2025 19:05, Charan Pedumuru wrote:
>>> Convert TI OMAP SDHCI Controller binding to YAML format.
>>> Changes during Conversion:
>>> - Add patternProperties for pinctrl-<n>.
>>> - Define new properties like "ti,hwmods", "ti,needs-special-reset"
>>>   "ti,needs-special-hs-handling", "cap-mmc-dual-data-rate"
>>>   and "pbias-supply".
>>
>> Why? commit should answer this.
> 
> The above properties are not documented in the text binding, so I defined them to resolve DTB_CHECK, I will write the reason in next revision.

You revive discussion from 3 months ago...

Anyway, explain in the commit msg that properties are already used in
the DTS.

> 
>>
>>> - Remove "ti,hwmods", "pinctrl-names" and "pinctrl-<n>"
>>
>> Why? You just added ti,hwmods, so how can you remove it from required?
> 
> The property is defined but is not required by all DTS files and the old binding says it is required for all boards, I will add this reason to the commit message.
> 
>>
>>>   from required as they are not necessary for all DTS files.
>>> - Add missing strings like "default-rev11", "sdr12-rev11", "sdr25-rev11",
>>>   "hs-rev11", "sdr25-rev11" and "sleep" to pinctrl-names string array.
>>>
>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>> ---
>>>  .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 ------
>>>  .../devicetree/bindings/mmc/sdhci-omap.yaml        | 155 +++++++++++++++++++++
>>
>>
>> Filename: ti,omap-sdhci.yaml or one of the compatibles (or anything else
>> following convention that it should match compatible).
> 
> Sure, I was following the name format of other files from the same directory here, but will change it to the compatible in next revision.
> 
>>
>>
>> "ti,needs-special-hs-handling" is already documented in other binding
> 
> Well, I didn't see this property defined in any common.yaml in mmc directory.
> 
>>
>>
>>>  2 files changed, 155 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>>> deleted file mode 100644
>>> index f91e341e6b36c410275e6f993dd08400be3fc1f8..0000000000000000000000000000000000000000
>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>>> +++ /dev/null
>>> @@ -1,43 +0,0 @@
>>> -* TI OMAP SDHCI Controller
>>
>>
>> ...
>>
>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..e707837bc242b055bbc497ed893a91c9b24f2dde
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.yaml
>>> @@ -0,0 +1,155 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/mmc/sdhci-omap.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI OMAP SDHCI Controller
>>> +
>>> +maintainers:
>>> +  - Ulf Hansson <ulf.hansson@linaro.org>
>>
>> This is supposed to be someone caring about this device. Eventually
>> platform maintainer.
> 
> Sure, I will change that, I was following the names of MAINTAINERS from the list I got from the command, "./scripts/get_maintainer.pl Documentation/dev
> icetree/bindings/mmc/sdhci-omap.txt"
> 
>>
>>> +
>>> +description:
>>> +  For UHS devices which require tuning, the device tree should have a
>>> +  cpu_thermal node which maps to the appropriate thermal zone. This
>>> +  is used to get the temperature of the zone during tuning.
>>> +
>>> +allOf:
>>> +  - $ref: sdhci-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - ti,omap2430-sdhci
>>> +      - ti,omap3-sdhci
>>> +      - ti,omap4-sdhci
>>> +      - ti,omap5-sdhci
>>> +      - ti,dra7-sdhci
>>> +      - ti,k2g-sdhci
>>> +      - ti,am335-sdhci
>>> +      - ti,am437-sdhci
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  pinctrl-names:
>>> +    $ref: /schemas/types.yaml#/definitions/string-array
>>> +    minItems: 1
>>> +    maxItems: 19
>>> +    items:
>>> +      enum:
>>> +        - default
>>> +        - default-rev11
>>> +        - hs
>>> +        - sdr12
>>> +        - sdr12-rev11
>>> +        - sdr25
>>> +        - sdr25-rev11
>>> +        - sdr50
>>> +        - ddr50-rev11
>>> +        - sdr104-rev11
>>> +        - ddr50
>>> +        - sdr104
>>> +        - ddr_1_8v-rev11
>>> +        - ddr_1_8v
>>> +        - ddr_3_3v
>>> +        - hs-rev11
>>> +        - hs200_1_8v-rev11
>>> +        - hs200_1_8v
>>> +        - sleep
>>> +
>>> +  dmas:
>>> +    maxItems: 2
>>> +
>>> +  dma-names:
>>> +    items:
>>> +      - const: tx
>>> +      - const: rx
>>> +
>>> +  ti,hwmods:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    description:
>>> +      This field is used to fetch the information such as
>>> +      address range, irq lines, dma lines, interconnect, PRCM register,
>>> +      clock domain, input clocks associated with MMC.
>>> +    pattern: "^mmc[0-9]+$"
>>> +
>>> +  ti,needs-special-reset:
>>
>> I don't understand why you added this. There is no user of it.
> 
> 
> May be, but the DTB_CHECK failed for some boards when not defined it here.

Then maybe should be dropped from DTS?

> 
>>
>>> +    description:
>>> +      It indicates that a specific soft reset sequence is required for
>>> +      certain Texas Instruments devices, particularly those with
>>> +      HSMMC (High-Speed MultiMediaCard) controllers.
>>> +    type: boolean
>>> +
>>> +  ti,needs-special-hs-handling:
>>
>> I don't understand why you added this. There is no user of it.
> 
> ...
> 
>>
>>
>>> +    description:
>>> +      It's presence in an MMC controller's DT node signals to the Linux kernel's
>>> +      omap_hsmmc driver that this particular IP block requires special software
>>> +      handling or workarounds to correctly manage High-Speed (HS) modes like
>>> +      SDR25, SDR50, SDR104, DDR50.
>>> +    type: boolean
>>> +
>>> +  pbias-supply:
>>> +    description:
>>> +      It is used to specify the voltage regulator that provides the bias
>>> +      voltage for certain analog or I/O pads.
>>> +
>>> +  cap-mmc-dual-data-rate:
>>> +    description:
>>> +      A characteristic or capability associated with MultiMediaCard (MMC)
>>> +      interfaces, specifically indicating that the MMC controller
>>> +      supports Dual Data Rate (DDR) mode
>>
>> Drop the property. We have standard properties for this and there is no
>> ABI for it anyway.
>>
> 
> Same here, the DTB_CHECK failed, so had to define it here
> 
>>> +    type: boolean
>>> +
>>> +  ti,non-removable:
>>> +    description:
>>> +      It indicates that a component is not meant to be easily removed or
>>> +      replaced by the user, such as an embedded battery or a non-removable
>>> +      storage slot like eMMC.
>>> +    type: boolean
>>> +    deprecated: true
>>> +
>>> +  vmmmc-supply:
>>> +    description:
>>> +      It is used to specify the power supply (regulator) for the MMC/SD card's
>>> +      main operating voltage (VCC/VDD).
>>> +
>>> +  clock-frequency:
>>
>> Why is it here? Nothing in commit msg explained adding it.
> 
> I will add this change to commit message along with the reason.
> 
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      It is used to specify the frequency of a clock in Hertz (Hz). It's a
>>> +      fundamental property for communicating hardware clocking information from
>>> +      the Device Tree to the Linux kernel.
>>
>> Redundant description. It is not a fundamental property. It is a legacy
>> property.
>>
> 
> Sure, will change the description.
> 
>>> +
>>> +patternProperties:
>>> +  "^pinctrl-[0-9]+$":
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    description:
>>> +      Phandles to pinctrl states. The numeric suffix determines the
>>> +      state index corresponding to entries in the pinctrl-names array.
>>> +    minItems: 1
>>
>> Why exactly do you need these?
> 
> Some boards have this property with multiple pincontrol states, so had to define a pattern property to recognize all the defined pinctrl properties.

No, that's just confusing error from dtschema. Look at other bindings -
no binding defines type and description for pinctrl.

It just means your schema was incomplete.

Best regards,
Krzysztof
