Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21C14AD29
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125443; cv=none; b=K5PbPPmDPysuMCsbhfJh7JO4Y95oBIONr2d0068DRR2xXuELcU2y6iwK82d/KpoCd0/2caiWDDNDcm83oJyi/T6iBGleqFUxABOxyhMDV3eKqoVcnVM/gj3Ljwd0k8SQiuR13eWhpSTm+edjXKxhsYWmopp6iO+to6mm+nYzrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125443; c=relaxed/simple;
	bh=vFTpKydtyiDddUobygfeyVWyr4s0AkGFJ6e0BY5C7PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdjnIn0Hqio8Xmv4EA0QjG8wk4Us7srOovhe5/DU6L/d+R8BkPrsk2LzmQeEwCtYnE1WC4dBimk3k6YhjUliWCEqNnA59GcUrAjl2w9jno6Kzx1j6IS3mX7t80+RG3SjL97DOrGHO2nbYyL0jK9DEU/Ppv7sUV87l8Lbszhv6Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ybwxBiXI; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybwxBiXI"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso5713050276.3
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 05:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125441; x=1709730241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4xrPKeqtgEGV9Q4IBEmk+WaDilZyeoAcRRC9Axa6hc=;
        b=ybwxBiXIRXB5RiLEhGRthnkei3MMShfAuSq4rpub29+ACNPlYcJNGepRlhAeOx+0x2
         9lXVSoj3DuPlJ/wvjH9Smzdi4YW/ILbbKmow/F+shWX7dOFkPfoau1kWYlRFnfC0CP3x
         dBJve3sRmnSw6tCnqp/iAJdzluc5hVAkGoLrgRLzUzKdOZ20Tg/u7mn8mjmhnTZsMZzH
         asC46cXmOjus/h2kwSiDjRZ2UowcBmAA/WEjH5Tn/+rx/g1PwiFr9R5nQbu+OjAfKDEH
         V9koODHEsb/JKOj6M5+7yLjtDStqR1TZIDPd2H3KFYV8Oxi9q76QhEDz0aJck9V0dsGk
         XRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125441; x=1709730241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4xrPKeqtgEGV9Q4IBEmk+WaDilZyeoAcRRC9Axa6hc=;
        b=eAg9uEqDQ0iLRq8Iqa/LhkYtkZwfzuUv2pggyZkQR+isOUdf6XDPuHdDFB1xvSyT78
         EmrNdhRV804wvCv1clgtX+6Zy5JWS62LlfjrhiKp9pTXdcCDqV+uGLnkoGzhS8iN2S6K
         u2as1GUjqZ8wSmHJcko/Zyxnnea2PUEqr9rnL3WlaqJMX3c1xtOVcjN+98IhPdmKS9tl
         x2e+/TzX4Uw4oP9zSsuN3nAzpf/KkZp0siBGV6bQJTGCbdztqBD9hpNoxklWfxXs7v+J
         jm9nlTo7/u2alSkyB0xvLVDU9SMeoA/fUJu6u2T5fBBfAnWXfapLdUZhRA/R1AZX7rAe
         Svxw==
X-Forwarded-Encrypted: i=1; AJvYcCUm5NNClAHBcOcFGvRNOnxe9+rMj+kqPwpRnSS/e6dAe7P9dZ/T+oIURJaz/L3BfoQVwZeA28DYuAqRJpSWRhX4E48Hl0+4KtKp
X-Gm-Message-State: AOJu0YwtkV3OOyBdoisMxDGltCMsbUS5h6optt/JksIbkVFzKFy6Dq00
	6DMVyWfqbxSHcSNKIa6JA/TPnpWA/Lsyg38OvdNgcix0F7IF7tXoYVrVKy7oYiJbS4jHGNTjxwk
	2WZBhFD4FhSnkWdpZaOHIzXKtn6fesKcSzm+3QA==
X-Google-Smtp-Source: AGHT+IGfbfWQ26vfcOGPm96x3PWRIKRsRzOqFj+BnyrgrRljfJCRT/1aUOwJAvx2MvOjZjDrvH/UChy9Nm4zE+AZOHU=
X-Received: by 2002:a25:9c02:0:b0:dcc:2f94:591a with SMTP id
 c2-20020a259c02000000b00dcc2f94591amr1934963ybo.12.1709125441193; Wed, 28 Feb
 2024 05:04:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217144202.3808-1-jszhang@kernel.org>
In-Reply-To: <20240217144202.3808-1-jszhang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:25 +0100
Message-ID: <CAPDyKFptc2K3PfrzQxzWctnCNbqRZVOmDDLDe9uWLUPp1Q7_Vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: sdhci-of-dwcmshc: support Sophgo CV1800B and SG2002
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 15:55, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Add support for the mmc controller in the Sophgo CV1800B and SG2002
> with corresponding new compatible strings. Implement custom sdhci_ops.
> Currently, only sd card and no-1-8-v is implemented and tested, I will
> try to find a board with emmc and sd/sdio sdr104 support.
>
>
> Jisheng Zhang (2):
>   dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo CV1800B and SG2002
>     support
>   mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  2 +
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 66 +++++++++++++++++++
>  2 files changed, 68 insertions(+)
>

Applied for next, thanks!

Kind regards
Uffe
