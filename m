Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71524E016;
	Fri,  6 Mar 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802496; cv=none; b=mUUOr/l08MLJYEwh19wYGirwMxyKUP10vSVziBlg/dQfs4aljPznjZ+xlV6uteTW3ZrIstEG09E5N0wWdlSwufrqDSkuB4juIfWx7Lmr6zalyTsGDi2pM2GyeZ6nGI3TTL/p9uAVNkliB2Q+csvu2mWB9bf3hF3YIP1QZeA3fSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802496; c=relaxed/simple;
	bh=X33DmcoobMWBjEwpsJyBbUD2aCD20Mj1tSw9gJzI7Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDczkMc04DDhRV5OGdxMnYfsnmQ0SI195EF2FWZmPTX/OKw7duwwnQSru9dSFWSi0wdJbcukiyXp6UPWCfFQ50Rfz0HGwoC0TxFf52uaPa0GOUPdpTtyR2byTGY8/Ozw30hBKQBYiO3hfWsJ5bBTrnHZiZymHS2sI2j06CKBgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOgoep/+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOgoep/+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCB6C4CEF7;
	Fri,  6 Mar 2026 13:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772802495;
	bh=X33DmcoobMWBjEwpsJyBbUD2aCD20Mj1tSw9gJzI7Jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dOgoep/+4phJj0umQVQUS86utVKKBhD/Y2RplvBXHJHFlIntcP7F3VFoLhSCurnsx
	 JfgreDgqnixgEzRJYJBad4SWt8L/Rtfp7/dLqRh2JjsZAQ56dgvR/OTYzOFvQaT49w
	 aBmj08fG84p5R9/Slzy50lj4rp22jkqnA4ukRSmOeaxyvyhI5/PtHl4W/yFO6R7ls3
	 4byowxRgWlzwNWGbUH0gQBTL9K+H9hXaSCsfwrdjRAMYbFrg0CjBJmszGT1O8T76yd
	 46NPFnHF/TBtWt5qxEwlsephriCRW0oBYSBUPewrPGehsQenO6y3B5YcmRS6wj/WT8
	 wsVGN7cSGcgdw==
Message-ID: <aa85df27-ebbb-472a-a300-f8ae87080ee3@kernel.org>
Date: Fri, 6 Mar 2026 14:08:11 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: samsung,exynos-dw-mshc: Make both
 clocks required
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ping Gao <ping.gao@samsung.com>
References: <20260306112742.64235-1-ulf.hansson@linaro.org>
 <3eb61c4b-2902-4a62-8246-4bed683fe326@kernel.org>
 <CAPDyKFosu5=gAb0QzhkACO6RhXkOFNiKKOSdwrDsezT-bx4U2w@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAPDyKFosu5=gAb0QzhkACO6RhXkOFNiKKOSdwrDsezT-bx4U2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2026 13:55, Ulf Hansson wrote:
> On Fri, 6 Mar 2026 at 12:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 06/03/2026 12:27, Ulf Hansson wrote:
>>> The current binding allows one or two clocks to be specified, which is
>>
>> It allows only 2 clocks, unless you meant that referenced dw-mshc schema
>> allows one clock. I don't see it there, so I am a bit confused.
>>
>>> wrong, as both clocks are needed. This is also confirmed by looking at the
>>> exiting upstream DTS files. Let's update the binding to fix this.
>>>
>>> Cc: Ping Gao <ping.gao@samsung.com>
>>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
>>> index 27c4060f2f91..3e560dde714e 100644
>>> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
>>> @@ -42,6 +42,7 @@ properties:
>>>      maxItems: 1
>>>
>>>    clocks:
>>> +    minItems: 2
>>
>> That's redundant, 2 clocks are already implied.
> 
> Doesn't maxItems mean the maximum number of clocks? And since clocks
> are required, it means that it's perfectly fine to only have one?
> 
> My points is, we seems to be requiring *exactly* two clocks, no?

minItems is already (implied) at 2, so I don't see what is different
here. You can open any other binding and see exactly same pattern
everywhere, so that's why it would be good to see here explanation why
this binding is different than others. IOW, what set here the number of
items to 1?

Best regards,
Krzysztof
