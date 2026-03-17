Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD3A2D9484;
	Tue, 17 Mar 2026 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773731905; cv=none; b=mrflFtaedTmvSfXf1uSPtdOsXPezxTNHoaj42bnF2xvD3oDGRTP17z5ozA5/35zw7vEOXavRhXmi1OIGsoNtyEBwm3O3RB7hrK8kmE+GRSMQWVD1dq4uAXQ8dOHSWK/GI0SFmn5Fa8ebLGvGex28JqkmHkDsgjzZOsTf+88P2EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773731905; c=relaxed/simple;
	bh=h9QFqvOOpHvhugdy8AYjOuTSpNkBlBQMvK7y+lI+LnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXxFcLfW5da1nNA97Dv3gC06aD0/Wu0xslRZwE8vNrFoRus8/Q+DUJvMtB1ZWEfevHWAG8vycbeYcqKNUZa2g8uTRBSTLTnUZ/mBf6Yu2DDw3zbR5TbMKy9LOIqmNx92t0gxLbuzBVh25LeZvCdPI/I2v04ZOlY0EkrQFD+oEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUYoH5pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUYoH5pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD65C19424;
	Tue, 17 Mar 2026 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773731905;
	bh=h9QFqvOOpHvhugdy8AYjOuTSpNkBlBQMvK7y+lI+LnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nUYoH5pf5SdZ1TVJPh121r6zO8wtIxVvxUpI2gnrddqmL0/OznM/xQ7LMKdAWgC3C
	 RxjyFwcrQbP1VkQsLH9cGqmNnGzXmUYtThlrkb3d2iMZ9ysinkj0Hzn5fEfHjwufGj
	 16jSVvA2nUYU/qjhTWUnyouqUCf806Sa9aiJyLVSIWQJmTITjHYjGuYWO91CbuIOU1
	 +AA6GjKcaZovkpq+OLPHi0fmkDOfEElcbVSeF1KXSRtDPb8imYvelwn07Qon2yUriJ
	 eit7wS0g9KmVMsyCNwoGqbdMkvaUtbbo9U7tGwT7pNjQHT9Fes4qx7mrBfm3GLjjPN
	 cwtxssYtpMpfQ==
Date: Tue, 17 Mar 2026 08:18:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: nick.hawkins@hpe.com
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, jszhang@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC
 dwcmshc compatible
Message-ID: <20260317-shapeless-ambitious-numbat-d8d6e8@quoll>
References: <20260316150115.2616827-1-nick.hawkins@hpe.com>
 <20260316150115.2616827-2-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316150115.2616827-2-nick.hawkins@hpe.com>

On Mon, Mar 16, 2026 at 10:01:14AM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the 'hpe,gsc-dwcmshc' compatible string for the HPE GSC (ARM64
> Cortex-A53) BMC SoC eMMC controller.
> 
> The HPE GSC requires access to the MSHCCS register in the SoC system
> register block to configure SCG sync disable for HS200 RX delay-line
> phase selection.  The required 'hpe,gxp-sysreg' property takes a
> phandle to the existing 'hpe,gxp-sysreg' syscon and the MSHCCS
> register offset within that block.
> 
> The HPE GSC eMMC interface only exposes a single 'core' clock (no
> bus clock), so clocks/clock-names are constrained to a single item.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

