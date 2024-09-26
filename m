Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8151494AC;
	Thu, 26 Sep 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373251; cv=none; b=AfJn5Jz/bFNH04zLgSnAZBmEe/4qPp/8VAHVNfQxkNmsAzZkqIXSiHMPtVN/PUpqC/hxXQ0LbAuwlsDap0+sE46z9ZPeqljoJtawo+/U1uPmx7RWP+RV9enu1c9HkJlvDXCJolMraSTvRsB67fXVBjY1c4+Rq1gaemtsHPW5EzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373251; c=relaxed/simple;
	bh=lXPOdfXYiJSIOPk0X98x8wE/c1zTD2p+6mktwIChUvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMRIUaBfGFK0U47WGsnuKYklwfkXuvkY40PddeWavL8sK5E3BJ5gxcHt+3ZsOFJe6nigUkpwKyecTvoqyIAEuwdl8RvBs/CkqqdsYYbu5hwGB3iqp7uw+6QPGLzvuncV5FOcAdXu+qV8FbPCbX2nPfihPenAPPsyJHN+MlbX78c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN3H9Etl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN3H9Etl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4071C4CEC5;
	Thu, 26 Sep 2024 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727373251;
	bh=lXPOdfXYiJSIOPk0X98x8wE/c1zTD2p+6mktwIChUvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PN3H9EtlobMXbvdAL8DZSVOktwc+8F2pVFoTxbCmf+WKXMxcp6MyHaQledrpLJhvo
	 8sN9UElr0KicTKG0wJEZm1pVQvJFOtmX4aybnrkpJ/Qb9a0Y8gnnKDaQVH2CgBtFH+
	 k1r0ST6uwj3gtmhHXxffEefApV23sS+XTmFv3k1RokhidAXtIjA1AjZKiqBFoeoOzf
	 ZsDbj9VUwa8nNx3wfJawSbJzSaWpCCj3iLEc/dA3+7O8FBxkllH7x9VScC2EAzZM3f
	 W7JW5RmfHCGB+xRqGrB7FWIiSOYPoRH1bcXR6b7LRW01SV3KOq28FyYRNk1pZKZgDh
	 sDHAqWFwm1HsQ==
Date: Thu, 26 Sep 2024 12:54:09 -0500
From: Rob Herring <robh@kernel.org>
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: ulf.hansson@linaro.org, krzk+dt@kernel.org, matthias.bgg@gmail.com,
	wenbin.mei@mediatek.com, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Message-ID: <20240926175409.GA2644361-robh@kernel.org>
References: <20240926070405.20212-1-andy-ld.lu@mediatek.com>
 <20240926070405.20212-3-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926070405.20212-3-andy-ld.lu@mediatek.com>

On Thu, Sep 26, 2024 at 03:03:18PM +0800, Andy-ld Lu wrote:
> Extend the devicetree bindings to include the MT8196 mmc controller
> by adding the compatible string 'mediatek,msdc-v2', which could be
> also used for future compatible SoCs that support new tx/rx.

Generally, every SoC ends up changing at least slightly. So we don't do 
version numbers except when there's a well defined versioning scheme of 
the h/w (e.g. FPGA IP blocks). So, use SoC for compatible string.

> 
> Add three properties for MT8196 settings:
> - 'mediatek,prohibit-gate-cg', indicate if the source clock CG could
>   be disabled when CPU access IP registers.
> 
> - 'mediatek,stop-dly-sel', configure read data clock stops at block gap.
> 
> - 'mediatek,pop-en-cnt', configure the margins of write and read
>   pointers while begin to pop data transfer.
> 
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
> ---
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> index c532ec92d2d9..82d1a9fac67c 100644
> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> @@ -25,6 +25,7 @@ properties:
>            - mediatek,mt8173-mmc
>            - mediatek,mt8183-mmc
>            - mediatek,mt8516-mmc
> +          - mediatek,msdc-v2
>        - items:
>            - const: mediatek,mt7623-mmc
>            - const: mediatek,mt2701-mmc
> @@ -154,6 +155,30 @@ properties:
>      enum: [32, 64]
>      default: 32
>  
> +  mediatek,stop-dly-sel:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some SoCs need to set appropriate stop-dly-sel to configure read data clock
> +      stops at block gap. The valid range is from 0 to 0xf.

SoC dependent or board dependent? Imply from the compatible for the 
former. A property is fine for the latter case.

> +    minimum: 0
> +    maximum: 0xf
> +
> +  mediatek,pop-en-cnt:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Some SoCs need to set appropriate pop-en-cnt to configure the margins of write
> +      and read pointers while begin to pop data transfer. The valid range is from 0
> +      to 0xf.
> +    minimum: 0
> +    maximum: 0xf

Same question.

> +
> +  mediatek,prohibit-gate-cg:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Decide if source clock CG could be disabled when CPU access IP registers.
> +      If present, source clock CG could not be disabled.
> +      If not present, source clock CG could be disabled.


Sounds like you need to describe the clock in "clocks".

> +
>    resets:
>      maxItems: 1
>  
> @@ -191,6 +216,7 @@ allOf:
>              - mediatek,mt8188-mmc
>              - mediatek,mt8195-mmc
>              - mediatek,mt8516-mmc
> +            - mediatek,msdc-v2
>      then:
>        properties:
>          clocks:
> -- 
> 2.46.0
> 
