Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85B332ECB;
	Fri,  9 Jan 2026 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951243; cv=none; b=HwzcuXB69lQmgAVioIPOSAODsHgOXSV3WOKpi23V8/AoMdnu+UkATnBmxfulYe+Iv8So4CTg5G/Jqx5r05gz+d3wUp3vkQ1huZz9VYj7GyIMa74k5qZknnYeLDyjFsKQRDkRr6GoPEDRowhw0VJh6KL9S6Z5qLj+xuOakohrIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951243; c=relaxed/simple;
	bh=3AeINoDybmIWU2wLjbaEaippAGFl95KiJUHzFKs9IpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTtnA3P/MyazLf2NLYZWqvpCcJ3BnkHo6hwYadg65AIL6wVhlpao1W4qRkF7tBavXTvGUNhUiw6S5BkeAs1mtyIL09jKj6+YUWlHCBphOwFoSRdS2+nYqpV4O+1na33LJB07rOLhZbDBNHgN86L3I7QJ4q7XT8V73IaJqILihk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFKg7AGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFKg7AGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B11C4CEF1;
	Fri,  9 Jan 2026 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767951242;
	bh=3AeINoDybmIWU2wLjbaEaippAGFl95KiJUHzFKs9IpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFKg7AGW2kdubeInzebs0roxQzYOndkeGDjE7FGNdET4rl9eG+E1fkXngyCJoqeEc
	 lhD0JuN9odhgzLZc8Hmh/CeMZEe/25IXcZNQ37+0eG4KDvWsHa5lOlLbTPn1hkb2/0
	 mdB60FmAp8wB98yt76W3Gh9r4vU55elG3N7ROgvEFHLSxPtPcLZLmNU29sTrZPbEV0
	 zW7Z7E/JmsN+B0f/E7O5pHywpa03/kwqPTscCF0NSwopZQTa7WqSnIRrAgo9VFoJpm
	 eTa8/E2XEun+4Ox8SghYU3bl6T4QzA7P4B95J1v9FL8d/3ahqVaRaBVkFPsVkjEsvg
	 TqWqHLkvhY7Pw==
Date: Fri, 9 Jan 2026 10:34:00 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Simon Glass <sjg@chromium.org>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, linux-mtd@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 06/10] dt-bindings: mtd: partitions: Drop partitions.yaml
Message-ID: <20260109-bright-purring-oyster-8c9f0b@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-6-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dt-mtd-partitions-v1-6-124a53ce6279@kernel.org>

On Thu, Jan 08, 2026 at 11:53:15AM -0600, Rob Herring (Arm) wrote:
>  patternProperties:
>    "^partitions(-boot[12]|-gp[14])?$":
> -    $ref: /schemas/mtd/partitions/partitions.yaml
> +    type: object
> +    additionalProperties: true
>  
> -    patternProperties:
> -      "^partition@[0-9a-f]+$":
> -        $ref: /schemas/mtd/partitions/partition.yaml
> -
> -        properties:
> -          reg:
> -            description: Must be multiple of 512 as it's converted
> -              internally from bytes to SECTOR_SIZE (512 bytes)
> -
> -        required:
> -          - reg
> -
> -        unevaluatedProperties: false
> +    properties:
> +      compatible:
> +        contains:
> +          const: fixed-partitions
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
> index bbb56216a4e2..e56dba83f00a 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> @@ -30,7 +30,7 @@ properties:
>      deprecated: true
>  
>    partitions:
> -    $ref: /schemas/mtd/partitions/partitions.yaml
> +    type: object

I think you need explicit, since we require it for incomplete nodes:

additionalProperties: true

>  
>      required:
>        - compatible

...

> -unevaluatedProperties: false
> diff --git a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> index ed24b0ea86e5..7619b19e7a04 100644
> --- a/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml
> @@ -24,7 +24,9 @@ properties:
>        - description: AEMIF control registers.
>  
>    partitions:
> -    $ref: /schemas/mtd/partitions/partitions.yaml
> +    type: object
> +    required:
> +      - compatible

Same here

Best regards,
Krzysztof

