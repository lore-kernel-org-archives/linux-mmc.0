Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4C2AD0B;
	Sun, 11 May 2025 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994726; cv=none; b=k0nDoMYOrzzoMnY2a4p/EuXyg1SQSb+LdTAADmJeOxnyfBDsgVKKy3M9nz6ERaqtwi7UC3RHlqr91GFBUqHce8rB07V3gVvp4OY7pNcVDJoAeGRDg0v2TT9dFOQyE6zLHG4j0ke8Lc81eKc+2DGzmXUzFcyyGbbOPXWs/BEwMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994726; c=relaxed/simple;
	bh=cnqdJZvkmx3y60pH7Gads9qpCjZsfIaAZvT2pXmfcbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfuV5FXSQo5DWlcfrU1clqFhR9sw58HmEICRpRxnYyNzawb8/RkSTfkPTlH/TLFRaM/63ZvT1avQsWzEEBcDmHekCI9Bur/qlhIIiVR+18fpUHfiGvBX00xNx89PcjTIZ1odN2EqBpfaacF9TrqRpueeRdnwKwCsa9+MnLodmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULNcqahg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULNcqahg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687ABC4CEE4;
	Sun, 11 May 2025 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746994725;
	bh=cnqdJZvkmx3y60pH7Gads9qpCjZsfIaAZvT2pXmfcbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ULNcqahgZ4ZAkuMgrqibxWGKFNDSgsyOyt9hCYIUlaqHpbW2pb3dkASKFvF0rNOeu
	 oKAhxgqJGnYrZ5Qywyh2NJA9s65GXSo8vXJfQmtZzXMsL0qVtm8a/arL5Hx6K7AvUb
	 9SWssS06J7OM85SDeyNJDsbvTyUsqSJ5bgNtwqREKu+vEPFZ1WB9y2jatGs6AkPZfO
	 EArzPbAd0C1/PrnRtEZfUFA//hlJ9lG/jAJj+te/SLVTxWY7ZRegHV1G82PA1iShZI
	 4hsbEDhug+XrqEs+XUkuNgteWutWN19GivG1lQEH53ofqEpJxctdWguuM3fk+T7MJ/
	 ZTR+Ea7UYPXCw==
Message-ID: <ecf3565a-e0ec-4848-a157-d0b5d1770b11@kernel.org>
Date: Sun, 11 May 2025 22:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: ti-omap: convert text based binding to
 json schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250510-ti-omap-v1-1-588b0ccb1823@gmail.com>
 <b18bc629-6bf6-4490-be98-033b771ecda7@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <b18bc629-6bf6-4490-be98-033b771ecda7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/05/2025 19:20, Charan Pedumuru wrote:
> 
> 
> On 10-05-2025 22:07, Charan Pedumuru wrote:
>> Convert TI MMC host controller binding to YAML format. It's a
>> straight-forward conversion of the typical mmc host controller.


Not really - you added properties.


>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
>>  Documentation/devicetree/bindings/mmc/ti-omap.yaml | 61 ++++++++++++++++++++++
>>  2 files changed, 61 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.txt b/Documentation/devicetree/bindings/mmc/ti-omap.txt
>> deleted file mode 100644
>> index 02fd31cf361d6ed893ec2f9eb8368b358ab2bae1..0000000000000000000000000000000000000000
>> --- a/Documentation/devicetree/bindings/mmc/ti-omap.txt
>> +++ /dev/null
>> @@ -1,26 +0,0 @@
>> -* TI MMC host controller for OMAP1 and 2420
>> -

...

>> -	};
>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap.yaml b/Documentation/devicetree/bindings/mmc/ti-omap.yaml


Filename based on the compatible. Didn't you get exactly such feedback
already?

>> new file mode 100644
>> index 0000000000000000000000000000000000000000..3660f54550e0ee46d3a7cfa3f531d95802f1e2fb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/ti-omap.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI MMC host controller for OMAP1 and 2420
>> +
>> +description:
>> +  The MMC Host controller for TI OMAP1 and 2420 family provides
>> +  an interface for MMC, SD and SDIO types of memory cards.
>> +
>> +allOf:
>> +  - $ref: mmc-controller.yaml
>> +
>> +maintainers:
>> +  - Ulf Hansson <ulf.hansson@linaro.org>


No, this is supposed someone responsible for the device, not subsystem
maintainer.

>> +
>> +properties:
>> +  compatible:
>> +    const: ti,omap2420-mmc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  dmas:
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +
>> +  ti,hwmods:
>> +    items:
>> +      pattern: "^msdi[0-9]+$"

Missing type: string-array
min/maxItems?

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - dmas
>> +  - dma-names

That's a change - binding did not mention it, did not make it required.
Every change should be explain in commit msg.

>> +  - ti,hwmods
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    mmc@4809c000 {
>> +        compatible = "ti,omap2420-mmc";
>> +        ti,hwmods = "msdi1";
>> +        reg = <0x4809c000 0x80>;
>> +        interrupts = <83>;
> 
> Forgot to include irq interrupt-controller header and use it for the interrupts, will change in next revision.

Header does not look like used...

> 
> 
>> +        dmas = <&sdma 61 &sdma 62>;

But here you need two <> phandles.

>> +        dma-names = "tx", "rx";
>> +    };
>> +...
>>
>> ---
>> base-commit: 3e039dcc9c1320c0d33ddd51c372dcc91d3ea3c7
>> change-id: 20250502-ti-omap-12655fa9db3e
>>
>> Best regards,
> 


Best regards,
Krzysztof
