Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB433A1CF2
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882597; cv=none; b=c7GNFRjNjhwwgLiXUtGKG8xFHKDa5GqL+vvr0TLjOSKrSXK7KHlBhrCtaPPp5OCyTQCzHsYpwes7jk7dtFZQuf0nHaEUKVJ3qixRmUcUitDhgYZq0vqOkH3yHH27UiaC/RGKEl6hxNr1edSKW6nZef+8z0t2Mw5dew2uhjTTIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882597; c=relaxed/simple;
	bh=xOKQOoM2AfNja8dsA/CxDG47x21cuiNISWWb8aEVEJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc7WNEvX9ZVZyQfiYyU3ypwBpcfxH2KKtfLLemUjrhZ8A3HYo1jziMUm0YdUSFWgwqwtXfRMsVcEVdWq1SReTa1j2GfnVsvoriHoNaT8sCqnOJ3N/XnvjMhNZd2ZpvxHuVvVGQhi0ROREjHJ0R54Vuo55sWOXs5Reo7AGR1z/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRKLj1cx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRKLj1cx"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-787e84ceaf7so30648577b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882594; x=1763487394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=za1gdfyK3qzPGcN1dvu1lDNgvKHZXorLMMwhejsf9TA=;
        b=GRKLj1cx7hYkLoDKUIVhvq57O40wZyIcbs2vowstDhvLHyMjlmDpcPGy5gcSKtZugs
         qjciS3MlZ9M2xToRf1uje9yHpVPxHmijqGq7KvZ/E8Z3JohiCDQ3Wczhp0uH5/AicupE
         Ctd1IEOZAz/U0HceO/ppsBPPhOklr//JU3A+SVaj/xyzv5pw5KVAKZQcwsnYCMH2ARcq
         zpXUIPcCe32MbmoAdPz4HmHu1Exyxb11i58/p39oV++Ufpo+mJ0d1tGY6iPatVc3LUqt
         ynGAL5mGT0mzZ9VxIQ0cUjh3nP8ZUIHRS55XytbRvelxJWpaDmpeUNDim4Z9KmcYr56i
         l/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882594; x=1763487394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za1gdfyK3qzPGcN1dvu1lDNgvKHZXorLMMwhejsf9TA=;
        b=JlJ09IzkcEu9w92FRd1uJcpvQs86f2OF2D6WV66Fu4/lGVI2twqUfNfTDIIpn/z4e6
         todAeckEfUUsrCoRM7uJRsdbbjVHl7yvdFrLbFQy63CgCrD1O7h2ZFBf8QVVV9AU4t3l
         nlGcPyh+L4l2Il6hb5JX/rRrC20VDQiLwpxJaqKwkwsDpDMvookBVMhuHhVVn6bbok69
         7hVC5kIahz7GlJx331xRb3Ism8LE/CflH0dHnLPIL83LNgqboZW7r43s7UQCKxMTaAJp
         TyuH5vYGV272xcsCpVLedF+/i3E/nCkLlKl9jbDIRXRrlPc2rqQhWgjcI3wU0lH9BwU+
         75Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXJaNUCgsm6UjdrcPi8JtYy+43+ZCD2F/1l2f+yG1IM/ytNsrG0oiTyrcZanYHWS6Mzzf2vtrW+zlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tVNY0JcMuZeC9CqmbsdHNFYEspB5XW6Bwor339GAkJGwozmN
	rA8w0PxstxHYY/0XebnWkWVk5YHiD3W+qnpFIy8nnB4h6pgTKuwGSlC0+T6g+nmn/7QPD7vlhx8
	81fa5nuPxY+kUB7tMARIDPmfXudHvKNr21vGPXkpiPQ==
X-Gm-Gg: ASbGncuH4HpqJJT+JUIp0AUVWtyVJ2xH+GjP/wueyPL3Je9/ZzSFPPGOWoM246hfkt+
	dWzWgS/ePZ7CAQ393/PRlJvk02WKx+/7cXrTR27LyPdanLrWzz1QhEobXTDMPxc5Y2l/cuUZUOL
	LKzwNqvJ489e1MeLiYpQszoJjkT1GslW0lj0wSZIpmxYEu3SrvPtFEJDBMHeqoELhnrtag+XMs8
	0ALDHgeQzHVunSBWaapW5HMDCdrtg/drrdgsr3XKxt7F1oehJISo/9Cmlt2XPrzeX0iqx+f
X-Google-Smtp-Source: AGHT+IHCw1UcWzR9TPBE2DxyUpgbvAXRgMv7lWv2gMJ/bZXyLo3o561gH5tEFbtxTRBwtRHVUXKhCc7VU5xNaGwU2MA=
X-Received: by 2002:a05:690c:8b90:b0:768:70a1:46c2 with SMTP id
 00721157ae682-787d543a745mr98347307b3.48.1762882594490; Tue, 11 Nov 2025
 09:36:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-davinci-mmc-v3-1-5b27b9c9ecc4@gmail.com>
In-Reply-To: <20251023-davinci-mmc-v3-1-5b27b9c9ecc4@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:35:58 +0100
X-Gm-Features: AWmQ_bnvpism8NQxIoxTruBGzEdbb8m_Fhm8OHtqEgCF2-lTQKiQId72TAJ0VRU
Message-ID: <CAPDyKFr2TrHY6VAt_1y4jKOr1J5727_osx+75U9_=+LExYZJiw@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mmc: ti,da830-mmc: convert to DT schema
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 15:20, Charan Pedumuru <charan.pedumuru@gmail.com> wrote:
>
> Convert TI Highspeed MMC host controller binding to YAML format. Define
> 'clocks' and 'interrupts' properties to resolve errors identified by
> 'dt_check' and 'dtb_check'.
>
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - Change the maintainer for the binding to "Kishon Vijay Abraham I".
> - Link to v2: https://lore.kernel.org/r/20251011-davinci-mmc-v2-1-355da3e25123@gmail.com
>
> Changes in v2:
> - Modified the commit message.
> - Removed 'interrupts' from required properties following the old binding.
> - Changed the maintainer for the binding to "Conor Dooley".
> - Link to v1: https://lore.kernel.org/r/20250523-davinci-mmc-v1-1-ceebd8352d9c@gmail.com
> ---
>  .../devicetree/bindings/mmc/davinci_mmc.txt        | 32 ------------
>  .../devicetree/bindings/mmc/ti,da830-mmc.yaml      | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 32 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> deleted file mode 100644
> index 516fb0143d4c..000000000000
> --- a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -* TI Highspeed MMC host controller for DaVinci
> -
> -The Highspeed MMC Host Controller on TI DaVinci family
> -provides an interface for MMC, SD and SDIO types of memory cards.
> -
> -This file documents the properties used by the davinci_mmc driver.
> -
> -Required properties:
> -- compatible:
> - Should be "ti,da830-mmc": for da830, da850, dm365
> - Should be "ti,dm355-mmc": for dm355, dm644x
> -
> -Optional properties:
> -- bus-width: Number of data lines, can be <1>, <4>, or <8>, default <1>
> -- max-frequency: Maximum operating clock frequency, default 25MHz.
> -- dmas: List of DMA specifiers with the controller specific format
> -       as described in the generic DMA client binding. A tx and rx
> -       specifier is required.
> -- dma-names: RX and TX  DMA request names. These strings correspond
> -       1:1 with the DMA specifiers listed in dmas.
> -
> -Example:
> -mmc0: mmc@1c40000 {
> -       compatible = "ti,da830-mmc",
> -       reg = <0x40000 0x1000>;
> -       interrupts = <16>;
> -       bus-width = <4>;
> -       max-frequency = <50000000>;
> -       dmas = <&edma 16
> -               &edma 17>;
> -       dma-names = "rx", "tx";
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
> new file mode 100644
> index 000000000000..36b33dde086b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/ti,da830-mmc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/ti,da830-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI Highspeed MMC host controller for DaVinci
> +
> +description:
> +  The Highspeed MMC Host Controller on TI DaVinci family
> +  provides an interface for MMC, SD and SDIO types of memory cards.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,da830-mmc
> +      - ti,dm355-mmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mmc@1c40000 {
> +        compatible = "ti,da830-mmc";
> +        reg = <0x40000 0x1000>;
> +        interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <17 IRQ_TYPE_LEVEL_HIGH>;
> +        bus-width = <4>;
> +        max-frequency = <50000000>;
> +        dmas = <&edma 16>, <&edma 17>;
> +        dma-names = "rx", "tx";
> +    };
> +...
>
> ---
> base-commit: 7bac2c97af4078d7a627500c9bcdd5b033f97718
> change-id: 20250523-davinci-mmc-c704440c3dd0
>
> Best regards,
> --
> Charan Pedumuru <charan.pedumuru@gmail.com>
>
