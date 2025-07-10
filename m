Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A81623FC74;
	Thu, 10 Jul 2025 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184064; cv=none; b=VHTiWNudTXMutfiYVPsi3VSBi1YgJ16tQHjOrKwtziJvqTWFrA2aVxOwIvFgDJ05X834lqW9FADWcfd8t+912SgMZf+qmR5Qsd0BWI6e/zwKnm3TQ3chBBsu7EID3PLPB2D/uoF/pl+Lhzxrf3CzOh7TuRqwg4mBI0jnyMv3uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184064; c=relaxed/simple;
	bh=38qOBtAa0la59Awj3HuO+ZqZhYtdC8Mzp5gPefGF6ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQ0J+0JI/z/sT1Km//ZRW9GxpgTuQz4H5R7jSvVd0gspgO3F2n/1ry2lTB85vNgeps78zG/fUi5we6PjHRbgVqdaf0blJMAYqGi272+pxa1jl/RuLKapSnh6x0mXc841ABCPOAn58H5OuT4P7NUnEp7D66wI2iJFiWnywbfqFdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwehugbX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwehugbX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9E1C4CEE3;
	Thu, 10 Jul 2025 21:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752184064;
	bh=38qOBtAa0la59Awj3HuO+ZqZhYtdC8Mzp5gPefGF6ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwehugbXDOU6yJ5ZmM+oDgTJsB44iLXjZMhjebZn2xddJt8rnpRIHszIsQEgU6CO5
	 86/hbFQAmaCMjmIRPMKOTcNyscxwT0rpRI9faF3yw1Pc7+GRxZnNdWUiSt5J5qe39n
	 N73liM7IoJqgczI82biIgSsXVAsK5KY/zac972yLIhoqx6RUSVdztA9mCmglGHgzNm
	 HmJ5A84zVDVfYJyzvNJR4Oe8wRKZKEnGIKjpWHoVS56hLcoaeYOlkUaRaEYixZLAxL
	 5FuYl3cRMtMa1mfX+Ved0n1m9bbqctuHC7so72JUmMwmOy8CzXlVfwdxb6pDTuz6vW
	 xt2tmM3KAL27A==
Date: Thu, 10 Jul 2025 16:47:43 -0500
From: Rob Herring <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	David Wronek <david@mainlining.org>, Karel Balej <balejk@matfyz.cz>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, soc@lists.linux.dev,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v16 1/5] dt-bindings: mmc: sdhci-pxa: restrict pinctrl to
 pxav1
Message-ID: <20250710214743.GA4021364-robh@kernel.org>
References: <20250708-pxa1908-lkml-v16-0-b4392c484180@dujemihanovic.xyz>
 <20250708-pxa1908-lkml-v16-1-b4392c484180@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708-pxa1908-lkml-v16-1-b4392c484180@dujemihanovic.xyz>

On Tue, Jul 08, 2025 at 07:09:46PM +0200, Duje Mihanović wrote:
> The current pinctrl properties apply only to the pxav1 controller.
> Adding one default pinctrl node to a pxav3 controller therefore causes
> a schema warning.
> 
> Check the existing properties only on pxav1. pxav2 and pxav3 may add
> their own set of pinctrl properties if and when needed.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
> Changes in v16:
> - New patch
> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 36 ++++++++++++----------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> index 4869ddef36fd89265a1bfe96bb9663b553ac5084..e7c06032048a3a73eb3eb67a887e75db273ffa92 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -30,6 +30,26 @@ allOf:
>            maxItems: 1
>          reg-names:
>            maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mrvl,pxav1-mmc
> +    then:
> +      properties:
> +        pinctrl-names:
> +          description:
> +            Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
> +            SDIO CMD and GPIO mode.
> +          items:
> +            - const: default
> +            - const: state_cmd_gpio
> +        pinctrl-0:
> +          description:
> +            Should contain default pinctrl.
> +        pinctrl-1:
> +          description:
> +            Should switch CMD pin to GPIO mode as a high output.
>  
>  properties:
>    compatible:
> @@ -62,22 +82,6 @@ properties:
>        - const: io
>        - const: core
>  
> -  pinctrl-names:
> -    description:
> -      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
> -      SDIO CMD and GPIO mode.

       minItems: 1

Won't adding this 1 line here solve your whole problem?

> -    items:
> -      - const: default
> -      - const: state_cmd_gpio
> -
> -  pinctrl-0:
> -    description:
> -      Should contain default pinctrl.
> -
> -  pinctrl-1:
> -    description:
> -      Should switch CMD pin to GPIO mode as a high output.
> -
>    mrvl,clk-delay-cycles:
>      description: Specify a number of cycles to delay for tuning.
>      $ref: /schemas/types.yaml#/definitions/uint32
> 
> -- 
> 2.50.0
> 
