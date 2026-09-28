Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD046EC9F;
	Mon, 28 Sep 2026 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582993; cv=none; b=LkbCAKSK3TCYJs3dUw2ozx2u2+km1ZkEcYnsoawrSWtIQsic4bdqjAWMyd0tgYAX25zeH29oF2CzYq1+amO7cXM1xbj1Swv2kvjpSUh6T/cV2BrF+XzGMv8dFOOLG/rJLS/ch09INWHnVEqqok+HcgUJ0rQKPDDIkuexA7gOsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582993; c=relaxed/simple;
	bh=SyPk4IyNF5t5dqEs9JlwsHtPv1atbpAv3KWokGW2LzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgVN27omc+FUoLIIa7/yipB01Nqg/OJB+T9OecRiL1DD2cu9eiiywjj3+RrxrzStu5iqjgnKJKzn6KmoRGgP7mcfu8v3kWOgi2Pj2bYCloAuc783QuYhUCsP9SGah23Kzt4AfOmPAqfvaHoMt0gOYikzFni2azTwI7fg3VpYY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPlMjnHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPlMjnHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1971F000FF;
	Mon, 28 Sep 2026 08:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582991;
	bh=4vkwMqEbKDECyOrbFUQuixGz194KxSACX1c7ic6lEmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPlMjnHyQR+LugBeOdYlkD6y8qn5VJ0Vuivkz0BE5ACb9s6eKxrkeT32UJYPcI92A
	 K9wTSFwKF5aqV0VH8/hRwD9ktLquVSnhABVzP6or4DQH5dSKSUTSOJENYUFqxmcedd
	 UE2Rix+nUgaNzEZr9bzj07DQGpZtaSEbOGMu2nssY7MNAmdxz2pafj/gnZw5HQkwOP
	 QJK5/3/diLtPy6Yfm8J5OUwJWLcvxE9OEpS2EOKjclFXj1QRt4Bi6fvrMhNbLY09cN
	 klQRxzAWZBLnva11xWZkzki1Dk9ExUQy4ggQpInt+GMY/pnnKhYFBsYkQ+qVfGlYrk
	 0vf5/jyxhQ5Yw==
Date: Mon, 28 Sep 2026 11:09:45 +0300
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, adrian.hunter@intel.com, aubin.constans@microchip.com, 
	ehristev@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Subject: Re: [PATCH v2 5/6] arm64: dts: microchip: ev23x71a: enable QSPI
Message-ID: <tl5ep4ze2e5ctv7c47jsjedvcpnibdspo5az7a73i5p7iwbivk@vbtd4rhtvroa>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-6-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907132617.1198548-6-robert.marko@sartura.hr>

On Mon, Sep 07, 2026 at 03:25:33PM +0200, Robert Marko wrote:
> Enable the QSPI controller and describe the onboard SPI NOR flash.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Missing '---'

> 
>  .../arm64/boot/dts/microchip/lan9696-ev23x71a.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> index 4012ea7d07bb..985ca31e74e7 100644
> --- a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> +++ b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> @@ -463,6 +463,21 @@ phy27: phy@27 {
>  	};
>  };
>  
> +&qspi0 {
> +	status = "okay";
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <100000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

As sashiko pointed out, #address-cells, #size-cells, should not be
necessary here. I dropped them and applied to microchip-dt64.

Thank you,
Claudiu
