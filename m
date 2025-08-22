Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2E2D0606
	for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857793; cv=none; b=cM81wBxjVHyE8tk2L4ElE2V6kUwuxyqapIvNu7uiOq0FJWzU0bfsiGqJN6C8ICOix0/WmRVEtppb++yIpM4fvUo8PviIqhejJPal44fGZmHu9bvj0p2Y88KnMxRscc91MfKel5a4IVDZIIUjJau4/wVNWVnW4bmUZuQXSRZgRq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857793; c=relaxed/simple;
	bh=57Vitio2azD+9kmpahn/amN6R2csSipeQSyroiiFzSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfQgU+WwDmvGVhE5MM4/+/2XxeO/rKufx5PCflIDce5hWCKd9JoDuYxqV+bCgPOSsTnC8wA+sv2MuvRIMjdiz8PLp67dKrKrYhoXK/VKBp6v8e6FGzRJG12MtsBUpYXtLs2xLJhTN2xqJNt3DQNMnBIKCYGgpUAzGJW+DfLnTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jR6PI2AS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jR6PI2AS"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e93cc7c64faso1981511276.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755857791; x=1756462591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HaYDNgmpp6+5Y0purWP5xrvTSV/5IxfqoEtA6v9W5K4=;
        b=jR6PI2ASQv9VtaoEyamh4ecuOp6429sa1kC6JfVvxoFmtEtfu4sg0loB9BnS9EWNnB
         ID1K2pFpbwbKBk+WdIObKHc9eiyT558XkVpA+slZfOatYQ4CRFZLyLDmHy6RwKnciEyd
         OBcDi6Pm3+F4ybaAkAKGsjSq9J8z1g4E89A2THmSEphdmAiAtn9pjCjqS6reQw8x5pub
         f29AwLxLSck/lG2yCKA6EZ5I6XEShdNnv78cdOTj1cESoUKffwinjoIDG5RPBgr7UFuk
         hM90PI9fqsuiJMkpFytKyOC/lJHav2ohL0fvqpu68eczjcsNghtHLPNCAQt5OTmNAEhu
         dxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857791; x=1756462591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaYDNgmpp6+5Y0purWP5xrvTSV/5IxfqoEtA6v9W5K4=;
        b=Te+tyNliAxp8ctweOdL0fHLh2Tt9dahOAjjMfZ+oSiXXPKyj2LDVPm90SENi/0wigM
         CPXyrJcD988mvVgL/ipKfb1YH0XV6RhAgUwjyu/mIYpQB060h2X7bZqNuAvSkFNd+0nn
         eiVj7RIeH53Sy/mjvQERZoYeykmwlRpfjHPSJPqq8Jjt0yU1XotRfIn/wIzEss/k++K9
         j3WRKOZi6AGIQCnWneYoCegQfrv9ZgfGhZaGwJZ71gbzqcBafsLedeQl/12HcNM37Oxa
         MlVuSVixjBLULNAi9toeHLU7ARZerjx1L2KF9WHX+RI941yXUJ5seWb0GDIHGZ55hDzQ
         mv4A==
X-Forwarded-Encrypted: i=1; AJvYcCUbHsCYAEBU8x1m8izISYKvHlOlEeGZea2CZ/X1xtARe0GGj/tduEHOdi2lkT8lF4nzyWk3SSP9oSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBOOYsgBsRsdEdd37dPg/+Ib1gCk6xpNqDeFE75ZaB7hExcne
	WsoxYHY/6eqatLrOJK3s7cjSNQEBBnb5eHzhhSceEcvDZGWDh2QiQjpd6T43Bi9wwQlLd0FPM5l
	GI6+5VzAr1nqY4mvzcKIM3ntAR8MNSXSBgnPc6XmMQA==
X-Gm-Gg: ASbGnctDK/feaIaJz69ihFz9HSkA99R6K/uHFSnIvHb25kMMyUgcRLvOa/qXbsAnVNS
	+POxQhSNm8vlO3OIlN0KC6gxeMkRa3g3LAIU+I72/MB/8kNQYmHAdVzeli5mcuSM3DIfBCxCf8I
	DJf6WTMjJk/kj7a/AQWcYqCSk8hDQ21xPMvtTm+HYJdodKL4/7ajnR9Ga9Qf8IIMJ99pT7kLtL7
	8Jt02WOvW1NvH4ZYbU=
X-Google-Smtp-Source: AGHT+IECN4iF6OJRZss7SzgvNDRQzHApMMJpc7r0Uvvc1Us1BzsqkR4L17K931ey157QBh786lvQEBfqaMX6lnlmEy4=
X-Received: by 2002:a05:690c:4c09:b0:71f:b944:100c with SMTP id
 00721157ae682-71fdc5523e6mr23503877b3.51.1755857790925; Fri, 22 Aug 2025
 03:16:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815013413.28641-1-jszhang@kernel.org>
In-Reply-To: <20250815013413.28641-1-jszhang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 12:15:54 +0200
X-Gm-Features: Ac12FXyxAkGguyf-io5vSuMnfnRSfBwdLkdVC850p3szzqDms2u92OsOrxVCVQU
Message-ID: <CAPDyKFoRRtJQgFJeMbuwkKRN4LbHpEpK38q2U8TXje7m6buRfA@mail.gmail.com>
Subject: Re: [PATCH 00/38] mmc: host: use modern PM macros
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Manuel Lauss <manuel.lauss@gmail.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Russell King <linux@armlinux.org.uk>, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Michal Simek <michal.simek@amd.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Alexey Charkov <alchark@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Aug 2025 at 03:51, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards or
> __maybe_unused.
>
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
>
> Previously, I only cleaned up the host drivers which I used, e.g
> sdhci-of-dwcmshc, sdhci-pxav3 and sdhci-xenon, these are both compile
> tested and functionality tested. But then I also cleaned up other
> host drivers, but they are compile-tested only.
>
> Jisheng Zhang (38):
>   sdhci: add some simple inline functions for !CONFIG_PM
>   mmc: sdhci-of-dwcmshc: use modern PM macros
>   mmc: sdhci-xenon: use modern PM macros
>   mmc: sdhci-pxav3: use modern PM macros
>   mmc: sunxi: use modern PM macros
>   mmc: alcor: use modern PM macros
>   mmc: atmel: use modern PM macros
>   mmc: au1xmmc: use modern PM macros
>   mmc: cb710-mmc: use modern PM macros
>   mmc: davinci_mmc: use modern PM macros
>   mmc: mmci: use modern PM macros
>   mmc: mxs-mmc: use modern PM macros
>   mmc: omap_hsmmc: use modern PM macros
>   mmc: rtsx_usb_sdmmc: use modern PM macros
>   mmc: sdhci-acpi: use modern PM macros
>   mmc: sdhci_am654: use modern PM macros
>   mmc: sdhci-brcmstb: use modern PM macros
>   mmc: sdhci-esdhc-imx: use modern PM macros
>   mmc: sdhci-of-arasan: use modern PM macros
>   mmc: sdhci-of-at91: use modern PM macros
>   mmc: sdhci-of-esdhc: use modern PM macros
>   mmc: sdhci-omap: use modern PM macros
>   mmc: sdhci-cadence: use modern PM macros
>   mmc: sdhci-s3c: use modern PM macros
>   mmc: sdhci-spear: use modern PM macros
>   mmc: sdhci-sprd: use modern PM macros
>   mmc: sdhci-st: use modern PM macros
>   mmc: sdhci-tegra: use modern PM macros
>   mmc: sh_mmicf: use modern PM macros
>   mmc: toshsd: use modern PM macros
>   mmc: wmt-sdmmc: use modern PM macros
>   mmc: mtk-sd: use modern PM macros
>   mmc: sdhci-msm: use modern PM macros
>   mmc: via-sdmmc: use modern PM macros
>   mmc: dw_mmc: exynos: use modern PM macros
>   mmc: dw_mmc-k3: use modern PM macros
>   mmc: dw_mmc-pci: use modern PM macros
>   mmc: dw_mmc-rockchip: use modern PM macros
>
>  drivers/mmc/host/alcor.c            |  8 +++-----
>  drivers/mmc/host/atmel-mci.c        |  9 +++------
>  drivers/mmc/host/au1xmmc.c          | 18 +++++++-----------
>  drivers/mmc/host/cb710-mmc.c        | 19 +++++++++----------
>  drivers/mmc/host/davinci_mmc.c      | 14 +++-----------
>  drivers/mmc/host/dw_mmc-exynos.c    | 13 +++----------
>  drivers/mmc/host/dw_mmc-k3.c        |  9 +++------
>  drivers/mmc/host/dw_mmc-pci.c       |  9 +++------
>  drivers/mmc/host/dw_mmc-rockchip.c  |  9 +++------
>  drivers/mmc/host/dw_mmc.h           |  3 +++
>  drivers/mmc/host/mmci.c             |  9 +++------
>  drivers/mmc/host/mtk-sd.c           | 14 +++++++-------
>  drivers/mmc/host/mxs-mmc.c          |  6 ++----
>  drivers/mmc/host/omap_hsmmc.c       | 13 ++++---------
>  drivers/mmc/host/rtsx_usb_sdmmc.c   |  7 ++-----
>  drivers/mmc/host/sdhci-acpi.c       | 18 ++++--------------
>  drivers/mmc/host/sdhci-brcmstb.c    |  8 ++------
>  drivers/mmc/host/sdhci-cadence.c    |  8 ++------
>  drivers/mmc/host/sdhci-esdhc-imx.c  | 13 +++----------
>  drivers/mmc/host/sdhci-msm.c        | 21 +++++++++------------
>  drivers/mmc/host/sdhci-of-arasan.c  |  8 +++-----
>  drivers/mmc/host/sdhci-of-at91.c    | 12 +++---------
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++----------
>  drivers/mmc/host/sdhci-of-esdhc.c   |  8 ++------
>  drivers/mmc/host/sdhci-omap.c       | 18 +++++++-----------
>  drivers/mmc/host/sdhci-pxav3.c      | 11 +++--------
>  drivers/mmc/host/sdhci-s3c.c        | 11 +++--------
>  drivers/mmc/host/sdhci-spear.c      |  6 ++----
>  drivers/mmc/host/sdhci-sprd.c       | 10 +++-------
>  drivers/mmc/host/sdhci-st.c         |  6 ++----
>  drivers/mmc/host/sdhci-tegra.c      | 13 +++++--------
>  drivers/mmc/host/sdhci-xenon.c      | 13 +++----------
>  drivers/mmc/host/sdhci.h            |  7 +++++++
>  drivers/mmc/host/sdhci_am654.c      | 10 +++-------
>  drivers/mmc/host/sh_mmcif.c         |  8 ++------
>  drivers/mmc/host/sunxi-mmc.c        | 11 +++--------
>  drivers/mmc/host/toshsd.c           |  8 ++------
>  drivers/mmc/host/via-sdmmc.c        | 10 +++++-----
>  drivers/mmc/host/wmt-sdmmc.c        | 16 ++--------------
>  39 files changed, 141 insertions(+), 286 deletions(-)
>
> --
> 2.50.0
>

The series applied for next, thanks!

Kind regards
Uffe
