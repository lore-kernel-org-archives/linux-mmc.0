Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FAE1527BB;
	Tue, 24 Sep 2024 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169508; cv=none; b=JrguPa2LfbpmHM+SH+prN9018Bx3yTZwXCqnH0TDPNsKbP2sFy2mn/DkC3XdNpXI490KTFtZUMXX66LwgDjkyiNwcDZTyEKCEuG4sOE2Qd3lNrdbNn7UWEh9996UHOzcGZ0MK061e+wIxUkXFnbwp0uFnhHwk5+zd58mqzs0SFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169508; c=relaxed/simple;
	bh=pN30MXgNTMZzoPVWBePwvf9D4eXRBCcLLbOa8I8Cew0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kbn3yPgCmJOYQSFDDf2XaHdem/w3k8NV7r675Ls1ahksLApN/Ie31uevmHbpL43WjBbJIAJxf63k2ezyQkUiSn+NMHm/ocFI9TuQ6x2iZlfftQiNDOu4pfaAhMtw+M/j10GI5xS0XjMLi3MxcmJgxjTynKsPsAKfxoMOOvSFkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEflUu9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEflUu9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCF8C4CEC5;
	Tue, 24 Sep 2024 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727169507;
	bh=pN30MXgNTMZzoPVWBePwvf9D4eXRBCcLLbOa8I8Cew0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEflUu9Ndq28Rb1X+YLgRa/Jabxwf9wTMs2iBS3b6ERa7ny6Gjo17THqNzWiXZEXi
	 glkjl132IGbmFozdqvKpFWCFCuQgGVdjB3inDKNBfgatfoxcA23wNlEFSW8G5hRSMf
	 8LIYv8IK4uNhW+2gF6v/00nP+eGH7eC0Wr7WVtcUqpoHL2SiKAUXWrhXRlJhOWZ8pr
	 /a+pXkI2Nz2EJepVEkhkbddQ/AvPHe5J7gg3sgD/xvyHPhtiHHDbuvYACOE7ckNN9V
	 JNVzU2vI8ns4ClKmEn9zYcnmrJ+RP0mV009AB7mD19N2oiCKbpHp1+CSbV6E5fm8Lk
	 jlOv0mh2rYZ4w==
Date: Tue, 24 Sep 2024 11:18:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: convert
 amlogic,meson-mx-sdio.txt to dtschema
Message-ID: <mbc2cacow73vmwn3w42aucq6x6xijbpgustkv3v6etgv35xih7@truf2rbgf3vo>
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-3-5aa8bdfe01af@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-3-5aa8bdfe01af@linaro.org>

On Fri, Sep 20, 2024 at 10:38:05AM +0200, Neil Armstrong wrote:
> Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> bindings to dt-schema.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

...

> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - amlogic,meson8-sdio
> +          - amlogic,meson8b-sdio
> +      - const: amlogic,meson-mx-sdio
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
> +      - const: clkin
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "slot@[0-2]+$":

^slot@[0-2]$

(because foo-slot@22 is wrong)


> +    $ref: mmc-slot.yaml#
> +    description:
> +      A node for each slot provided by the MMC controller
> +
> +    properties:
> +      reg:
> +        description:
> +          the slot (or "port") ID

Drop description. Should be rather part of mmc-slot.yaml.

> +        enum: [0, 1, 2]
> +
> +      bus-width:
> +        enum: [1, 4]
> +
> +    unevaluatedProperties: false

Hm, I wonder why not all slots are defined in your DTS? Why not all of
them are required? I assume the slots are there always, as part of the
controller.

Is this because of driver limitation mentioned in the old binding?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc@c1108c20 {
> +        compatible = "amlogic,meson8-sdio", "amlogic,meson-mx-sdio";
> +        reg = <0xc1108c20 0x20>;
> +        interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
> +        clocks = <&clk_core>, <&clk_in>;
> +        clock-names = "core", "clkin";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        slot@1 {
> +            compatible = "mmc-slot";
> +            reg = <1>;
> +            bus-width = <4>;

Best regards,
Krzysztof

