Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1E1DF268;
	Mon, 21 Jul 2025 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108543; cv=none; b=ep0Lj0yynKBy0iMbxoCCetEMqZseoO88H60s+khsSNUkYh6+2cN5LKS7hSqGdr/LOAuKbaVocIcAfHgfv+yojAPp6bDD4eodn4jV9mgd55bIZrwheUd1wQL92mgnHxPRRsL7+EEYE2JQcNBkr22OX8tSc7MShRgwj21E74tDa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108543; c=relaxed/simple;
	bh=VLKknsNLQ7hZ8ksRK19QXAoZd/orE4Mqim5z7wdtjE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVnl6zMQJbwGusIbQWBPhSXgrc3eWPDqSLqGopITP+RuN1Izt+3zoDSOr8NLpvHVDdq+IGEr6ytz1jTsW3gpz8MIVcWDCF4NaqNkuhpG5DvkePcsQY5Wqi0lksRQ0oUEeMGIw+EOFHoIklVzYmAEFe1LehzzktzmH+mtklsMs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC5nHnjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC5nHnjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B2AC4CEF6;
	Mon, 21 Jul 2025 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753108542;
	bh=VLKknsNLQ7hZ8ksRK19QXAoZd/orE4Mqim5z7wdtjE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KC5nHnjygXK76RzpvSxpPKZSEpT+kUqkpow0LPVjNdyMfZ6JT/2V6iUrV3Khb4r00
	 0uowXfj/AowZbOFlVxwdkVe/vVAn0yEtwCJDU3plMWz3Bs3sT4oFo2fF+NQFEAm24m
	 7IgrbQlc56sxfQCuzzfvp8F/XeKRp9CQ9aWPwdsYUmBhU8idTPD7sS3Cj2TDTmXFjQ
	 uDdcG/bEbz2HOm1p3Zk+nyKhR3pchaiYuQ25R0by+tHUodKxksHXnestf1I/EUGDsx
	 7ut5thBMXZpO/SqKkUSgI2DxQVOYuGbJ5PEppya18agTljFbRqu3ZduJ60voV/60vs
	 4uHsnxvh3hW1g==
Date: Mon, 21 Jul 2025 09:35:41 -0500
From: Rob Herring <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RFC 1/2] dt-bindings: mmc: sdhci-pxa: add state_uhs
 pinctrl
Message-ID: <20250721143541.GA593898-robh@kernel.org>
References: <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
 <20250718-pxav3-uhs-v1-1-2e451256f1f6@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250718-pxav3-uhs-v1-1-2e451256f1f6@dujemihanovic.xyz>

On Fri, Jul 18, 2025 at 11:12:38PM +0200, Duje Mihanović wrote:
> On the pxav3 controller, increasing the drive strength of the data pins
> might be required to maintain stability on fast bus clocks (above 100
> MHz). Add a state_uhs pinctrl to allow this.
> 
> The existing state_cmd_gpio pinctrl is changed to apply only on pxav1 as
> it's unneeded on the other controllers.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 45 +++++++++++++++++-----
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> index 4869ddef36fd89265a1bfe96bb9663b553ac5084..7a9e2a63ac4351aea10b2763ca250ce4889df1eb 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -30,6 +30,39 @@ allOf:
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

blank line

> +        pinctrl-1:
> +          description:
> +            Should switch CMD pin to GPIO mode as a high output.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: mrvl,pxav3-mmc
> +    then:
> +      properties:
> +        pinctrl-names:
> +          description:
> +            Optional for increasing stability of the controller at fast bus clocks.
> +          items:
> +            - const: default
> +            - const: state_uhs

blank line

> +        pinctrl-1:
> +          description:
> +            Should switch the drive strength of the data pins to high.
>  
>  properties:
>    compatible:
> @@ -62,21 +95,13 @@ properties:
>        - const: io
>        - const: core
>  
> -  pinctrl-names:
> -    description:
> -      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
> -      SDIO CMD and GPIO mode.
> -    items:
> -      - const: default
> -      - const: state_cmd_gpio
> +  pinctrl-names: true
>  
>    pinctrl-0:
>      description:
>        Should contain default pinctrl.
>  
> -  pinctrl-1:
> -    description:
> -      Should switch CMD pin to GPIO mode as a high output.
> +  pinctrl-1: true
>  
>    mrvl,clk-delay-cycles:
>      description: Specify a number of cycles to delay for tuning.
> 
> -- 
> 2.50.1
> 
