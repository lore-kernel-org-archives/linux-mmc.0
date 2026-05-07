Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22D313E29;
	Thu,  7 May 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778180484; cv=none; b=rVAk1sMbT+/4UMK0pMDVGXbW3o+xhnKCJWh5gtvHj/y6UzpqVf66VErd7QIkSLzQGxn2LXx2ToAVc9yaoN7FRxstm6AWU4ZREqHb5v+XSHHZgFxKew9HPe/cRR+pyNzGUd7FjrUUqu5V5KwamN5UOUykaZpNU+ml59YKo3GoSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778180484; c=relaxed/simple;
	bh=F4f295Djvpi+RQS8z+Fs3xpcXcpwkoyA+LBpQ1fvBaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noxHi2i2mSHcVXG+1802TPHmUprvxsJNTzCn+GqfCCZg+gYgVJBPEcbldjqPnYRdcKCBRtGqY2MjUUHuNiBIDOlOvd04PyGo0IMSSOcT32TQHIcgLZ7ViseSROEHCqCV3L/gPgSmJtLQaoRryl91WJBGh49Ml3uDUULEI547Ovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=tl3qD4DI; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="tl3qD4DI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=UhWt9GIcE0Eg5lAt4TvJi+a4FqjU40A5a8Y0h0GVjdA=; b=tl3qD4DIve1t57w4IepB4O3aUX
	WI8RndCoJA7rzWgQ0X0aRlRrnmjDdv4ATUqAf8tdKai6hFozEwMeIHWQB7yknemaMd/G9I0YMlMIV
	PKDS3Eo5XNB3wCxwCvEUlYzgncviRheivcEPNjvoCT9pPPhDuHIu/+pmo/cyYQSWsYFG1Eldv8Efc
	+3OLAzshMQz6FmwYKRrqWkAa9YqOiEPSX0g8hUN9IR0NCUlNdZmVXT1m8MlYjT/Khjyg1R1VTculK
	mGABxiKaeblL2uQ/s7op42k4DWcjCmI48dQUOUsLTmXxszUrFR0fWTdaj5eRtWSrmu2tnjT5Sqj5i
	a0slrciA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1wL3Sz-000000090rv-1Xu2;
	Thu, 07 May 2026 20:28:57 +0200
Date: Thu, 7 May 2026 20:28:56 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Message-ID: <afzZ6Fjdt4puGjZ6@aurel32.net>
Mail-Followup-To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2026-04-13 10:02, Iker Pedrosa wrote:
> Add complete SD card controller support with UHS high-speed modes.
> 
> - Enable sdhci0 controller with 4-bit bus width
> - Configure card detect GPIO with inversion
> - Connect vmmc-supply to buck4 for 3.3V card power
> - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> - Add dual pinctrl states for voltage-dependent pin configuration
> - Support UHS-I SDR25, SDR50, and SDR104 modes
> 
> This enables full SD card functionality including high-speed UHS modes
> for improved performance.
> 
> Suggested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 5790d927b93d..a7d88564630f 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -220,7 +220,7 @@ buck3_1v8: buck3 {
>  				regulator-always-on;
>  			};
>  
> -			buck4 {
> +			buck4: buck4 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3300000>;
>  				regulator-ramp-delay = <5000>;
> @@ -241,7 +241,7 @@ buck6 {
>  				regulator-always-on;
>  			};
>  
> -			aldo1 {
> +			aldo1: aldo1 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3400000>;
>  				regulator-boot-on;
> @@ -367,3 +367,23 @@ hub_3_0: hub@2 {
>  		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
>  	};
>  };
> +
> +&sdhci0 {
> +	pinctrl-names = "default", "uhs";
> +	pinctrl-0 = <&mmc1_cfg>;
> +	pinctrl-1 = <&mmc1_uhs_cfg>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +	broken-cd;

Card detect is marked as broken as a proper definition requires pull-up 
support in pinctrl. Support for that went into 7.1, so I guess it's not 
safe to use the proper definition. That means using the following 
changes on to of this patch:

--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -406,9 +406,7 @@ &sdhci0 {
 	pinctrl-0 = <&mmc1_cfg>;
 	pinctrl-1 = <&mmc1_uhs_cfg>;
 	bus-width = <4>;
-	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
-	cd-inverted;
-	broken-cd;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 	no-mmc;
 	no-sdio;
 	disable-wp;

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
