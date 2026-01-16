Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B3221726;
	Fri, 16 Jan 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768558835; cv=none; b=Ha4DHqtsf3LVNfdO13AMxR2ERtco4k0OQQLf1m5F9/XUd5TrIyixYDvFGSKmHVsKE+3k8RBIp8+xXkz7EU8oIY+NCg/vVktAExGAL+FMM8ogqpKttSfWTBMgDZxyi4WlxCN4+WUYUim3EiZr0vxqZeclqqfGiyxOyjhtS3sicZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768558835; c=relaxed/simple;
	bh=1JZLMS1HVsbd6aWEx+GimXeEmDseHFvWx560rTN8Xww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3vOEPQLHgSGsbBX1ZrliXtkff6Z5zN1Bhx7YOPVaSOhL0f6OYcBs9CCcxbmP5384k08Ts0JuTKTFibKWRFT9eLy5D+PkPrSFdv3qlYeNJH35HvDIR89xc1K23vnvrWMS4wU5NiUaSeDRYADPvTcPxHo4VWBCNg0eMQKIIrG+vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ensECWlL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ensECWlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4D2C116C6;
	Fri, 16 Jan 2026 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768558835;
	bh=1JZLMS1HVsbd6aWEx+GimXeEmDseHFvWx560rTN8Xww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ensECWlLD29cMvgjZm38/hPpVFtsmbJMXILx0Yqwpbfj6HPK6Fit3bcD4dSr0M+D1
	 qWfg1/ZUqaSFWbWmwx5gJV6qHCTYrmKct3GvuoV+CjWoY5eT/fMiLlWWOPLEhg3IkB
	 l4FfKaakjdSiQ5CKrXG9UmlkKUq9I5o/SdeXxZMPuGjn/nko7hpNsNVObkClete8AX
	 +ajcUjEPaNhohL73gub37pmu/gH4VPr2scgaPS64ZkMiTy1kz4Ox9mxrEIkIa421tl
	 gAMAqzimBonxCmxl1W+mVcO7vmlPbETgQMfmGAaSFtSZLZRpLDs0LlE/6cM5hhVqEa
	 opMEKMZpubsog==
Message-ID: <8ba68d9c-5cd1-4616-998e-2ff5d3440984@kernel.org>
Date: Fri, 16 Jan 2026 11:20:30 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: rockchip-dw-mshc: add
 rockchip,disable-runtime-pm
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Marco Schirrmeister <mschirrmeister@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <20260111-melodic-chestnut-coua-73e6ec@quoll>
 <CAGJh8eAWNe0JzC7BdA2Rw5etCYgGq3O5Zdgk9zSzsLNv18k=ag@mail.gmail.com>
 <1791168.izSxrag8PF@diego>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <1791168.izSxrag8PF@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/01/2026 10:43, Heiko Stübner wrote:
> Hi Marco,
> 
> Am Montag, 12. Januar 2026, 00:51:24 Mitteleuropäische Normalzeit schrieb Marco Schirrmeister:
>> On Sun, Jan 11, 2026 at 10:41 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>>> +  rockchip,disable-runtime-pm:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Inhibit runtime power management. This is required for boards
>>>
>>> What is runtime power management? Like Linux PM? If anything phrased
>>> like that is it is a clear no go. Bindings describe hardware.
>>
>> You are right. This refers to the Linux PM subsystem and describes
>> software behavior.
>>
>>>> +      where the bus timing becomes unstable if the controller is
>>>> +      runtime-suspended.
>>>
>>> You described the desired Linux feature or behavior, not the actual
>>> hardware. The bindings are about the latter, so instead you need to
>>> rephrase the property and its description to match actual hardware
>>> capabilities/features/configuration etc.
>>
>> On this board, the bus timing becomes unstable when waking up from
>> a low-power state. This causes a constant retraining loop.
> 
> As you describe it here, it does sound like a real hardware quirk (which
> would be a dt-thing) ... it's just that the previous wording describes it
> in a non-hardware way - as Krzysztof pointed out in his reply.

I can also imagine that you miss some register programming, clocks or
regulator voltage, so "unstable" has to be actually analyzed.

You should not really disable a Linux driver feature just because your
hardware has issues. And even then it's more likely some MMC core part,
not entire runtime PM, is problematic here.

> 
> 
>> I will move this logic into the driver and handle it as a board specific
>> quirk using of_machine_is_compatible("friendlyarm,nanopi-r76s")
>> instead. I will send a v2.
> 
> This won't fly I think. We can't really have a (possibly long) list of
> 
> If (boardA) foo();
> if (boardB) bar();
> if (boardC) bas();
> 
> That really is not sustainable and most likely won't get accepted.

Yep


Best regards,
Krzysztof
