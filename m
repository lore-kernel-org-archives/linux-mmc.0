Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3A229B0D;
	Wed,  5 Feb 2025 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738744087; cv=none; b=BgK+Gk8hQyIbGoDvoJKLZR3KSYg8aIN9ASBz4sKfq3camKYdfSglqO21/ZxmHqHta2ST6/vxNFL9FCx851kTo9twyWgs5fFrsTwRQCF5VieYPEs21OmCxYX6h//00G8WxGC5bPxDdpj6V8shKkIepNSF7V5wOdOHvtaTfV2SmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738744087; c=relaxed/simple;
	bh=CFd1at/8SMlmUXn2NDq5TSXadPYqd3iQolIPX3ikTW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhMR9ksN8Kt7Op/tN6CsDen9QOfpsU0Cu9/MmMUANYVWfuIqcUgnNLkNr6l0mUjZLt4TaT0TWEL2PHSUgaUCmsMJIVpOIGEipJ8rMQWnnz/i3aFTET2aKtNkKnSO1iuOl5Jb+UZ2lBX+ToZmElLHujBX9yRhsoxgC9KjjhDWEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1ljhnKd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1ljhnKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECA3C4CED1;
	Wed,  5 Feb 2025 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738744087;
	bh=CFd1at/8SMlmUXn2NDq5TSXadPYqd3iQolIPX3ikTW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1ljhnKdJD2LM6Y2LHYGv/OgPP/cMZvit0Le2OZiUh/BUyNouNO7USToUdfesOqCm
	 lUcJZoG8EHYVrp1qCDEHhr76Z/vZy/aBTFYmt1Ucz//PY2dffDTNbAYtirDrGvyxjX
	 W8jn4G6ovDJzfcwTjr5l0Fyh6d6DUqDJKKKbcntE1fn09q8M+Abs+l1sbSdZrvABpu
	 c02lpKSbOWb0aBH0hnGfuKjPIkQlQekU9wYSWFn2vVbSDuUbjtdXMwhzb1lQE6Pmdw
	 Kpx04iKAMY8HP4VEKe0tm8RI5plUYq/6lgMc38G6pkJHNRdg4cChz6prQ2FGl62x5k
	 pliAN73c+a9cw==
Date: Wed, 5 Feb 2025 09:28:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Sergey Lisov <sleirsgoevy@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: samsung,exynos-dw-mshc: add
 exynos7870 support
Message-ID: <20250205-premium-cuttlefish-of-strength-506a7d@krzk-bin>
References: <20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org>
 <20250204-exynos7870-mmc-v1-1-c87cfc72be4a@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250204-exynos7870-mmc-v1-1-c87cfc72be4a@disroot.org>

On Tue, Feb 04, 2025 at 02:04:16AM +0530, Kaustabh Chakraborty wrote:
> Document the compatibles for Exynos7870's DW MMC driver, for both
> non-SMU and SMU variants.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

