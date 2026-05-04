Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E31B86C7;
	Mon,  4 May 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880591; cv=none; b=JGG2UAzDlsEUcrqY7eS0IdfErF2VIYUCMQkwAYe41+510UZ3GtSfyLa2MpPhqVj3DZWD+PxGW6Ui/SRyldorDUR0JifQg7T4sWNc15dJRFDUxXanllrNmhjdFgyPwP+SeGMIDpGuDxsCKzshciIQ6fLRnNHUQ1HFFz5351mg140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880591; c=relaxed/simple;
	bh=bh3ovJn8JLAnMA6CkcWRCD4kPhHdbml/zu3lMDSb1RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3bWlcw6pS/fA4oZmpbmzI4hoHFL5fCgoVk0RpPjDCFg73dPKqlBqVkTWZrPyD7k6q2T0e+KJ5S5q/wBp1cV70mbSMYaCrMOTQ2EvkXB+07JEVakyaii4yX5rFqELnOuTCCpK6wzjbnFB1MeaCYH2be/pPfMWE5pwREVj7V25uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKOgHeZ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKOgHeZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE1EC2BCB8;
	Mon,  4 May 2026 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777880591;
	bh=bh3ovJn8JLAnMA6CkcWRCD4kPhHdbml/zu3lMDSb1RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKOgHeZ6BLbhYsIpmwAGs+SKNBdrrgcP5q1TudtvunigHspULJx2czDG7Kgk9/xrh
	 zVqiGLWk1CEdJuCvT1DJ9j+VHOv7ENLBgPtstZaqKQUeUscvTqAry7kyGq3O3NRz7/
	 B+3cX8hcdsMVtkryCxnc502zF8p52eoLydJIXnYUC6eBXOMctrw0LOa++TWbnbh9xg
	 QTjCCeAsgJEPZKx+r9PGsWPw9UbGOvTPH71s7dGvlvXHRlvaAqxaEzbMOF1r71QT/n
	 onle774duGjhWcg6V6r7kzaNNcaSLR5pnxqca0UZkwv2cSAXsF6w9SddZJmGZyPTiD
	 km5GQzqwRgvKQ==
Date: Mon, 4 May 2026 09:43:08 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: st,sdhci: convert to DT schema
Message-ID: <20260504-rational-gleaming-clam-aeaaff@quoll>
References: <20260503-st-mmc-v2-0-11ae3216d2ce@gmail.com>
 <20260503-st-mmc-v2-2-11ae3216d2ce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260503-st-mmc-v2-2-11ae3216d2ce@gmail.com>

On Sun, May 03, 2026 at 08:35:30AM +0000, Charan Pedumuru wrote:
> +$id: http://devicetree.org/schemas/mmc/st,sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics SDHCI-ST MMC/SD Controller
> +
> +description:
> +  The STMicroelectronics SDHCI-ST MMC/SD host controller, which is
> +  compliant with the SD Host Controller Interface (SDHCI) specification and
> +  is used to interface with MMC, SD and SDIO cards. The ST SDHCI controller
> +  extends the standard SDHCI capabilities with platform-specific
> +  configurations such as additional register regions,clock inputs, and delay
> +  control mechanisms required for signal timing adjustments which are
> +  necessary to support high-speed modes and ensure reliable data transfer
> +  across different ST SoCs.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +maintainers:
> +  - Peter Griffin <peter.griffin@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: st,sdhci
> +      - items:
> +          - const: st,sdhci-stih407
> +          - const: st,sdhci
> +
> +  reg:
> +    minItems: 1
> +    items:
> +      - description: Base address and size of the MMC controller registers

s/Base address and size of the//

> +      - description: Base address and size of the MMC delay/auxiliary registers

Here the same

> +
> +  reg-names:
> +    oneOf:
> +      - items:
> +          - const: mmc

Drop three lines above

> +      - items:

So this is just items like you have in "reg" part. Same syntax.

> +          - const: mmc
> +          - const: top-mmc-delay
> +
> +  clocks:

Here and:

> +    items:
> +      - description: Clock for the MMC controller
> +      - description: Interconnect (ICN) clock
> +
> +  clock-names:

here: Old binding icn is optional. You need to explain in the commit msg
all the changes done during conversion.

> +    items:
> +      - const: mmc
> +      - const: icn
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: mmcirq
> +
> +  resets:
> +    maxItems: 1

Best regards,
Krzysztof

