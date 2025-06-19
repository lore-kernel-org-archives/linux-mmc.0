Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304522756A
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332033; cv=none; b=AFaw/D9ycXS/OknNoGTgk5jGeaYS9nWzFCAF7C/7G6WQONXJafPriL4dJAa6Qx0hQHMxd3ACLqvtbdIcULM8qMK/qpSziNlz/mUmv9HUrqlXHAUzTJSIcmCfdgHMYqpoTLT3ymo9l8OLXjdog7MLbtIsn0vMNCH9r+8WiChs+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332033; c=relaxed/simple;
	bh=NZ5ua//HRvEUXqDrATHvprzOWGicDxLR60a8JgIYce8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhLmQQqj5BUKeqoQEPYj2wHy093m0btVaKBAJpA3iKw2AIt5tgqEBfPHWD0O7P1+sonv+b+9XcnWANLpmOO+dK2XptzKsGI6xTVqa1HNe8eieIvRJ0Ukri1c/5GaRJkrx6uq0cnhHx8IA/Ai0CS56AOnxwte9JTVEYycnAZAFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omQiXrPl; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omQiXrPl"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8275f110c6so564832276.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332031; x=1750936831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/7Q/trZ5SbmALMt3c06DmQkKxihbiVngkXZ1QJXJs8=;
        b=omQiXrPlr0TGWS9dR27S05Pt+YOLpmtTGoS8NpYhDjrSFgb2SbqxuJe7A5e0EGgT+V
         n34gBrNfJ3EkzotKF/d8cz/S7Da43KFm3kJxQC268JeAEJtcpJkD0kHznCbEG2Rep1aD
         juMOin+kiGFI5BCX/sRnybPB1HDZvPp8m3vrQLBkQoZUThMRF4OCT1frQAxjUfVBVXCI
         Wrr3RYyp2eYdGkM9JQFpeXaO+7ACS0whO2WCfKTacj2LHEZ/s01Pdd7EYXrnngzDrOmy
         7iyA2vW4CzkxWxWiegx1RVubmkvrkAlqPclp5uQV8zjGI6oqEPnbSFAuJ3OY0pU8bbDp
         05xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332031; x=1750936831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/7Q/trZ5SbmALMt3c06DmQkKxihbiVngkXZ1QJXJs8=;
        b=A5Q1Hh9pVM5oy1rkm4QH5Fdcl+TcAp3n72H3DR6YPKNh8MMkolUOauzhP2S2k4I5ns
         O+Zw339+rQUXLV+EZrwzpvpGAAJTHXywvxU4soxQvInjaOq1s147utwv4ypB8Tn0xX3J
         68oA8+LSViYTEHAfX2Qcctv30zBgerl7JEgiHT1Twit1ba+k9+Oqa9wvh4o+sPGUYdxx
         +ssYiPCwrnzjzk7Q2nTe4FZLDpLiQS2Nd8riZ84xs3f+aHoDOSYACoD3PE164dCaZZyb
         sDDSVTWRpuDb5ih5RqT5F8jXMo22+m9U0SeJcnnRqKryeyfQKWhtCH9jZgBzAoImNtpw
         RP5A==
X-Forwarded-Encrypted: i=1; AJvYcCWQ65JqMJyPAEDHUTAZ8z4W2gyEzmd6D4K25fsWkzXglVBve0dUkU05m7lrn/RD2QSJQGu//1UK8H0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WSR6gnC1TPjaECldHZPnh0xm4iMYqLmuXH2lDqYXydI3YJ68
	2eQEwHr46QrvQ50pFnsLZavxEaZlgVFm485DpxmgBJKDW9QWY4Yr9fRe3oW/NkX+KIsxqg8Rgdz
	ECSMaod9Py1vNdXxpnTWGAaLQ5+9UJ/Vn+y2gj5CtXw==
X-Gm-Gg: ASbGncvA6PEZXyio3kMDfv8zIB8k7IgI0t1WTLqnxssfVMTrIgHeSaUZd93tmkI2I+u
	NM/9NiLEMbJRyJ4iEUqtx8Bingry+0Ipjfvl6EjDbUYfAL76wyphOloOS2uSR6wKI2tyASkq9fE
	gt5B/PGUZo8sxM52JSC6M4cHBtJyrO947RxXjJOoWIfdes
X-Google-Smtp-Source: AGHT+IGY/qzZki/fMsjjuqz3QT3bNQU2e2XUVD7CMMeyaBLxvbqSsIzzLZ3yi5RD+SHlUmmOxvGIAhjFnpWIBIUm4EQ=
X-Received: by 2002:a05:6902:2189:b0:e82:b91:a7d7 with SMTP id
 3f1490d57ef6-e822ac8e43cmr26709534276.29.1750332030811; Thu, 19 Jun 2025
 04:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603152245.1068740-1-Frank.Li@nxp.com>
In-Reply-To: <20250603152245.1068740-1-Frank.Li@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:19:54 +0200
X-Gm-Features: AX0GCFt2y5yccN4trdKSkYckbzJZTNRqp_GOOavsdhs8BlNDoJbkpBlOUHNguuE
Message-ID: <CAPDyKFo1dAkvvrO_xb3fk8pguTspB2OWxcA-zdN+Z1yOkbt4ww@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: mmc: mxs-mmc: change ref to
 mmc-controller-common.yaml from mmc-controller.yaml
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, wahrenst@gmx.net
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 17:23, Frank Li <Frank.Li@nxp.com> wrote:
>
> Change ref to mmc-controller-common.yaml from mmc-controller.yaml because
> imx23/imx28 use dual mode controller (spi and mmc). So default dts node
> name use spi instead of mmc. The legacy reason, it use difference
> compatible string to distringuish work mode (spi / mmc).
>
> Fix below CHECK_DTB warnings:
> arch/arm/boot/dts/nxp/mxs/imx23-olinuxino.dtb: spi@80010000 (fsl,imx23-mmc): $nodename:0: 'spi@80010000' does not match '^mmc(@.*)?$'
>
> Additional add clocks property.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> change in v3
> - add clocks in example to fix dt_binding_check warnings/errors.
>
> change in v2
> - add clocks to required
> - fix typo legancy in commit message
> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> index 32e512a68ed61..df07ea3b81d15 100644
> --- a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> @@ -17,7 +17,7 @@ description: |
>    and the properties used by the mxsmmc driver.
>
>  allOf:
> -  - $ref: mmc-controller.yaml
> +  - $ref: mmc-controller-common.yaml#
>
>  properties:
>    compatible:
> @@ -31,6 +31,9 @@ properties:
>    interrupts:
>      maxItems: 1
>
> +  clocks:
> +    maxItems: 1
> +
>    dmas:
>      maxItems: 1
>
> @@ -41,6 +44,7 @@ required:
>    - compatible
>    - reg
>    - interrupts
> +  - clocks
>    - dmas
>    - dma-names
>
> @@ -52,6 +56,7 @@ examples:
>          compatible = "fsl,imx28-mmc";
>          reg = <0x80010000 2000>;
>          interrupts = <96>;
> +        clocks = <&clks 46>;
>          dmas = <&dma_apbh 0>;
>          dma-names = "rx-tx";
>          bus-width = <8>;
> --
> 2.34.1
>
