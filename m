Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2F1FDD;
	Tue, 25 Mar 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898055; cv=none; b=AFhngvthKh1yfDqPY3IztNM+U+cfgNkJR0zg9QE+fYPR1kkQeK2DarpN52mq1mccCRKSAo0r05FSaDQHkQ4DsdcVtr6zW/KyYgwkZKzpuYuU5jONdv/sBSXIcden8WRTe4kO25Q09yf24oWlQ8RrNy5z7kETkffILMEVErg+htY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898055; c=relaxed/simple;
	bh=xj2m28Ti0TkvOIJe8EXIP8rCVJJiSJ2Q+cPMUlJtiLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRg5nhp1grNA7nLU1NKo87Jkg8PrlfZrzy7vj5v422z3tQlNhTEcyw+eHC+kw3OgM2rmj6cQhJ1C+eeysKT7i/ZOxGBjeMHDT7Z0QbPPbq9q9dKi7uJu79EFT6mqOu7ztgigCse2ZIPcevRLyi61ue58w9xfqrB7XPt4CInePI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ayS+QmiN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ayS+QmiN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742898050;
	bh=xj2m28Ti0TkvOIJe8EXIP8rCVJJiSJ2Q+cPMUlJtiLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ayS+QmiNet5Hdbi6IDs8ib9eCDd79/eaAeVdfdZcC1I5YOhAqjYfTyjc7ZCVMrOJ1
	 pgSUDVJ7Jst0sQ+6KsrfMj4+eKvPIpT57QAwmk3wNPYQEveORlc5dRpxolndKWBs+/
	 Wh10I0ufahc/DzN1UWdPZkAcdx3XYA8ZEGCCkYsxOVORh/0Fc66qeTeidJelMjpEQ+
	 kzl3LwxzN5Rd5BValTtzB16mqaEcJab/tyOEpkNYETN0fe9DFR6i6I2jwFO4A1ImyG
	 21bJfJQ/0HB83kbk/AwzAt7Y85GLGneMlLmCQONOiD40wLM/SgZgJE/4FR09JsrAwL
	 NLUdY0y9KHoLg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 35A2017E0A5C;
	Tue, 25 Mar 2025 11:20:49 +0100 (CET)
Message-ID: <3572d6e2-8950-4937-bed5-624bf5bde7f3@collabora.com>
Date: Tue, 25 Mar 2025 11:20:48 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
To: =?UTF-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>,
 =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
 <Chaotian.Jing@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 =?UTF-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 =?UTF-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
 <20250306085028.5024-2-axe.yang@mediatek.com>
 <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
 <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>
 <b09f618a-eaf9-4258-ae2d-67eff1cb249f@collabora.com>
 <f8ce830d831aaba0d2748d31f8ba4a9915b7a14e.camel@mediatek.com>
 <52d2f247a3058b96625bcdf5ab370282dfc9fb0e.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <52d2f247a3058b96625bcdf5ab370282dfc9fb0e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/03/25 03:41, Axe Yang (杨磊) ha scritto:
> Hi Angelo,
> 
> Any comment on this :D
> 

Check inline reply below....

> Regards,
> Axe
> 
> On Wed, 2025-03-12 at 14:30 +0800, axe.yang wrote:
>> On Tue, 2025-03-11 at 10:47 +0100, AngeloGioacchino Del Regno wrote:
>>> External email : Please do not click links or open attachments
>>> until
>>> you have verified the sender or the content.
>>>
>>>
>>> Il 07/03/25 07:59, Axe Yang (杨磊) ha scritto:
>>>> On Thu, 2025-03-06 at 10:19 +0100, AngeloGioacchino Del Regno
>>>> wrote:
>>>>> External email : Please do not click links or open attachments
>>>>> until
>>>>> you have verified the sender or the content.
>>>>>
>>>>>
>>>>> Il 06/03/25 09:48, Axe Yang ha scritto:
>>>>>> Add 'mediatek,disable-single-burst' setting. This property
>>>>>> can
>>>>>> be
>>>>>> used to switch bus burst type, from single burst to INCR,
>>>>>> which
>>>>>> is
>>>>>> determined by the bus type within the IP. Some versions of
>>>>>> the
>>>>>> IP
>>>>>> are using AXI bus, thus this switch is necessary as 'single'
>>>>>> is
>>>>>> not
>>>>>> the burst type supported by the bus.
>>>>>>
>>>>>> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
>>>>>
>>>>> I am mostly sure that this is not something to put in
>>>>> devicetree,
>>>>> but
>>>>> as
>>>>> platform data for specific SoC(s), as much as I'm mostly sure
>>>>> that
>>>>> all of
>>>>> the instances of the MSDC IP in one SoC will be *all* using
>>>>> either
>>>>> single
>>>>> or INCR.
>>>>
>>>> No, actually MSDC IPs in one SoC are using different versions.
>>>> Usually MSDC1 (index from 1) is used as eMMC host, the left hosts
>>>> are
>>>> used as SD/SDIO hosts. They have similar designs, but there are
>>>> still
>>>> difference.
>>>>
>>>>>
>>>>> So, I think I know the answer but I'll still ask just to be
>>>>> extremely
>>>>> sure:
>>>>>
>>>>> is there any MediaTek SoC that has different IP versions for
>>>>> different MSDC
>>>>> instances, and that hence require single burst on one instance
>>>>> and
>>>>> INCR on
>>>>> another instance?
>>>>
>>>> Yes. Actually every SoC has different IP versions for eMMC and
>>>> SD/SDIO
>>>> host as I said.
>>>> e.g. For MT8168, signel burst bit should be set to 1 for eMMC
>>>> Host,
>>>> but
>>>> 0 for SD/SDIO Host.
>>>>
>>>>>
>>>>> And if there is - is there a pattern? Is it always SDIO
>>>>> requiring
>>>>> INCR or
>>>>> always eMMC/SD requiring it?
>>>>>
>>>>>
>>>>
>>>> No, there is no pattern. Both eMMC and SD/SDIO hosts need to be
>>>> configured base on IP version. There is no binding relationship
>>>> between
>>>> eMMC/SD/SDIO and the burst type. eMMC burst type might be INCR or
>>>> single, same as SD/SDIO.
>>>>
>>>
>>> Okay but if there are different IP versions, and AXI/AHB is
>>> determined
>>> by the IP version, why aren't you parsing the MAIN_VER/ECO_VER
>>> registers of
>>> the MSDC IP to check whether to use INCR or SINGLE?
>>
>>
>> To address your concerns, I had further discussions with the
>> designer.
>> Their response was that the bus type and IP version are not bound
>> together. This contradicts my previous statements, and I apologize
>> for
>> that.
>> According to the designer's feedback, I must say that the single
>> burst
>> setting is indeed tied to the IC, but the granularity is such that it
>> needs to be set individually for each host.
>> Given the large number of ICs Mediatek currently has, adding burst
>> type
>> information for each host to the driver's compatible structure would
>> mean adding hundreds(maybe thousands :() of lines to the driver for
>> the
>> compatible structures for *all previous SoCs* (currently there are
>> only
>> 13 compatible structures, and they can be reuse by new SoC). This
>> approach seems very cumbersome.
>>
>> So I still believe that placing this setting in the DTS is a more
>> appropriate approach.
>>

Hello Axe,

sorry for the wait - this email fell through the cracks and I didn't see
it at all, so thank you for the ping.

Unfortunately, I don't think that this would be acceptable from a devicetree and/or
bindings standpoint, but then you don't really need to modify the pdata for all of
the currently supported SoCs to declare false, as false==0, which is the default.

But maybe there's another way out of this.

You said that this modification is done because some controllers are under AXI and
some others are under AHB... I was doing some cleanups to this driver and doing so
made me check a couple of things....

When a MSDC controller is under AXI, there will be configuration for that in other
registers - specifically, I'm wondering if the EMMC50_CFG2 register can be used to
check if we are under an AHB to AXI wrapper or not.

The idea is to read this register (offset 0x21c), [27:24] AXI_SET_LEN contains the
number of beats per burst (from 1 to 16), and also [23:19] AXI_RX_OUTSTANDING_NUM
contains the number of outstanding transfers (1 to 13).

If a controller does not have an AXI2AHB Wrapper, or if it does not use the AXI bus
this register should read zero I think?

Especially the two fields that I mentioned before, those should read zero.

That, especially because the hwaddr for the controllers is anyway and always long
0x1000 - and I think that the extra registers space, on controllers that don't have
the EMMC50 registers (msdc1 and msdc2) should be still reserved to those and never
used for anything else.

Would that detection way work?

If it would, we'd be again autodetecting whether to set or not the AXI single burst
option in the patch bits...without relying on specifying anything manually, not in
the devicetree, and not in the platform data :-)

Cheers,
Angelo

>> Regards,
>> Axe
>>
>>>
>>> Cheers,
>>> Angelo
>>>
>>>>
>>>> Regards,
>>>> Axe
>>>>
>>>>
>>>>>
>>>>>> ---
>>>>>>     Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 8
>>>>>> ++++++++
>>>>>>     1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-
>>>>>> sd.yaml
>>>>>> b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>>>>> index 0debccbd6519..6076aff0a689 100644
>>>>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>>>>> @@ -100,6 +100,14 @@ properties:
>>>>>>         minimum: 0
>>>>>>         maximum: 0xffffffff
>>>>>>
>>>>>> +  mediatek,disable-single-burst:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>>> +    description:
>>>>>> +      Burst type setting. For some versions of the IP that
>>>>>> do
>>>>>> not
>>>>>> use
>>>>>> +      AHB bus, the burst type need to be switched to INCR.
>>>>>> +      If present, use INCR burst type.
>>>>>> +      If not present, use single burst type.
>>>>>> +
>>>>>>       mediatek,hs200-cmd-int-delay:
>>>>>>         $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>         description:
>>>>>
>>>>>
>>>>>
>>>
>>>


