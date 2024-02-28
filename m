Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BB3BBEE
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125455; cv=none; b=OAnPWTFldAv2Tl9Zbf8JodLDaMGl15Ftwm+wkq203GT+F1hQsLcnPimM2dTqzifIesNEkMga4/3hkjZ6rbznm4s7OCc+xsB4z6CAhPbEyt+zT6/Ma8C6GoIlMk+/KrQ0oHpGcuWX/NL5nCYsGRddVajUYfPiVT6bqeiIiZhLdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125455; c=relaxed/simple;
	bh=Cdy6St+TAumTxcMKiWP3rQKGFwXjSr1a5rEWEah7bhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd/eAf1hiRTdZ9DDZVUuPYDi919RCKe8ZA7VSS3DF+F5f5lYv4OHhVdS7o5fIFvvSJk5hVukAFxsTeW+8Ep9hTU5eIs8TV0RQpCDBhKYoeQdAvx5pmb9LOfmpZYgQ831UWaYvunRT/2QXD+Z1+GCc7XPTxhVuMmGFYe+9hcrTSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKeF63px; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKeF63px"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60938caa800so8687037b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 05:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125452; x=1709730252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IPWk4N9bdPXdKR4Ei2myz2DuKAxPeauHNUmWL9ZIWn8=;
        b=zKeF63pxHKPF2yRiXrYHQOw3dq5jXpfIE1AM1R9b7tMky3wyexxz/Yfy0IKKdSBdqH
         TOtTwF9iDEhIISf5W+0niaZ1zvqEElZATxPmk/Lz2ME3ybgm9cNp2aTxMJ89fXBeMcwt
         Nt5FcMKumvpdbO7DycngoIFI+7TXVwtLDilYK1ed6z7zpIlcSlJpEWR7G0lZd4KzOvdL
         tnk4SM9dlZmy+BxG0QpZ9l/HY/ezp/Yq9uHRvxz/PbVo4DUnHQrb2OHDeYyKuzIGsfi7
         eJrw8hfGcjXOhL3juEXANY5Ray0gvVb9oGO/48M3CQ8yIRbikTdJIjN8/+AxMaX9klye
         BZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125452; x=1709730252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPWk4N9bdPXdKR4Ei2myz2DuKAxPeauHNUmWL9ZIWn8=;
        b=QruFT5ndw8uFTzeG7xfnXRnlgymH18sh/jqxTxGD5/pqqUnmiTzJxcv5w5OOhpO+ez
         7mcpqNU1oBuEGu2Is3RedrF8I9mAo/Knef+3OD/5pgqtZfVNLKelF3C2eph75Nky1eg5
         byzxEljfUTt3HlEuxyHUv11JDl2AMZuMxQYRPPFv5/UACkUAtTMIsfETTjnZhTQwzyKg
         xIaVIJWSNaX97DRioi62JoGJBPD9CCzFuhqyU56WRyPxQd7AaBCjC2U6KuhYTi8lxeBB
         aL0sToOyHxqVACJyHTf47xCC87ZyQx1reC0Eku+euAHBUMFPkbSrNV5VeFtfqStEBe7m
         okcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn/B/75JBEzr3RemrqLVtyHi58wkOiHvx9a593BpJAnaWf5DfFS1eCP5haK/J3fgs4sC0Ii0m4wYIwT3QqFhYfRJzMSkR0H5Me
X-Gm-Message-State: AOJu0YwydZ497/MUKKuMDgmApyGzb6fLqEX+2Cb/Q05gQEyuLfH96ITg
	6tek0fbygSnylEs0kRU9/0ow349iivRvxE6RzAcMyNwr8Azov7FsUd5eSUuGTDo+s5ap3+8Rtjq
	EUwD0BtvB8uvBtWijnqbg0d14xPokaXVbTARQ1g==
X-Google-Smtp-Source: AGHT+IGf021TO6N0A+Jn2pGdfdFuuxCfKPfqVCGX0Uaf82k6lo+cEMKalwjn9R3wNeAVL/LJosMsp6k5luz1m2Bj3lo=
X-Received: by 2002:a25:bc86:0:b0:dcc:e388:6db6 with SMTP id
 e6-20020a25bc86000000b00dcce3886db6mr2493381ybk.55.1709125452103; Wed, 28 Feb
 2024 05:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221184602.3639619-1-m.felsch@pengutronix.de>
In-Reply-To: <20240221184602.3639619-1-m.felsch@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:36 +0100
Message-ID: <CAPDyKFryo0vLS-t9XmA5=xAE27JQGh787f+-DGzMQWTdmBufLA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add default and 100mhz state
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 19:46, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Some devices support only the default and the 100MHz case, add the
> support for this to the binding to avoid warnings.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 82eb7a24c857..e47253e4eac4 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -173,6 +173,11 @@ properties:
>            - const: state_100mhz
>            - const: state_200mhz
>            - const: sleep
> +      - minItems: 2
> +        items:
> +          - const: default
> +          - const: state_100mhz
> +          - const: sleep
>        - minItems: 1
>          items:
>            - const: default
> --
> 2.39.2
>
