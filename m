Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF35209681;
	Thu,  6 Mar 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252797; cv=none; b=nygXyFWD7yOuqqcEMWMnlIxbfY1n/KcJX9vD/D0BL69pxbYgJ+kF5EwPox0A8PNu4jxuFDUAUwgmjq3oMaQNf0FQyon107HEXB+SmyhiYzRL+mKalMW0+QRHxP4m+FZVDUsm8ZXsmHs1spRvw/I14bGOH4owK2iQ9niV8bmQDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252797; c=relaxed/simple;
	bh=HaJSPixWk9LaPQTM/7v8ziJlqwgqjQtFlWD0716NMgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBF8P6L6iR307HlPTVR2kXl0Xtag1fktMlw5sL6qX507ccWo5QMaiA8CneAJrfmWGMHns8RaXudM8K2j9nSYUVdJItzDq49IoWkBW8X0doKDcOvHif6LkMoEOwZMZvLzUfhPXAOb7YAQ1N3e2iHi9F9XOTLsHJoJcdPCLAiJbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YEpxC2nf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YEpxC2nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741252793;
	bh=HaJSPixWk9LaPQTM/7v8ziJlqwgqjQtFlWD0716NMgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YEpxC2nfGB56882Ka73HUj6sruDMJS5dK4rsbbJv3CacywU3xGTS+fkvrsZkHN5ix
	 JmSBie5uIbZyfaKJlQoIVqh+UzbjQaLGSqTF9DkOKU6nMwUSqZjZhiBzyL5mpUO42Q
	 +7DXScC4/SVm+y6d1jpa/s3rjPxq3BnifGor7uqhPacQ5WVLt00Ghx0UmtHGLTE/y6
	 CJcBrCTG8X+XI/GoszYcMqAkTwljE6Qezxbdo+ADxKoAZEYuu3+kvzBXk2TjNroPAz
	 6cMigYwHRGF+5V5EAV21ybE+9Ah9b2ddxTJ4L9y274KsmskIPFyxmIq0pSUIMkEtJK
	 RH52QjaWQugFg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6C53D17E0599;
	Thu,  6 Mar 2025 10:19:52 +0100 (CET)
Message-ID: <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
Date: Thu, 6 Mar 2025 10:19:51 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
To: Axe Yang <axe.yang@mediatek.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: yong.mao@mediatek.com, qingliang.li@mediatek.com,
 andy-ld.lu@mediatek.com, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250306085028.5024-1-axe.yang@mediatek.com>
 <20250306085028.5024-2-axe.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250306085028.5024-2-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/03/25 09:48, Axe Yang ha scritto:
> Add 'mediatek,disable-single-burst' setting. This property can be
> used to switch bus burst type, from single burst to INCR, which is
> determined by the bus type within the IP. Some versions of the IP
> are using AXI bus, thus this switch is necessary as 'single' is not
> the burst type supported by the bus.
> 
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

I am mostly sure that this is not something to put in devicetree, but as
platform data for specific SoC(s), as much as I'm mostly sure that all of
the instances of the MSDC IP in one SoC will be *all* using either single
or INCR.

So, I think I know the answer but I'll still ask just to be extremely sure:

is there any MediaTek SoC that has different IP versions for different MSDC
instances, and that hence require single burst on one instance and INCR on
another instance?

And if there is - is there a pattern? Is it always SDIO requiring INCR or
always eMMC/SD requiring it?

Regards,
Angelo

> ---
>   Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 0debccbd6519..6076aff0a689 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -100,6 +100,14 @@ properties:
>       minimum: 0
>       maximum: 0xffffffff
>   
> +  mediatek,disable-single-burst:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Burst type setting. For some versions of the IP that do not use
> +      AHB bus, the burst type need to be switched to INCR.
> +      If present, use INCR burst type.
> +      If not present, use single burst type.
> +
>     mediatek,hs200-cmd-int-delay:
>       $ref: /schemas/types.yaml#/definitions/uint32
>       description:



