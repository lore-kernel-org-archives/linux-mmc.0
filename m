Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598703783C7;
	Fri, 15 May 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834322; cv=none; b=bv+77L22DDUEfuDmlpg+Gk8q2AimE8P5aiBRGbIoHXqKpxQ3KsJYyXsfxMirIgTKLmdGv/EGnTp8HvaKTB1iuKXOycp6zJ9Mxu2wlOnFNAw+C+yW7BbgULlD6yN7EZZkc80Gq1UOJB77NYGSmHIbojmxVjswPqBLHJNPQIp7YZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834322; c=relaxed/simple;
	bh=XG/EIXPNvLdE4Zu7+fwLFVs1bcN3hpfAnJuJiRMQK8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XITe7kGPssx7mYbnAau2iON9+xMA7Wh44avvjnM35hWV0gOcHndbrDuXsIvyhug2EvxHe7Ja2UQHvOpuIBfXjZR5yWlGMdHnQGGoLJy5yQO43B9fte6QmMB2dGFkgCU+MJzV6T9u7fAdJ2icWDVkqAmvJYjTbpOR2qyH9x6rwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIyUlFzB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIyUlFzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8CFC2BCB8;
	Fri, 15 May 2026 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778834322;
	bh=XG/EIXPNvLdE4Zu7+fwLFVs1bcN3hpfAnJuJiRMQK8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIyUlFzBhF3evafEmZZ+zV9TWJ1hJCpJtMHjI3bgyw+cqyQn4oOphVQBuzK6qMLEB
	 5RIhJtqIrCrydi83/qgBq11w+Y9e2omf5yAvxGmJm56JPbEdlQoOAPp/mU6667A8/K
	 ZBCOqZfDt3URmkECODIU/fbib/VEyauKM5HfaAAVK7ymERpNsy2UoUERxuHDvSEQxh
	 zJEM9v54i6a0/w+gMrPoY50zXtXiW8OUeStnnIxkyr4K15zS8jEvaIx0jOhFfrMwDa
	 VM9DjcQ7x9UUcQ5qQVB4ANuyKOX8i9fqpacQVTbvkjKWhkW5vv35fwOCTKV0F2LBeM
	 An+at1x/2XLQw==
Date: Fri, 15 May 2026 10:38:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/9] arm64: dts: agilex5: add Cadence SD6HC controller
 and SOCDK enablement
Message-ID: <20260515-tuscan-spider-of-realization-ffafdf@quoll>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-4-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260511202132.5597-4-tanmay.kathpalia@altera.com>

On Mon, May 11, 2026 at 01:21:25PM -0700, Tanmay Kathpalia wrote:
> The Agilex5 SoC device tree gains an SD/MMC controller node backed by
> the Cadence SD6HC, with IOMMU integration via the system SMMU. Card
> power is supplied by a fixed 3.3V regulator and I/O voltage switching
> between 1.8V and 3.3V is handled by a GPIO-controlled regulator.
> 
> The SOCDK board enables the controller for SD-only operation in 4-bit
> bus width with high-speed and SDR104 UHS-I modes at 200 MHz maximum
> clock. SDHCI capability overrides clear the SDR50 tuning flag and
> override the clock base mask to report 200 MHz.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 38 +++++++++++++++++++
>  .../boot/dts/intel/socfpga_agilex5_socdk.dts  | 26 +++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 352c96d144a8..7e080f13166f 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -300,6 +300,44 @@ portb: gpio-controller@0 {
>  			};
>  		};
>  
> +		sd_emmc_power: regulator-fixed-3p3v {

NAK, this fails basic rules of organizing DTS/DTSI and the nodes. This
is simple-bus, so how could you have here a regulator which is non MMIO?

Plus, explain me how these regulators managed to appear on the SoC
die/silicon?

Best regards,
Krzysztof

