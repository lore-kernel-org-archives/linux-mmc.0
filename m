Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011324317E;
	Mon,  7 Oct 2024 05:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728280535; cv=none; b=b/KxS7ny4YRKoP9RBYV25T1TxXDdnPoi97qw9BuF8ym0SDSCJlWnVfT8ypv3wFUavqcHQfjMrbVL708x1tTaCgZtp3h+Ne5bPNUlABAN9zjthS1BM2v5qK99xd32IpTW/sAg1tUNEStvI1NA89LCIfIVBMEMDrvRKG4FI5PTco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728280535; c=relaxed/simple;
	bh=J9urfxcnqXo+r0zVu4pjopmJJlcc42dMLRF/ElIUMkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3IoVKItbl3CskKtKuin6Zi5vma2nBoS+BOy75Y9nF3/m1eRW1wTqYtCDAaiVuWnHq32upt3H5OlPZ5snjhe+UmOx8NVzchlSVpeMXqUi8bTuhphAb0eFyj3V12jEanWdjzMB/J1yBzdy9bKeLzoGqYQEpLQXqluepW+1NZL5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DY3f0qxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DY3f0qxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F46C4CEC6;
	Mon,  7 Oct 2024 05:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728280534;
	bh=J9urfxcnqXo+r0zVu4pjopmJJlcc42dMLRF/ElIUMkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DY3f0qxjV4sArWNZ9Uh4gBWFawn2qn7GxWNq+6iDQHf6HBaFRq5fL51AQ/jU/kUEB
	 Li/7P9CwZXcjAgJesInKE0mRUrHEvH8juB657T1Br3QDOVNFiyoTHbtYwm3H23SMfm
	 UjPYzSO2ZOgLMya0Jt1OUuG2wvKwOuDkz9SAQvCKxOb7ioF1nVo05IVauxLq4DS/tf
	 77bJ+51qOjlI+n1DqUxWSGcPbddXWZoIfQPM1crASG5mx2hJd2yDB4Di/rxjSjwK2V
	 FdQgRt4NeiGFypEtkjKkcYObzrkngGS9VTCR/TSoLRI5wMZhRua9o2vAcqIGDVWv2E
	 3eJaBfnk+fV1A==
Date: Mon, 7 Oct 2024 07:55:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wenbin Mei <wenbin.mei@mediatek.com>, 
	Frank Wunderlich <frank-w@public-files.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com, 
	ansuelsmth@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
Message-ID: <p7lqqhet6ahmvieh5xaws6ugsnasmuw6k4oajkmfcctuhrs4dn@quvrkmyof5ss>
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241006153447.41377-2-linux@fw-web.de>

On Sun, Oct 06, 2024 at 05:34:45PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add binding definitions for mmc on MT7988 SoC.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - fixed minItems to 4
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index c532ec92d2d9..7380f72ea189 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -21,6 +21,7 @@ properties:
>            - mediatek,mt7620-mmc
>            - mediatek,mt7622-mmc
>            - mediatek,mt7986-mmc
> +          - mediatek,mt7988-mmc
>            - mediatek,mt8135-mmc
>            - mediatek,mt8173-mmc
>            - mediatek,mt8183-mmc
> @@ -263,6 +264,29 @@ allOf:
>              - const: bus_clk
>              - const: sys_cg
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7988-mmc
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 4

Drop

> +          items:
> +            - description: source clock
> +            - description: HCLK which used for host
> +            - description: Advanced eXtensible Interface
> +            - description: Advanced High-performance Bus clock
> +        clock-names:
> +          minItems: 3

This is still wrong... anyway, drop.

Best regards,
Krzysztof

