Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB14AA581;
	Thu,  3 Sep 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440452; cv=none; b=u3PbT57PiePTylQzmbgZjEQHhq7In7Mxko9Xg8Al1CXU1gWkg327lgiYsXJ2ikaD7gPxHuPLir5kntlAINB7SSJAL2mGwKk+cm9/O3HOWxgKep+HF1Y50DIak30Ft8B603JKg6s7zi/vga96CvVYZVW42DH+7GrA+ioGzTTtGqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440452; c=relaxed/simple;
	bh=2jCCbt+FQXCbWg0CbWpY7BWoaZps7tU2RqU8vFlYFJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4p5LtOxPF7O+FeY4mfDxoVAok/rXkEsnH7u6OWokgGul7vlIBoL77BSx+VbEXyfR287crK5BcmpsdUFYklcuxMfSaHveine4KKOlVeBs1Sr/3HioOePcHrWTzeqNggBwQxJnsymPKEG//6Zs6UHae6CzsXufLbI5r8xvUsxIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuaBmTRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuaBmTRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BC11F000E9;
	Thu,  3 Sep 2026 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788440443;
	bh=iegNva3kkOGJqjCoKK1iRqK5iFz7ZD4YDy8u6AOCQVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JuaBmTRR2rTrs+dzlAeqYCZZFwDrmCKGd3uT8IPDU4YSqKWK3PnBdTDk20//uAy14
	 VhPiw1hy90EnkF/yrhvEX7blaDtM3iCXX1+a9rm4cqngxZCvjrdIUo8N781ht6zl+n
	 ZGoDZzuJJYpfO52npPPSmT0MeXUx02U5Q0coe1Wf3yoobyrmJ5UjDj6FcyKudyS2Jj
	 X0T8F3vy4cqCKhKe6SXb8Ug76wWClmniPyilsvJylEG194A+/lA3V9k/cDkCjZB0+G
	 2R/m1C6D5+LwDKC5MglHBL2ieJISBwnsUKXQX1y0uJFG+uUeYP6EymykyJ8k++0rUo
	 0vWPUZHVHHUZQ==
Date: Thu, 3 Sep 2026 15:00:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Long Wan <long.wan@linux.spacemit.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: mmc: spacemit,sdhci: Add tx delay
 property
Message-ID: <20260903-tactful-scorpion-from-nibiru-a4ebe2@quoll>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
 <20260902-07-k3-sdhci-dts-v1-2-4e7909cf4233@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902-07-k3-sdhci-dts-v1-2-4e7909cf4233@kernel.org>

On Wed, Sep 02, 2026 at 07:03:13AM +0000, Yixun Lan wrote:
> From: Long Wan <long.wan@linux.spacemit.com>
> 
> Introduce a vendor specific property to configure the step count of TX
> delay line which should be applied before RX tuning, compensating for
> board level trace differences. The TX delay line result comes from test
> out of real board which vary from different hardware layout.
> 
> Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> index f35bf7ce08dd..3399a2d076dc 100644
> --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> @@ -63,6 +63,16 @@ properties:
>    pinctrl-1:
>      description: Optional pinctrl state for 1.8V UHS operation with "uhs" name
>  
> +  spacemit,tx-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 255

default: 0, I guess?

Best regards,
Krzysztof

