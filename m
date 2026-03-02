Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8323FFABB;
	Mon,  2 Mar 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469517; cv=none; b=K3oc2EP68knmJTEWY55H55gCFqIFeEueobsy4FOQefeBTmVuMIErmOySvjDKA6xLDWPVB4nDiWXKIEObxrNgyO1fohwujxxxzhccPRpDUNZHYpyoau4Z5DpDyRbDivqDcZiuWIihcPZisF/eoP/niEgdCwKRFtHIVYbwkr30VM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469517; c=relaxed/simple;
	bh=NUxV4VvQPyCUU/fWGu4E6/ZDNrlAixdG0q3S1m4kZd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEM0B3TlNp3NaEiTRgbrFcPeDO4GJJY3Nq1HqxrZUzVLNXdF8Nhf4CDrkukntg3xlGV6PMxtoaLbmom4CXqW+9xO1JrlftBnW2DyERcMljNjD2nsPIMD8iC9e+G7oVeELMUomyuO+3OFUz3IZ8sU0lOXoe2KGp2S1Geh3dDySNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiT5Got4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiT5Got4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A04C2BC87;
	Mon,  2 Mar 2026 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469517;
	bh=NUxV4VvQPyCUU/fWGu4E6/ZDNrlAixdG0q3S1m4kZd0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZiT5Got4pWgkWA2IGaLMv+NeaHnBSUtVzOj3g8C26JgJfii7R0Jll5Ux5i8jX69fa
	 3AMrz1Nb6Pu0PD24DjSJrzNOwlR8TG+Rt3tROFmYTasjTw1lYMr4qONj863uX3S/WO
	 CpzYHk5jp51NfV1yuZBcw6LiCwIC9rr478ONkabqhLh3xC7WFuP+0Ygryp3oxXktFt
	 9InJ6JW+VsK4vftBH9+gFDt1pK99VkC93abEcuCAHE5xlJ28Tv6DdgLzGRWaHtKoED
	 uF9FUclDwZ7Rlt5vwDGOmNzUKqT+9ByFSvzcfU1TrlpevcVKCGnBGr7U53ql9cGNU3
	 W0ZiC8y0bjjJQ==
Message-ID: <3339ddcb-d0f5-4117-99fd-f3f158b7903d@kernel.org>
Date: Mon, 2 Mar 2026 17:38:32 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: sdhci-msm: Add ICE phandle
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
 Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
References: <20260217052526.2335759-1-neeraj.soni@oss.qualcomm.com>
 <20260217052526.2335759-2-neeraj.soni@oss.qualcomm.com>
 <20260217-berserk-puma-of-focus-bcbe82@quoll>
 <e3ac0681-605d-c1df-e4f0-78a2c142fa66@oss.qualcomm.com>
 <21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org>
 <544925d0-cf32-6b2a-548e-d6f7cc517581@oss.qualcomm.com>
 <01085021-c116-46de-a0ce-730455620cb2@kernel.org>
 <32b7763b-ba44-4341-8528-be97d6607354@kernel.org>
 <06967254-7fa6-218e-db8a-8e4a118a7d24@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <06967254-7fa6-218e-db8a-8e4a118a7d24@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/03/2026 12:25, Neeraj Soni wrote:
> 
> 
> On 3/2/2026 2:27 PM, Krzysztof Kozlowski wrote:
>> On 02/03/2026 08:48, Krzysztof Kozlowski wrote:
>>> On 02/03/2026 08:45, Neeraj Soni wrote:
>>>>
>>>>
>>>> On 2/19/2026 1:57 PM, Krzysztof Kozlowski wrote:
>>>>> On 19/02/2026 06:38, Neeraj Soni wrote:
>>>>>>>>  
>>>>>>>> +  - if:
>>>>>>>> +      required:
>>>>>>>> +        - qcom,ice
>>>>>>>> +    then:
>>>>>>>> +      properties:
>>>>>>>> +        reg-names:
>>>>>>>> +          not:
>>>>>>>> +            contains:
>>>>>>>> +              const: ice
>>>>>>>
>>>>>>> And reg is still 4? This is not correct syntax. You need to define
>>>>>>> proper and final constraints per each device. I would write example, but
>>>>>>> why... more things you could just ignore.
>>>>>>>
>>>>>> I had included changes for reg in v3:
>>>>>> https://lore.kernel.org/all/20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com/
>>>>>>
>>>>>> but those were not reviewed so i assume them to be incorrect and dropped it.
>>>>>> Will fix this in next patch and post.
>>>>>>
>>>>> Patch v3 was also not correct, because SDHCI v5 devices should have 1 or
>>>>> 2 entries, not 1-3 as previous patch said.
>>>>>
>>>> This is not clear to me. Here:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n80
>>>> it says the entries should be 1-4 and there are no v5 specific constraints.
>>>
>>> There are, just scroll.
>>
>> Here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n212
>>
> Yes i had looked at this but, as i understand, this constraints the minItems: not the
> maxItems: and in your comment here:
> 
> https://lore.kernel.org/all/21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org/
> 
> you expect v5 entries to be constrained to 1-2 and not 1-3. So, as i understand from here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml#n78
> 
> the v5 can have 1-4 entries without "qcom,ice" and 1-3 with it which is what i had posted.

We have long discussion and you are just not replying to the problem. I
am done here. I wrote already what is wrong and what I expect.

Repeating the same as before in the FIRST comment: Your patch allows
incorrectly four reg entries for v4 and there reg entries for v5.

That's a NAK.

Best regards,
Krzysztof
