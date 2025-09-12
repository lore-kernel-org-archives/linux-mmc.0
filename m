Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9711030E0E4
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684088; cv=none; b=MJivEMA9vjGJy/gS70rAaBFgzEkDRE7EsVEwmO1XW844R95U9Eo/AgEDAqltQwLDREf+simsNGf/Jy5N9mT04S6npdeqMStKseJyLGQoQW60gbFqVaUYYQGbxlIgGy9bjr37T9hixoBGgc++JSJZUk9oTfNo3Sog7WfIaBXz8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684088; c=relaxed/simple;
	bh=jBAJnWbm3U7P7Cjj9/LDsEwkfdx+34ipvAwi6e6JbN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dd3wEeQPsWEAEbzQFuR7/1zEMxVj/73Ub6qF/Z7i8dMdMBXrrxeP6tjmbErLBkbjVVNiugDieXPrbi7Y3BMsM+FTLuWyJPSapbHRpM0c1U3BezXKaqyW8xdr1l3dfwRN0rw7+lvhCYeadqJOhOF+bPDHv8FKRdpPS1vwYJegsow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oi3FQcvR; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oi3FQcvR"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea3e8330e8aso388030276.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684085; x=1758288885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mZtqMj7Buty9BX5eJg7ubUn79cX89LfYOj/ik3ZHLw=;
        b=Oi3FQcvRq0UCceorzqvufvSeyjtXGQhRDTMwu0dZ66xbAAEgaUYN+bXC/WJhCoJiXA
         ROs71+l4unXx5dNfUfJoH5TxNstsOcBHdmtr+c6wE6PPA7Uab7z4+sDD/bvxfUBawpDc
         VXRe5rOC4vanfTmRx+wSyBK/4V7TAacKcdGSJuR4+QNdo7Tg/VieSrCXPu9qJZ8bTx/R
         NLsSP1ZD4O8s+LF4lRIqVWqGRP/rMy5uV32BssFd96TFNZ6NPSLylOuSM4zAkPE4tmRQ
         MdeNiYz5e9XAYDVikY8T5qzaGx8VrgrwWXSeWFJbBRazGgdgx7UJfVaRX+88I8rIgJtZ
         wK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684085; x=1758288885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mZtqMj7Buty9BX5eJg7ubUn79cX89LfYOj/ik3ZHLw=;
        b=PyoMndV/oAMRn8I1zp0Fua21mm6/5poQX2bFPvR3VCHh/9dJRtQOE1WrVLgKzdBI0r
         XjYBCaqxJ3d4C7Xpo9d0bBAqhX6tmUwlLK4lYhRvx9L2VI5iwNK+qOdVPaIaFWWOeIy7
         Qpv5G24cpF3/4f4yJDyc5ieJP21FqMpy8vzev0NoQRD9UEoJKhHoC7OX+UfqSo2CPhld
         W14dvU9EDS0a/x3w87qlfQb5sWxGACLp489oJdE1Fv4eRVESOkYya7JYEpWK/NAb4jMY
         3n5DodYDPsTSLhwEH9mVbATziek9xsLTMnanxn+8GeOukbpsnYabeHgmRIh+S2DH1Tyc
         1ZRw==
X-Forwarded-Encrypted: i=1; AJvYcCXKwvZQOp1uRFNkTEPXPE/YI11lHKHS866ldRVXvowN7ju/0oS72W5u7HIyVNfDUwdZPGUHmuPXsxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjGpKUxlmdzBYJ3ie+ZkPvsa9+lZWZmNxlpbjx2ncJm2EZppKm
	/GzsWBnQn7EbtltaUFaRnIePrim0OhqC+T1AbZhBwjTd5QrauYS4MSrk/ZfVehxkUUmm6OOS4j/
	gOZeLCST1vAxSZACjXtVUDwwbf82nkgKyW5L1XlDrLQ==
X-Gm-Gg: ASbGncuAFSP5WfaCV03iLIOvQQ02LBKo45MD3M0/7iSVbwtj9oPkSz01qr8T7iHv3dZ
	hw6JaI8tCOJuTCgL/otlvrP0h24fVxmrZw/UayYaOxA0RRFlwKDbviTfpBIyTtJPPyMwzYlHtRk
	Tw451qSEgck5ev5e+w9Zxqif5Z3kvcl9yP2p/WR013ytt7VloMYjlci15i894Wu/49O53i0FLJd
	RX4BGW9
X-Google-Smtp-Source: AGHT+IF2QK5PvgUDodJDMy1anuNhy7mAPtH2+u/Cb/GRw6eKlaFsdB7czQFqmCkQDIeivB9L2qowVeqeZqmayZt5HLU=
X-Received: by 2002:a5b:984:0:b0:e93:2d7c:96f2 with SMTP id
 3f1490d57ef6-ea3d9a3f50bmr2300108276.24.1757684085343; Fri, 12 Sep 2025
 06:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-pxav3-uhs-fix-v1-1-9f56b0b54749@dujemihanovic.xyz>
In-Reply-To: <20250903-pxav3-uhs-fix-v1-1-9f56b0b54749@dujemihanovic.xyz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:09 +0200
X-Gm-Features: AS18NWC26DOvm0iS2ScvulN5VJ9F2qVNM2KeyrWRgOgPMN3f410QETMn0vlg0XQ
Message-ID: <CAPDyKFowahX41+XqhQHmBcd9MCxkfo=pPSpdFinm4wHZSONJaw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-pxa: Add minItems to pinctrl-names
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Sept 2025 at 12:51, Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz> =
wrote:
>
> Some older boards only require a default pinctrl. Add a minItems
> property so these don't cause dt-validate warnings.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509030625.PBgLIAwG-lkp@i=
ntel.com/
> Signed-off-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-pxa.yaml
> index fba1cc50fdf07cc25d42f45512c385a9b8207b9b..186ce8ff4626a1eb07633e08a=
eb6322ae2eb25a8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -44,6 +44,7 @@ allOf:
>            items:
>              - const: default
>              - const: state_cmd_gpio
> +          minItems: 1
>
>          pinctrl-1:
>            description:
> @@ -61,6 +62,7 @@ allOf:
>            items:
>              - const: default
>              - const: state_uhs
> +          minItems: 1
>
>          pinctrl-1:
>            description:
>
> ---
> base-commit: 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7
> change-id: 20250903-pxav3-uhs-fix-9cbcfd2ec0b1
>
> Best regards,
> --
> Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>
>
