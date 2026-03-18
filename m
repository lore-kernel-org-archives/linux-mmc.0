Received: from hall.aurel32.net (hall.aurel32.net [195.154.119.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B102C3260;
	Wed, 18 Mar 2026 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.154.119.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773865494; cv=none; b=P7+4fLPLMfLdy8j0gWWzSndS1krn0qjZPl3hRUhR9F6tY9P4HG7bcKjpzWc2bWOXTD669qhWAl22smlB1a5BjhrMG7IS6lsI5PbOs/seUkljXfQ3GYEM6lRweNKtoqc3uOlg952k+ZJiWK6xnQN75I6MH7WwsuL8dt8pnwA34uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773865494; c=relaxed/simple;
	bh=HuY68fpkysrM76Huysj2jziHARJD9bmofcAGT2xtv2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD404rhF+fGHCHHASjh8C+6oZujlX0O95RE3jjFSToPu/s4gKqk9zZ742xmrfls8HTRBfZxakRB+QT8D3VnbcwhKmKihp9pdU659O0CXFLQadfi3JZ6G3nucPEPWYmuDSOv8I2Yz3f5gQGhSD1VoFVXsytEwkFRQlVXiDP8aNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net; spf=pass smtp.mailfrom=aurel32.net; dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b=C2or/c1n; arc=none smtp.client-ip=195.154.119.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurel32.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="C2or/c1n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
	; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
	Subject:Content-ID:Content-Description:X-Debbugs-Cc;
	bh=DxuFz52fFq6pkfpxsifbWk1sah6P9t7hQOOOvkqb+BE=; b=C2or/c1nfGppJw2wonUiXwDl8M
	U0MXuq4A+MilzgT1hA08TOf46BxtiuYqfLiIPH+8hF5Mx3Mq82OoHLIQgCnBnXE+DbG2PUpwwtzXx
	Wgd73hUpBxRHZozfD1B2qsd//sDDigr4PnrgJa007CJpa8qPQcky64PQsKRkVM44LwPWRffjOI1GY
	eWiNlGcUR6nFuB+qosOuEe71UK+34L3JJj9CheBs15AupuxmUYUL5ZI8bLq+VNMmouZM0YyNT6NDw
	S6f2qE3u5r0qETOPWE7BaaPzh95TWUJ9gHgmw8iRqs/uDGeCaUZoHxbczSRLA095hJqUolwez8gWe
	szD3vDRA==;
Received: from authenticated user
	by hall.aurel32.net with esmtpsa  (TLS1.3)  tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <aurelien@aurel32.net>)
	id 1w2xRd-00000005fXL-1dM1;
	Wed, 18 Mar 2026 21:24:45 +0100
Date: Wed, 18 Mar 2026 21:24:44 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v3 7/7] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Message-ID: <absKDGLCw26xr7Z4@aurel32.net>
Mail-Followup-To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-7-aefd3b7832df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-7-aefd3b7832df@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

Hi,

On 2026-03-16 15:03, Iker Pedrosa wrote:
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
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 404b69c47b91f8c37d74a3031dbad0d94a28d1b4..a7d480d01ccc0439dbf456ed5a81f467af68056a 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -222,7 +222,7 @@ buck3_1v8: buck3 {
>  				regulator-always-on;
>  			};
>  
> -			buck4 {
> +			buck4: buck4 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3300000>;
>  				regulator-ramp-delay = <5000>;
> @@ -243,7 +243,7 @@ buck6 {
>  				regulator-always-on;
>  			};
>  
> -			aldo1 {
> +			aldo1: aldo1 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3400000>;
>  				regulator-boot-on;
> @@ -369,3 +369,22 @@ hub_3_0: hub@2 {
>  		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
>  	};
>  };
> +
> +&sdhci0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc1_cfg>;
> +	pinctrl-1 = <&mmc1_uhs_cfg>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> +	cd-inverted;

Thanks for this driver. Unfortunately, this is not correct for the 
Banana PI F3. The OrangePi RV2 buffers the signal from the SD card 
connector through a transistor, inverting the signal. On the Banana PI 
F3, the signal goes directly to the GPIO, and does not even have a 
pull-up.

With the following change, I have been able to get the patchset working 
as expected:

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index a7d480d01ccc0..72b0f75f936aa 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -375,8 +375,7 @@ &sdhci0 {
 	pinctrl-0 = <&mmc1_cfg>;
 	pinctrl-1 = <&mmc1_uhs_cfg>;
 	bus-width = <4>;
-	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
-	cd-inverted;
+	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
 	no-mmc;
 	no-sdio;
 	disable-wp;

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
