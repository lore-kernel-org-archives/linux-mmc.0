Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F2221DB3;
	Fri, 11 Apr 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744391137; cv=none; b=FF8SJj1aIldOMa89SaGF7wiLezX869l5Xvjri8RuHAB2dTp3vOwx4Tm9UzhmmgCO7ucFNH9jitVnqSz7rT2LThHnSBUgj6EVIORwwp6lKbmkHo24OmKGBNzedKCuV5vdQe2nWmbv6rrYwGJSnAdL1bdKUYfVdM4C+CYuZrobX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744391137; c=relaxed/simple;
	bh=PfGPVWiR4UxNAnBai380IGxTf6wYvxNfjOD+EC1euOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7Z5m5Zojc/UYnkuNOFm8BeS1IImd4qvCmZd2DLYmkwy+t7+X65vxjWuJiIUE5bRGTDHn9rV4Vhae3UHgfth4asNAV1FvZolnrJHRgPGitM99O3WIwZvxk76gZbfOuCcfJ3oHsw5ZFyr9jnQLvJ87wmEbaI2P+sctj5okxYJATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpWzvNVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpWzvNVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388ABC4CEE2;
	Fri, 11 Apr 2025 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744391136;
	bh=PfGPVWiR4UxNAnBai380IGxTf6wYvxNfjOD+EC1euOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpWzvNVBKx9XHRe+51DoRjU7ms0IuIOGkEOTeLsgNDUTgpHRyxmgj8YC3Jy8KXemv
	 F7laDyJsapjMRpK2ZorpzxPL2LgDaEF/N9Pw1Ws4vD4xWw9uAfJNctQHvUA6/8l26O
	 fdT3N5ZtRefNx9ZgIDFQr2QMuj9PObkUBF+nuvmwFxQ5XrKDp4jDEo9ElcmmqOggv2
	 uniQdCtAs/fXSQFDIdojJmtkSlvE5VXj4jfADsAewD/whBSm/5hDBL42FU2tt1BPqL
	 WyrCGFag3mAsd5d9sSw4k/7T4+dAm2qHkHdN3QG2i6RAo8RE9UGGrStvZKSniUoG+k
	 6SBBj02SDdVcA==
Date: Fri, 11 Apr 2025 12:05:35 -0500
From: Rob Herring <robh@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v1 3/4] dt-bindings: mmc: loongson,ls2k-mmc: Add
 compatible for Loongson-2K2000
Message-ID: <20250411170535.GA3391061-robh@kernel.org>
References: <cover.1744273956.git.zhoubinbin@loongson.cn>
 <cefcd16d303936247b94bc13047c8a1861bb8330.1744273956.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cefcd16d303936247b94bc13047c8a1861bb8330.1744273956.git.zhoubinbin@loongson.cn>

On Thu, Apr 10, 2025 at 04:40:37PM +0800, Binbin Zhou wrote:
> Add the devicetree compatible for Loongson-2K2000 EMMC/SD/SDIO controller.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../bindings/mmc/loongson,ls2k-mmc.yaml       | 47 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> index f3e94f5f3a35..24d217a9bbe6 100644
> --- a/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> @@ -9,6 +9,9 @@ title: The SD/SDIO/eMMC host controller for Loongson-2K family SoCs
>  description:
>    The MMC host controller on the Loongson-2K0500/2K1000 (using an externally
>    shared apbdma controller) provides the SD and SDIO device interfaces.
> +  The two MMC host controllers on the Loongson-2K2000 are similar,
> +  except that they use internal exclusive DMA. one controller provides
> +  the eMMC interface and the other provides the SD/SDIO interface.
>  
>  maintainers:
>    - Binbin Zhou <zhoubinbin@loongson.cn>
> @@ -21,8 +24,10 @@ properties:
>      enum:
>        - loongson,ls2k0500-mmc
>        - loongson,ls2k1000-mmc
> +      - loongson,ls2k2000-mmc
>  
>    reg:
> +    minItems: 1
>      maxItems: 2

Missed this in the first patch, but you need to define what each entry 
is.

>  
>    interrupts:
> @@ -42,11 +47,31 @@ required:
>    - reg
>    - interrupts
>    - clocks
> -  - dmas
> -  - dma-names
>  
>  unevaluatedProperties: false
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - loongson,ls2k0500-mmc
> +          - loongson,ls2k1000-mmc
> +
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +
> +  required:
> +    - dmas
> +    - dma-names
> +
> +else:
> +  properties:
> +    reg:
> +      maxItems: 1
> +
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> @@ -65,3 +90,21 @@ examples:
>          bus-width = <4>;
>          cd-gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> +
> +    mmc@79990000 {
> +        compatible = "loongson,ls2k2000-mmc";
> +        reg = <0x79990000 0x1000>;
> +        interrupt-parent = <&pic>;
> +        interrupts = <51 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk LOONGSON2_EMMC_CLK>;
> +        bus-width = <8>;
> +        non-removable;
> +        cap-mmc-highspeed;
> +        mmc-hs200-1_8v;
> +        no-sd;
> +        no-sdio;
> +    };
> -- 
> 2.47.1
> 
