Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8722C235B;
	Tue, 23 Dec 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500986; cv=none; b=kLByJBT6nqIOa4ggZaO+Ab9Ms6NTJSiEmokx0rj0fvP5ROa1Eh4pbYLRix6C+teUPywZsyCOIaW9TGerrg0l4J4+vBpVBvFIarjtlXp7SFR5v8BKGHEBkF2TNGPBLKzptjTc/RCeGAwilM4OpvkXdorsKOP8f448JXsY0d0g/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500986; c=relaxed/simple;
	bh=dGSBxeN+GJn8mz9SDAWxeBi3X526sNdmyiKL7f116Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4sGvzsmECASLxsGMTKymrPVvEIRfuy6FizYZcK+CO5Sq5hXRdbj+7069+BiHRXKnIHvqzV/x0CyJev06BuS5/ZMtCKLyIZwo9XSk0gXYZZWmgfK7reOSeqT/oRbqHSbCsaF/jF7nyHn5Sx4s5Rh2eWeYFjq0kX3OvbATlxZiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyEpcvzH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyEpcvzH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53F5C113D0;
	Tue, 23 Dec 2025 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766500985;
	bh=dGSBxeN+GJn8mz9SDAWxeBi3X526sNdmyiKL7f116Nw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyEpcvzH4PwQr/eYYz4pV3Iuv3i/sytNejmHJENaBgTrHpnSJoSMnGv8sH/OPw4Ho
	 YPEmxA6fUIEyBjWOtCgMACSdqd+C38RQQsv+/6uBEdDFda46W05bYcZkH35M9gg33B
	 FguIvh641Y2VVbc3+ZSpCZjLXs90S4jGfqgbvP/rrBp3v7+703iaLTBmfLNv5R1vfo
	 icyIZ+s7TQnI0q4PW0nDAM1DtIIuDRIZWwXr7faZu+nS5Pzaxsolyuavt4TmezVWvU
	 4EIYNUh3yHfdmNvtGMfUuoCPviIsFVwC0onrs6n+7xtUj3PaCdqSzVAXf3Mhsyl+eH
	 4xpWkzlI0tmSw==
Date: Tue, 23 Dec 2025 15:43:01 +0100
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
Subject: Re: [PATCH 5/8] dt-bindings: mmc: axiado: Add axiado eMMC variant
Message-ID: <20251223-ludicrous-carmine-mushroom-983c69@quoll>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-5-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-5-5457d0ebcdb4@axiado.com>

On Mon, Dec 22, 2025 at 04:45:04PM +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Add device tree binding variant for the Axiado AX3000 Arasan eMMC
> controller. This variant identifies the specific eMMC controller
> implementation used on the AX3000 SoC and enables the appropriate
> driver configuration.
> 
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 8e79de97b242a698a2c555b0b94e2975b1761710..47d0e35efea00bf7b1927bd0cfa39c86f0137d44 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -106,6 +106,12 @@ properties:
>          description:
>            For this device it is strongly suggested to include
>            arasan,soc-ctl-syscon.
> +      - items:
> +          - const: axiado,ax3000-sdhci-5.1-emmc
> +          - const: arasan,sdhci-5.1
> +        description:
> +          For this device it is strongly suggested to include
> +          clock-output-names and '#clock-cells'.
>  
>    reg:
>      maxItems: 1
> @@ -334,3 +340,15 @@ examples:
>                     <&scmi_clk KEEM_BAY_PSS_SD0>;
>            arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
>      };
> +
> +  - |
> +    mmc@86000000 {

No need for a new example. Please writing bindings and writing schema
docs first.

Best regards,
Krzysztof

