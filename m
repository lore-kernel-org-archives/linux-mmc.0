Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A8E273D76;
	Sat, 14 Mar 2026 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483861; cv=none; b=Pf1PgO5oUmndpTGCUMVyzu9mH65VtHa+gVi4Xagj1IjD0+I5pBMEEiYf8faeMR8KevoNr8mFS/GDY3MuCx7Tx+OI8oO6KhcnlKuFAzTwSelJmRupczgPKYTYPcCT7kaWcUUSJoo6xjqGFgy1ClOdX0wBnfKJLriqIFR9kn1Qncc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483861; c=relaxed/simple;
	bh=Ml/lEKonYkIliYF/LMmTBJQ2qVPdHCM46twoQHPrNRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcxSvgC9fU7JvDWB1nYTa1hRIeKNdGGpbL145vtgeuZ6Wj2Qc2uKTH0tFDEoo2AGEla/42ynuDoDUJ0kR/1EghWPlvcteWrzuoEK9atFymBnQKayBoE9cOWTiT0PHZ9M2NG4JOsqXOFNvm4eDYJaxrD4hMliWi/RBfAA1hrLKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQDW6WnV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQDW6WnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F45C116C6;
	Sat, 14 Mar 2026 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773483860;
	bh=Ml/lEKonYkIliYF/LMmTBJQ2qVPdHCM46twoQHPrNRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RQDW6WnVIy3RVOdnc3BHCsn3XXqrqpnd2AvzdZZ6jrrQAw9WJsdW5yO+Ppow/KV3y
	 FtgNQaV9jv2MDtwed31KOHgxokOTuyavl8vkljbG7mau4u+XMfn9U/zgDQ40dbWWwT
	 A7NErRvwFl4pfvg/tmLP5Oz1m2Cl8KhkTCbFXj64+ot8INpfqS/Mz6PyxDRN0AE1kj
	 7vHEnSZDW3XFLMGt+N+SSiDPrJWbNG3kvB3dYMsBoBGEBrBbIdZflpxniq2ioGg6kj
	 RJW34RJhg12PgAlPWmt4uRL+ghUyONP3iygDFL0397wIr33UbzzkbC8+uz8CSNQA2x
	 qMomNsmNPtbSA==
Date: Sat, 14 Mar 2026 11:24:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-of-aspeed : Add ast2700
 support
Message-ID: <20260314-perch-of-eminent-swiftness-e4efcf@quoll>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
 <20260313-sdhci-v1-1-91cea19c8a67@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313-sdhci-v1-1-91cea19c8a67@aspeedtech.com>

On Fri, Mar 13, 2026 at 01:27:56PM +0800, Ryan Chen wrote:
> Add the "aspeed,ast2700-sd-controller" compatible. The ast2700 sdhci
> controller requires an reset, so make the "resets" property mandatory
> for this compatible to reflect the hardware requirement.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index d24950ccea95..a2ff9a94db13 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -26,6 +26,7 @@ properties:
>        - aspeed,ast2400-sd-controller
>        - aspeed,ast2500-sd-controller
>        - aspeed,ast2600-sd-controller
> +      - aspeed,ast2700-sd-controller

Also, not matching your driver.

Best regards,
Krzysztof

