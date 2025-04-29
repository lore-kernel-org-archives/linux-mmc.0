Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E812BE7D3
	for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921225; cv=none; b=mHmF3w3scajN4ZwKZPHLA35ke6GuFkXq4dGE3GAeNeyLL8PevIKKcUXy7pZSn3A/BD7fbAhTIDGhkpDUznUQupvyen8esqVEygqYtz01f0QRkw3SEPoNWO8ZwLOnk22U5NyQJ/J3DlYke4VV1WPV4zoWaY+TMwhvWSvw7CFbkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921225; c=relaxed/simple;
	bh=ZanEZrl1MQTBJFkH/y5+fms6HZ1lW1UJH8TVe2y0Kws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEbOp6U6Rae98Vtmyiii8E2lQDntupVG8fzRA7b6awaKPt3DEYi1oTHUZkeHzgwlbPSCns8/Xn5aygEns1tM2KA6FWGZ01zkh757UlmS1dboOoyrPWFtoPA2HQFNfj0FPpTd0UnJVxJrxnJXIWHlycnJsR8YhN+6GF62hIcVfkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAN3kQXT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAN3kQXT"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ef60e500d7so53595397b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745921222; x=1746526022; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Ew3/QJhFzeoXSRlNN1VxKNu1WmYD8oNT84srDahOU=;
        b=XAN3kQXTwxYUwHug2FiI5ytwDGsSYy9irnfuXX/Pu8Cgg6dKbRoJjBZVF8tCA0o4d9
         3rlYjtN2a2VM/bAQHT7Cy+13yKDIK767bYTFVDlUyis+kmg5tkM/hk0Kq0AJ7kI5rX4N
         WHfMdH0k5ylS+4V/fN/RyoDy7t7oreeG/BZma5OBHZ+tKnNoz8ywtYRDUYpKECgqMOaV
         Ju6W3qG68wrrnn6fj8YZYojf7J2JX1EuPnWh5FDAlhxyzmRlE+C0YM5nd+RiAXl4bkij
         8mgseJhIeQxQM+mxdfEYXD4oOpxK9Q4Ai+IsIXCDUmJn+uINcWDhftJ57aKZ+zvYCjl+
         BItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745921222; x=1746526022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3Ew3/QJhFzeoXSRlNN1VxKNu1WmYD8oNT84srDahOU=;
        b=eqfylhS3WniVL4u2UOtYvQX3EPUx/pGwsnSyUim4Orp1d5FrI0yz3wAdf0lFlY1XB6
         4syubDGTtk6sdK18WvyqRU4ECTmH2AKw7wS+obLnR/XwaEZ6RMivOKcy3eWO7yMSrDST
         rixcN2wcTXRcxw04dxBWOOKiOBX2EDS75h55QRSt5LgRT3j4xupUDtmH8ANL9+BPM6SP
         g0O/uBbviKl6obCP8VIdf3xy8fxZZwq/sX8LpcYg/EinJwSMsoFzoBSqShZddxur5xPE
         vaAtzDdXI+HtBZy/5EUrbb5jOprwATjpqcnB7MSeR8NJn1q899jKRvpblZerFYYe4RNv
         xxrw==
X-Forwarded-Encrypted: i=1; AJvYcCVHE1aYYOdCnon0NBgZRI37AXQX1QpQKRnkfQ44+LTusNuJXfvol3k994YWAIZjvzPYcM8QQp4DKaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggiBgh1X5MCSKNN8N7777zGZqy1RAMIWVdGGxMCNUpy6L6t8I
	kV7tWsYia9PX2331emu61efD+N6eGCbr7Q0geE3uLqHobghzIidhqqzIjcFfpF08v1Axe77jbG8
	QDLSQAunlNv7G5J7TYccVO9QyxyP/C4yc+LbWMg==
X-Gm-Gg: ASbGncs9Z+fKa6C4nF3vSekJ7iWLQPgeHXkE526qTRWinxFtg3EkP6DciNp7jZhR/Ju
	cioplprYN1FDlCXJVLqPl6/ZbSEBZykFS6zV/PBr03hCEVn6nT5z70Sg5MwnZfAY5+S88D9J7SN
	ax2gFxzOWWy61qvdtY3M9ImYk=
X-Google-Smtp-Source: AGHT+IG76v7imH4Qmr1mZ2+FW38Kt9fhuFdotLsZyhENyHP+RbqVndMxng4jwgw0v2+7ykOIPXB+oYvsflTcyUn2X+o=
X-Received: by 2002:a05:690c:81c6:b0:700:a93e:3302 with SMTP id
 00721157ae682-7089b43746emr20556137b3.37.1745921222377; Tue, 29 Apr 2025
 03:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423-vt8500-sdmmc-binding-v2-1-ea4f17fd0638@gmail.com>
In-Reply-To: <20250423-vt8500-sdmmc-binding-v2-1-ea4f17fd0638@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Apr 2025 12:06:25 +0200
X-Gm-Features: ATxdqUHP1S1wKEk1JriqHl-INpfSR9z-V8MbSWsNuh6Dtm-S1RKGwycj8hOUG1k
Message-ID: <CAPDyKFotiXYeG7k4u1YFs9vE9hH+Ut29feZZvTBSFcthJp0+vg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: vt8500-sdmmc: Convert to YAML
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 12:53, Alexey Charkov <alchark@gmail.com> wrote:
>
> Rewrite the textual description for the WonderMedia SDMMC controller
> as YAML schema, and switch the filename to follow the compatible
> string.
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Split the series from v1 into separate bindings patches so as not to
> spam all the subsystems with unrelated changes, per Rob's suggestion
>
> Changes in v2:
> - described the sdon-inverted property in greater detail (thanks Rob)
> - dropped the hunk that updates MAINTAINERS for easier merging - will
>   be updated later in a single pass to cover all VT8500 related files
>
> Link to v1: https://lore.kernel.org/all/20250416-wmt-updates-v1-3-f9af689cdfc2@gmail.com/
> ---
>  .../devicetree/bindings/mmc/vt8500-sdmmc.txt       | 23 --------
>  .../devicetree/bindings/mmc/wm,wm8505-sdhc.yaml    | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt b/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
> deleted file mode 100644
> index d7fb6abb3eb8c87e698ca4f30270c949878f3cbf..0000000000000000000000000000000000000000
> --- a/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -* Wondermedia WM8505/WM8650 SD/MMC Host Controller
> -
> -This file documents differences between the core properties described
> -by mmc.txt and the properties used by the wmt-sdmmc driver.
> -
> -Required properties:
> -- compatible: Should be "wm,wm8505-sdhc".
> -- interrupts: Two interrupts are required - regular irq and dma irq.
> -
> -Optional properties:
> -- sdon-inverted: SD_ON bit is inverted on the controller
> -
> -Examples:
> -
> -sdhc@d800a000 {
> -       compatible = "wm,wm8505-sdhc";
> -       reg = <0xd800a000 0x1000>;
> -       interrupts = <20 21>;
> -       clocks = <&sdhc>;
> -       bus-width = <4>;
> -       sdon-inverted;
> -};
> -
> diff --git a/Documentation/devicetree/bindings/mmc/wm,wm8505-sdhc.yaml b/Documentation/devicetree/bindings/mmc/wm,wm8505-sdhc.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..5b55174e908836866fbba42336db94cb03f9137b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/wm,wm8505-sdhc.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/wm,wm8505-sdhc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: WonderMedia SoC SDHCI Controller
> +
> +maintainers:
> +  - Alexey Charkov <alchark@gmail.com>
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: wm,wm8505-sdhc
> +      - items:
> +          - const: wm,wm8650-sdhc
> +          - const: wm,wm8505-sdhc
> +      - items:
> +          - const: wm,wm8750-sdhc
> +          - const: wm,wm8505-sdhc
> +      - items:
> +          - const: wm,wm8850-sdhc
> +          - const: wm,wm8505-sdhc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: SDMMC controller interrupt
> +      - description: SDMMC controller DMA interrupt
> +
> +  sdon-inverted:
> +    type: boolean
> +    description: All chips before (not including) WM8505 rev. A2 treated their
> +      "clock stop" bit (register offset 0x08 a.k.a. SDMMC_BUSMODE, bit 0x10)
> +      as "set 1 to disable SD clock", while all the later versions treated it
> +      as "set 0 to disable SD clock". Set this property for later versions of
> +      wm,wm8505-sdhc. On wm,wm8650-sdhc and later this property is implied and
> +      does not need to be set explicitly
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc@d800a000 {
> +        compatible = "wm,wm8505-sdhc";
> +        reg = <0xd800a000 0x1000>;
> +        interrupts = <20>, <21>;
> +        clocks = <&sdhc>;
> +        bus-width = <4>;
> +        sdon-inverted;
> +    };
>
> ---
> base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
> change-id: 20250423-vt8500-sdmmc-binding-01c6ce3f6678
>
> Best regards,
> --
> Alexey Charkov <alchark@gmail.com>
>
