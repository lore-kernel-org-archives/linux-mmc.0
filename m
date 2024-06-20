Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380551AD4B9;
	Thu, 20 Jun 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900957; cv=none; b=I7VIfIq8YmzF5BUjtPhj4I+K/qPbRQ4Wi1cDc5/16IHUxvG86I/rzn+H5a5LezbArNAYUANfeK0d8d88DI/oAJqvL7fXb2HeBvax8g4R3hdmWQ7/U5AQDLWzxoryiYCIBwqN/VJBgrN0iX3RWJn8tq4Il8LESptftT0vhqHwSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900957; c=relaxed/simple;
	bh=BrICMMZrS8m6MYe0kQ4cVRc55ARLzaghyayTnAQ5YTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy4vioTgC+WpBYXAxMn3i+nIgP45rWGBp5seIsTfnBCNjBwD8Kybjm+WUypLltTxoqBGfxMT/KS6TBqBIgPnlYQRYreWLI1rAnwBTTpi3VlHNQ/bZhgmLFuR4sW8ZaoeJFUp5nSPueCBgWn9aUCa2noQPrmbUj/Rcv1BiVYqDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfRWGxIY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfRWGxIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16970C2BD10;
	Thu, 20 Jun 2024 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900956;
	bh=BrICMMZrS8m6MYe0kQ4cVRc55ARLzaghyayTnAQ5YTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfRWGxIYwv7J5fGI6mps0kORlWb0ron2PdO3PjRczD4G/Y4pAX+qMDDlzHuead6Rf
	 5jAD0/cIlrJEByacZSSW93LFqUBkoDOjBef0kR0hKHegJcoEREXpWDfrik5/EuvrSn
	 A7zH4b572BPnpHCutK77CIgPTNSyRv7nDlEiH3jshxrlZyfz4MjKDkJiy/pOkFNwYm
	 QCNf0IMYU70IXg8D6ABA3AApRAgichtlf817CcTHMEK4DWew6s1cOGmDlHnZxTHah+
	 7BBA+bGOoJYioXZwVoofX8K7N4RxxewpcxU3LhG5yPloMJNDK8UTCOWm75uMINa8Cq
	 5Hsiul3plJ+Wg==
Date: Fri, 21 Jun 2024 00:15:12 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo
 SG2042 support
Message-ID: <ZnRVkPy5akurmi_D@xhacker>
References: <cover.1718697954.git.unicorn_wang@outlook.com>
 <dcc060c3ada7a56eda02b586c16c47f0a0905c61.1718697954.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcc060c3ada7a56eda02b586c16c47f0a0905c61.1718697954.git.unicorn_wang@outlook.com>

On Tue, Jun 18, 2024 at 04:38:30PM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> SG2042 use Synopsys dwcnshc IP for SD/eMMC controllers.
> 
> SG2042 defines 3 clocks for SD/eMMC controllers.
> - AXI_EMMC/AXI_SD for aclk/hclk(Bus interface clocks in DWC_mshc)
>   and blck(Core Base Clock in DWC_mshc), these 3 clocks share one
>   source, so reuse existing "core".

No, this seems not correct. This should be the "bus" clk, and your above
sentence "aclk/hclk(Bus interface clocks in DWC_mshc)" implies this clk is
for bus

> - 100K_EMMC/100K_SD for cqetmclk(Timer clocks in DWC_mshc), so reuse
>   existing "timer" which was added for rockchip specified.
> - EMMC_100M/SD_100M for cclk(Card clocks in DWC_mshc), add new "card".

I think this is "core" clk, no? Plz check which internal clks' clock
source is the so called EMMC_100M/SD_100M.

> 
> Adding example for sg2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 69 +++++++++++++------
>  1 file changed, 49 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 4d3031d9965f..b53f20733f79 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -21,6 +21,7 @@ properties:
>        - snps,dwcmshc-sdhci
>        - sophgo,cv1800b-dwcmshc
>        - sophgo,sg2002-dwcmshc
> +      - sophgo,sg2042-dwcmshc
>        - thead,th1520-dwcmshc
>  
>    reg:
> @@ -29,25 +30,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  clocks:
> -    minItems: 1
> -    items:
> -      - description: core clock
> -      - description: bus clock for optional
> -      - description: axi clock for rockchip specified
> -      - description: block clock for rockchip specified
> -      - description: timer clock for rockchip specified
> -
> -
> -  clock-names:
> -    minItems: 1
> -    items:
> -      - const: core
> -      - const: bus
> -      - const: axi
> -      - const: block
> -      - const: timer
> -
>    resets:
>      maxItems: 5
>  
> @@ -63,6 +45,43 @@ properties:
>      description: Specify the number of delay for tx sampling.
>      $ref: /schemas/types.yaml#/definitions/uint8
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: sophgo,sg2042-dwcmshc
> +then:
> +  properties:
> +    clocks:
> +      items:
> +        - description: core clock
> +        - description: timer clock
> +        - description: card clock
> +
> +    clock-names:
> +      items:
> +        - const: core
> +        - const: timer
> +        - const: card
> +else:
> +  properties:
> +    clocks:
> +      minItems: 1
> +      items:
> +        - description: core clock
> +        - description: bus clock for optional
> +        - description: axi clock for rockchip specified
> +        - description: block clock for rockchip specified
> +        - description: timer clock for rockchip specified
> +
> +    clock-names:
> +      minItems: 1
> +      items:
> +        - const: core
> +        - const: bus
> +        - const: axi
> +        - const: block
> +        - const: timer
>  
>  required:
>    - compatible
> @@ -96,5 +115,15 @@ examples:
>        #address-cells = <1>;
>        #size-cells = <0>;
>      };
> -
> +  - |
> +    mmc@bb0000 {
> +      compatible = "sophgo,sg2042-dwcmshc";
> +      reg = <0xcc000 0x1000>;
> +      interrupts = <0 25 0x4>;
> +      clocks = <&cru 17>, <&cru 18>, <&cru 19>;
> +      clock-names = "core", "timer", "card";
> +      bus-width = <8>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +    };
>  ...
> -- 
> 2.25.1
> 
