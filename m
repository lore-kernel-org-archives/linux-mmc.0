Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CA3A5E68
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882605; cv=none; b=qM2UdZf559EbBnEVd8wZQJcrbn+/pq3/F72zWsprBlVbchUzE1rtlfNMQxQaV40HZ3q0CP4/JouCBHsBGH+iruQrZzClodhetPTGsZNIinpXBXURSytQBnnBeLJ1407R4fQXVNB8/YCWq+pCcP8un4iIrb6SeYSmRj3oNzlM78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882605; c=relaxed/simple;
	bh=GfPwU3WVL/mqvs4GPLhG3djWjmY9v9NI1x29PMXFGyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8/AOlMVGBWlUxS/x+5rkwPVpP8bCpCLINdfSCo/njxye4B2016Jf4iTF4S4Vi5FUKcgKUt87jKj7RDTozJd5OD72KaYjj6C25Sy8c+8GKAzkpzEhfF1xjpXh4KJjq7fpVq+3d+wB6O6E1UjJjG4p8O2H6m7ZZlTYQRi4NxNvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKFf7who; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKFf7who"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7866bca6765so36551417b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882603; x=1763487403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E3Hk9DW5kL5J6uSFQvWJOZ9wCy+RP65Vlpdw339EGuY=;
        b=FKFf7who3A2tS3s034PJCS6QmKjFCt3T7OlYRJBLONfS4SHJMZ0tcVJklUm5mVf6p2
         s29rXhXTIFc3TpKyUIgUcSlqk/1LiE/+ZlYtqOLk5HWEN6nwUEBX00YvzpexLACBYbcy
         UImdVWF6crtp54frgH4gI9Rf8fjJCG8Ben2Vvy8WNO+Wi7NQZo3TChoPkz8p1MP2Naar
         XnfQpwobZN/r3wbTqUohfkew4ZcKL33amU4rbaW9frJG5asxct4mK3J+IUeePVOidW3y
         6YMzx4Zm+zzzZrRcfUfKxJgkszL0BTi52IpLIrW/AfhYOtnl4u5h2ic3zEhzBQaRvdCM
         rbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882603; x=1763487403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3Hk9DW5kL5J6uSFQvWJOZ9wCy+RP65Vlpdw339EGuY=;
        b=NNr/7XmtkSeft8Wf0Ym39vW4AxNLzuGerMigax0M/HU2I6ii3xaSgrgkVORTsGD8Ce
         pXbbVmQr+OknCIZP1hx6vCwPPeLXcMSP6vWTZFUNxl0gQrS2qWxtn29AKZK4GDLhvJP4
         PnYI1ViymR+ikP1J0IIHZlsvtp8RMH+WWovZX4/0nk7bNVm6NzPrM66iTlwkUQIEDwKK
         rd29WXtoTxKENO47SFAN7JgS0nrNUcg5zK01b7x1PkgVw4cEOFIFXFkW/vv7iUZtd+N2
         a2xcGByYwvDBRyPb9JDeOVWpJ0geukwyQnq9l1RDGlZqEuR8W/qHIAWraBpxjuIgxIB9
         eHTg==
X-Forwarded-Encrypted: i=1; AJvYcCWKT+4wmAyslZ9aPp2JOZkhSPkvG9QRfHOKsDpFQcX/+jAmMytp9/5yYFwr7U6MtI5ABMLKX8X65ZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3N6leTVYuJbSTyZwIvqCczaVKyM6WRzCgNDbNlt1RNnKSIKM
	Zde9O3Sg5KgCUQbXcgn5WXr9zcAtbtlbGhWHUVtwicGjCLIl6HYa16dNbxWb9CMfdUeC86+xtVS
	yg10KG37bVu1cMtKK9xilAMJr8kdQsG16MtqfQHN+mQ==
X-Gm-Gg: ASbGncsLC51Zo+h1+dH3n/TkR5aN+5NSHdzlz3+nzCxnw6HABI5BcQmCoIR3SmMYitQ
	x8h9RiOslzIQHQ+NNjDOe0iyfcDMXf9dU+YS2hsXVFrokjeyi9oReusPJsTg1wE322B2rYvdPSO
	+Wf4xF6qtZefIoVYez6/cJ0EbOZ+KcrcVBv22NLtFF7yOVprr2FqZqo08foK7Jzxri6ir+pA2+B
	zeJNIPsZdLRkchju+4n/fVsaz4gXwIuYJkSqhIoHITJ34OXDzx+zHFbepSG1lkMp/L1NdyBMUhf
	2RqsG98=
X-Google-Smtp-Source: AGHT+IGbbBsvM979BCP7ZWmX0I8ipBBs21XHkx/ZeiB+cUiRLX1ImPDfEKdBhe4xqH2QU7hiVfRmvH9dCgXFqY4eMx4=
X-Received: by 2002:a05:690c:c349:b0:784:ad94:ac70 with SMTP id
 00721157ae682-787d5361c39mr85380607b3.9.1762882602935; Tue, 11 Nov 2025
 09:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-milbeaut-v2-1-9e1954ff7708@gmail.com>
In-Reply-To: <20251027-milbeaut-v2-1-9e1954ff7708@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:07 +0100
X-Gm-Features: AWmQ_bmuX6vBN8aGtBR_ITBEbCmoqP3ikMVZofcmAm_bdFoSLSIpSUJ-RArnX18
Message-ID: <CAPDyKFpdeBgZKnK3KgNTQPWNw5R2rnSgB=uRjDUs8sBvbEDwJQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: socionext,milbeaut-m10v-sdhci-3.0:
 convert to DT schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Taichi Sugaya <sugaya.taichi@socionext.com>, 
	Takao Orito <orito.takao@socionext.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 17:49, Charan Pedumuru <charan.pedumuru@gmail.com> wrote:
>
> Convert SOCIONEXT Milbeaut SDHCI controller binding to YAML format.
> Add a new property "voltage-ranges" to resolve dt_check errors.
>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Change the description for the property "voltage-ranges".
> - Link to v1: https://lore.kernel.org/r/20251023-milbeaut-v1-1-3e4ff67110ad@gmail.com
> ---
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     | 30 --------
>  .../mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml     | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 30 deletions(-)
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
> -       "iface" - clock used for sdhci interface
> -       "core"  - core clock for sdhci controller
> -
> -Optional properties:
> -- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> -  requires the CMD_DAT_DELAY control to be enabled.
> -
> -Example:
> -       sdhci3: mmc@1b010000 {
> -               compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> -               reg = <0x1b010000 0x10000>;
> -               interrupts = <0 265 0x4>;
> -               voltage-ranges = <3300 3300>;
> -               bus-width = <4>;
> -               clocks = <&clk 7>, <&ahb_clk>;
> -               clock-names = "core", "iface";
> -               cap-sdio-irq;
> -               fujitsu,cmd-dat-delay-select;
> -       };
> diff --git a/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
> new file mode 100644
> index 000000000000..2ba53626a959
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/socionext,milbeaut-m10v-sdhci-3.0.yaml
> @@ -0,0 +1,79 @@
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
> +    items:
> +      items:
> +        - description: minimum slot voltage (mV).
> +        - description: maximum slot voltage (mV).
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc@1b010000 {
> +        compatible = "socionext,milbeaut-m10v-sdhci-3.0";
> +        reg = <0x1b010000 0x10000>;
> +        interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
> +        voltage-ranges = <3300 3300>;
> +        bus-width = <4>;
> +        clocks = <&clk 7>, <&ahb_clk>;
> +        clock-names = "core", "iface";
> +        cap-sdio-irq;
> +        fujitsu,cmd-dat-delay-select;
> +    };
> +...
>
> ---
> base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
> change-id: 20250524-milbeaut-5c0267202e2c
>
> Best regards,
> --
> Charan Pedumuru <charan.pedumuru@gmail.com>
>
