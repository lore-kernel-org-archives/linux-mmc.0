Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E2101C4;
	Mon,  7 Oct 2024 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300615; cv=none; b=Wb/Qm5uk9b7i00J6zSkVe1lAvSt2H06eUNaRJBHKZt1qSgIhXRUDpQfEW54hXGOFhwZHHxE6jMHat081UgveBzxOgTk3fbwarYjEXvwq9VDHgf69rvyOdhOBIp5+49DgApAyuHVRSVai1QOPvtJeHAKqf/sIJFZro6xJxlFIH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300615; c=relaxed/simple;
	bh=Rz4+xwYlnejseHEd/Mnd7CZL6xZvLaDMPzooI0qTgmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o892fXTdrPLrIZAoof5y1edjVkTzV+OTiBHchDRiaRlbmHc2Rh+wI8F7YUYrs6ictShqsnKSNN0Df9egpS8k9RtziNZmyMZ2X4gFn0bpOsutKbegoFeP9YM5DH8xLRu8oy2if6j6cCDcd0PInBexVBLQ90NVkrfdjlL0N6OLEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+VYGleb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+VYGleb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D307C4CEC6;
	Mon,  7 Oct 2024 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728300615;
	bh=Rz4+xwYlnejseHEd/Mnd7CZL6xZvLaDMPzooI0qTgmY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f+VYGlebZh0izT4/wpS/jAuaUTaxn4XJzdQWFUUUjyyAoKYN8Dqalm10RaSmeJZWW
	 7DgfSR9zCvSx+tgGzWfO15tA7COUMo5s2dhPCPnZ+7BAlMsH5btJN6OasQpA9PXa1M
	 ET+aqUEQWR8+5UolWB756Aw1oEPrN1Mn1YdEE+XkaEq8yhbPELGohjioLJvbfyQtBI
	 iTed0U7xAlSpvAM7Z/yAaxa+xdRdQOmV22GNyDerGFbbNfMxSXDH4Y9Wh2khSoKUIQ
	 Zd2fuQBRZ66QaavW8BYx10oBSI5cKQI0c4CjbyfJE7vCDiA8QqZWG1i38FYcGQsjdO
	 WQIptI9bu5MsA==
Message-ID: <e6709979-e69e-4b55-be9f-c1353dd8ffc7@kernel.org>
Date: Mon, 7 Oct 2024 13:30:08 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for mt7988
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>
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
 <20241006153447.41377-3-linux@fw-web.de>
 <89e54baa-0f05-47d7-8d81-68862f822c59@collabora.com>
 <trinity-2ac8c3fe-ad19-424b-ab4f-da84c42c4ae1-1728290266613@3c-app-gmx-bap03>
 <272309da-24ff-49cd-9e4b-287054218cbc@collabora.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <272309da-24ff-49cd-9e4b-287054218cbc@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/10/2024 12:14, AngeloGioacchino Del Regno wrote:
> Il 07/10/24 10:37, Frank Wunderlich ha scritto:
>> Hi
>>
>>> Gesendet: Montag, 07. Oktober 2024 um 09:58 Uhr
>>> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
>>> Betreff: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for mt7988
>>>
>>> Il 06/10/24 17:34, Frank Wunderlich ha scritto:
>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>> Add support for mmc on MT7988 SoC.
>>>>
>>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> There's no need to add yet one more duplicate mtk_mmc_compatible platform
>>> data, nor one more compatible string to this driver, as this is exactly
>>> the same as mt7986.
>>>
>>> Please reuse the MT7986 compatible; in DT you'll have:
>>>
>>> compatible = "mediatek,mt7988-mmc", "mediatek,mt7986-mmc";
>>
>> as explained in binding, the clock config is completely different (except first 2 also required by driver - 3-7 are optional there). mt7988 uses axi and ahb clocks.
>>
>> but i could of course use the mt7988 compatible with mt7986 compat data...but looked dirty to me so just copied the block (to allow later changes if needed).
>>
> 
> In case there will be any changes required *later*, you can always add new platform
> data for the MT7988 compatible, as it's just only a code change and nothing else.
> 
> For now, since they're the same, just reuse mt7986_compat.
> 
> Reusing is way better than duplicating - here and everywhere else - especially when
> this implies a 100% duplication.

If you use same match data, then entire change should be dropped because
it is redundant. Instead express compatibility in the bindings and use
fallback.

Best regards,
Krzysztof

