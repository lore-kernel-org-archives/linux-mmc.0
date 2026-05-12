Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02FB3D75B6;
	Tue, 12 May 2026 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564646; cv=none; b=bULcmtYesV6nWcPBtsBDDCoaglPrny/VEXlghmlYIL2BLjMtV2Bby/whZ/AYChLc6KyujWAHMVn6116WbYWqSucLJuz/cr/VNYCzE10o4NKuYMGS0w5qX8s05QTrnrbuCTPX5tekZCiNqOH4rcJKUBhUbGrazON1FvUznzqXJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564646; c=relaxed/simple;
	bh=8knoL5yl+L/C1sO73WYMrEIqVvOTPdr2v82r8D/MlYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvZcLWX6VK9y7oap1k/wYe1XpniK8MNNpD5vkC9wlzdvI3cVodfaP9V/QmQHYOJB3cvZUZgGyap1T3gDTEbx9jrcM0M0TDRlDP32FtKpHl5wwEgg/GJmQID1b/AZsqq9ipR60x/2qxgQ01mrH1MwXE/qw50HDbiW1CrinfNaznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAsFfDP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAsFfDP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE32C2BCB0;
	Tue, 12 May 2026 05:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778564641;
	bh=8knoL5yl+L/C1sO73WYMrEIqVvOTPdr2v82r8D/MlYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAsFfDP93SdyCex0eOLxjTPzb+hB66LGW0zPAflAuQTW6kShm78EL/2RCIIES6gvT
	 mrRnNz6EJ1cg2tvH9CMEzndU0Eu9gmPMHy9il0MIE2Hc7iQ3oG6DWta371i2NGLyGB
	 6oR6EF0SI1JvI3AnOGDadLeVLhYdXBNMU3eGdt5jPKzbjMMDPpzp9loRwfOj9PT1YG
	 ATcTOWbf8HkUfej7yOecqVv6jkgi3vtK5tA9S24Dyf/AzOkOAaC5XhoWYbNQrFvoBN
	 CidtdC2+K2AOyUQ6ZFLyIFsny+FFOc+HpKTzlMoNiVQ0jnwkOrBAxMOcsLMJ7SwDOv
	 DoWzjh7BrnQEg==
Date: Tue, 12 May 2026 05:43:58 +0000
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulfh@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>,
	Margherita Milani <margherita.milani@amarulasolutions.com>
Subject: Re: [PATCH v9 7/8] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Message-ID: <20260512054358-GKE3624147@kernel.org>
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
 <20260511-orangepi-sd-card-uhs-v9-7-ae48c0b2b2cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-orangepi-sd-card-uhs-v9-7-ae48c0b2b2cf@gmail.com>

Hi Iker,

Please note, once you are sending new patch series, please drop patch 1-4
which already picked by Ulf, but keep increase the version number


On 10:54 Mon 11 May     , Iker Pedrosa wrote:
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
> Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index e20daa50a152..8fea6e87acec 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -221,7 +221,7 @@ buck3_1v8: buck3 {
>  				regulator-always-on;
>  			};
>  
> -			buck4 {
> +			buck4: buck4 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3300000>;
>  				regulator-ramp-delay = <5000>;
> @@ -242,7 +242,7 @@ buck6 {
>  				regulator-always-on;
>  			};
>  
> -			aldo1 {
> +			aldo1: aldo1 {
>  				regulator-min-microvolt = <500000>;
>  				regulator-max-microvolt = <3400000>;
>  				regulator-boot-on;
> @@ -374,3 +374,21 @@ hub_3_0: hub@2 {
>  		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
>  	};
>  };
> +
> +&sdhci0 {
I'd suggest to add alias (to 'aliases' node), so we will have stable
dev node regardless whichever device probe first.. something should like
	aliases {
		..
		mmc0 = &emmc;
		mmc1 = &sdhci0;
		..
	}

So, how about let's make it convention here, first device is emmc, second
is SD card, third is sdio device (haven't added yet).. We introduced emmc
early before this patch, so it stays unchanged which is nice for end user

Please apply this alias idea to all boards although I only comment in this
patch..

> +	pinctrl-names = "default", "uhs";
> +	pinctrl-0 = <&mmc1_cfg>;
> +	pinctrl-1 = <&mmc1_uhs_cfg>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	no-mmc;
> +	no-sdio;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	vmmc-supply = <&buck4>;
> +	vqmmc-supply = <&aldo1>;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +};
> 
> -- 
> 2.54.0
> 

-- 
Yixun Lan (dlan)
