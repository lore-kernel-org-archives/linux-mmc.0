Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A268A24169E
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778706; cv=none; b=n3o4aGORQp0pdKyyeGBtSUt61ZvrdTGLH1DoCOQrSv8mRlTelpuWaIM3+Wz7r0GvHFaIgFukIm7ltbBOBRuAhJdGlAHO4M/jGzrMYdhyWQk0Z7Mj9AqEXey+n+dqJd9YYH7j/k3eNX5B04uKIxvt6akoCLYgiisOepVoSpxkxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778706; c=relaxed/simple;
	bh=KZOfhNvGBAR8H62mSv+Cnr7UPfTIt95Y31gyzfttSyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QV2Ef+l5/SMt4imUGe+OaQLmVecyJLMz92ISFlekJZRebtX3a//Ow4jk29Osx2nGjKFkKYzoxaOlrg8R4ATtulCqjY/IMnyeU+fcOC3sJRTvOEe4wXWGv8AzmIGMuF4ZqR+egYpM2be60eB6pSFVGSMhQeb76z00tAE8nhDbbZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OSxP8NG/; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OSxP8NG/"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6febf391132so52008267b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778703; x=1742383503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RAyMzA/EpimoKgZu8On+/pcgYmPCkV2jR9c+DuBL0OM=;
        b=OSxP8NG/YruoBusSECCaQSmlndpuks8ST1i+s+tXMCLht+pvx+cE9a8v65Xo9DodRU
         EKXDk+mD3SPq/G0tjHjr9awYLeK/tqMzCl+13G/JTLByWAj8N7NHNLrRf5sGXAs/6yzm
         78Dn9VoAJLBMHQClVJw+zzmwyF1EuzUnyLEVrJhkzWIkENN2I6wNu1yYDrJsdLbOZTy+
         XBnHXY3bmA0xXdIzjJ+VHbI5+ZFFsJxS17nuZdHolNGmHQXRtz9pjj9Wxh/PBYxvrcLV
         gE9jDKZgt0SkznH7ehVXFLl7E38rwhPft//nGRalmRCjNmxtm9kcOwFKPrWwlwvwExM1
         yYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778703; x=1742383503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAyMzA/EpimoKgZu8On+/pcgYmPCkV2jR9c+DuBL0OM=;
        b=g+UV+bmZRcxiFnYxKI15yyGMsXQ3AvC7s2xoNsoIqAjh5D48o0InLDsH7wh2DtEaz6
         RwRKGDx+mJNVbLg3LYhBI9eIq/X0hafvWicGeVhe76N/s12bOMtnWth3ojRibpCTkT7G
         VzpYVriB3mmlh4U9N53BNPSuH6sBeR0cej3Hw6GY/C+RjsCYnB5xDSdVRC9MnC07C31s
         mA9IAUuneLSMiupeSEKUTcPsJ8mirYcW5KZvGGx98OTpQMRzkc9m2u6tPAiBl1WMFspm
         TxJtTLPbk/pXeSwHi4fNxIPEJkJ+nl5JSkUGw3Dx3v0gxi1V/U+g6yvX+YS2pT6XaTd/
         BsqA==
X-Forwarded-Encrypted: i=1; AJvYcCXONFQwl8XBgxXJ/0eqvNr4Vq93E/jZY76eQxp75P7WjDfDFGm6r8TvRSBdUTXOypt8t9gLox7o9o0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqgLz29qFMkDG6t3aRbiGLAK0CIqlDt+lh4ZjiK3Uyqnlk6r0h
	Qo0KfCSBcptVucQ8J2dbVQ4UHGVFcG4ZELBqWuZhTqbMyzJ7xHU/rhxbx7n5woQfuEevZ7SnwJR
	08tYvCz5DVj7YWIuT1p8ZtMRt+jx/ELevacMOXA==
X-Gm-Gg: ASbGncuEXWXk49fQPZGtT8Mx+FPrjRC/2tPUVMaduVQyhzuqwYiI6Mm9ThMZxrgqEv2
	lEmud2nqh01NVE8/GMH3sqsnvqXBHL6Imk3yxE6FMyFdgUwSizDsPU97rpig9pznApBb2HbSJPb
	B1Z4w3aufI7kuMrS6UPBapC5YqwKg=
X-Google-Smtp-Source: AGHT+IGglu9wcUZQJ7kM7L4REyiuLkmFGiD8FrS6mR3Xkylx8tygAZpPYRnV6JQzsp7VhJrt3avxrAJ6Y8EDAb/0jS8=
X-Received: by 2002:a05:690c:4287:b0:6fe:d759:b156 with SMTP id
 00721157ae682-6fed759b590mr172175717b3.2.1741778703631; Wed, 12 Mar 2025
 04:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306170937.242183-1-Frank.Li@nxp.com>
In-Reply-To: <20250306170937.242183-1-Frank.Li@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:26 +0100
X-Gm-Features: AQ5f1JoI6EhIkJvZ2urcM945k8zoD09K83RZ6y4RdDZ4NA6PxGMieT1lQ5GBlVM
Message-ID: <CAPDyKFprhKa-XqJgfPjphuBCcn4ra2Gj0VewZ8iGqjYAYc2CFw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: Add i.MX94 support
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Mar 2025 at 18:09, Frank Li <Frank.Li@nxp.com> wrote:
>
> Add compatible string "fsl,imx94-usdhc" for the i.MX94 chip, which is
> backward compatible with i.MX8mm. Set it to fall back to
> "fsl,imx8mm-usdhc".
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index b9b9995705290..b98a84f932772 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -57,6 +57,7 @@ properties:
>                - fsl,imx8mp-usdhc
>                - fsl,imx8ulp-usdhc
>                - fsl,imx93-usdhc
> +              - fsl,imx94-usdhc
>                - fsl,imx95-usdhc
>            - const: fsl,imx8mm-usdhc
>        - items:
> --
> 2.34.1
>
