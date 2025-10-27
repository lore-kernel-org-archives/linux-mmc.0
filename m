Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1C1C27;
	Mon, 27 Oct 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573475; cv=none; b=UiMUfxQnuesAh15DZY4UdPQf9th8CEcrTfMumAHM7PDJ9O0DZkhcj3WNk5VBKXpRdfsUJM8uSqXZLD9tK6ewZPq3kF01/zKVkIw3ZKh0KEWALflr5nQB+6ZgykBE/QuQRXLaezRR2yRhznurRgRUrjm77a4NldA1THr343ajicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573475; c=relaxed/simple;
	bh=vQlBeuOimfnDQArLcW6HVQ1cZwXaJm+WEydOmRjU5rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o44Qk05Q+12V5eTHUyXfSl+dUTxz9TI0AGlBZsdXPXb75wiyCJ3rEDXcfyLaGST7I2SkqAe3SqjCptaVlmXlrPveB7xxVv6noVAVXw7FVD/IvTCfpiRJbigSl61vfhApUU5WItvV3tgrhQRSRv7/rzBALiptXO4jUrIw6mWvMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYX9aQgn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYX9aQgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7C3C4CEF1;
	Mon, 27 Oct 2025 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573475;
	bh=vQlBeuOimfnDQArLcW6HVQ1cZwXaJm+WEydOmRjU5rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYX9aQgnXs4w4qx23uZ1wSZQTKEhkqsu6hBA8OFqCL03nz4a66I2RXsW+tItPEiZB
	 tTr+MMdzfFfQaEPMNodsnPXLZE8WCKh+lHTgF1W4gXBIi9U6kkQI382+B2swxQjFrv
	 S3LuZBfQXKw0wr6cX8MbB15mCu0dRuPNPFnBjdfBMMB+2YrxFlnO0UvwTjznpckpc4
	 hptzh3FzAeEHNNnePQXkAC3No2jW9SzTVKDMCuVmwymv7m+wKfeNW97T0SZepVPJxE
	 sn/w1JCP5khrBGhHV9essXo5om5jcbms9lj5N7tuYGT4/ExjTRd4qOejG4inPuWxaE
	 EyOKH6g+NzS4A==
Date: Mon, 27 Oct 2025 08:57:52 -0500
From: Rob Herring <robh@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
Message-ID: <20251027135752.GA316916-robh@kernel.org>
References: <20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com>

On Thu, Oct 23, 2025 at 05:37:36PM +0000, Charan Pedumuru wrote:
> Convert SOCIONEXT Milbeaut SDHCI controller binding to YAML format.
> Add a new property "voltage-ranges" to resolve dt_check errors.
> 
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 ---------
>  .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 78 ++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt b/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> deleted file mode 100644
> index 627ee89c125b..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* SOCIONEXT Milbeaut SDHCI controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci_milbeaut driver.
> -
> -Required properties:
> -- compatible: "socionext,milbeaut-m10v-sdhci-3.0"
> -- clocks: Must contain an entry for each entry in clock-names. It is a
> -  list of phandles and clock-specifier pairs.
> -  See ../clocks/clock-bindings.txt for details.
> -- clock-names: Should contain the following two entries:
> -	"iface" - clock used for sdhci interface
> -	"core"  - core clock for sdhci controller
> -
> -Optional properties:
> -- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> -  requires the CMD_DAT_DELAY control to be enabled.
> -
> -Example:
> -	sdhci3: mmc@1b010000 {
> -		compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> -		reg = <0x1b010000 0x10000>;
> -		interrupts = <0 265 0x4>;
> -		voltage-ranges = <3300 3300>;
> -		bus-width = <4>;
> -		clocks = <&clk 7>, <&ahb_clk>;
> -		clock-names = "core", "iface";
> -		cap-sdio-irq;
> -		fujitsu,cmd-dat-delay-select;
> -	};
> diff --git a/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
> new file mode 100644
> index 000000000000..6b67bef30347
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SOCIONEXT Milbeaut SDHCI controller
> +
> +maintainers:
> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
> +  - Takao Orito <orito.takao@socionext.com>
> +
> +description:
> +  The SOCIONEXT Milbeaut SDHCI controller is a specialized SD Host
> +  Controller found in some of Socionext's Milbeaut image processing SoCs.
> +  It features a dedicated "bridge controller." This bridge controller
> +  implements special functions like reset control, clock management for
> +  various SDR modes (SDR12, SDR25, SDR50) and physical pin property settings.
> +
> +allOf:
> +  - $ref: sdhci-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: socionext,milbeaut-m10v-sdhci-3.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +
> +  fujitsu,cmd-dat-delay-select:
> +    description:
> +      Its presence indicates that the controller requires a specific command
> +      and data line delay selection mechanism for proper operation, particularly
> +      when dealing with high-speed SD/eMMC modes.
> +    type: boolean
> +
> +  voltage-ranges:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix

Sounds more like a uint32-array.

> +    description:
> +      Two cells are required, first cell specifies minimum slot voltage (mV),
> +      second cell specifies maximum slot voltage (mV).
> +    maxItems: 1

You can better describe it like this:

items:
  - description: minimum slot voltage (mV)
  - description: maximum slot voltage (mV)
