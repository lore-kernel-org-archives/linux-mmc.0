Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D181B3F1F;
	Mon,  7 Oct 2024 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296103; cv=none; b=fNjeKgDg22rqZRB+LHewZOdIe8YClfsQbbdYHxNU570XJr6Cl+p0a88sHisM63de20mjhN48QsxjKKxSYjzEKPYfLFeSTKyofsrXBkYdVfBYfujAPzNe3sOO47Dg3YC2vEJvnxtsJcLxvRcv7k7bz9GesMvPKCkhxGNr7Uj4L0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296103; c=relaxed/simple;
	bh=yuxB0ScFBvA5iGHvK/eJWsI8vouvpQMIaMlt77HeU8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf9CnbeRLD9pvxosNqQN9Cbp+vhR07uU7XPdy/X7m/dcNsGJsId4Zt3X9Cw1rYXNY6Jz5XBCOYQYlg/UIXDfxT8+ZnRCKUNnCLJ2z7TTNFfJMwpIHnIpaVEqQkqVsrrYAEdgc/Lv0SQdAx0GHKG1BADS29DaDV0U5tovN5DbzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Iijidlpu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Iijidlpu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728296099;
	bh=yuxB0ScFBvA5iGHvK/eJWsI8vouvpQMIaMlt77HeU8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iijidlpu6bar59WUE05h2ibAszTqyDjP+Eun50NWrm0Ej2h+tAh1oj+rS3WRAqBJ4
	 3PFdNKluA6XFdGiJgr9WOZt0wJZoKn9nrp95lOfCE8AZLBD8LkQYu7SVh4zLM3DXCx
	 d44y4qR+ptKlKGOLd1nLhvLyHMJLQZYhSVnQ+fNxu6m6v3dqrHwQWPquYLNpX0EgOq
	 n/x+DPZ7wE/KlXEM27+YwIiSsGxX3e6/QSgbXb/WQaEMLPchYISMRYi9yqO+xJQUdn
	 R3rqGIJIS/iUM4wilOWhuIvVFeJZA2AcVrl1a1BlIji1HJbKRGSpIGT63rEbRuF+OU
	 YqLxdzdWafxfQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0C1717E1201;
	Mon,  7 Oct 2024 12:14:58 +0200 (CEST)
Message-ID: <272309da-24ff-49cd-9e4b-287054218cbc@collabora.com>
Date: Mon, 7 Oct 2024 12:14:58 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for mt7988
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
 <20241006153447.41377-3-linux@fw-web.de>
 <89e54baa-0f05-47d7-8d81-68862f822c59@collabora.com>
 <trinity-2ac8c3fe-ad19-424b-ab4f-da84c42c4ae1-1728290266613@3c-app-gmx-bap03>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <trinity-2ac8c3fe-ad19-424b-ab4f-da84c42c4ae1-1728290266613@3c-app-gmx-bap03>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/10/24 10:37, Frank Wunderlich ha scritto:
> Hi
> 
>> Gesendet: Montag, 07. Oktober 2024 um 09:58 Uhr
>> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
>> Betreff: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for mt7988
>>
>> Il 06/10/24 17:34, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add support for mmc on MT7988 SoC.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> There's no need to add yet one more duplicate mtk_mmc_compatible platform
>> data, nor one more compatible string to this driver, as this is exactly
>> the same as mt7986.
>>
>> Please reuse the MT7986 compatible; in DT you'll have:
>>
>> compatible = "mediatek,mt7988-mmc", "mediatek,mt7986-mmc";
> 
> as explained in binding, the clock config is completely different (except first 2 also required by driver - 3-7 are optional there). mt7988 uses axi and ahb clocks.
> 
> but i could of course use the mt7988 compatible with mt7986 compat data...but looked dirty to me so just copied the block (to allow later changes if needed).
> 

In case there will be any changes required *later*, you can always add new platform
data for the MT7988 compatible, as it's just only a code change and nothing else.

For now, since they're the same, just reuse mt7986_compat.

Reusing is way better than duplicating - here and everywhere else - especially when
this implies a 100% duplication.

>> Cheers,
>> Angelo
>>
>>> ---
>>>    drivers/mmc/host/mtk-sd.c | 14 ++++++++++++++
>>>    1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>>> index 89018b6c97b9..6d5afe51a61d 100644
>>> --- a/drivers/mmc/host/mtk-sd.c
>>> +++ b/drivers/mmc/host/mtk-sd.c
>>> @@ -571,6 +571,19 @@ static const struct mtk_mmc_compatible mt7986_compat = {
>>>    	.support_64g = true,
>>>    };
>>>
>>> +static const struct mtk_mmc_compatible mt7988_compat = {
>>> +	.clk_div_bits = 12,
>>> +	.recheck_sdio_irq = true,
>>> +	.hs400_tune = false,
>>> +	.pad_tune_reg = MSDC_PAD_TUNE0,
>>> +	.async_fifo = true,
>>> +	.data_tune = true,
>>> +	.busy_check = true,
>>> +	.stop_clk_fix = true,
>>> +	.enhance_rx = true,
>>> +	.support_64g = true,
>>> +};
>>> +
>>>    static const struct mtk_mmc_compatible mt8135_compat = {
>>>    	.clk_div_bits = 8,
>>>    	.recheck_sdio_irq = true,
>>> @@ -629,6 +642,7 @@ static const struct of_device_id msdc_of_ids[] = {
>>>    	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
>>>    	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
>>>    	{ .compatible = "mediatek,mt7986-mmc", .data = &mt7986_compat},
>>> +	{ .compatible = "mediatek,mt7988-mmc", .data = &mt7988_compat},
>>>    	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>>>    	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
>>>    	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
>>
>>

