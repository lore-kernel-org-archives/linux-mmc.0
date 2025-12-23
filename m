Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9452F39B1;
	Tue, 23 Dec 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499803; cv=none; b=NO/Aw6wwtcJ3W6nLGC1gfiZvbicD4aJlq7RGEcMtLFmwj3cY0yaYfYlpBw4WAxsdCh52pXOT/ztykkfz6QZL/rFPKMkyRETFylpmjMZYwh1nqGlRffqthhEVDQ7aWaWLOMxR+cqfbFSlZuv99XYRl9vYkSnGlm79GEqanIq4pWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499803; c=relaxed/simple;
	bh=dL54WGAJEIPqhAAVO0KPXAc3S1Hb2d8e3/d03vmvnlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSXqzHp9Orm2GObGSX2Vr7LmfhIHPdoLWUuLMV6dCW0EnB2gSl/9/KHkluVtNfuXNbrF3qXr+9K887Xs8yed1MLL5pjrS15oAt43wjUnPPXDcW+5+Pm0XMlWWm5YiqdWZOHK1kreSBaMj0vLB5QWXDM32rgmcwWeERkhSPwjfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtU9/nfa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtU9/nfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3F3C113D0;
	Tue, 23 Dec 2025 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766499802;
	bh=dL54WGAJEIPqhAAVO0KPXAc3S1Hb2d8e3/d03vmvnlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtU9/nfasD0eBgjUmrrugR/NgKFFqaTCSHn7CNmgNpQCtkqI7WV+Did2wNuBM7sG4
	 Tozeh/wrBBl3HS3lz2KobxeXmLseRP0KXcA9puHc9MhUZiEqbdEHpAfwVaiz3CpX5c
	 TIcP/4NVd5VrIvIaXsRaNOtRUwHKPN4h/Q9nN4GqfG/kGW0veOGEnJhqeJrHTJAVHz
	 g3aqkPwTYPZcYt86izEa34vmhdec68+owZG98ABGYpaWtZKRCVyxUC/1eRbuPnPEka
	 eQ/8WUSiUkDAeRMwZGVw2+b0wTJe5/CBwiRyIxANJgk3YgrRPpUIB8CyIwXumXaqpP
	 jN4cZf2uZ7aJg==
Date: Tue, 23 Dec 2025 15:23:18 +0100
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
Subject: Re: [PATCH 1/8] dt-bindings: phy: axiado,ax3000-emmc-phy: add Axiado
 eMMC PHY document
Message-ID: <20251223-nondescript-horned-mouflon-36ba75@quoll>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-1-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-1-5457d0ebcdb4@axiado.com>

On Mon, Dec 22, 2025 at 04:45:00PM +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Add device tree bindings for the Axiado AX3000 eMMC PHY. The bindings
> define the required properties for configuring the external Arasan
> eMMC PHY, including register base addresses and clock references
> needed for HS200 mode operation.

Do not say what the bindings are supposed to do. We can read the diff.
Explain the hardware.

> 
> Signed-off-by: SriNavmani A <srinavmani@axiado.com>
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
> ---
>  .../bindings/phy/axiado,ax3000-emmc-phy.yaml       | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f88941ce60cbd99a73e8c504e0bf36c626bbf674
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/axiado,ax3000-emmc-phy.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/axiado,ax3000-emmc-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Axiado AX3000 Arasan eMMC PHY
> +
> +maintainers:
> +  - SriNavmani A <srinavmani@axiado.com>
> +  - Tzu-Hao Wei <twei@axiado.com>
> +  - Prasad Bolisetty <pbolisetty@axiado.com>
> +
> +description: |+
> +  Bindings for eMMC PHY on Axiado AX3000 SoC.

Irrelevant

> +
> +  - compatible:         Should be one of the following:
> +                        "axiado,ax3000-emmc-phy"
> +  - reg:
> +      maxItems: 1

Entire description is not correct. Do you see any file written like
this/

> +
> +properties:
> +  compatible:
> +    enum:
> +      - axiado,ax3000-emmc-phy
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - "#phy-cells"
> +  - compatible
> +  - reg

Wrong order, use the same as in properties.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    emmc_phy: emmc-phy@80801C00 {

Drop label and node is just phy@

Also, use lowercase hex everywhere.

Read DTS coding style - Axiado already received this feedback, so you
should follow it in all your submissions.

Best regards,
Krzysztof

