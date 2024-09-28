Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7BC8DF;
	Sat, 28 Sep 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727530792; cv=none; b=gBtoXF/o2Of+KVVYkcU49lxPYp0LjiKOzLBQoAG+EwpgZcC33F3Yy1lqzjqzvAkM2DFM+VhXwnqKWreHpXgq/dSW5NI7LIzBblYTdDmn46uN8h8bG/WuhK4LnWSgoKVRdCLVgsdHpYn4uUrYaCRQHv+nqeKETm1qCLouS0784dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727530792; c=relaxed/simple;
	bh=H5ZN0gpItc2hzxYwHv5spamvIBLBAgjW6cCpZ+l4R7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYk9Da18kcmuIec2dlHEVhUvNhZ8jD++tmHrwbAV2jfuNNWDySIdpqtOza3CAxuARSIKY3fj0ZyeHbLH7++WyOPR+eH+vQAPbA5uOb1sSKfHZWLaScLYxBL4yWRRgFanBoqb+ilGjuAg3YlYzpPTcTh0OHxwplx1QV2vL4i/S3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc4lAi5L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc4lAi5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92ABCC4CEC3;
	Sat, 28 Sep 2024 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727530791;
	bh=H5ZN0gpItc2hzxYwHv5spamvIBLBAgjW6cCpZ+l4R7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uc4lAi5Lsvgx1JHrdNvawk0WkKZ5YJUKC2Rq36zUzdTwrD4P73ehT/q+NGlNGwLDQ
	 sK8Ha9eJEB83DdeeT2V6zjSGstN3jLRSNC057M0Tleawil/HdDuxraB2ttd+nRg+DM
	 J9Dx4TsoiPx8s+oLJeaWxIbGM7cQSoAQIlzleQnlIVPkbOaLA5GTii74muoJ5Mu29K
	 WvScgSycgAIvaBZBSuEk7tRdk+NJl4PhfA272OQxLWSuzm319FfKqZfjjKChYhNQ5U
	 37MPReypFNLtzXJY26/+EE47dIEvSXboVV31sxvpRO8rNmekAoL57DXNIFpZmI5H2x
	 sZJNtYsqzr3Ug==
Message-ID: <30e4735e-bf50-440c-8ad1-6bcf8b8bd930@kernel.org>
Date: Sat, 28 Sep 2024 15:39:46 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
To: =?UTF-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>
References: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
 <20240926070405.20212-3-andy-ld.lu@mediatek.com>
 <20240926175409.GA2644361-robh@kernel.org>
 <10ce6e9af6daa69735f46b45028ec1b2d25ee66a.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <10ce6e9af6daa69735f46b45028ec1b2d25ee66a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/09/2024 15:14, Andy-ld Lu (卢东) wrote:
> On Thu, 2024-09-26 at 12:54 -0500, Rob Herring wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On Thu, Sep 26, 2024 at 03:03:18PM +0800, Andy-ld Lu wrote:
>>> Extend the devicetree bindings to include the MT8196 mmc controller
>>> by adding the compatible string 'mediatek,msdc-v2', which could be
>>> also used for future compatible SoCs that support new tx/rx.
>>
>> Generally, every SoC ends up changing at least slightly. So we don't
>> do 
>> version numbers except when there's a well defined versioning scheme
>> of 
>> the h/w (e.g. FPGA IP blocks). So, use SoC for compatible string.
> Thanks for your review.
> 
> The new tx/rx represents a significant update for mmc controller of
> mediatek from the MT8196 chipset, and the dependent settings remain
> consistent for MT8196 and subsequent SoCs. Therefore, It is proposed to
> use a unified compatible string for these SoCs that support new tx/rx,
> and name it as 'IP(msdc) version two'.

Sorry, nope. That's not valid reasons.

>>
>>>
>>> Add three properties for MT8196 settings:
>>> - 'mediatek,prohibit-gate-cg', indicate if the source clock CG
>> could
>>>   be disabled when CPU access IP registers.
>>>
>>> - 'mediatek,stop-dly-sel', configure read data clock stops at block
>> gap.
>>>
>>> - 'mediatek,pop-en-cnt', configure the margins of write and read
>>>   pointers while begin to pop data transfer.
>>>
>>> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
>>> ---
>>>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 26
>> +++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>> b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> index c532ec92d2d9..82d1a9fac67c 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> @@ -25,6 +25,7 @@ properties:
>>>            - mediatek,mt8173-mmc
>>>            - mediatek,mt8183-mmc
>>>            - mediatek,mt8516-mmc
>>> +          - mediatek,msdc-v2
>>>        - items:
>>>            - const: mediatek,mt7623-mmc
>>>            - const: mediatek,mt2701-mmc
>>> @@ -154,6 +155,30 @@ properties:
>>>      enum: [32, 64]
>>>      default: 32
>>>  
>>> +  mediatek,stop-dly-sel:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Some SoCs need to set appropriate stop-dly-sel to configure
>> read data clock
>>> +      stops at block gap. The valid range is from 0 to 0xf.
>>
>> SoC dependent or board dependent? Imply from the compatible for the 
>> former. A property is fine for the latter case.
> Yes, it is SoC dependent in principle, but we would like to use a
> unified compatible string for MT8196 and subsequent SoCs as mentioned

Also no :(. Use SoC specific compatible.

> above, and this register setting(not relavant with new tx/rx) may be
> variant. Therefore, want to use the property of device tree to set
> individually.
>>
>>> +    minimum: 0
>>> +    maximum: 0xf
>>> +
>>> +  mediatek,pop-en-cnt:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description:
>>> +      Some SoCs need to set appropriate pop-en-cnt to configure
>> the margins of write
>>> +      and read pointers while begin to pop data transfer. The
>> valid range is from 0
>>> +      to 0xf.
>>> +    minimum: 0
>>> +    maximum: 0xf
>>
>> Same question.
> Same as the reply above.
>>
>>> +
>>> +  mediatek,prohibit-gate-cg:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description:
>>> +      Decide if source clock CG could be disabled when CPU access
>> IP registers.
>>> +      If present, source clock CG could not be disabled.
>>> +      If not present, source clock CG could be disabled.
>>
>>
>> Sounds like you need to describe the clock in "clocks".
> It is not with clock itself, but rather with the bus design that would
> check the 'source_cg' status bit to decide whether to prevent the CPU
> from accessing the IP registers. And there have been no changes to the
> 'source_cg'(already been descirbed before) for MT8196.

I don't understand why do you need this property if it was already
described. Please do not describe things twice.


Best regards,
Krzysztof

