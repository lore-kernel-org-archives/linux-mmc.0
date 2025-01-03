Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD11FA8F3;
	Fri,  3 Jan 2025 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917633; cv=none; b=XwJ64Stz81IQ9EnxRNVKcTrFOJNm3An0xp06Ze7DMtMSd+0BKlH2af0Z+TdzrpteypedGq2VECRz8ayZbrch7S1InbulAVgKzyBSMLiOVjci10RnYP6qAe9upqz823KQKssmzUk/jJ+p0oxIPt/zWcsOlUcvFtvphSxXvc/CJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917633; c=relaxed/simple;
	bh=OQotMPthgURrK4NyFLK+Ka0bfbaNpftNzQuniOt335w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=b4nBchzOwjugjiqwt6kN0XRRLSvaacqAuxBPRyS3EqOEflqen+ENG/HeJrYRLRNYi/aShatZSKeJ3Z83SsUXBZ3i/yPuLnYGrhl3dGkUC/mYDas9FSEvbcTOE/x9EAxM1lQwGnC4PAX8cFZNvuv7Svcwtj1bTWs3JYsYa7tRKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+zUBjVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+zUBjVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6355C4CED6;
	Fri,  3 Jan 2025 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735917632;
	bh=OQotMPthgURrK4NyFLK+Ka0bfbaNpftNzQuniOt335w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=P+zUBjVHiN5LrRa9QQqPpsDY9OUYrl1tUTMJ/I3TPaUNqhpdtk6zy7AMrn44a7Wzf
	 5cBMC8xQZQvCbDK9JXVBHfYeoA2Y5aWBY8vZNYUi4KIw2zeIq1IpysKmkdAB1kSMFe
	 Q9ft+8yR7OfBljWqR8AffuSQ2fOq1I6nUlEiZ7CrHmPZvqQB2sMoQKSMnKaZ94xYRH
	 smPROd6m73XnmPLXgTzmkbSzS9RqnO1X2zFZdiFxn2deJvlXioAdGuQ9Rm9XEztEQ2
	 9bFM276246cnQnJwciZwyq5GPlIOW7vZLz6NcrtOVrGnKVn3PBuCzsfZmtDUvj0woR
	 6TwN/2fbhCxCA==
Date: Fri, 03 Jan 2025 09:20:31 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com>
Message-Id: <173591745832.2305341.4361607015231954485.robh@kernel.org>
Subject: Re: [PATCH v1 0/5] arm64: dts: exynos8895: define usi and mmc
 nodes


On Thu, 02 Jan 2025 22:58:41 +0200, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This patch series adds the required syscons for controlling USI, as well
> as defines all USIv1 nodes for Exynos8895 and adds support for utilizing
> the external SD card storage in dreamlte. Due to PMIC not being supported
> yet, we'll assume that the regulators are pre-enabled by the previous
> bootloader for vqmmc. (in our case uniLoader).
> 
> The patchset relies on [1]. I also expect the exynos mmc binding
> maintainer to pick the specific-compat patch.
> 
> Best regards,
> Ivaylo
> 
> [1]: https://lore.kernel.org/all/20250102204015.222653-1-ivo.ivanov.ivanov1@gmail.com/
> 
> Ivaylo Ivanov (5):
>   dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for
>     exynos8895
>   arm64: dts: exynos8895: add syscon nodes for peric0/1 and fsys0/1
>   arm64: dts: exynos8895: define all usi nodes
>   arm64: dts: exynos8895: add a node for mmc
>   arm64: dts: exynos: exynos8895-dreamlte: enable support for microSD
>     storage
> 
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   1 +
>  .../boot/dts/exynos/exynos8895-dreamlte.dts   |  39 +
>  arch/arm64/boot/dts/exynos/exynos8895.dtsi    | 906 ++++++++++++++++++
>  3 files changed, 946 insertions(+)
> 
> --
> 2.43.0
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y exynos/exynos8895-dreamlte.dtb' for 20250102205846.223955-1-ivo.ivanov.ivanov1@gmail.com:

arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/syscon@10420000: failed to match any schema with compatible: ['samsung,exynos8895-peric0-sysreg', 'syscon']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10440000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10440000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10440000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10460000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10460000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10460000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10480000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10480000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10480000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@104a0000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@104a0000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@104a0000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/syscon@10820000: failed to match any schema with compatible: ['samsung,exynos8895-peric1-sysreg', 'syscon']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10840000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10840000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10840000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10860000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10860000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10860000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10880000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10880000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10880000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108a0000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108a0000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108a0000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108c0000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108c0000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108c0000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108e0000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108e0000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@108e0000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10900000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10900000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10900000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10920000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10920000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10920000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10940000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10940000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10940000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10960000: failed to match any schema with compatible: ['samsung,exynos8895-usi']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10960000/i2c@0: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/usi@10960000/i2c@10000: failed to match any schema with compatible: ['samsung,exynos8895-hsi2c']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/syscon@11020000: failed to match any schema with compatible: ['samsung,exynos8895-fsys0-sysreg', 'syscon']
arch/arm64/boot/dts/exynos/exynos8895-dreamlte.dtb: /soc@0/syscon@11420000: failed to match any schema with compatible: ['samsung,exynos8895-fsys1-sysreg', 'syscon']





