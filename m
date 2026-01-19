Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93029994B;
	Mon, 19 Jan 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818921; cv=none; b=YHBrapw+rAycYe4ZJ9fvBU+mG2Nix7JEGRgevgMgAB0Zw8XoNuwIm5bpP0pIPrd8vvVS6jdFKuEpEJfO69WzwEZNzezHuV0DKHkSqc0P9ysVJyOiY73qUHdL3X1vJoJDZKw3Mrmth8mJaXaMtt+A03G7e2UV2g9N/mw+yHdrZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818921; c=relaxed/simple;
	bh=5R+bvxi6OEBJh5n7CU0DYl8TNpunqW07MyIIaVXFiqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHI3qZkLrhzFerAWJLu7BMGIyIU5T2Tx0RnX0yOcyK7HAyMS4Jx26fEa5ALlWdul7jchBEREidcOvK5cY3tQV3u0vlSUD3jY8NhQcI3rmbQB35MM7EnjDC4gmAbhv3aU/Du9ylgSEDwn8RJKFZOh6EUtJOknciSE6qms+ayA/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB2suOng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB2suOng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4737C116C6;
	Mon, 19 Jan 2026 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768818921;
	bh=5R+bvxi6OEBJh5n7CU0DYl8TNpunqW07MyIIaVXFiqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MB2suOngHVAefS3QSo/arRR7nXnGqStsOW/yE4g03vogpVlTqXjL+sZSu4Uvt/jhV
	 sBalJGEB4r1VgUR4y/zIzHO+ehhiOY6N32mIunoufhqcpJynZfDL1Q1SzVEuXzDdHG
	 wLNGNgRduDXabIVF7X1cybVA9bZzO8+eE17ucnHfN2Cuihjd3vbi4NFrMXW4OIoLds
	 jC/+w5WIEclLSaqCvDjzie9wI/BkZMgQ7HiF3BcxfZEkKLg+AN28qg2jfpkfvls6k5
	 h4XWoYEt1LaGDYyoLbZ/M2nflBEyHIa3yEOJjhO/f5tPviUmuZq4YQJpe3NxJoRr3B
	 P8qODy1P/ZHOA==
Message-ID: <fce1d7e3-22e2-4a01-aea3-573900da8bd9@kernel.org>
Date: Mon, 19 Jan 2026 11:35:16 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260114094848.3790487-1-neeraj.soni@oss.qualcomm.com>
 <20260114094848.3790487-2-neeraj.soni@oss.qualcomm.com>
 <20260115-intrepid-space-meerkat-d44ec9@quoll>
 <ce49730e-75d3-87fd-3190-44e45cf83fe0@oss.qualcomm.com>
 <6d14abf7-da78-4ccd-8032-d0197098982c@kernel.org>
 <c6200c33-29b4-7bfc-1b07-6a04383f8dd1@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <c6200c33-29b4-7bfc-1b07-6a04383f8dd1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 10:47, Neeraj Soni wrote:
> Hi,
> 
> On 1/16/2026 12:48 PM, Krzysztof Kozlowski wrote:
>> On 16/01/2026 07:50, Neeraj Soni wrote:
>>> Hi,
>>>
>>> On 1/15/2026 2:33 PM, Krzysztof Kozlowski wrote:
>>>> On Wed, Jan 14, 2026 at 03:18:47PM +0530, Neeraj Soni wrote:
>>>>> Starting with sc7280(kodiak), the ICE will have its own device-tree node.
>>>>> So add the qcom,ice property to reference it.
>>>>>
>>>>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>>>> index 938be8228d66..8a6a25ceabe1 100644
>>>>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>>>>> @@ -140,6 +140,10 @@ properties:
>>>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>>>      description: platform specific settings for DLL_CONFIG reg.
>>>>>  
>>>>> +  qcom,ice:
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>> +    description: phandle to the Inline Crypto Engine node
>>>>
>>>> Description should also say: for what purpose.
>>>>
>>>> You either have this phandle or ICE address space on sc7280 and newer.
>>>> You cannot have both, so your schema should encode it properly.
>>>>
>>> Sure. I will update this in next patch.
>>>
>>>> Otherwise you just sent something which already was on the list and it
>>>> even was reviewed:
>>>>
>>>> https://lore.kernel.org/all/ba3da82d-999b-b040-5230-36e60293e0fd@linaro.org/
>>>>
>>>> You even copied the commit msg but did copy the authorship!
>>>>
>>> Sure. Thanks for pointing out. I will fix the authorship in next patch.
>>
>> If you add if:then: cases, the patch will differ, so make it your own.
> 
> Okay.
> 
>> But sending exactly the same patch with the same commit msg as what is
>> already on the lists under your own name is not correct.
>>>>
> Okay this was not intended and have taken care of authorship in my other posts but i will ensure
> not to repeat in future.
> 
>>>> Anyway v3 and v4 were not correct and probably v2 should be used after
>>>> adjusting it with my comments.
>>>>
>>> Okay. As i see your comment in v2 here:
>>> https://lore.kernel.org/all/c8eea30f-5ea2-cfc9-273a-3c6e99a316b9@linaro.org/
>>>
>>> i guess what you want is not to drop the entries for clock but rather capture it
>>> in the "description" of the ICE phandle entry. Is this understanding correct?
>>
>> Clocks should not be touched, but reg should.
>>
> Okay but In sdhci-msm.yaml file:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n78
> 
> the currenty entries for "reg-names" do not specify for which hardware register range they are added. So shall i add something like

Read the rest of the binding.

And finally wrap your emails correctly. I am bored asking this over and
over, so if there is silence in the future - you can guess why.

Best regards,
Krzysztof
