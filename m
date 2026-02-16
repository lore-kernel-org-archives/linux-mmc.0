Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783ED2F1FC7;
	Mon, 16 Feb 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240113; cv=none; b=U8Dg9Wxywudf2H6O7rU7PWyb2ZvctPtIxynyo+QsWtmneQ5P03uzCtoFsBEEpUGL32s76iIPXRbiRVOySFjPNotzU//wjYYK6y7NNFOXTzIiopcUXRv5PsFsdDeyZkCTVevWch68WWYysag47JHpcs9Z4BOM+cpBa0VOPseo/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240113; c=relaxed/simple;
	bh=3LVYokJeMWivWKgeVcKV82xhskBynkboV20Vzq+QB74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLL1zDwlTuQgna7MGJfANOuZAeOxhh5wJIRYKYqWnyCDds4wPSL/YMVmm2HfCpNGBhIu76gwjnsO7N8tV7Jqm+OmHgp9torMZTLy8XpLqM4O/Dvrj8YthR8sqC97Mg/O/tr4hIursZqwck9olC/9ZZ/ms9zBgeYXoQbS1S3P2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr1z6BgV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr1z6BgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A75C116C6;
	Mon, 16 Feb 2026 11:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771240113;
	bh=3LVYokJeMWivWKgeVcKV82xhskBynkboV20Vzq+QB74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lr1z6BgVMEHEj81mWB5i3VbVSA2bCBgvc74vLfwXrVKVrLUukXFbf4WjxoIIwarre
	 5nIgfigSm/8soPxfcZedOQ43iAifoTTP9z03M6uaHWUAYzyQN2Pmj0z8U9EoiPYnHj
	 wp/xZ59OvA8q2Qz2doX9zSbZ3qmyCzB8oKR3rbN9yZfwookCcNucI/PFg1puRBkyBo
	 u7vuGqDnudopc3j9kmTR56zzZhg8QfqV44Ky+TSn8by1BLYLJb4k4NoJo8FXMsM6au
	 LrCAZwOs8KHPVTXMiXC37D5z8GOks4+OS9kM/Lp6Nb3r/G7oFzF7C6jFKzKkk03tzb
	 p0UHkAsxvBQxg==
Message-ID: <2e212989-5976-4ac0-a86a-01414ca856f5@kernel.org>
Date: Mon, 16 Feb 2026 12:08:28 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
 Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260206112053.3287756-1-neeraj.soni@oss.qualcomm.com>
 <20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com>
 <b6e510da-b369-4c43-b9a1-455478af4948@kernel.org>
 <640e2eca-1656-1723-38e8-d6cd97e6e2e3@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <640e2eca-1656-1723-38e8-d6cd97e6e2e3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2026 12:05, Neeraj Soni wrote:
> 
> 
> On 2/6/2026 4:56 PM, Krzysztof Kozlowski wrote:
>> On 06/02/2026 12:20, Neeraj Soni wrote:
>>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>>> So add the qcom,ice property to reference it.
>>>
>>> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> Co-developed-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>> Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>>
>>> ---
>>>
>>> Some initial work is done by Abel here:
>>> https://lore.kernel.org/all/ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org/
>>> and by Abhinaba here:
>>> https://lore.kernel.org/all/20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-1-2a34d8d03c72@oss.qualcomm.com/
>>>
>>> This patch adds the purpose and usage for phandle in the description and encodes
>>> it properly in the schema.
>>> ---
>>>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 26 +++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> index 938be8228d66..f35b675c9f16 100644
>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>> @@ -140,6 +140,12 @@ properties:
>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>      description: platform specific settings for DLL_CONFIG reg.
>>>  
>>> +  qcom,ice:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: |
>>> +      phandle to the Inline Crypto Engine node. ICE having its own platform driver will use this phandle to
>>
>> Please wrap code according to the preferred limit expressed in Kernel
>> coding style (checkpatch is not a coding style description, but only a
>> tool).  However don't wrap blindly (see Kernel coding style).
>>
> Sure. While executing dt_binding_check the tool reported max limit as 110 characters so i wrapped
> around it. I will consolidate the description to single line in next patch.

Can you read Linux kernel coding style as I asked?

Best regards,
Krzysztof
