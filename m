Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722D279DC3;
	Tue, 23 Dec 2025 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500497; cv=none; b=HZ8mIFr2Tirseyqlbyu0PgYArC+WwnyH+dOZDlwg6dqz9cCjMNVztpDK2U+7C/UFVGzhqA9vCHTVA+bdLdTfywl0esH7iWi1itEY6Pj87XXVAP+b3fjY5MeRby1uDUPuPoTQNUeG8pGPiEyidSm0ovNuaZLYb+1YUBgLY5PG81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500497; c=relaxed/simple;
	bh=GXtA+vB+W9gE4Dn/u160SHU3bD3uZ/5Ml+1W+23Kiwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0A1frATt0hzVC5TNEwvVAWKlIqxWC1xDSDyvsFEkLLRfeiRSHE+LWN5DXFA6GXw70Gj6xD5+F9boic+qH4uubuziIdaoNsvFg86M1NqQKWiJADB8avzBuQLYtSelCGkkpNoxCJyxHnzdnlubXfXANeMlziua0b/zIwwxSloGA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUpNs4vh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUpNs4vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B82C16AAE;
	Tue, 23 Dec 2025 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500496;
	bh=GXtA+vB+W9gE4Dn/u160SHU3bD3uZ/5Ml+1W+23Kiwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LUpNs4vhYmXhRm1ObM0ruZ/cdf+EVFZ5EU+hW1R0kx15iGOoVNNkXIhCq6ZEe6+nm
	 x2mFl1uR73zvgyI9B6Lib4DBUesmi30KrBJfAyYByz/Lky7qqJRnOiZrLfNMO2RAEo
	 P+0RbpwhaIiAbaixDEqDRPcdqwK1BY4s7swnbvRqXHdAz4yPiHwRbxn0Tprv9dwKme
	 kJcpEq2SsKr46ufiqo7fg2MYG6Daoc2e6ghp8OkiW6PdjDZXzRRkdxCJw+S+yJF6f/
	 etTP2/+e8KI5joxJPC+L5KqOmhXxCDN/ELpZVFxryHh5DdPtL7QeYQDLezSj7Fc1Bn
	 pk8zxtFJh7bbg==
Date: Tue, 23 Dec 2025 15:34:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tzu-Hao Wei <twei@axiado.com>
Cc: SriNavmani A <srinavmani@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: dts: axiado: enable sdhci host
Message-ID: <20251223-fat-nickel-copperhead-9adeed@quoll>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-8-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-8-5457d0ebcdb4@axiado.com>

On Mon, Dec 22, 2025 at 04:45:07PM +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Enable the SDHCI host controller for eMMC support on the AX3000 EVK
> evaluation board by referencing the SDHCI node defined in the SoC
> device tree include file. This enables eMMC functionality on the
> evaluation board.
> 
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>

Why DTS is both BEFORE and AFTER drivers? This is a total mess.


> ---
>  arch/arm64/boot/dts/axiado/ax3000-evk.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/axiado/ax3000-evk.dts b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
> index b86e969625573bf92bdd5e4435ea571dd7500de2..a5cc75dfbe554749201b0910ec268c899bc5246c 100644
> --- a/arch/arm64/boot/dts/axiado/ax3000-evk.dts
> +++ b/arch/arm64/boot/dts/axiado/ax3000-evk.dts
> @@ -80,3 +80,11 @@ &uart2 {
>  &uart3 {
>  	status = "okay";
>  };
> +
> +&emmc_phy {

Axiado already received comment to read DTS coding style. Did you read
it?

Best regards,
Krzysztof

