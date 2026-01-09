Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEEA33064A;
	Fri,  9 Jan 2026 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951406; cv=none; b=uNlovJDp6a0CV/4Wm1AUhOOiCqsQ9IsVXt02cWZZixm0SlJUL9bXzeYQmt1+dXkjmx6zxqytY3yD8vm31vOsLtSJx/+OovuH3h4SNOSuZ61zrLJvBlL3V1rrvdigXY3X/ZDp3KPfI+VATEtkepmZTrmyqA6LTgVyaq8CxIw58kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951406; c=relaxed/simple;
	bh=KbbH+ZwfSvrSqtK4kL/K3r5o8gMgqXyODhycXl6OaeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivar/ba5yp7AmHyLLjZY/ldHA/YUMM5p+6824XeJFWJFCeWaOGG/527Q8PUEhUUnw+mA2i6ng5AvA2Pvv6PJoI/DY34bzmjae/4KA127kZtwmm1/Dzua0H0ygnbkIBTOAQsN+CwTFRbNYVzJeuVg3sklFIulqDNpX8mUoe4Ytlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfiCrGxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfiCrGxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E26C4CEF1;
	Fri,  9 Jan 2026 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767951406;
	bh=KbbH+ZwfSvrSqtK4kL/K3r5o8gMgqXyODhycXl6OaeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SfiCrGxLuACvgGefuyzVhDRM0+w9dazE12b+FryR6C9q/i/gAMWjXRNuFqvjtujO3
	 6vqWFwH4wemaFz/c9Pm+sh+H9jsD8LGSO7ikBibgfl54gw+k23VBfmygzfaqe2JmdY
	 W+7bHN1JMxRHMnD+0tEm9pSJ/4+TWmbPFKzza3xo9ivBl71UtSO46Z7BbimDWVEqvT
	 jXwnNPrv+3MYuOi/1lhk3l/b8OvPnJpWSb/PIPCywJWlzYKEE1fQvGjCIZj53/CU5H
	 TUqvvTm/q09ld8Y63ix04g0ZpUnGtxYOG0OaZ/5JI5wE1WM/EDaAJYJqzjEJUkbt+d
	 clF5/EDwnXelg==
Date: Fri, 9 Jan 2026 10:36:43 +0100
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
Subject: Re: [PATCH 07/10] dt-bindings: mtd: Ensure partition node properties
 are documented
Message-ID: <20260109-affable-poetic-albatross-ff7fcf@quoll>
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org>

On Thu, Jan 08, 2026 at 11:53:16AM -0600, Rob Herring (Arm) wrote:
> Partition nodes without a compatible have no restrictions on additional
> properties. Fix this by ensuring 'unevaluatedProperties' is set when
> there's no compatible property. If there is a compatible property, then
> there should be a specific schema for it which will enforce
> 'unevaluatedProperties'.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/mtd.yaml               |  8 ++------
>  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml |  2 +-
>  .../devicetree/bindings/mtd/partitions/partition.yaml        | 12 ++++++++++++
>  .../mtd/partitions/tplink,safeloader-partitions.yaml         |  2 +-
>  Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml |  2 +-
>  Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.yaml   |  2 +-
>  6 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd.yaml b/Documentation/devicetree/bindings/mtd/mtd.yaml
> index e56dba83f00a..5a2d06c96c0d 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mtd.yaml
> @@ -36,12 +36,8 @@ properties:
>        - compatible
>  
>  patternProperties:
> -  "@[0-9a-f]+$":
> -    $ref: partitions/partition.yaml
> -    deprecated: true
> -
> -  "^partition@[0-9a-f]+":
> -    $ref: partitions/partition.yaml
> +  "(^partition)?@[0-9a-f]+$":
> +    $ref: /schemas/mtd/partitions/partition.yaml#/$defs/partition-node
>      deprecated: true

This makes partition@ deprecated. Looks unintended or needds commit msg
explanation.

>  
>    "^otp(-[0-9]+)?$":
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> index 26bef777353d..4d79f786fcd5 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> @@ -33,7 +33,7 @@ properties:

Best regards,
Krzysztof

