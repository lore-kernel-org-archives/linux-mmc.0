Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01EB39281D;
	Mon, 29 Jun 2026 07:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716929; cv=none; b=A6KoX7kP9lvgOcon0yE8qxOrnMMx9U3isM8dnG9QeemLeGp0zn07/8JW4IZ5jdcKSiivOrxLLWuxzzzRNc1aqMgc2rIZSDbXD+W8aZ/i10bySZueGoxEn82VeYSyrbk+CCR2rDxWyMRx11Rm4UzF6KaVEULp39BGEaYD7CxjLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716929; c=relaxed/simple;
	bh=AFjbAa+aazuaTMUkSU70sCrEnd6qV6YG3qHQVxfhN/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUgbc8R9yKyoKTNM56rQCLRbz4IbblptmX5rAmBrnz2/Om15HqhCQf7XK8kS10GMN+Lno1VyIF0FojjWlhf/ghZfO6QSrj/NOC6Hd2ofz+yzycTaTCIoXlcgfM4bTgufQ3l3jlBVB7vOK585uxgERKtGxLhhj00BmD1/E8RmAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUmUsa+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUmUsa+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2244E1F000E9;
	Mon, 29 Jun 2026 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782716928;
	bh=j4IbeVZZX1szgVgWe5UZHjmE9WJxk0PetPENc70a2wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KUmUsa+oQh3+RoyZDVsYJMNdQny1qTgQQ7GBsruRBvEhUoZijluL+bMcC1NGVtvb3
	 SGFmKRFI5vtBgiJ387vFvXSCdXEOwG2eUf7PxQYmste35tvETtbMqvUOneslzplVbA
	 F7MI7VALN+hYUKKjFjqIXjK2HShxrjgN1Oiuf/U4WGbge1HbY5/f6MOvkQturz74EE
	 uPLCmEzN9wdnvrgLpyAiNna9JiON9x9OrQ9wej86WaZ/nmvCZHWgcLCs/6acYBW1ia
	 2u0UxXjTl03bSxZ8/SKUg0IisqW709/htFLOX91Mmflp3kby5DrE6Ewm4IAbCGKF64
	 Esfal96QVWvXA==
Date: Mon, 29 Jun 2026 09:08:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
Message-ID: <20260629-woodpecker-of-luxurious-wind-cc4ed4@quoll>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-10-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627201457.12318-10-tanmay.kathpalia@altera.com>

On Sat, Jun 27, 2026 at 01:14:54PM -0700, Tanmay Kathpalia wrote:
> +	rst_combophy = devm_reset_control_get_shared_deasserted(dev, "combophy");
> +	if (IS_ERR(rst_combophy))
> +		return dev_err_probe(dev, PTR_ERR(rst_combophy),
> +				     "failed to get combophy reset\n");
> +
> +	/*
> +	 * Assert SDHCI core and SDMMC OCP/AXI bus resets together so their
> +	 * active periods overlap before both clock domains are released.
> +	 */
> +	rst_sdhc = devm_reset_control_get_exclusive(dev, "sdhc-reset");

Binding has no reset-names property (just open the binding!), thus you
cannot use this.

Best regards,
Krzysztof

