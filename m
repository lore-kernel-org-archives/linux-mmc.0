Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2032264DD
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332033; cv=none; b=CbqVrU3HLIpxF/MQfL4BB5hw0VQIJT3aMdtPQPtJV19hBXdzqpVn4XRyGLLxX0AAYS0ne1wggB0ajSN9mCDzvrvWvwG4yUjDMKrWEdQ2okkoT9Y6gyBFOu2JiKAh3qxsukRhzxLhDn199lbmcINUFm5uhskaO5gL+jHFPbkqa80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332033; c=relaxed/simple;
	bh=lYFZw4l/ySiLP9yv1DOpV3NKA5HpDmbgq92YmFRhr7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq849ndV2kO2WAmKLOmmmPdgCud6YDSWiWxwY2RzRDYs5p5OCO/iwl4Vz7NjSqGcr9zMZy8AQqTCCNdOG+ow81kzIs1H0rr1JaGRyhmwQdxcC1a+hFCWT8aX5bu09Aah7mP98dTOSrUL6U24pZaMtPvPCt2ymNZ40RFPRtfY9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=saCQmiov; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saCQmiov"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e81749142b3so638470276.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332029; x=1750936829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PBUsi0YBNMAsSBVKTalCtjkPCy5c9CLBxMjhKRUhDZY=;
        b=saCQmiovoIwSTwybLtAnXZYvOAzByJ87BfKcwZnjjvns9YSwiaIptpOBZGMoqSI4jm
         AkQ8EmmB6ArnpxipOVCg+G4KMUsWplhMRCmFstrDvgW4XhMqCjOW++qdRvnUcOd6KxTd
         CGRgobtgWvEuKUwyslKHjAfUPhRvVLUa6uxCiO2dy2iFqrdn0JYaUpszbaQEcUJ05LMs
         GeS4rcojM8ng9RU+f3DjJiQrrmiwqW29AwASiKW0lH4a4g9E3vVy/HdBkmsvNjv3KNA3
         jtEbY5cL+v1euXR9Eve0K5MsEMSLfb+fzoqneMcZOcx5KlBzdy1XEpS5wPDNll4j0jK9
         agWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332029; x=1750936829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBUsi0YBNMAsSBVKTalCtjkPCy5c9CLBxMjhKRUhDZY=;
        b=fd/66qsD9Pgr9Aq16zzp8sXy7QgvqNop/tJJ5F5mVjlwEWH1UgYTlILb0WY6f3O0Nr
         tAmM/uZxpwn02rePIF+kMkiaQ7VPumKQ/nYn8zwTkVh0klZzR+Yn77GuoQqAVyzDBvOJ
         +EU4X0QaXzWFcT82jBXvm81VstCg5T4XVSuSYicIQirE0TL89zNMItateUr6h0V9a12K
         oUGZkJMz4z49GiZsLzlHC5vyep6ayjM1GFH9E6Xq7AhAs3Fc6zGgUcTbl+G8aLYN+A7L
         aTD+DAhKkVqzFEXmr67M2hHgGLRedFFgqp10Lmml1MF8eGLDDwEcQFprWebkDEEcwx29
         7eIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHZrdtoCMNK9GWnWc56L2LZYvBDmJ8P7u6Z2zB8hGtosUbAZiXADzKrS34CT8cYhw9aAIOrIOPUKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZ1FtQTgYCrqL2EhkghZIdA4O1b5v7LQHUSmn3VcLk6GUeibj
	sd/5CaLl9ijeReXHMhdhlAsGTUxZxflA2MjqJSfrut8lnCwTODn9UvRlOQn9MLF28cpW3CDko0r
	kjqKMFYHAstqrFSTI+i+ntiNBwRYERIXtQuFHqExa1g==
X-Gm-Gg: ASbGnctbNIhhYoHvAkKP1zvaXs5e85gc5bt+qirJvYziKC1igHM2SvYEqDPS1rH/727
	QjfqKR1IwGPJJEU4oS1xjiBlX1PqPAmaSkC2EQSTOIbUgAL0uW7xKdFNEQajbZdrKbi9eziIlS/
	xebukMSRcuuZznKdF0XWyVbSmqk+AVOgIQ+J+s7QHayuWM
X-Google-Smtp-Source: AGHT+IHX9ksGPdiWQPczJro/bAe1IGvypwqoP8WCOZDCwwHcVTV4TvNUdtBj0nob0BRaQUU78E2vrWhUpGn208sRiuY=
X-Received: by 2002:a05:6902:1b04:b0:e82:13f4:6156 with SMTP id
 3f1490d57ef6-e822acc6b88mr30435408276.13.1750332028965; Thu, 19 Jun 2025
 04:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749127796.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1749127796.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:19:50 +0200
X-Gm-Features: AX0GCFvvZQe_9Nix73DE7Q-G_-P34yyA4RJkioiqjIQNcE5PdVnCw3Am06hW7zc
Message-ID: <CAPDyKFqbCcHPN8yf9Rzo0b0Gr2uBwXUCJDQNkSnnBesESN+kQA@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] mmc: Cleanup sdhci_pltfm_free()/sdhci_free_host()
 usage
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Adrian Hunter <adrian.hunter@intel.com>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Taichi Sugaya <sugaya.taichi@socionext.com>, Takao Orito <orito.takao@socionext.com>, 
	Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, openbmc@lists.ozlabs.org, 
	Michal Simek <michal.simek@amd.com>, Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org, 
	Aubin Constans <aubin.constans@microchip.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Yixun Lan <dlan@gentoo.org>, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-tegra@vger.kernel.org, Hu Ziji <huziji@marvell.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Jun 2025 at 09:32, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> After the first part of the cleanup[1], there are sdhci related
> drivers that need further cleanup.
>
> This patchset is the second part of the cleanup series, and since sdhci has
> sdhci_alloc_host() as the general interface, our main job is to clean up
> sdhci_pltfm_free() and sdhci_free_host().
>
> [1]: https://lore.kernel.org/all/cover.1748933789.git.zhoubinbin@loongson.cn/
>
> Thanks.
>
> -----
> V3:
> - Collect Reviewed-by and Acked-by tags.
> Patch-19:
>   - Use dev_err_probe() to cleanup the code.
> Patch-32:
>   - Fix build warning by lkp:
>         https://lore.kernel.org/all/202505300815.tjQRQD6z-lkp@intel.com/
>
> Link to V2:
> https://lore.kernel.org/all/cover.1748515612.git.zhoubinbin@loongson.cn/
>
> V2:
> - Collect Reviewed-by and Acked-by tags.
>
> Patch-01:
>  - Set sdhci_free_host() to empty, rather than dropping it.
> Patch-07:
>  - Set sdhci_pltfm_free() to empty, rather than dropping it.
> Patch-22:
>  - As requested by Yixun, retain the goto scheme.
> Patch-35:
>  - New patch;
>  - Since all calls have been cleaned up, sdhci_pltfm_free()/sdhci_free_host()
>    are now dropped directly;
>
> Link to V1:
> https://lore.kernel.org/all/cover.1747792905.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (35):
>   mmc: sdhci: Use devm_mmc_alloc_host() helper
>   mmc: sdhci-acpi: Drop the use of sdhci_free_host()
>   mmc: sdhci-milbeaut: Drop the use of sdhci_free_host()
>   mmc: sdhci-pci: Drop the use of sdhci_free_host()
>   mmc: sdhci-s3c: Drop the use of sdhci_free_host()
>   mmc: sdhci-spear: Drop the use of sdhci_free_host()
>   mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-bcm-kona: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-brcmstb: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-cadence: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-dove: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-esdhc-imx: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-esdhc-mcf: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-iproc: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-msm: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-npcm: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-arasan: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-aspeed: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-at91: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-dwcmshc: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-esdhc: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-k1: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-ma35d1: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-of-sparx5: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-omap: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-pic32: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-pxav2: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-pxav3: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-sprd: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-st: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-tegra: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci-xenon: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci_am654: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci_f_sdh30: Drop the use of sdhci_pltfm_free()
>   mmc: sdhci: Drop sdhci_free_host()/sdhci_pltfm_free() interface
>
>  drivers/mmc/host/sdhci-acpi.c       |  3 ---
>  drivers/mmc/host/sdhci-bcm-kona.c   |  2 --
>  drivers/mmc/host/sdhci-brcmstb.c    |  1 -
>  drivers/mmc/host/sdhci-cadence.c    | 21 ++++++------------
>  drivers/mmc/host/sdhci-dove.c       | 12 ++---------
>  drivers/mmc/host/sdhci-esdhc-imx.c  |  3 ---
>  drivers/mmc/host/sdhci-esdhc-mcf.c  | 25 ++++++----------------
>  drivers/mmc/host/sdhci-iproc.c      | 18 ++++------------
>  drivers/mmc/host/sdhci-milbeaut.c   | 19 ++++++-----------
>  drivers/mmc/host/sdhci-msm.c        | 11 ++++------
>  drivers/mmc/host/sdhci-npcm.c       | 15 +++----------
>  drivers/mmc/host/sdhci-of-arasan.c  | 26 +++++++----------------
>  drivers/mmc/host/sdhci-of-aspeed.c  | 10 ++-------
>  drivers/mmc/host/sdhci-of-at91.c    | 30 ++++++++++----------------
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++-------
>  drivers/mmc/host/sdhci-of-esdhc.c   | 11 ++--------
>  drivers/mmc/host/sdhci-of-k1.c      |  1 -
>  drivers/mmc/host/sdhci-of-ma35d1.c  | 23 +++++++-------------
>  drivers/mmc/host/sdhci-of-sparx5.c  | 24 +++++++--------------
>  drivers/mmc/host/sdhci-omap.c       | 21 ++++++------------
>  drivers/mmc/host/sdhci-pci-core.c   |  9 ++------
>  drivers/mmc/host/sdhci-pic32.c      |  9 +++-----
>  drivers/mmc/host/sdhci-pltfm.c      | 16 +-------------
>  drivers/mmc/host/sdhci-pltfm.h      |  1 -
>  drivers/mmc/host/sdhci-pxav2.c      | 26 ++++++-----------------
>  drivers/mmc/host/sdhci-pxav3.c      |  7 +-----
>  drivers/mmc/host/sdhci-s3c.c        | 16 ++++----------
>  drivers/mmc/host/sdhci-spear.c      | 11 ++++------
>  drivers/mmc/host/sdhci-sprd.c       | 33 +++++++++--------------------
>  drivers/mmc/host/sdhci-st.c         |  6 ++----
>  drivers/mmc/host/sdhci-tegra.c      |  9 +++-----
>  drivers/mmc/host/sdhci-xenon.c      | 15 +++++--------
>  drivers/mmc/host/sdhci.c            |  9 +-------
>  drivers/mmc/host/sdhci.h            |  1 -
>  drivers/mmc/host/sdhci_am654.c      | 20 ++++++-----------
>  drivers/mmc/host/sdhci_f_sdh30.c    | 13 ++++--------
>  36 files changed, 135 insertions(+), 356 deletions(-)
>
>

The series applied for next, thanks!

Kind regards
Uffe
