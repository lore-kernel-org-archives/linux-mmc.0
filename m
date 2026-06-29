Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667902DF6EA;
	Mon, 29 Jun 2026 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716850; cv=none; b=PShbyJD+raVj3BRwN97idC64PZ3+mqetU4Nysep42jM2/xu90ZOuQiRfhdah9PKG8cB59nc8le32e1hwbhd3m7eYGs4sBCUHt66ooFZY8iQ+RMJCqNzWibq5OIA3XULZ+sY3HmHkh2JUTWWV7Rx1snx0svMEcrvJyvxoyjrTxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716850; c=relaxed/simple;
	bh=RabWbNxVVw5+wsSfwokvLyo8cCIxRtNUHYXURlhxNGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev9KSnBNbJTdVVVnGYkTGO3VftsaakrgGEWrAI15womiV43FEQfKzUDMI69EjAYkb+Tq4Cao+CLF3mNyJYCDhZSvvVDMNs1GudNOsCWGxI9uHJL/Om1zPqobshpYv3zjCpPppOTOUFaMTEpG4bvwtdcghnvNn4aCsUsavsgcKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwnQe0Gx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwnQe0Gx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D827D1F000E9;
	Mon, 29 Jun 2026 07:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782716849;
	bh=RIf7bEwC3Pbgc+fNYSyHu70M4rQWzPypAFIrNhVkzfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bwnQe0GxhfRfkTQd3zcmCi2lBB3MWpbiLY8ZwtYB9kghATt3tRrZFIdZISXP85n0a
	 OfkKMaTMYR9GeXs5BKO9tuymVW0DMvUNH1TlmFLWH+iRoFrRyR8+QroaHKw3/oVWPx
	 7P8elPGD8Fc/yQkgtaHPNJRotHAYEQgb9d0xQiXylWsmq8macGpklirfateWX2SoZP
	 rxtOMTca14R10r8b0aYzst92ljVy/1SLLbkshMzoqF8eU6Gf8sKOtGiQwTgGXN0El3
	 k5i0aUSwD7fCZZrVtflxGhxz/HfJR6UVyZxL8fWir/ITJ3Tprii7153lwuvtpYT84C
	 Zy+tZnvbJ8J4g==
Date: Mon, 29 Jun 2026 09:07:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] arm64: dts: agilex5: add SOCDK eMMC daughter
 board support
Message-ID: <20260629-wild-dramatic-clam-80eb5c@quoll>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-6-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260627201457.12318-6-tanmay.kathpalia@altera.com>

On Sat, Jun 27, 2026 at 01:14:50PM -0700, Tanmay Kathpalia wrote:
> Add socfpga_agilex5_socdk_emmc.dts for the Agilex5 SoCDK eMMC daughter
> board variant. Define board-specific regulators at the DTS root: a
> fixed 3.3V supply for card power and a fixed 1.8V supply for eMMC I/O
> voltage.
> 
> Enable the shared SD/eMMC controller for eMMC-only operation with an
> 8-bit bus, HS200 and HS400 modes at 1.8V signaling, and a 200 MHz
> maximum clock frequency.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>  .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 120 ++++++++++++++++++
>  2 files changed, 121 insertions(+)
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

Same mistakes... Do not introduce random order.

Best regards,
Krzysztof

