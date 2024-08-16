Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0C13A256;
	Fri, 16 Aug 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796627; cv=none; b=m3j1QhoCwHJ+1sh0RNplsOvuZC2Jl6//1xj52CWTtBwasuGVxDrkg67f52hXf8/7tTr6K+s+SsfSosvNCoLHt3j0D2prHGpfJzpp/SCOpslH/lUEzJLsXaznV+HYQGu2+O8cJl/Qhu2/M16qlfxaTrVoXOXxOY8NEERqAnBUfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796627; c=relaxed/simple;
	bh=I4jD9noy6kedXXh1u+n1aRGJn3cGj+nV2MzUS/dZpUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZm2QzuPLxTcsrzhtgXdHA/jK5A2CX1fJ4VHsuLqO4c2b+CmltDG2eix9frr5y+RB2pUwe0M7a/MAjQB0ZC4IOHJryZej8ntvMzImM6I+2a48VR6RoZas6COk+c3CcTgZtJVNUjYnwEEFbKgNeJKy/jSlHmmmVFnruibOQoQYL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePRWQodI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePRWQodI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14379C32782;
	Fri, 16 Aug 2024 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723796627;
	bh=I4jD9noy6kedXXh1u+n1aRGJn3cGj+nV2MzUS/dZpUA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ePRWQodI9pMQX6TxlQGcEXCnJzzDxmoakBwJ0ioiW16SNeldu9o0ZJsQ+kf8KGUHw
	 6OjE21a8NLjN1zZNjtVJklssrI22rMz2G15NcGoGg37zFp9eBeHYon5hiBE5XLE/29
	 NQ+k+REciR6WKeWx7T/l+GM68YmcMvoDg5nsiPfDwbLHU56MXywa5Bdm1oD78ERGaT
	 JrWKdP3IGwbFsjQNFkstZmtSB/IrtIe/JkCDDnMFrZ48wGy1zXfTB+bDo9MKPw3n4u
	 Xl0S4FXj0lFH5JJeXKvwHc6qudhDLqlPlCGJtIpuM0/dhP9cKgL8nt5mh7YcwQrZSp
	 rHYQ8CsXQKbMA==
Message-ID: <20e1c51c-0231-40de-919e-664df906a724@kernel.org>
Date: Fri, 16 Aug 2024 10:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add support for rk3576 dw-mshc
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, Detlev Casanova <detlev.casanova@collabora.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
References: <20240814223555.3695-1-detlev.casanova@collabora.com>
 <5057223.82XvGhxQ46@diego> <e640cbc4-6870-4607-a91e-0af41dd76df9@kernel.org>
 <2504176.W2GruxG5Vl@diego>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <2504176.W2GruxG5Vl@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/08/2024 09:45, Heiko Stübner wrote:
> Am Freitag, 16. August 2024, 08:52:04 CEST schrieb Krzysztof Kozlowski:
>> On 15/08/2024 15:49, Heiko Stübner wrote:
>>> Am Donnerstag, 15. August 2024, 00:34:00 CEST schrieb Detlev Casanova:
>>>> Add the compatible string for rockchip,rk3576-dw-mshc and add support
>>>> for the rockchip,v2-tuning flag, a new feature of this core.
>>>>
>>>> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>>>> index 211cd0b0bc5f3..0543cdb51c657 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>>>> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
>>>> @@ -39,6 +39,7 @@ properties:
>>>>                - rockchip,rk3368-dw-mshc
>>>>                - rockchip,rk3399-dw-mshc
>>>>                - rockchip,rk3568-dw-mshc
>>>> +              - rockchip,rk3576-dw-mshc
>>>>                - rockchip,rk3588-dw-mshc
>>>>                - rockchip,rv1108-dw-mshc
>>>>                - rockchip,rv1126-dw-mshc
>>>
>>> this would mark the rk3576-dw-mshc as being the "same" as the
>>
>> Not the same, but compatible.
>>
>>> core rk3288 variant. rk3288 was the first controller introducing the
>>> clock tuning for higher speeds. with the clocks being part of the CRU.
>>>
>>> As we can see in later patches, this rk3576 though changes that
>>> setup with moving the tunable clock configurations into the controller
>>> itself.
>>>
>>> So please don't claim to be compatible to the 3288, but instead start
>>> a new block for this new set of controllers:
>>
>> The question is can new device work with old compatible (without new
>> features)?
> 
> the rk3288 and following have their clock phase tuning for hs-modes in
> the main soc's clock controller. Hence you have the "ciu-drive" and
> "ciu-sample" clocks [0].
> 
> On the rk3576 (and probably following) those clock phase settings moved
> inside the mmc controller itself. So there are no external phase clocks
> anymore.
> 
> So right now we have two types in the binding, the rk2928 type [1],
> used on the old rk3066 and rk3188 socs, that did not support mmc hs-modes
> and the rk3288-type which introduced phase tuning via clocks from the
> main clock controller.
> 
> The rk3576 now switches to having phase tuning in the mmc controller
> itself. So throwing that on unmodified code for the rk3288 will get you
> degraded functionality, because the tuning won't work because there are
> no "ciu-drive" and "ciu-sample" anymore .

One could still argue that rest of programming model is the same, thus
"degraded" mode counts as compatibility, but I do not insist on that.

> 
> 
> And with that separate compatible we could also "tighten" the binding
> a bit to make those additional clocks more explicit for the rk3288 type.
This you can, and actually should, do with existing binding. Maybe just
a bit more tricky/complicated code.

Anyway, fine with both compatibility-approaches.

Best regards,
Krzysztof

