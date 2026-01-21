Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71992FBE12;
	Wed, 21 Jan 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014016; cv=none; b=mcfsbsI59lwL1dt2dwJZIrsgeiWWjuRGlPhVQwafqfaX1OkHGeaASn7HqjOkXWyt5Q5kUva14iTD9ZLyzFEoo1aUFrXzZMW8AxAPNuq/4heToiakOimoOKdKG1+uC/oDDxcrX0FUe3b6kyGq4lZR83Zq5sr8GWk7DjMivVgh7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014016; c=relaxed/simple;
	bh=Z7AKcqKCdVo5K9fbbsB5xIAy1McNGsgeezfpuSs7aiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jx2vtybnYGxQUAtbShVb1gHPcWZ5FOzKUO4Z+AiHf0iqgTiQ1TTudADBQ5El1YqXtq/rsDyis+Unt5k2CayknTccWjc/bOVMuJT7w2b/N0zpczBZ6eMQdaWsf5InVpUw1EF8/ViSlpbtpqyeUIoXZUOqQmGyWZ6YH7QKnXhOOPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meoGeEWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meoGeEWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6122FC4CEF1;
	Wed, 21 Jan 2026 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769014015;
	bh=Z7AKcqKCdVo5K9fbbsB5xIAy1McNGsgeezfpuSs7aiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meoGeEWMh9HsFWabKvkgvplnCsGRr9lNvPY7lZVMnK8hGssgoTaOyapsiLs/RwxCV
	 X47RUwGKe3P6y8dfoZZesztRtEBVwLTS7j5eHnScJyUmz9VjwkDbsx9pMM1MZUfj/E
	 yz7ZcQOmkT4DFfJjsc4FDTDcn4WlX6n/4rhXIScKGO0zSzNOKAmKzIq6XLnPHUAx7c
	 bC7pB4wBDciqkeECt+/tqbLYJzZLgDXEh1lJ8O3+X/WKikNo7YBGWV2xreq2DM4lC7
	 oLhoXwW7F6vbYQs7NGoipsuaAHQ8Z7jAWZsHX57sX/cL+ndIWYHO5yqtyKZuWTjBDg
	 PO1o9Y2bPhg7w==
Date: Wed, 21 Jan 2026 10:46:54 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: linux-mmc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: spacemit,sdhci: add support for K3
 SoC
Message-ID: <176901401388.3439509.9465691892166826989.robh@kernel.org>
References: <20260121-07-k3-mmc-v1-0-ff77c07bfdf6@kernel.org>
 <20260121-07-k3-mmc-v1-1-ff77c07bfdf6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-07-k3-mmc-v1-1-ff77c07bfdf6@kernel.org>


On Wed, 21 Jan 2026 15:27:35 +0800, Yixun Lan wrote:
> The SDHCI controller found on SpacemiT K3 SoC share the same IP with
> K1 generation, while fixed the broken 64BIT DMA issue. Introduce a
> compatible string to enable support for it.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

