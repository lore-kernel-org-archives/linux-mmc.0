Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA42153EA;
	Wed, 18 Mar 2026 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821781; cv=none; b=H+PXml0307KKw5PSULAwC/yt9rJNRARykHm0a6e3B1jdjisMNgOB1HTNQ5sVikcj4vhc2wL65igT0zhzVCpUAAQ65jXMjWzSHgSj62iSrApxSAsrrBhBv+qprxXE7MzmRdDCrgpkLRmh/qrN5v20o7A+mygDj2I/1w0RZK+K4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821781; c=relaxed/simple;
	bh=24fPFwUkbw//dSGKXR5fDVH0uAFMUSzI9ZdDlbFt4Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQ0FlzOYcLTYv6SJ5X1Y+q79ndwkEoelrtwAUPVvVgrIMu+SC3Vn5iu3K4llJU8dfaPsOH80k0bhUtmWgu8iiOpw07DXztD0FFXbNiCl3MP+e4auAiu9BKq5EOCC1DrvODceUX1of582UPG0/6SSmVJGrBVpExhkAIqoBH9Uoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF5CVt1t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF5CVt1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72E4C19421;
	Wed, 18 Mar 2026 08:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773821781;
	bh=24fPFwUkbw//dSGKXR5fDVH0uAFMUSzI9ZdDlbFt4Fs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MF5CVt1tB6vSe8iiWK2mYjHTALFieTz2c1hiW4cz+W+53MvHQ7V33+CVbI2jxl3B4
	 tIrGZ/BkxGyuyclxXMKOrwLUg+6Ct8aUkHR49op/0X3osJb8CV68xeHWJEAO2RT1Xe
	 OBekmrALQ4rAsl6iyw1mNu46WK3YsFI9xs4OXMPlglhxjp/gPlb+jyogctqCOO6EKk
	 KMXfnsqUZn04a2L6K0LUObRfOz6u4jL8MSmzpqhIs42ZC0EG/tssWCpb6gekYO92Am
	 sNzGXOsKy9YVmGS4SDb02LniynXKYTD3orp3hpP1SeYjzGRp7+/XoYa9M2ZsUM25pD
	 xKOiPzz6oN60Q==
Message-ID: <f46bf4fb-b6e5-4238-9c23-c435c4b8e275@kernel.org>
Date: Wed, 18 Mar 2026 09:16:15 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: dt-bindings: sdhci-of-aspeed: Add AST2700
 fallback compatibles
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Ryan Chen <ryanchen.aspeed@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Andrew Jeffery <andrew@aj.id.au>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com>
 <20260317-sdhci-v2-1-39b1f063061b@aspeedtech.com>
 <20260318-abiding-sloppy-poodle-efd3e5@quoll>
 <TY2PPF5CB9A1BE666DEF10944BBA2A2256BF24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <TY2PPF5CB9A1BE666DEF10944BBA2A2256BF24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2026 09:09, Ryan Chen wrote:
>> Subject: Re: [PATCH v2 1/2] mmc: dt-bindings: sdhci-of-aspeed: Add AST2700
>> fallback compatibles
>>
>> On Tue, Mar 17, 2026 at 01:56:42PM +0800, Ryan Chen wrote:
>>> Describe AST2700 as compatible with the existing AST2600 SD controller
>>> and SDHCI bindings by requiring fallback compatibles in the device tree.
>>>
>>> Also require `resets` on the AST2700 SD controller node.
>>>
>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>> ---
>>> Changes in v2:
>>> - add missing blank line
>>> - modify ast2700 compatible items const
>>
>> Why?
>>
>>> ---
>>>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 39
>> +++++++++++++++++-----
>>>  1 file changed, 31 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>>> b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>>> index d24950ccea95..9c8e068964a1 100644
>>> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
>>> @@ -22,10 +22,14 @@ description: |+
>>>
>>>  properties:
>>>    compatible:
>>> -    enum:
>>> -      - aspeed,ast2400-sd-controller
>>> -      - aspeed,ast2500-sd-controller
>>> -      - aspeed,ast2600-sd-controller
>>> +    oneOf:
>>> +      - const: aspeed,ast2400-sd-controller
>>> +      - const: aspeed,ast2500-sd-controller
>>> +      - const: aspeed,ast2600-sd-controller
>>
>> No, previous code was correct.
>>
>> Is this some microslop LLM product? I questioned style last time and now we
>> got random changes without explanation.
>>
>> Please confirm - did you use any LLM microslop tools to create this patch?
> No I create it with B4. And commit each by each, I don't use LLM to porting this.
> 
>> Please also confirm - who internally reviewed this patch before posting?
> I port this and do test in my side and confirm it.
> 
> 
> In https://lore.kernel.org/all/20260314-flat-topaz-peacock-440a9c@quoll/#t 
> You request drop driver compatible; 
> Base on your instruction, So I do my study in Linux.
> Use following to do compatible. Not add driver compatible string.

Replacing enum into list of const is not related/relevant to what you
wanted to achieve.

Best regards,
Krzysztof
