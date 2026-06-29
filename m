Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D93016F1;
	Mon, 29 Jun 2026 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716814; cv=none; b=Cq4xAkqcgI5C4eFAw2IxcZbrt+yicFnmJES1hxiAQ0OyNZYXbr3M6V9jjt9MFhPwuJk9ClxAtFa5j+TKKGHEk5uIY9qV3lLiqcb5I1enWSqAN855mpblwPweU5zRfCAk/nDXT0tL4KwQoe//FGIWT3zcllKMdWOwpU+Y69fASQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716814; c=relaxed/simple;
	bh=MIXcyY1CCOONfuBlyW6YIqghRNgN0+vYhL/lXgW18zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5pEZUlIpIrZiUUHYSeDNLzQLNNOOErCHRmT9CkYOyhuL9HSDpgzil6Al4l3h8aKmKKSRg+tL3VvSqYvTR1XEhwwfkkxtEPmX2HLXRphymsSQ3QnNpO2dF8IPhQBOOZBBu1b7BxGKGX6AYZ1Ptl5ya0QTdbdHOTDS5fZJUUKZRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmSS8X6m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmSS8X6m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C9A1F000E9;
	Mon, 29 Jun 2026 07:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782716813;
	bh=HKJKsj1rOXrs1oZ4EtVD1DezAJ5STX3YirLLKQfvR98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gmSS8X6mLl4E7DIH3z99xkKieDyPPHRxeHCFPdF08FAb/NrUuE9HuInH6/ZG4j6eW
	 Vy+k9mqO4JEg2KQK3P7TFImb7I+Agu+AhezX0q6qTFxEtG3yrrV9jzzKvoIvLVOVwM
	 jb9v9hEYNbcpwWdelaVC9bC+n0a3RqabM9tUDz8rVT8SaxhZH8HRKwBk7s2tIxMOsH
	 L5pw4HfKphzasxM3ae5jd0mIKByYFR9BhYMZKgebydLu6+pQopnQDBRQMMiI8VhXZ+
	 jjy/ZZISqF9crjbm0nvbTIwcbVcHqM9tD7PSwCpJqql47OzgiQdcfkIrwNTwKQRPay
	 2eWPfCpcukDNw==
Date: Mon, 29 Jun 2026 09:06:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] dt-bindings: arm: intel: add Agilex5 SOCDK eMMC
 board variant
Message-ID: <20260629-venerable-zealous-dinosaur-c7efe0@quoll>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-5-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627201457.12318-5-tanmay.kathpalia@altera.com>

On Sat, Jun 27, 2026 at 01:14:49PM -0700, Tanmay Kathpalia wrote:
> Add "intel,socfpga-agilex5-socdk-emmc" compatible string for the
> Agilex5 SOCDK board variant configured with eMMC storage.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  Documentation/devicetree/bindings/arm/altera.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
> index 206686f3eebc..f5efcbc381b8 100644
> --- a/Documentation/devicetree/bindings/arm/altera.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera.yaml
> @@ -113,6 +113,7 @@ properties:
>                - intel,socfpga-agilex5-socdk-013b
>                - intel,socfpga-agilex5-socdk-modular
>                - intel,socfpga-agilex5-socdk-nand
> +              - intel,socfpga-agilex5-socdk-emmc

Do not break the order of entries.

Best regards,
Krzysztof

