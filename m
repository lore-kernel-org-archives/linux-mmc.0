Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B034214F;
	Tue, 23 Dec 2025 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500448; cv=none; b=iYGjUL1lwelnomxDogpGbFFSTJq+KakofM7ei+IvAnO92jvUhmRPz1oqSebsdRFx4ic0BkGy0P/Uq7cSpEjyqoxhLvTXltnTgxP/+puag5ze+/EiAP9tarn8RZXLwpuLVTtCZVBX+0FmpQ2JXF9N7ueJk/t6rze61vNuDk83PaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500448; c=relaxed/simple;
	bh=/WkCZpcjC5bw20Uuag2CiawKOzwJcdpsoXAnM2eGkLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okianr5ymKz3kVyJvQou37XV/OVsfF2JFprMYWsxLiCwYG3w9i4hl0nM4FY7yPHwlOaieeasKVyLbyr5x0eH3k4Of22uQBaaHZ9CqxWaGiQj5Ze/pmplGpK9RI9zjm5U3hN/V8GBs8ca3YrnxLzx5nHSAUkCdIZr099iRZW0Noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZc2WNwR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZc2WNwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C85EC113D0;
	Tue, 23 Dec 2025 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500448;
	bh=/WkCZpcjC5bw20Uuag2CiawKOzwJcdpsoXAnM2eGkLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZc2WNwRe5BY6dEFOqXYosiONReBdWsxoeFfucODmACjHaOSmpdo9b9r3QahCF8TV
	 CDH9TYhuALO1FriHVG4lY74lmjhvE235sCsINPCCicWqAPVq2FCo/jyfgBavtLz6ab
	 DbluFXKUtUgDI5yy3licU5ECnLqVcd5H9Lxcg/pmKoq0rysWLVNZNcskSDVbWKsRLV
	 rwSiTzN41vNo3YMq2Z4ULM+iB2BHONgefBzB0k2wiZKkOcp1Wbz0lcynuu5zgr/zpw
	 Eq4p17nTRn6tfmq+I+W8uyGSSN2XkQKPqA1zNua5QFdKs2aKDWvcAiUb78+H9hFR+o
	 M4PHPbIX14oQw==
Date: Tue, 23 Dec 2025 15:34:05 +0100
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
Subject: Re: [PATCH 6/8] mmc: host: axiado: add AX3000 eMMC PHY support to
 sdhci-of-arasan
Message-ID: <20251223-optimal-ochre-kestrel-a8cb1c@quoll>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-6-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-6-5457d0ebcdb4@axiado.com>

On Mon, Dec 22, 2025 at 04:45:05PM +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Add support for the external eMMC PHY used on the AX3000 SoC in the
> sdhci-of-arasan driver. The default Arasan host driver operates at
> 25 MHz, but with the external PHY support, the controller can achieve
> HS200 mode operation at 200 MHz.
> 
> This change integrates the AX3000 eMMC PHY driver with the existing
> sdhci-of-arasan host controller driver to enable high-speed eMMC
> operations.
> 
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 20 +++++++++++++-------

Why do you mix mmc, phy and soc into one patchset?

>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index ab7f0ffe7b4f007a58eb0a26868b08b0b02b40f3..2d4f64e9014ae168957113478edc11209cd76b64 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1547,6 +1547,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>  		.compatible = "arasan,sdhci-5.1",
>  		.data = &sdhci_arasan_generic_data,
>  	},
> +	{
> +		.compatible = "axiado,ax3000-sdhci-5.1-emmc",
> +		.data = &sdhci_arasan_generic_data,
> +	},
>  	{
>  		.compatible = "arasan,sdhci-4.9a",
>  		.data = &sdhci_arasan_generic_data,
> @@ -2019,15 +2023,17 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  			goto unreg_clk;
>  		}
>  
> -		host->mmc_host_ops.hs400_enhanced_strobe =
> +		if (!of_device_is_compatible(np, "axiado,ax3000-sdhci-5.1-emmc")) {

No, don't sprinkle compatibles all around. You should use driver match
data for this.

Best regards,
Krzysztof

