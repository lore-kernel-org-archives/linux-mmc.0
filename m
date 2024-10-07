Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8491B5EDE;
	Mon,  7 Oct 2024 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295978; cv=none; b=cE2uEkW//xm/I0QPbcebg74rD7wTZZfePxinm3hlyLcaluNa1k1/qjkpPpMfDVUn0KsyC4mn0i/41gDTwbiUf18PzEWr0ThE5RhC5unr4U/ZNaKWd/tnPf/Wtag/7e01eY+u9hsuj9B90vomXFicboBJGKmuZw4m1PYZm/NqIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295978; c=relaxed/simple;
	bh=uX9MuZyTAsy4ZwdDWDKwMwzG+/9sWZbBeG99JoLQaCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8106wWKIT1cGoJO8Xz29iNvtZ7UkQA/+41IYWrCqqe6p2wDfijjZH9pSoAVd5SE2aSWaAgt5nF/6o5n/p1YuYqIExPy3dfE0t1cvjQUCP5tkitzdLwooRw4X2t04kzIRQsgL/6N2bQzOLPIfRVSaoVAwIdsxtETHDmoHPDBHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PxAJhh/N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PxAJhh/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728295974;
	bh=uX9MuZyTAsy4ZwdDWDKwMwzG+/9sWZbBeG99JoLQaCQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PxAJhh/NsDp5f2eWZN0zCO0G8kricMgKpRZOIklpJ5n71qrx8yvRD2KddLkcu78WN
	 lN+f0ps82+wUHSyox5r+ms7fwCSFodTdUXT+PXdMXw19DbSqp4GciIbAbBkVNcR/jg
	 Bk6Keb0jmXClqKx1vECROVLKPzbHu+ZaA79oyNj0ln/qseZA0e1ThQEQrR1fmpKUPY
	 xXUDltk6Xv/ViASdbCfTrpUYvnaUKNWpQQkTJo2xpzaZ8ZKNNODjy0NGhs81+D2fcS
	 AiIBGudyOzGzbMGwvFp7Eft9QMgOaWPsxZpSu7ehtTTJokdmrjg6pKP4DLb40zFFJd
	 nK2hnthAAH9sQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 089E817E120E;
	Mon,  7 Oct 2024 12:12:53 +0200 (CEST)
Message-ID: <f072a20b-abc1-4da9-b03c-fb384601bc52@collabora.com>
Date: Mon, 7 Oct 2024 12:12:53 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Frank Wunderlich <linux@fw-web.de>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-2-linux@fw-web.de>
 <b41c51c4-775c-49ca-84fd-1137b61f42d5@collabora.com>
 <trinity-6fcf3e00-393c-48ee-9aae-26057be08645-1728289985089@3c-app-gmx-bap03>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <trinity-6fcf3e00-393c-48ee-9aae-26057be08645-1728289985089@3c-app-gmx-bap03>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/10/24 10:33, Frank Wunderlich ha scritto:
> Hi
> 
>> Gesendet: Montag, 07. Oktober 2024 um 10:00 Uhr
>> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
>> Betreff: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
>>
>> Il 06/10/24 17:34, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add binding definitions for mmc on MT7988 SoC.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>> v2:
>>> - fixed minItems to 4
>>> ---
>>>    .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
>>>    1 file changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> index c532ec92d2d9..7380f72ea189 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>>> @@ -21,6 +21,7 @@ properties:
>>>              - mediatek,mt7620-mmc
>>>              - mediatek,mt7622-mmc
>>>              - mediatek,mt7986-mmc
>>> +          - mediatek,mt7988-mmc
>>>              - mediatek,mt8135-mmc
>>>              - mediatek,mt8173-mmc
>>>              - mediatek,mt8183-mmc
>>> @@ -263,6 +264,29 @@ allOf:
>>>                - const: bus_clk
>>>                - const: sys_cg
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - mediatek,mt7988-mmc
>>
>> Are you really sure that you can't reuse the MT7986 compatible?
> 
> have not found a way to reuse mt7986 binding because clock-config is different...
> from driver view we can use the mt7986 compatible, but from binding view it is different.
> 

Okay, that's fair.

> regards Frank
> 
>> Cheers,
>> Angelo
>>
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 4
>>> +          items:
>>> +            - description: source clock
>>> +            - description: HCLK which used for host
>>> +            - description: Advanced eXtensible Interface
>>> +            - description: Advanced High-performance Bus clock
>>> +        clock-names:
>>> +          minItems: 3
>>> +          items:
>>> +            - const: source
>>> +            - const: hclk
>>> +            - const: axi_cg
>>> +            - const: ahb_cg
>>> +
>>>      - if:
>>>          properties:
>>>            compatible:
>>
>>
>>


