Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAD1E8342;
	Thu, 19 Feb 2026 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771489639; cv=none; b=ibAHTHAeS47RPgUqKfT5Q/Wzti9bEKh2jLE0GUjXa1vzeyuFaX8QClGxwNroosyjUG+HhyGk2PAHNHLTH+/rYLsa9HrRZOsKMpplVNU8yLAHk+mYgFCLq/oU0df9pu+MxbhBQ11ByxQvS2FLubqmpzjxRrglEQSiRSW+lvVWslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771489639; c=relaxed/simple;
	bh=Y5n2vf0KF3JTxIpPOMa3hJNUJxaR9JRHGsLr1tXqdJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmsxxhrbyLFgESHmfar/CDmkFxDAP5mbkbbR6GfKawZNh1ys35LARQFrkvfoUOakFXUrsD4NtBDAhONsfbpKMwl4LT1N1k9OP7Rah4ItW7A+wNgqjsK9S43GBCLoMW6db4jjUGTWrHfYUKxWMteNLgqGaJ77jDVHodH5K2xXpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bguq/hn3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bguq/hn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07068C4CEF7;
	Thu, 19 Feb 2026 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771489638;
	bh=Y5n2vf0KF3JTxIpPOMa3hJNUJxaR9JRHGsLr1tXqdJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bguq/hn3A6435NAXM/fkTO+Ads2AWQhVr5OoeXFnKLWC0EsEqN3EIdrBoICrZ8R1f
	 KYLt/xwc4MUbQNYXVu3fKwsA+0opaBa9ZvUoO20dHR//ZojxRDKSiKppJzksWS9TdH
	 j+yfHUAYRK0oj2q4biWiVSz2IXVGSAoZlvCqXsIavv/YQ4eDO7nmoZDry59U7npuQI
	 PP0iTJv8dq4BnKSFbaol/0/hwrHbnI7rLLHJRvGPzQxGmIzhyYAmFAM3JwG6S2ixzo
	 CQmCQMPuggH3DV2rKL8KYD5hdzyA3Nu2nSOIPBm2KTz58x+C3Z6gB7/6627jtV4b1E
	 rzUuPll1Qm9mw==
Message-ID: <21a87714-cd11-4217-a2aa-82fddc3a8530@kernel.org>
Date: Thu, 19 Feb 2026 09:27:14 +0100
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <e3ac0681-605d-c1df-e4f0-78a2c142fa66@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/02/2026 06:38, Neeraj Soni wrote:
>>>  
>>> +  - if:
>>> +      required:
>>> +        - qcom,ice
>>> +    then:
>>> +      properties:
>>> +        reg-names:
>>> +          not:
>>> +            contains:
>>> +              const: ice
>>
>> And reg is still 4? This is not correct syntax. You need to define
>> proper and final constraints per each device. I would write example, but
>> why... more things you could just ignore.
>>
> I had included changes for reg in v3:
> https://lore.kernel.org/all/20260206112053.3287756-2-neeraj.soni@oss.qualcomm.com/
> 
> but those were not reviewed so i assume them to be incorrect and dropped it.
> Will fix this in next patch and post.
> 
Patch v3 was also not correct, because SDHCI v5 devices should have 1 or
2 entries, not 1-3 as previous patch said.

You need to embed the ifs:

189   - if:
190       properties:
191         compatible:
192           contains:
193             enum:
194               - qcom,sdhci-msm-v4
195     then:

here you add one more if:

196       properties:
197         reg:


198           minItems: 2
199           items:
200             - description: Host controller register map
201             - description: SD Core register map
202             - description: CQE register map
203             - description: Inline Crypto Engine register map
204         reg-names:
205           minItems: 2
206           items:
207             - const: hc
208             - const: core
209             - const: cqhci
210             - const: ice
211     else:

and here as well.

212       properties:
213         reg:
214           minItems: 1
215           items:
216             - description: Host controller register map
217             - description: CQE register map
218             - description: Inline Crypto Engine register map
219         reg-names:
220           minItems: 1
221           items:
222             - const: hc
223             - const: cqhci
224             - const: ice

At least that's the simplest solution I see now.

Best regards,
Krzysztof
