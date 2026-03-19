Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45566385509;
	Thu, 19 Mar 2026 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773885188; cv=none; b=J7FGO5RIZZqIr5lZ1SEuPafqA5oauTfCToyBSi1GIgxjgE+LyKHXKcInU2mcIV4Q3o/0PQkJCMJLxtZxoYeKMiKtLP/SABHPY+QlDGhCgQJcnGBP3Sy0oEN+qGKP5f4SiIaDYvUJx5JqSx86qeUQe3BIUEQo/EETfCXZlO4/YRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773885188; c=relaxed/simple;
	bh=0E5OqoKU9mNupvcGG7Hc3GPoauqIcESgXzJArXxkHDg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLwWCxED2X35sz3UEV19qp0w7TtsJEMyeKbmMwrd82nmYNKSyntVnc8lJOwPnr55b9AUICnWorH7vedhicA45/tyCLBl3gAY/CmdrpPFFCwg/pitdbxStujJHkJwVl1Rp0iCo0psg1AvsTz5waya0HG2w/fGXlS0cKR3Sq4QJH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSLcPVWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSLcPVWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D009C19421;
	Thu, 19 Mar 2026 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773885187;
	bh=0E5OqoKU9mNupvcGG7Hc3GPoauqIcESgXzJArXxkHDg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=pSLcPVWMa+BVZkgO5QU9TWEWwO46D3ZCp6PuP1rL14PuTB5QVLPGs+EnBUFsBQdEO
	 cYwf+AvQGnbBvahVxPzDzTfbLLKOuBSdj2Nhog5MfpCY3pHL2xFWeIG64gu2ANaNev
	 CmfGqIwmuKWsxaSaSPKcSibP5RAqfyclpuhkofyvUBsMeRsLeMHHG1g939ecovHH+u
	 8+spxu7zhMfpLrpPAcBtD8UKBFvARQPB7FhdsyyF10F4je6O1cRmCPzHnHG72GvjOk
	 fmnyAlBkGhAw0FoV1TW4yMiZG5LbCyorWpWFzW3LC+WbDEl6Z+sFXQtup8gEUMXY3m
	 AJxrBFqB4k06w==
Date: Thu, 19 Mar 2026 09:53:05 +0800
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v3 7/7] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Message-ID: <20260319015305-GKA489299@kernel.org>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-7-aefd3b7832df@gmail.com>
 <absKDGLCw26xr7Z4@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <absKDGLCw26xr7Z4@aurel32.net>

Hi Aurelien,

On 21:24 Wed 18 Mar     , Aurelien Jarno wrote:
> Hi,
> 
> On 2026-03-16 15:03, Iker Pedrosa wrote:
> > Add complete SD card controller support with UHS high-speed modes.
> > 
> > - Enable sdhci0 controller with 4-bit bus width
> > - Configure card detect GPIO with inversion
> > - Connect vmmc-supply to buck4 for 3.3V card power
> > - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> > - Add dual pinctrl states for voltage-dependent pin configuration
> > - Support UHS-I SDR25, SDR50, and SDR104 modes
> > 
> > This enables full SD card functionality including high-speed UHS modes
> > for improved performance.
> > 
> > Suggested-by: Anand Moon <linux.amoon@gmail.com>
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > index 404b69c47b91f8c37d74a3031dbad0d94a28d1b4..a7d480d01ccc0439dbf456ed5a81f467af68056a 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > @@ -222,7 +222,7 @@ buck3_1v8: buck3 {
> >  				regulator-always-on;
> >  			};
> >  
> > -			buck4 {
> > +			buck4: buck4 {
> >  				regulator-min-microvolt = <500000>;
> >  				regulator-max-microvolt = <3300000>;
> >  				regulator-ramp-delay = <5000>;
> > @@ -243,7 +243,7 @@ buck6 {
> >  				regulator-always-on;
> >  			};
> >  
> > -			aldo1 {
> > +			aldo1: aldo1 {
> >  				regulator-min-microvolt = <500000>;
> >  				regulator-max-microvolt = <3400000>;
> >  				regulator-boot-on;
> > @@ -369,3 +369,22 @@ hub_3_0: hub@2 {
> >  		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
> >  	};
> >  };
> > +
> > +&sdhci0 {
> > +	pinctrl-names = "default", "state_uhs";
> > +	pinctrl-0 = <&mmc1_cfg>;
> > +	pinctrl-1 = <&mmc1_uhs_cfg>;
> > +	bus-width = <4>;
> > +	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> > +	cd-inverted;
> 
> Thanks for this driver. Unfortunately, this is not correct for the 
> Banana PI F3. The OrangePi RV2 buffers the signal from the SD card 
> connector through a transistor, inverting the signal. On the Banana PI 
> F3, the signal goes directly to the GPIO, and does not even have a 
> pull-up.
> 
> With the following change, I have been able to get the patchset working 
> as expected:
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index a7d480d01ccc0..72b0f75f936aa 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -375,8 +375,7 @@ &sdhci0 {
>  	pinctrl-0 = <&mmc1_cfg>;
>  	pinctrl-1 = <&mmc1_uhs_cfg>;
>  	bus-width = <4>;
> -	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> -	cd-inverted;
> +	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
Have to mention, to use the pull-up, the patch to support gpio config should be applied
https://lore.kernel.org/r/20260312-k1-gpio-set-config-v1-0-8c3541da16b1@pigmoral.tech

if you don't want to introduce the dependency, add "broken-cd" property
should also workaround this..
>  	no-mmc;
>  	no-sdio;
>  	disable-wp;
> 
> Regards
> Aurelien
> 
> -- 
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net

-- 
Yixun Lan (dlan)
