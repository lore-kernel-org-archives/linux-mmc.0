Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191737BE92;
	Fri, 15 May 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834257; cv=none; b=SNAIhIZcPQq8vh0oI/rfTMESwXTH2ktwRxrY7KOVchHkSmnkmmeXSNo7nGz47AzEiiOSqaEB7hBD/v1VYaLEYzM4BSTLP7mJohgRrxOC7UvLCe+Z+ot6//Fhr+S+EhbbYbOkqb8lu+5nNt5Uez7MC1GPZANG9juhObgFr3yzPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834257; c=relaxed/simple;
	bh=Xb3/rFZm8quAdmfCBcVLcrTPXxcmnubz0zWi4H3oHa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+GUf/eg9dsStz41A/yciNoSD50aNtAEoTWBJ515+EM2Wz/yeKKfk1BIXdLA25iDc+4/Clv/TF9DPWtmAJRuHa5wcUVCgPO0V2PEne6gUFd33cRrH4Afmm30gWNQ8Zw2ZfvSw4Olkusj8SK5KFiFda7YT9h0TCmx/R+aqwrMUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYZQrY2h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYZQrY2h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DBFC2BCB0;
	Fri, 15 May 2026 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778834256;
	bh=Xb3/rFZm8quAdmfCBcVLcrTPXxcmnubz0zWi4H3oHa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYZQrY2hmBlGh7hUrYA083VdIAS+tbri/UypZ4iyfJ65Dm1zYMnepL0aju+c7pnQc
	 dtCcISvdk75P4x++gvcMQsxNecKRNU84tnI0fCmxYtLgmplorGdWS89v9tlSwhqZyB
	 35B5G109LGPPoERxHlmJtNo1//EYTVTpK3YoY3kMmPXpXyKhWmtjaLyyCIH7s2h7EO
	 gBQA9cq37sgllV6WniN+22zO/H6PE+/S5shgUfHCQbG1cx68ElB5krgN0YcqqvEJFr
	 BfIYu6zTZlNqe6qSlMAJcM/7ciU0Qzhu7AfcIhaURDtmxuSGBucUuY8iZOsx1OuRKX
	 CDFiRRc2Jw/eg==
Date: Fri, 15 May 2026 10:37:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/9] arm64: dts: agilex5: add SOCDK eMMC daughter
 board support
Message-ID: <20260515-grinning-inescapable-butterfly-eba39d@quoll>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-6-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511202132.5597-6-tanmay.kathpalia@altera.com>

On Mon, May 11, 2026 at 01:21:27PM -0700, Tanmay Kathpalia wrote:
> Add device tree support for the Agilex5 SOCDK board variant with
> eMMC daughter card.
> 
> Update the SoC dtsi with a fixed 1.8V regulator for eMMC I/O voltage.
> 
> Add socfpga_agilex5_socdk_emmc.dts with eMMC controller configured for:
> - 8-bit bus width
> - Non-removable eMMC device
> - High-speed, HS200, and HS400 modes at 1.8V
> - 200MHz maximum frequency with SDHCI clock base capability override
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>  .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |   8 ++
>  .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 111 ++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
> 
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index 33fcc55d0cb9..5bbbcfda1f48 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -8,5 +8,6 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>  				socfpga_agilex5_socdk_013b.dtb \
>  				socfpga_agilex5_socdk_modular.dtb \
>  				socfpga_agilex5_socdk_nand.dtb \
> +				socfpga_agilex5_socdk_emmc.dtb \
>  				socfpga_n5x_socdk.dtb
>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 7e080f13166f..feb4ccb317a7 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -317,6 +317,14 @@ sd_io_1v8_reg: regulator-1p8v {
>  					<3300000 0x0>;
>  		};
>  
> +		emmc_io_1v8_reg: regulator-fixed-1p8v {

How is this property of a SoC? How SoC itself has a fixed regulator for
EMMC? Really?

Best regards,
Krzysztof

