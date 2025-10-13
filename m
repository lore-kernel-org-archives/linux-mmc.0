Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E260B8A;
	Mon, 13 Oct 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355608; cv=none; b=mEAiHYb1edk+4v6/BWd0k+Tiw1Aj5L1P6tRTktxFeOeAyu+3n5sqQNYTKJCirY9w72+79UxXg2CcepxvWFH+7WwbLZnspdKHPRZcXWJPnRdrhO/QKEahi7LPfW3dk8mHjYcUFthJIwPzegWj3OgZ5DY/7rdSEIqVutHm+Mz3VvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355608; c=relaxed/simple;
	bh=/nFN+Pu9AvLmWGrbw90bVYGKBnjBTI4Pl7YgnTZHZss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSQQkJsDX2pySz1uUQOItt7cH5kXDtKhDLFRFO0KCo9Su9zmtDZlrtfRrzwXYtrWxDgw/tFWbn6OVS9SZeTPW1eMObIbNZ4BVURY03PqWfpwH/SeDQJD2CFxrEnfiPXZ1GyY8BiSkPMXGu1hYZi2AYMpuXUmZJMNEETswgHaglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSMhnG8n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSMhnG8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F9FC4CEE7;
	Mon, 13 Oct 2025 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760355602;
	bh=/nFN+Pu9AvLmWGrbw90bVYGKBnjBTI4Pl7YgnTZHZss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSMhnG8nPjwfeur33NRn69MF+qY5sf9wexD14vvY8LPIBfT8tnuFybjCyI+ozHh8t
	 HAQPT10sck3dNeyeZWuTFBL/nY57uuD7jSknkyM3miM/TuidGUbSISDIpHL5pshD+c
	 MMeq3bSUm1Y0gXxX5bJ/+yQ2ydJtnw88dsrM8cdg1BjebIb/uHB13X8XkUTEIZnc20
	 2ZEYFfLaeuQc9etXhsdZ7gLZRFWaZCnnlBRe6Ld5/0gQjGY/mxanoc+7CwFtc+kOvW
	 hOf2P+u8ZnOVvuM0watGoBmBfxsTMOyFu4u9kRR239fn3Qe0K2uNgdG3JUzf1bqYqG
	 UKW4YT8Z2qV8w==
Date: Mon, 13 Oct 2025 06:40:00 -0500
From: Rob Herring <robh@kernel.org>
To: hehuan1@eswincomputing.com
Cc: ulf.hansson@linaro.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jszhang@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com, luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com, zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com, lizhi2@eswincomputing.com,
	caohang@eswincomputing.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin
 EIC7700
Message-ID: <20251013114000.GA2755794-robh@kernel.org>
References: <20251011111039.533-1-hehuan1@eswincomputing.com>
 <20251011111150.553-1-hehuan1@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011111150.553-1-hehuan1@eswincomputing.com>

On Sat, Oct 11, 2025 at 07:11:50PM +0800, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> EIC7700 use Synopsys dwcmshc IP for SD/eMMC controllers.
> Add Eswin EIC7700 support in sdhci-of-dwcmshc.yaml.
> 
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 57 +++++++++++++++++--
>  1 file changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index f882219a0a26..edd6c8e90cad 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -30,6 +30,7 @@ properties:
>            - sophgo,sg2002-dwcmshc
>            - sophgo,sg2042-dwcmshc
>            - thead,th1520-dwcmshc
> +          - eswin,eic7700-dwcmshc
>  
>    reg:
>      maxItems: 1
> @@ -52,17 +53,30 @@ properties:
>      maxItems: 5
>  
>    reset-names:
> -    items:
> -      - const: core
> -      - const: bus
> -      - const: axi
> -      - const: block
> -      - const: timer
> +    maxItems: 5
>  
>    rockchip,txclk-tapnum:
>      description: Specify the number of delay for tx sampling.
>      $ref: /schemas/types.yaml#/definitions/uint8
>  
> +  eswin,hsp-sp-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:

This should be:

items:
  - items:
      - description: ...
      ...

> +      - description: Phandle to HSP(High-Speed Peripheral) device
> +      - description: Offset of the stability status register for
> +                     internal clock
> +      - description: Offset of the stability register for host regulator
> +                     voltage.
> +    description: |

Don't need '|' if no formatting to preserve.

> +      HSP CSR is to control and get status of different high-speed
> +      peripherals (such as Ethernet, USB, SATA, etc.) via register,
> +      which can close module's clock, reset module independently
> +      and tune board-level's parameters of PHY, etc.

Wrap lines at 80 chars.

> +
> +  eswin,drive-impedance-ohms:
> +    description: Specifies the drive impedance in Ohm.
> +    enum: [33, 40, 50, 66, 100]
> +
>  required:
>    - compatible
>    - reg
> @@ -110,6 +124,37 @@ allOf:
>              - const: block
>              - const: timer
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: eswin,eic7700-dwcmshc
> +    then:
> +      properties:
> +        resets:
> +          minItems: 4
> +          maxItems: 4
> +        reset-names:
> +          items:
> +            - const: axi
> +            - const: phy
> +            - const: prstn
> +            - const: txrx
> +      required:
> +        - eswin,hsp-sp-csr
> +        - eswin,drive-impedance-ohms
> +    else:
> +      properties:
> +        resets:
> +          maxItems: 5
> +        reset-names:
> +          items:
> +            - const: core
> +            - const: bus
> +            - const: axi
> +            - const: block
> +            - const: timer
> +
>    - if:
>        properties:
>          compatible:
> -- 
> 2.25.1
> 
