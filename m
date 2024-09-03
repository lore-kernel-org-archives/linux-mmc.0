Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F11DA114
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367087; cv=none; b=gp+kUJVF3+utiroTb0tVKFfkBi+mFwk4QaA40afsLwVJzVy0+wkSrCiWx7Vn15MzI2ZOh2PlnsUrI6OcR9lEzUilHYVNsSA8zPtQhDNdTJ9HMIrj+F5/N3u3SYJWeH2mAC6ocfHUla5KR3zh4H1u28TatsqGqMoo5jqZO7TCvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367087; c=relaxed/simple;
	bh=FZbJd1tZJzW9XzhGrtdmKRdbrVG5J6WlHQL95vMvdbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXs8LzjjwAKVj9a7evNfNR4q22iIONTbsliJ5tXnHhiE1tdL8eqcaLZbx8XD+wjFZYh21vtIK23ey2qJxzY3udkKuNtESu9K82OIe15gWo2eRNCJh2sGnd2BDV5zqfqmFNoVqf1JKDnFY1rAnnSyhzv7xEHCSyFClyC8o+ypG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=szQ9idGl; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szQ9idGl"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e1651f48c31so5456313276.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Sep 2024 05:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725367084; x=1725971884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GMKmnjbDpsQIapo5HuPs4+45d9/Y2i87xJa3a9ExiQU=;
        b=szQ9idGlwxL8K1QdeBo4T62bs7WNdIRII5l2BkMvPO0FtsFMY6g1kZYe1Qku/LQyeQ
         IV7dTYDeNn58B7WTgmWzZweluw4aQ1avEaZtLKnynEz2BzamPKh9m6XdthDjAAEc0gxe
         8ZevTNoO8B8RIJPSBPl4y8mC313TSEb4giRScE9EzpbSCn8HyOe5Jy57a1iUQCv4eJ6Y
         sdFXYkSPIRx9LfhVcCasc94F1YZPewB8w4kpk8EN1L2Xtj20W3OtpTFoP6Rsa1M2rnGX
         nglIHxgHLU/6Z2EzpENJ3MpIjmgpP6TvNaGTo68EBpOFUIJ0RQpUlSrzjaHPJloRyv5y
         9r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725367084; x=1725971884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMKmnjbDpsQIapo5HuPs4+45d9/Y2i87xJa3a9ExiQU=;
        b=PORSIMtXmMB/vhwAWPAnTdLK8BDvdx1DdXFswLrT5+zd1XnxOjV5SMNQGaKMsixJGe
         XpD8EnUqS5omhcVEpJyIsPHq0d0jZWnqmlwROixdp+mOWxiDTCYz8SjJrJgqx7JDXabe
         XuP7LPimmiwrDhgShrGWJjxOe/IWrICfy3I0i8yy9Mhrke7/S1AQNUlnbtTvlEBkmg+O
         Zw7pD+i+YZDlBnBQw+cR2B/Z7fKbDnqub/j4k75HYHfJWXt8liIbNkhAaecroUYcyIWp
         +APIA9PEHwE4vR30VHPgj+SYJL6V0Z9IDESOx6HbNs9VEilYGISwNIn52gtkRM574nze
         YiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqVV9YNivmq69tzO7Ht0O60VkbIg8Ka2AhSmhhr9RnysdbDS0NNpSj3mszWwdH+ohJDeVB0aC2xhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67tx7xZe9YfOour0MIBRur/mEANHVY+vKz5tIzGiFP0i6+GrP
	aMKG64ll88mcfhHEy0RdKHWAB4V3Nlb4gqxihWUL6QgIEW74fZym85ETlnggcMLtFelzue7Mi7Q
	KPNBdwOoHT8iWktU1xudRtmmL76pgnJcmnQRcuw==
X-Google-Smtp-Source: AGHT+IFoBiimtQty+ZFFbQefHWfDZl6LnzYy8OvfxnVeQ1irgttQ6ADNaC03ffHR60k5ULdX0MxqCJX0+8Vdu8/hM3c=
X-Received: by 2002:a05:6902:2309:b0:e1a:b361:4d94 with SMTP id
 3f1490d57ef6-e1ab361540emr6397661276.24.1725367084353; Tue, 03 Sep 2024
 05:38:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902-atmel-sdhci-v4-1-96912fab6b2d@microchip.com>
In-Reply-To: <20240902-atmel-sdhci-v4-1-96912fab6b2d@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Sep 2024 14:37:28 +0200
Message-ID: <CAPDyKFroWmE+P8S5XD5b2BgnnPjNO3B1XpOHsZAGU8rUOsEarQ@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: mmc: sdhci-atmel: Convert to json schema
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Aubin Constans <aubin.constans@microchip.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 12:57, Dharma Balasubiramani
<dharma.b@microchip.com> wrote:
>
> Convert sdhci-atmel documentation to yaml format. The new file will inherit
> from sdhci-common.yaml.
>
> Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
> in the DT.
>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> This patch series converts the sdhci-atmel dt-binding to yaml format and adds
> the sama7d65,sama7g5 compatibles to the list.
> ---
> Changes in v4:
> - remove the "atmel,sama5d3-sdhci" and "atmel,sama5d4-sdhci" compatibles and
>   add back the "microchip,sam9x7-sdhci" compatible from old binding which was missed.
> - drop the addition of sama7d65 in binding, will be sent along with the dts patch series.
> - Add the entire description of "microchip,sdcal-inverted" from old txt binding.
> - The microchip,sam9x7-sdhci is yet to be merged in DTS
> https://lore.kernel.org/lkml/20240729070934.1991467-1-varshini.rajendran@microchip.com/
> - Link to v3: https://lore.kernel.org/r/20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com
>
> Changes in v3:
> - update the items in clocks instead of plain description.
> - move the items list to clock-names.
> - since baseclk is must, change maxitems to minitems: 3, and modify the
>   conditional bits accordingly.
> - Link to v2: https://lore.kernel.org/r/20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com
>
> Changes in v2:
> - Add missing deleted file to the patch
> "Documentation/devicetree/bindings/mmc/sdhci-atmel.txt"
> - Link to v1: https://lore.kernel.org/r/20240830-atmel-sdhci-v1-0-01e3ec8c9804@microchip.com
> ---
>  .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 92 ++++++++++++++++++++++
>  .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 --------
>  2 files changed, 92 insertions(+), 35 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> new file mode 100644
> index 000000000000..8c8ade88e8fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel SDHCI controller
> +
> +maintainers:
> +  - Aubin Constans <aubin.constans@microchip.com>
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +
> +description:
> +  Bindings for the SDHCI controller found in Atmel/Microchip SoCs.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - atmel,sama5d2-sdhci
> +          - microchip,sam9x60-sdhci
> +      - items:
> +          - enum:
> +              - microchip,sam9x7-sdhci
> +              - microchip,sama7g5-sdhci
> +          - const: microchip,sam9x60-sdhci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: hclock
> +      - description: multclk
> +      - description: baseclk
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: hclock
> +      - const: multclk
> +      - const: baseclk
> +    minItems: 2
> +
> +  microchip,sdcal-inverted:
> +    type: boolean
> +    description:
> +      When present, polarity on the SDCAL SoC pin is inverted. The default
> +      polarity for this signal is described in the datasheet. For instance on
> +      SAMA5D2, the pin is usually tied to the GND with a resistor and a
> +      capacitor (see "SDMMC I/O Calibration" chapter).
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: sdhci-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - atmel,sama5d2-sdhci
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +        clock-names:
> +          minItems: 3
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/at91.h>
> +    mmc@a0000000 {
> +        compatible = "atmel,sama5d2-sdhci";
> +        reg = <0xa0000000 0x300>;
> +        interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
> +        clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
> +        clock-names = "hclock", "multclk", "baseclk";
> +        assigned-clocks = <&sdmmc0_gclk>;
> +        assigned-clock-rates = <480000000>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> deleted file mode 100644
> index a9fb0a91245f..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -* Atmel SDHCI controller
> -
> -This file documents the differences between the core properties in
> -Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
> -sdhci-of-at91 driver.
> -
> -Required properties:
> -- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci"
> -                       or "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci".
> -- clocks:              Phandlers to the clocks.
> -- clock-names:         Must be "hclock", "multclk", "baseclk" for
> -                       "atmel,sama5d2-sdhci".
> -                       Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
> -                       Must be "hclock", "multclk" for "microchip,sam9x7-sdhci".
> -
> -Optional properties:
> -- assigned-clocks:     The same with "multclk".
> -- assigned-clock-rates The rate of "multclk" in order to not rely on the
> -                       gck configuration set by previous components.
> -- microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
> -  inverted. The default polarity for this signal is described in the datasheet.
> -  For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
> -  and a capacitor (see "SDMMC I/O Calibration" chapter).
> -
> -Example:
> -
> -mmc0: sdio-host@a0000000 {
> -       compatible = "atmel,sama5d2-sdhci";
> -       reg = <0xa0000000 0x300>;
> -       interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
> -       clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
> -       clock-names = "hclock", "multclk", "baseclk";
> -       assigned-clocks = <&sdmmc0_gclk>;
> -       assigned-clock-rates = <480000000>;
> -};
>
> ---
> base-commit: 4b7d983dd85a5cdf4938f4a0a93adedf697ac04d
> change-id: 20240830-atmel-sdhci-c9a92b710624
>
> Best regards,
> --
> Dharma Balasubiramani <dharma.b@microchip.com>
>
