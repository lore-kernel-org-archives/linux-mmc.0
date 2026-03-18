Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E81F1537
	for <linux-mmc@vger.kernel.org>; Wed, 18 Mar 2026 23:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874848; cv=none; b=OUersfrnTcJu9QL8sN6+saMqwy/tex7PfuZ48KK/cbujFhg03jq4YOlF8165N8Z9ooE3sjuy3ajhPQ1uWrk1hGN2G6RMrMxQv9j+4l6yj/dEyVVqrvfZZGNTjw0u07M4jLce8ZlvLoPj9rdsjwexp6+jmobBnPbdIMKuB7Oga94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874848; c=relaxed/simple;
	bh=NvYYBRGAeWtKVYoN67ySXdYRyGcLlgtmbG657mYPVhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTgB+uDc00xtXOXKjoEyVi0O5D3vzpF9rxExxHxcgPfb4YO32GN6azBdFJnkffbPyhzZUsVY92K7+4yFusM7ZQllXIIiupu8PP4P3ImKu5pFwWbL/bq7lgljasT4/Zk33HyPafda7IbfSvukknMUJM644HAx/lXT2iDnppXBCdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OE8gDemK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OE8gDemK"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d750eeaec3so186536a34.0
        for <linux-mmc@vger.kernel.org>; Wed, 18 Mar 2026 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773874845; x=1774479645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXk/XAl/MQx/OXuZk0UOeHJIU6eSq8cRls/Q/FJTwAA=;
        b=OE8gDemKQzGDMIqqw4/3ZwA/2dH4vME+TPVVaSXxcbmtON7tpc5uPP8KPMNPFuEgDh
         30LrUqeV5c5XmkGg3bJxkTp73tUxIk1NgLiUfRkCzfusoiNX0csnXrnjz73cFcefgSTz
         GPa/Yh5AWYZ4zKoZaf1Zi4DWJobSclbMAI5GrJSuC28yo7mOWWmvy8yzTkIjFwuyvtIB
         EKbUGZipAsA0VWJRa7qIKLN6M10fuXfkIvYnP61c+cYF59HRdx4fU1b7EUBPlnVKD1jc
         bhcl6KAHckiUsGwjXexy3HQ3Rb+vIA1bzkfOXIrCUAKS/cq4lwSBKJzOB3zQMc20ksnv
         SxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773874845; x=1774479645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXk/XAl/MQx/OXuZk0UOeHJIU6eSq8cRls/Q/FJTwAA=;
        b=s+xBIswRKkpu8KAtE09ScdiItJvXh1YeYfmKC6M28RyV4mqA7E7XyUuSuDg2B+jGTF
         nGKQDmyZDFuke8vVUMwu5uWr4fiUCyXKkT9h4NePNhmxgvx54oWZ2qdPtVmOa9b3cTe7
         1mve8RKK06NTHLAge43kRl27LCuAWvUcTPDnvS260BMsLUpEYtjb1TzwN0caokDpHtpe
         R8mxUdnFkDDxz7XLC7C5wQhUexSdUPHsPogUMQC0qtVLyz+Uzx7OpsoxV+m5tjsx7Ytp
         ta4eqE5eSV4hAa5us61i1aFkNh3uzVJt4pYW9wGxDVb+Wo/j0oJSiKpndGnEXN09DZN9
         oMRg==
X-Forwarded-Encrypted: i=1; AJvYcCWYeezaQZWK2GVlkMWY+1PYcHfhdUznAMkJNxWEhzyHDZG1xCobJ0Rb/UtqiM3KTOOApeetY0DPlqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMk6GXCg/hLo2G9VCa+3dCzBAYNNaoYxaTRxZETX19kUeNsymW
	1Ge2pbmIVv9FZCQwBJV0qyvcteCUP+DiyHBqZHJfEOtUoBNkj4Kv1CdFUoZ61XdXorA=
X-Gm-Gg: ATEYQzyokKYSU4MwaLYHNemrZrsVzJ4J9wdIlB/3cEAsXDBXK0sKUY4zFiGOS0tUqEi
	Hd0fTqR2MCCq0iNPeXX/KTTU6R6+Bcn0Uvy28mke99U+w9kEJcB1xG98ARfviZRdn1iAcFz7u94
	4h/awv7KZoItEsTOoyS4f/Hbui1/7/ghj/E1//2r59Y5GQ/DByd5zn2GRou0Ok9ljidcP1ljzLE
	tyztjKZNq5VTyOYKBlLZBQ6qI1sdjFpQC4zlrkdE7MErEyPNEOcmh63pwM4eKQ6ANYvED5PGFbz
	6R+xsJLV8QGXrUtyO8jZ2KF26GNdiu863McM6dgFan5hBGqBxVnQy/6cm8B8SApQBhMrc51vMYc
	p7Bqwz4dbX7aTwWbPl0amPJs6n4SnoAQ7nz81auCbjXnU6l8OW8sDj+sXRLMTp2ZyXkgAt0QlIj
	NV8HbuLs+XqX3aTgGhkzkg1HtS8itgNjFFna3kAp2YTdLMJhu40wRKT7HCgtgqkAKr56gXyxfTX
	g==
X-Received: by 2002:a05:6830:730e:b0:7d7:4921:897d with SMTP id 46e09a7af769-7d7ca2bda63mr2987245a34.0.1773874845232;
        Wed, 18 Mar 2026 16:00:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:244c:fc8c:8216:1344? ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9950d99sm3182160a34.6.2026.03.18.16.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 16:00:43 -0700 (PDT)
Message-ID: <4cb07b9a-249a-4c13-b09a-6dac9f72265d@baylibre.com>
Date: Wed, 18 Mar 2026 18:00:42 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: mmc: mtk-sd: Add support for MT8189 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>
Cc: kernel@collabora.com, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
 <20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251203-mt8189-add-mmc-support-v1-1-f5ce43212fe9@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 5:45 AM, Louis-Alexis Eyraud wrote:
> Add a new compatible for MMC IP in MT8189 SoC.
> Even though this is partially compatible with the one found in MT8196
> SoC, the MT8189 SoC register layout has some slight differences and
> additional features.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index 6dd26ad314916a3e40cf55ff69a7d93ed63dbdd4..eb3755bdfdf7e001602c3eb870898275085df3e6 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -25,6 +25,7 @@ properties:
>            - mediatek,mt8135-mmc
>            - mediatek,mt8173-mmc
>            - mediatek,mt8183-mmc
> +          - mediatek,mt8189-mmc

I think this can be in the group with fallback to mediatek,mt8183-mmc.

I was able to make it work on U-Boot just using the existing match
for "mediatek,mt8183-mmc" there.

>            - mediatek,mt8196-mmc
>            - mediatek,mt8516-mmc
>        - items:
> @@ -192,6 +193,7 @@ allOf:
>              - mediatek,mt8183-mmc
>              - mediatek,mt8186-mmc
>              - mediatek,mt8188-mmc
> +            - mediatek,mt8189-mmc
>              - mediatek,mt8195-mmc
>              - mediatek,mt8196-mmc
>              - mediatek,mt8516-mmc
> @@ -240,6 +242,7 @@ allOf:
>                - mediatek,mt7986-mmc
>                - mediatek,mt7988-mmc
>                - mediatek,mt8183-mmc
> +              - mediatek,mt8189-mmc
>                - mediatek,mt8196-mmc
>      then:
>        properties:
> 

