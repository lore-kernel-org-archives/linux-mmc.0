Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE253B95FE;
	Tue, 20 Jan 2026 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899858; cv=none; b=aU2RRrwVkGGbTM5XEkgM17+ZA6UY60z5FCJT9Qeh47xIRNT+DMTfOwoBeTuoACXu7/GdMtBhd00YrL6qMRFGeB2ElBSKlinct4gxaf7yiCLnOTDLvAy49M1+qIMFqJwUct2lxfjo4YlAFGphljDDSYk/x6y4RJokIPqjWXNMXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899858; c=relaxed/simple;
	bh=MN5D24zEMc520dPM1Py+TMz+LPimSRzyHfeoCh7ZTxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suzhwa2XfCkXSadb8oUWrWzOtxk0bDL7WPqVzzcbBHcX4w7hoBy/y/gmbc1MVO0GGnaRWt4J/wP0EZG2QxNkUwVxKadt/AnSB2l11zsPujNmrI66gfI3naln7+RJTgfx977MBLZi4RQajDanAN/sEImuzBYy5t0IhZa9u24H2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ET65+//j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ET65+//j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EF7C19423;
	Tue, 20 Jan 2026 09:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768899858;
	bh=MN5D24zEMc520dPM1Py+TMz+LPimSRzyHfeoCh7ZTxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ET65+//jCX2UscF/MXtNYdgDvtYU+QIshghTZcm7TU9MCv7h0zskb2NNv7IKB0sRd
	 IZRfKjZvGU+oRp+Owc/DxXnUfEG2tXcfQlmCZvh06T7yFmD0MCSzUTl2HvDfd33t63
	 n5GJAbGpCRP1h4mFxGBBpEarmrefEFFpsEYpkCYdajYEk5jNzxzQw6Kr53gFvHX/NH
	 v0gihRwE3CL8+T0d9pW0zpPR04X/B35edwgSgdaViPpTLKF4a/gZozs2B5ot6e/o9x
	 97MuczfNqrrP2mQWj+hZLr/DgHVEeylDkcJBKVBnv658LZI6VvKwJoxstPIuXTNAh2
	 gF/9GOfU6RpqA==
Date: Tue, 20 Jan 2026 10:04:15 +0100
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
Subject: Re: [PATCH v2 10/10] dt-bindings: mtd: partitions: Combine simple
 partition bindings
Message-ID: <20260120-origami-lori-of-genius-8fd944@quoll>
References: <20260119-dt-mtd-partitions-v2-0-77ebb958a312@kernel.org>
 <20260119-dt-mtd-partitions-v2-10-77ebb958a312@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-dt-mtd-partitions-v2-10-77ebb958a312@kernel.org>

On Mon, Jan 19, 2026 at 07:48:31PM -0600, Rob Herring (Arm) wrote:
> Several partition node bindings are just a compatible plus properties
> defined in partition.yaml. Move all of these bindings to a single schema
> file.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> -        partition@200000 {
> -            compatible = "tfa-bl31";
> -            reg = <0x200000 0x100000>;
> -            align = <0x4000>;
> -        };
> -    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> index 159b32d12803..a6edf145df57 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> @@ -29,11 +29,7 @@ properties:
>  
>  patternProperties:
>    "^partition@[0-9a-f]+$":
> -    $ref: partition.yaml#
> -    properties:
> -      compatible:
> -        const: brcm,bcm4908-firmware
> -    unevaluatedProperties: false
> +    type: object

I think this is not specific enough now and you should have here $ref
(e.g. to simple-partition.yaml) with unevaluatedProperties. Otherwise
schema does not report:
1. bogus properties in partition@ nodes without compatibles (like the
   first one in the example),
2. partition@ nodes with some other compatibles (non-partition like,
   e.g. whatever I2C device stuffed there for which there is a schema of
   course)

Best regards,
Krzysztof

