Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF563D75C6
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068849; cv=pass; b=ZRnMVTkl5IMjdt75xlzI8MLl+zvAx8r/pgRtXNBOP/2IHuoP0wKLDhufcer33aBjlcJEuAkZaVMmsWVjGtjSFRWalxPIgqgZH1zjyK03qBcqWT+6F35chtlu1yMgMVbQz2afiqpdVEO4H4wJgfUCtabqjBLqNM2bcGL9yap9cxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068849; c=relaxed/simple;
	bh=cmRiodC9r+mRuSIKrsDa+1SgJTeHck5hhqgmz3f7sjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh/ZUoqR1OJ+2okxTP0mc8wFmcPG6jyDXXUkYqOmgRl05sMZ3X4Fs4jq/TAfg9t7DY9a0wt0fJJ5mOtBJw1k5/vlMBC7gWkIFAJpZi52XIXT29RwZjfqbRFi1a4i69SGAdXC/Dx+Vu0NzcIqLkxEG6mVeh3wEzZz232eJBfcqeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=twWyb9QQ; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twWyb9QQ"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so4823523e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068846; cv=none;
        d=google.com; s=arc-20240605;
        b=fcyAa56hSaWzYtoS0U1hEYJbKfC7svH9ZVhHyBRpcHDKUg1XpkvDccK0bE+FJEKKIT
         LtSN526UPfpyHnGmP10hUeM+pTHYwhLd4XNZ2ucKEr4+uyo6DWpdENxNt/C5cdfB3jM0
         hUuQVIAQ+O9e0hY0WU2RoN74cUq3eNZOCXUjYMzKWfW9A2Ffr4hCsaz+18CxXwo4FjAW
         0GkMWvRb+N57FDhPj5MXqF/kOWD3k7xd/Ro1WKDoSUrv+V8EGnoA/C3o67L7tMtk5xCG
         avtPn2jJWwQqHxO2ybx8wDMD5r4+W7sPKkM2EvqEJS98rsyH2pzLL/R3/t/5VZQ1s964
         cFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TdH8bvkNIpDog/K3q0ZzGRX8OtZ/OKv1fjCXdvgPWAI=;
        fh=BtkvOOGxORJ9VhpDEOOaRuxESM86MK7ps45F0J8Zv1g=;
        b=bM9pV0+uxSAA22ADp/0wIYWT0CEKAMOqqIRcr/X37PgDRUDsln9SwYcenpG267pNSp
         jOdZZ1+POiD8xuqpXHf+KC7wKsA9gPxyzjp8u+KeKbQgo4nqmkDDiNV5Drd58H4ygGSz
         8FOX0TpQR1oOHHNAmGbqhAAGgFFPIGWGShuROaS4HUVaSgovTDxUzzrSbjUmLhCrDOoB
         KWrJhBqRmGb3A4vJQc7ECzsoUMtoWcu7dx1O+MEd+5mr4Z7k3R1hM9vMYqORi5sBG0Yd
         RaWLCuUhMEBmSENW29UwGD8xtBuFSQKxjonsUaNQWxCDTHsjrNwHO4W0cSwJlLDiLBF+
         XIzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068846; x=1773673646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TdH8bvkNIpDog/K3q0ZzGRX8OtZ/OKv1fjCXdvgPWAI=;
        b=twWyb9QQ3QGMDsZuo33MY5G6XgRoCUvxskutOd8Jh2lMLypdjfnHm1p4yXGblJyv+S
         op0rrxngeG2SEZ7/ahCnZNIL2qnTrpg/xS7iol0vWHijZ752ByGH/7YBuxho6PD8K2/b
         KVa4hm4UAL0ukjZZlHcVZxFcicHsmwmnPP9coGkj6Yecoip5rnLhVuMr2vCdxKshwQib
         KXAg0TX2R8At0O4zRmyegS4Uv87xX4N7y4rYAS0Q/q7jqE7nJlsLPMaAhsyoIv6tyraL
         X9Bj5VhiFVhUvKvyqkeHRQLlOhJX0v183MqMbQ2o5izso9Yef25gzlaP4e/WD9SOeCga
         q5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068846; x=1773673646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdH8bvkNIpDog/K3q0ZzGRX8OtZ/OKv1fjCXdvgPWAI=;
        b=mv/YA78Z8cQ4NvMx7ToWlXBHU/leQTjOO0IbgL2mCcArqgGuoxhhFE4u4FLjyjOvhc
         MV99t+PqoUMZH0KOV7PiUzOOChcWb2RrKs5kMXeU8uk3BS7h6bH6bMnuZc7hiVADoRxQ
         R8eOB4FQHKMjjL0iKQomgVQ14jVzA+X1BwdxTrDypDJuSCWh4GL5rQQGU+m2yt+ifmDe
         vIq8kINFoqL8ug1RxO99hGjz8GTh9un9QHOd8Mt7OMg7FOlqXXKRG442s1YSe3Xheec7
         spHkOqk0LwP31/9ayYp1x+6dfZ54mD1cnUMKVCLnu8PIb3nH/h24d78pm/Rcjfv8JVDj
         Zyng==
X-Forwarded-Encrypted: i=1; AJvYcCWjCeHulw5wyMFFeGG+Dt151VZ6Ea1xwf6Z8bU7U/vc1hhkQVc6DDmiroW2RxSQws9AA+jSUH7serE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZR5kz2IQehwJ7Sc8XteYDPAOmb+NIQAKpir7HYFJrTzggeNAV
	e7ldY6zKbL1LlO+CS8ba+owacQn9V8iagmx5qj1iMvT3DyO2OyRJxrzS6cfztP87h/fV/SZDCnn
	5jp9yzumy2BuuUAY4YXtF4m56vEclfigO3MhzdfzvRw==
X-Gm-Gg: ATEYQzzpdEPhl4aVdeRb8VptY3pZ9fHIVQNw1XZsfBbPAwUjwIV6g+dncME6ja/YJHY
	Feugtk2bZAXiTOljcMseVJUOmtS/8L8DSw043q4Hz/BcL6Hy8PydnJoqACTLJ0St8cRl+PP8UbW
	1E9M7Re2dyZPE4VYpvfwtRefi7v4GVQvM0TK/WhYyg3h4vdbRXRsGhgR6f++MOu62LL81aFc8ws
	+bQyRkNX5jk5QtFaEJvDekeSiQCoNJWgRDi3FHRiqrIMs0P9T8tCTOaMk1UnmOiEc3DMhAJcMI7
	4S6ug1AH
X-Received: by 2002:a05:6512:3409:b0:5a1:2a71:cc3b with SMTP id
 2adb3069b0e04-5a13ccb1aeemr3618408e87.18.1773068845876; Mon, 09 Mar 2026
 08:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:49 +0100
X-Gm-Features: AaiRm53zSNZD-rgavB1hXZqnC71GE3J4BBqG9ZBYLAtj9oAS6JeEy0pPrIt0G5A
Message-ID: <CAPDyKFof23uOBe7duOLuFJ=qd8bv8f6ryFWbrPcTFB-Jg4ZQTA@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] arm64: Add initial support for NXP S32N79 SoC
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, s32@nxp.com, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Mar 2026 at 15:34, Ciprian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> This series introduces initial device tree support for the NXP S32N79
> automotive SoC and its Reference Design Board (RDB).
>
> The S32N79 is an automotive-grade system-on-chip featuring eight Arm
> Cortex-A78AE cores organized in four dual-core clusters. It is designed
> for high-performance networking and gateway applications vehicle
> architectures [1]
>
> Hardware features included in this initial support:
> - 8x Arm Cortex-A78AE cores (4 clusters of 2 cores each)
> - 32GB DRAM Memory. 28GB are usable and 4GB are reserved for ECC logic
> - Three-level cache hierarchy (L1/L2 per core, L3 per cluster)
> - GICv3 interrupt controller with ITS
> - SMMUv3 for IOMMU support
> - Generic Timer
> - IRQ steering controller
> - PL011 UART controllers
> - uSDHC controller
>
> This series also includes the necessary driver updates:
> - sdhci-esdhc-imx: Add S32N79 uSDHC controller support
> - irq-imx-irqsteer: Add S32N79 IRQ steering support
> - irqchip Kconfig: Add ARCH_S32 dependency for IMX_IRQSTEER
>
> Future patches will add support for additional peripherals such as
> networking controllers, PCIe, and other IP blocks.
>
> [1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N
>
> v5 -> v4
> - Squashed irqsteer 'Kconfig' changes with the actual driver updates.
> - Fixed tabular layout in the irq-imx-irqsteer driver
> - Added received 'Reviewed-by' and 'Acked-by' tags from V4.
>
> v4 -> v3
> - Added missing Signed-of-by's from one commit removed in v3 by mistake
>
> v3 -> v2
> - Split S32N79 SoC dtsi into separate standalone commit
> - Renamed a memory node in the S32N79 board dts
> - Fixed IRQ STEER DT-Bindings support for S32N79 addition
> - Updated S32N79 usdhc driver support commit message
>
> v2 -> v1
> - added driver changes required for S32N79 uSDHC support
> - added driver changes required for S32N79 IRQ_STEER support
> - updated commit message for uSDHC dt-bindings
> - implemented fixes for 'dt-format' tool findings on newly added S32N79 dts files
>
> Ciprian Marian Costea (7):
>   dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
>   dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
>   dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
>   mmc: sdhci-esdhc-imx: add NXP S32N79 support
>   irqchip/imx-irqsteer: add NXP S32N79 support
>   arm64: dts: freescale: Add NXP S32N79 SoC support
>   arm64: dts: freescale: Add NXP S32N79-RDB board support
>
>  .../devicetree/bindings/arm/fsl.yaml          |   6 +
>  .../interrupt-controller/fsl,irqsteer.yaml    |   4 +-
>  .../bindings/mmc/fsl-imx-esdhc.yaml           |   1 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  70 ++++
>  arch/arm64/boot/dts/freescale/s32n79.dtsi     | 362 ++++++++++++++++++
>  drivers/irqchip/Kconfig                       |   6 +-
>  drivers/irqchip/irq-imx-irqsteer.c            |  55 ++-
>  drivers/mmc/host/sdhci-esdhc-imx.c            |   9 +
>  9 files changed, 497 insertions(+), 17 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi
>
> --
> 2.43.0
>

Patch2 and patch4 applied for next, thanks!

Kind regards
Uffe
