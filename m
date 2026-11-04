Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800693;
	b=IdhWxPfLqWSzznZPQ86w3ehCdYXtM14RTX9FHxADvcsDNKysu9/NfYPs8X7ThQNf6LeY
	 yeA4mDA/p+oaW2Z4h1/u6M3s69MZ+Uh1J6Ag9ESnUR65D2kual+n21ZfDdtc6BdWEUx6x
	 4Y2upgxzZd9RC1bd8Tp2gsXHuZVhtnVRLI7U91HMTJXzl13pn0JAzLxx8IYvXS/he9t/1
	 mdIsAl85x2C2VSxfwXRpkAU2maNRWhk8Qu7lk+gfnijpBChUzBno9/Zbm/0D7RBkL85r2
	 FiSBFkrYiI0suMENmVtmn9I5kYB0ZxOEPE89ykDX4NWk8YGMhDMkk2vCnDtWgEFOL9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800693;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MVb4xfaJpwASIoo3kcJhurqFBOJZHmuInHRi0LnZvsM=;
	b=OFd2kcCcXEtkF8vjrr05ftGSLnxGvqtndQtNyuUIH+qV0lne4gp+vf9WUniMv873/Sq9
	 2kehoCDdcDea20s0D1UviX8KjQfRP22SKUjphhrtHNppXbBYiRWMzTUn4hY0qDBbwG+da
	 jB2paD71qEq2j03fXMudWaVL9acEB9Zy77wAzizm3NQCuaUSBIkYx9iWvcaerRqFdxjSw
	 SqniuH2NmAGZRgI2xNMP0ftYNu5Xv25YDQ34J1KS5qnndYvWZZ+z+OtrBJdErV8tFG4DZ
	 jrRKvhUsKU1APil5a2d040vniDWqwn/CbF1/hHWjXlu61xtTs+aRJiyy4LNc/XlvwcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iOcpw/0d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208B606A31B;
	Wed,  4 Nov 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iOcpw/0d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBB01F00919;
	Wed,  4 Nov 2026 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793800692;
	bh=MVb4xfaJpwASIoo3kcJhurqFBOJZHmuInHRi0LnZvsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iOcpw/0dpOwggrkLnLfdRLMAIveL90b8yXI1iYF1Whzpuo2o4uwo0wrTqjcVcxEvF
	 4OI5azIqfEUSJM2/aTvXK6Puy9cLMTMgk5xvje19dYP8yCVmlgWiQgt/ChVv/95Hfl
	 8UQckql552xiwQjz496vJ4k3kwlVZZdChOL44VNXB1rNzgXRY1HmLQyEnEUhmNNJkd
	 gW6jM1i2q+z6X97WkTpnMwO2p8GPc6zNcWV1JG7UCdspIcLwfrwuxdGcVM/Qv6GSLC
	 V+gadUysf8v+45NbsTY2kZIRvZqCsOHHYEdNhwAtH+QvrCHh38w5S8pJii8v2KKC88
	 3vmfWWoW9rJyg==
Date: Wed, 4 Nov 2026 14:58:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Anjana Hari <anjana.hari@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shazad Hussain <shazad.hussain@oss.qualcomm.com>, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Nitin Rawat <nitin.rawat@oss.qualcomm.com>, Ram Gupta <ram.gupta@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document bindings for
 Nord SDCC
Message-ID: <20261104-sticky-perch-from-sirius-d3ebb3@quoll>
References: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
 <20261102-sdcc_scmi-v1-1-244dbd893051@oss.qualcomm.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102-sdcc_scmi-v1-1-244dbd893051@oss.qualcomm.com>

On Mon, Nov 02, 2026 at 07:33:41PM +0530, Anjana Hari wrote:
> Add Device Tree binding for the Nord SDHCI variant of the Qualcomm
> sdhci-msm controller, where platform resources are managed by firmware
> through the SCMI power protocol rather than being directly accessible
> to Linux.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Unlike existing sdhci-msm variants, this binding does not require
> clock, interconnect, reset, or regulator properties. Instead, platform
> resource control is abstracted behind two logical power domains:
> 
>   - "power": controls the SDCC rail power state. The kernel requests
>     power-on and power-off transitions via the runtime PM framework;
>     these are forwarded to firmware as SCMI power-state messages.
> 
>   - "perf": exposes the supported clock frequencies as OPPs populated
>     dynamically by the SCMI perf domain driver at probe time via the
>     SCMI performance protocol. The driver selects operating points via
>     dev_pm_opp_find_freq_floor() and dev_pm_opp_set_opp().
> 
> Both domains must be listed under power-domains with their names
> declared in power-domain-names.
> 
> The compatible string "qcom,nord-sdhci" selects this variant at probe
> time and causes the driver to attach the two power domains via
> dev_pm_domain_attach_list() with PD_FLAG_DEV_LINK_ON, ensuring correct
> suspend/resume ordering between the SDCC controller and the firmware
> power domain devices.

Do not describe driver. How is it exactly relevant here for the hardware
description?

> 
> Signed-off-by: Anjana Hari <anjana.hari@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/mmc/qcom,nord-sdhci.yaml   | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml b/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml
> new file mode 100644
> index 000000000000..c512628617b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/qcom,nord-sdhci.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/qcom,nord-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Nord SDHCI Controller
> +
> +maintainers:
> +  - Anjana Hari <anjana.hari@oss.qualcomm.com>
> +
> +description:
> +  SDHCI (SD Host Controller Interface) present on Qualcomm Nord SoC.
> +  Clock and power resources are managed by firmware through an SCMI
> +  server, so no clock entries are required in the device tree node.
> +
> +properties:
> +  compatible:
> +    const: qcom,nord-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: hc

Where is CQHCI?

> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: hc_irq
> +      - const: pwr_irq
> +
> +  iommus:
> +    maxItems: 1
> +    description: phandle to the apps SMMU node with SID mask.

Drop description

> +
> +  dma-coherent: true
> +
> +  power-domains:
> +    maxItems: 2
> +
> +  power-domain-names:
> +    items:
> +      - const: power
> +      - const: perf

Best regards,
Krzysztof

