Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4A1B0134
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896507; cv=none; b=NmavY6A+jgXtjdGrVgEz2yHeXsi2tjsUbtYr/6+gSyRYyjFhv8ebGwn9NkUQqIfhb8YHf4+ZJlNylD9ZWcDTlxsHS+b79Au0TOBsK8Numkn5e08Gn3D4CFP+s10swB2uoVRSL0dqiyXwz11Xtzl5K1/BKelHoretLeNybvC6ZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896507; c=relaxed/simple;
	bh=omKEA7183JIq4+qk4ktnB4723ZppBGp3RLv0v4fpWqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXRCSvUbfKfGmOloS8GPyP03giuzsU0ZmvBKeTw4zgt7CPdHMv/bYM4atO6wQgVP9ztYFxMBtnqBOjavK5052t17bNmMmmXiOW+9IwtQvKsS6qojctbnFGbPyBzCNvM0RGevWmBOjtfeX1krrhLCqE21H7/Wq/beGlxrDtRZBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wu3boQu6; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wu3boQu6"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dff17fd97b3so986986276.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896505; x=1719501305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2n5KrLTZBvGu9gEb8O17y0tpUk8+ZpfDeRqP/uAfjQ=;
        b=wu3boQu68VI/klJgMzTutnkMF3/Qlh/iDrvPLlz3D/8gFSaFE3oTwzvrGYZQD6j4IT
         0ID06L98iNMODNoFbt1z+zV3dQUQ1DQiRvXRm2FhWEd/0l54Js8ZRNG1Q9RIoIr0ftdV
         IcoS5byFW0++Fl6T7kQyoDSzUJrnBorhTDwZuV/di53w9MWuUqpPQuOxmh9AACNuP9bz
         K/RWPFFGD5WsXWkWX9FD1kmj/v7RLVhN7Ba6vGbPS5PGdMWYLsRLNRNQQAntspWkzIMt
         KXMk49Ts0w8QvoMoqII7qghGOm8VJWd6DX3LETn8qnf1NNKLPRnDlrlSoYlaZmyXZfJg
         cb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896505; x=1719501305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2n5KrLTZBvGu9gEb8O17y0tpUk8+ZpfDeRqP/uAfjQ=;
        b=DHB/K4ESRGJxvfeslymCPZsPdLOT0LpoIna0lfQ0zMKrOhHEc2PASkmohLXH3ZmAn9
         cG9VzB6T2V3lmAzzkkRKKORB0wtmEDtcllwhVuNPybOCtZcb1sphhbY8p7fM54jaR2aH
         vRVa3DxRPdAsvfJefklMZ0MiAnlqsp1Md/kSn6g7y78Fr9UBK65QtAI7EZV7wKhy9ZhQ
         5YJ0HJHmNe+VdPwufGf0iPo2Pit/tDCpONP1Gygp4c9seFyZfaxx0zZPTr9rVtvR1qEM
         9thlFqWn/WyiVwCm8AJZlPvn5flL37WQuof1uHbXC5j7XK19KG3l6L/MXXQu6NYCn4Aq
         5HCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjT4ZhtSn9qs7VTG2wtf4mIJ6QlMFHyhIPLePoCvLHHg6SJ0b0hmYds203tpa4wdXi8yKhvOzruh2pmZItOiVxtDRm9KdONuRZ
X-Gm-Message-State: AOJu0Yyj4uw6+oSdGPDYTS3tkH5WbdsSPU4W2UlWJ2op9heh7aUjQX6j
	nbkmsnHxeTwl+FuVNFpToo3Hn2t3hG3Rp7F+mcje1nhDm/ERjZJRCBNB9zQi0kLaeSo9Muq3gP+
	9eyNm3ctqgizWg7tZTEizs7lDWMpCPiPPYLKtnw==
X-Google-Smtp-Source: AGHT+IEgsR6Axacelg4a84hDNwZ/HxzbPZz6nBbHwPbmaUBauO4zOvR4vycjA+yQ+ptsu9Vsx+lvyO9aNTZ86xfQU+o=
X-Received: by 2002:a25:840c:0:b0:e02:b68d:b432 with SMTP id
 3f1490d57ef6-e02be17563cmr6316451276.37.1718896505132; Thu, 20 Jun 2024
 08:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
In-Reply-To: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 17:14:28 +0200
Message-ID: <CAPDyKFrfQQu7GE2pHPHspKw3hkqf219kWCU2KwKMtTKQmKRbtA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] arm64: dts: convert fsl,esdhc.txt to yaml and fix
 layerscape dts warning
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 16:32, Frank Li <Frank.Li@nxp.com> wrote:
>
> Start from v4 because fsl.esdhc.txt to yaml already sent out as v3.
>
> Now only "bit-endian" proptery warning left.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v5:
> - squash dts patches to one patch and fix typo.
> - move spi-slot-mmc to first patch.
> - add Krzysztof Kozlowski review tag for fsl,eshc patch
> - Link to v4: https://lore.kernel.org/r/20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com
>
> Change from v3 to v4
> - Add dts warning fixes
> - Add mmc-spi-slot's voltage range fix, (not sure why it apply to
> layserscape's dts file.
> - clock-frequency is not required property
> - add dma-conherence: true in binding doc
>
> ---
> Frank Li (3):
>       dt-bindings: mmc: mmc-spi-slot: Change voltage-ranges to uint32-matrix
>       dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
>       arm64: dts: layerscape: Change node name from 'esdhc' to 'mmc'
>
>  .../devicetree/bindings/mmc/fsl,esdhc.yaml         | 105 +++++++++++++++++++++
>  .../devicetree/bindings/mmc/fsl-esdhc.txt          |  52 ----------
>  .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |  16 ++--
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   4 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   2 +-
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   8 +-
>  9 files changed, 124 insertions(+), 69 deletions(-)
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20240610-ls_waring_esdhc-93136a5dd794
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>

Patch 1 and patch 2, applied for next, thanks!

Kind regards
Uffe
