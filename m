Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86671292CE;
	Mon,  7 Oct 2024 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728288054; cv=none; b=bGiNalSEAseKqlv08UbNksozBlpnyATRcUZW5qkTClfD6sbb2nmc7aiXTMvu/9gVBEmLEd5tvQowfOBaKW4dZhnpJ4hOb7LPDZZkfiqUv+ma+UW9AqjYNflC2rzHfSwtEAqiW+EkVVuuzm8uPI3qd+ngaPMb2loTVRo3KML8rRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728288054; c=relaxed/simple;
	bh=+5Ki3Qd+uQCkPFiAQomOVnbgyWWRRbTdJWTqhHlaVq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kU0Xo+58h0ZoCrWbK0aSiqKmum9rl2E/8wQaLd5uPv6eKehUn3Qepb2y6s2k2kN7ImTGV5ctRKhIl1dtKOZILWytXHVp/mtarEk7+uZVR8rm4Eokp3jLgoLPBzVDRnNpgnHPWPzfxuKXJ0yi5sQ3QhZcMRhYaapPI2+i4eddkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RjT9NDll; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RjT9NDll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728288051;
	bh=+5Ki3Qd+uQCkPFiAQomOVnbgyWWRRbTdJWTqhHlaVq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RjT9NDll8qfp1wjFx0DPdEJkWpdQKui1hxY2PaCaHV9TbAah1XFOEYX9ir6cPI6Z4
	 M8tcogeET2C6IzHyqoZvSiPruwky+1RM9m7ro8G48pudLC0J1At0IgME+MtjrjyDTv
	 meAqySur6PPaKEegLuzuEbVnFT4ixqkncq8YSc8va2dzuTnD48CY0+B/7iBH2zVKeH
	 CHPHmCkGngdEpKV5kgtZwh8WdYv5tCtWiiYTf41GO996NZejoo6SJKNuSSD/B4qeuE
	 sZ7vdTloIBTD3/YwSMxVcjUE8GqTiErPxKRGKl43YQypKKbDuMWTr/2mt3cEXMjbJ2
	 50uLKGa8rd/Xw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BF8B17E1083;
	Mon,  7 Oct 2024 10:00:50 +0200 (CEST)
Message-ID: <b41c51c4-775c-49ca-84fd-1137b61f42d5@collabora.com>
Date: Mon, 7 Oct 2024 10:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
To: Frank Wunderlich <linux@fw-web.de>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-2-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241006153447.41377-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/10/24 17:34, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add binding definitions for mmc on MT7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - fixed minItems to 4
> ---
>   .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index c532ec92d2d9..7380f72ea189 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -21,6 +21,7 @@ properties:
>             - mediatek,mt7620-mmc
>             - mediatek,mt7622-mmc
>             - mediatek,mt7986-mmc
> +          - mediatek,mt7988-mmc
>             - mediatek,mt8135-mmc
>             - mediatek,mt8173-mmc
>             - mediatek,mt8183-mmc
> @@ -263,6 +264,29 @@ allOf:
>               - const: bus_clk
>               - const: sys_cg
>   
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7988-mmc

Are you really sure that you can't reuse the MT7986 compatible?

Cheers,
Angelo

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4
> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: Advanced eXtensible Interface
> +            - description: Advanced High-performance Bus clock
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: source
> +            - const: hclk
> +            - const: axi_cg
> +            - const: ahb_cg
> +
>     - if:
>         properties:
>           compatible:


