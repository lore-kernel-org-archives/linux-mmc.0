Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A32749EA
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654493; cv=none; b=rsNSsQ8laEcyUUQFrsk1RVsaaepBuyLV3alSVtKij+ZX8eQGQAhhiD0SGSzucEw2pv6I+jHqlIEYv9PLjV5kKuoNk+ofm7+Z+soycQ+Zh0+nByrS5v5OyblUD2rJ1Ch4rx7V93tDMP9La1rR5wrTYPz7PgMrFXJJ13dY0xAZoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654493; c=relaxed/simple;
	bh=udfUTmlF3isj8UVHWPBs361Rv5VOxzJppL60XaV+YLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ji2eZXzG+Hqe10QSzXwya61ohdrW9vQJ5V+MvurQJCxxzT4W3eg5HVlDb6HUvkf3IkL7qjUZZ9JKqWppsly0OxkClQb96/XSNUK0exNavGolTaBu4GbUm8xnazc4pZrWARZNrSmbNHhe2XT0sofQ9734GMxFb5Bmz1yiycdDNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BoxoEMKG; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BoxoEMKG"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e7b93d61ee1so1155548276.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747654490; x=1748259290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9ifYnJEHZkjugzgP1AAhyx3RM0Rc1N5KhZmwX4DzcA=;
        b=BoxoEMKG7+MxTLOExTlrOxbuLYn4smnfm90P6HL/T0O4i3wHR2ueoKEK3pSkCFPAYT
         hsm9wzIzMaqnTJY8Mh6kVDs688j9blWvQQiw2Yx9hlvDfKSVLdDxN8e+TPqVUWisC2sL
         jJsQx2AbHDU6fw0NzoKe651AAyWDfExoN5nz6TE0BwddoL7CxCuumB9lbocHq4zQXSQU
         Q/9ssXWFrLg/fmop34XM3lJylojgcfQnX6PasoLX1fBqwoNFiu9D883g0JXkG2lfeGiC
         g0/OgAqfkkM9qdtoFw+npYF4TLcF7lDI4MnpEWsRMsBbHMVBB3mknhhDHUUZCCrHbCyC
         x1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654490; x=1748259290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9ifYnJEHZkjugzgP1AAhyx3RM0Rc1N5KhZmwX4DzcA=;
        b=sM2lr/EPg9FSl3B5w1QMVyWChaya+kV+9Y0jR4LPBRQT+qWxglBLQ32TIjroK04rdC
         bJmV5rO6mIG/OXSjXqz2frF3IoyBgtpvC9oocHXgoGrX5UQzWIa80BY0XM/I8XLNA+oT
         DUL3jq6AQQAoD40ln4GXX0qxSO/yFsKaUyJENqrdORJ6GRd/xlQSvpoZAOeUk/mxhBIv
         PEQxfIbVhSFcknsp/55FLLQ8H+4kdI2ExVDgWhoWukinPiRHda9L37Q6L39aqDXlVoRD
         Yw6RFKIVGQE/9QotWnAXutESfgwAb9xL2BJDHYAzsjd9oDprbYDngbQExrivYE4StLal
         v1ng==
X-Forwarded-Encrypted: i=1; AJvYcCWEACxlE29udlzgGMPixu3vaJURXqlGsW7gOxoTVvZqBWA+Sc2jnz7qQJEi9zd5YsaU4SzfNiyW7jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNCLzE6/JB6F4x8CDhJB0/2Vn/K4bEfHqCwXb+l0F4fzSErFK
	lHEVq+8nYm6Cl04RAyGVMari0GHgrZZ2NXsQ+dc1BFa+qnGFhOvXLDzSks4joUQOItw35JTvaId
	RvFXTAWkNt1ss5soa0p7sRUjp7sHlEEGXSgI4C9ELeQ==
X-Gm-Gg: ASbGncs2qzMtE+zYLXMX4xaBmJf7SV3uFUvz9TM9qeXNnQUJwoobKrmsFHUK0WwQm6H
	u7z+Zrtw6IRrIIw8mk5845S60D8pwa+Frnqll7D67wmJkYZctY4oY+DWd7rTY50j1od7ZvR4FhB
	k11nHL+Jx3nJAabfuPB7E/HRMDYnxqujHVHQ==
X-Google-Smtp-Source: AGHT+IEzdVLtO9YBa5+IVyduAY6NRSx7ulnCzcRUIF50EVMFrKD1g2sNV/MU3FaCc/lVmOV0bCCHQy4wQPIgDk2szp8=
X-Received: by 2002:a05:6902:2181:b0:e75:c2d7:53d6 with SMTP id
 3f1490d57ef6-e7b6a0821b5mr17229222276.13.1747654490027; Mon, 19 May 2025
 04:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-20-k1-sdhci-v2-0-3e7005fae29b@gentoo.org> <20250501-20-k1-sdhci-v2-2-3e7005fae29b@gentoo.org>
In-Reply-To: <20250501-20-k1-sdhci-v2-2-3e7005fae29b@gentoo.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 13:34:14 +0200
X-Gm-Features: AX0GCFsNpQorB3Le9i73KErfl_8y60Wp1PR0WslTHu1cwMkDy6FRe6Gb1knvm-o
Message-ID: <CAPDyKFoDWS6DWdKOaxTDEYeKv3hjVDoR7XGi19nESVssc-RG8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-k1: add support for SpacemiT K1 SoC
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alex Elder <elder@riscstar.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 May 2025 at 10:51, Yixun Lan <dlan@gentoo.org> wrote:
>
> The SDHCI controller found in SpacemiT K1 SoC features SD,
> SDIO, eMMC support, such as:
>
> - Compatible for 4-bit SDIO 3.0 UHS-I protocol, up to SDR104
> - Compatible for 4-bit SD 3.0 UHS-I protocol, up to SDR104
> - Compatible for 8bit eMMC5.1, up to HS400
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  drivers/mmc/host/Kconfig       |  14 ++
>  drivers/mmc/host/Makefile      |   1 +
>  drivers/mmc/host/sdhci-of-k1.c | 306 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6824131b69b188cae58c8f48076715ca647ca28c..0ce78f22c33cfff916a2d4d680c79e9d19637e0e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -250,6 +250,20 @@ config MMC_SDHCI_OF_DWCMSHC
>           If you have a controller with this interface, say Y or M here.
>           If unsure, say N.
>
> +config MMC_SDHCI_OF_K1
> +       tristate "SDHCI OF support for the SpacemiT K1 SoC"
> +       depends on ARCH_SPACEMIT || COMPILE_TEST
> +       depends on MMC_SDHCI_PLTFM
> +       depends on OF
> +       depends on COMMON_CLK
> +       help
> +         This selects the Secure Digital Host Controller Interface (SDHCI)
> +         found in the SpacemiT K1 SoC.
> +
> +         If you have a controller with this interface, say Y or M here.
> +
> +         If unsure, say N.
> +
>  config MMC_SDHCI_OF_SPARX5
>         tristate "SDHCI OF support for the MCHP Sparx5 SoC"
>         depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 5147467ec825ffaef3a7bd812fad80545e52b180..75bafc7b162b9e1d4c6c050f5d28b9d7cb582447 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_OF_AT91)               += sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)       += sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)                += sdhci-of-hlwd.o
>  obj-$(CONFIG_MMC_SDHCI_OF_DWCMSHC)     += sdhci-of-dwcmshc.o
> +obj-$(CONFIG_MMC_SDHCI_OF_K1)          += sdhci-of-k1.o
>  obj-$(CONFIG_MMC_SDHCI_OF_SPARX5)      += sdhci-of-sparx5.o
>  obj-$(CONFIG_MMC_SDHCI_OF_MA35D1)      += sdhci-of-ma35d1.o
>  obj-$(CONFIG_MMC_SDHCI_BCM_KONA)       += sdhci-bcm-kona.o
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..8988053eeb33a476fa484d145579db6214b2d0b7
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2025 SpacemiT (Hangzhou) Technology Co. Ltd
> + * Copyright (c) 2025 Yixun Lan <dlan@gentoo.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/init.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +#define SDHC_MMC_CTRL_REG              0x114
> +#define  MISC_INT_EN                   BIT(1)
> +#define  MISC_INT                      BIT(2)

These define-names look a bit too generic to me. Please add some
additional prefixes so it becomes more clear what they are.

This applies to all the others below too.

> +#define  ENHANCE_STROBE_EN             BIT(8)
> +#define  MMC_HS400                     BIT(9)
> +#define  MMC_HS200                     BIT(10)
> +#define  MMC_CARD_MODE                 BIT(12)
> +
> +#define SDHC_TX_CFG_REG                        0x11C
> +#define  TX_INT_CLK_SEL                        BIT(30)
> +#define  TX_MUX_SEL                    BIT(31)
> +
> +#define SDHC_PHY_CTRL_REG              0x160
> +#define  PHY_FUNC_EN                   BIT(0)
> +#define  PHY_PLL_LOCK                  BIT(1)
> +#define  HOST_LEGACY_MODE              BIT(31)
> +
> +#define SDHC_PHY_FUNC_REG              0x164
> +#define  PHY_TEST_EN                   BIT(7)
> +#define  HS200_USE_RFIFO               BIT(15)
> +
> +#define SDHC_PHY_DLLCFG                        0x168
> +#define  DLL_PREDLY_NUM                        GENMASK(3, 2)
> +#define  DLL_FULLDLY_RANGE             GENMASK(5, 4)
> +#define  DLL_VREG_CTRL                 GENMASK(7, 6)
> +#define  DLL_ENABLE                    BIT(31)
> +
> +#define SDHC_PHY_DLLCFG1               0x16C
> +#define  DLL_REG1_CTRL                 GENMASK(7, 0)
> +#define  DLL_REG2_CTRL                 GENMASK(15, 8)
> +#define  DLL_REG3_CTRL                 GENMASK(23, 16)
> +#define  DLL_REG4_CTRL                 GENMASK(31, 24)
> +
> +#define SDHC_PHY_DLLSTS                        0x170
> +#define  DLL_LOCK_STATE                        BIT(0)
> +
> +#define SDHC_PHY_PADCFG_REG            0x178
> +#define  PHY_DRIVE_SEL                 GENMASK(2, 0)
> +#define  RX_BIAS_CTRL                  BIT(5)

[...]

> +
> +static int spacemit_sdhci_pre_select_hs400(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       spacemit_sdhci_setbits(host, MMC_HS400, SDHC_MMC_CTRL_REG);
> +       host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;

At least this deserves a comment. Isn't MMC_CAP_WAIT_WHILE_BUSY
working for all cases?

> +
> +       return 0;
> +}
> +
> +static void spacemit_sdhci_post_select_hs400(struct mmc_host *mmc)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       spacemit_sdhci_phy_dll_init(host);
> +       host->mmc->caps &= ~MMC_CAP_WAIT_WHILE_BUSY;

Dito.

[...]

Kind regards
Uffe
