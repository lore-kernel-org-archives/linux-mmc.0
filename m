Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC6224254
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332027; cv=none; b=PeGfDKcndM3SZzgf8IjpyyIqr+1SFpMkMkB78E4zRMCld1McjHGUs3cmxjvvzn9MVItZq8UrociFotRXoLxipTSerI4GhAxOTJSON9NlNBZi/zlpoUJ1RVTz4xPyf+sh2m8y4b242/w0qzUnvZDvBZ2DYRCBIQ7go0tkdXJSZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332027; c=relaxed/simple;
	bh=FXi+WJFW6Bobw2TGfYECgvzHUdtyEQiafbcUsvYvnjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sxOelvpO6gSj9p2oW//e3JZNGnyOHP1iaainFs40UgAN7D6pVlfX95ye/zV8+eSxbGOQBxz7j1ecLT0TPstPU2zhrQAaWA15/iswkJis72qduFWwjusYVU2bdtPuTYKSvJxY9Z9hiZIQJ3RnKbVkcpawGIpGLa6/8VrTqjmpJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oR7R4NCr; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oR7R4NCr"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso594226276.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332024; x=1750936824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=467MwhcOj3OTm9X3gDenyOsQFlDrz8h86HfbcY3/KmA=;
        b=oR7R4NCrIYuabvrpdUEw9FIOn8shh/WFbUtWUdB01X2kDgZXW7qdn2luSPxox/SMHa
         dHXmo2Rc8EvWpL1Wwldy/4FBGflJD+byNBkRQwVhrcFwe89IA2o4zTVOsKyOPfcHxamm
         +wjpQedF019rJTFwscTMbAtMYn1IweTVh6CK4GTKSSPIQcDQ2zGH13qW5Fs/WSCyo4bM
         oyha5dvMRRutGM0B8wW8StORP0lGR4IcBMJJTbTIzmiyckNIpYzfuC/89a7KybnYkRMd
         8v0OVfSXd7sx8DMuXfk98+dJRV10nRO11YunwLRgoRXa1Yj15c5XfvG0YpRww0qeDweU
         /Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332024; x=1750936824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=467MwhcOj3OTm9X3gDenyOsQFlDrz8h86HfbcY3/KmA=;
        b=nZ0xDoCa5YkboNDVDpSi/aCF6yzvIpGLEN6rNmD9kUA3os6SAWEV9Qywl65IdzGixF
         4QfcfCDAH+rgInxI01guEi2cfXQMaFxenyD3C/1owFwGkuvX+4YngxB8jTeTCNe9glxT
         qCN9e0jNrUzTVnsxgAd4S8LqXgNK2xMGN7ihiTHwjiUZWjSuTjYKiZFiPUAx5hRF3HFN
         ylqlE4LMWstLLRhKorg8C4HuTpEncAMA1obEO+VzZ1DeZhKIKpxGvVcoqfk4sAnA8z0r
         6QKRtPRkXT6PRnboQUxY0JB3P4EKF7FJNsS3Gq5VAijmSBMH0fTFO9TcqbSS1nGp1AE6
         HO0w==
X-Forwarded-Encrypted: i=1; AJvYcCUCpxGOzFiJrK1ZafyHWiHHq2tuIU+tpxp3bDQJ/KqZ0Aeo5Zo2pZ3sr3Qbj5+eXtz0hONnk+yIcSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP/6gh9VZqDc0mpY33F+46/4VYWiyzyGrIm3gEMYIeUk8whrEx
	MfwWjICk3QqH0XrwpFiOA8HtH0yvyKCiXr55yF9z5roE6E1r8Ve+qDdDHhKVT6SNMRXqwB2RbeF
	hZEVfqmiFXbILgO1q055cYTCe2ncZENo0eJltaDYyHw==
X-Gm-Gg: ASbGnct7ZeqFeUt8xlEStMDX4HcoZsojVOW0ifhSejzh0bYEvsKWPsVbfl7RUFDf9EG
	0CwzTVn895Qxh2r2pIOTlcTFwawLb6NRw2OfovT6c8VQwNqAWqgpcWx/At1sA3dwx5XfOfEtge0
	EGm/NmXBZLcgQvMCTJiTZ/tIZMdFZe+pUpMDRH8+a1MZt7
X-Google-Smtp-Source: AGHT+IHRXIFy/zQgQr+M/cZ9NbXzt8mygDIY1SH+YXKHF+bDlhEZcmMrRNyxfeACY5rdl3i5+Zn53uVgaTwardN428c=
X-Received: by 2002:a05:6902:1102:b0:e82:4ba:9488 with SMTP id
 3f1490d57ef6-e822ac2e7ecmr24672214276.1.1750332024251; Thu, 19 Jun 2025
 04:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748933789.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1748933789.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:19:47 +0200
X-Gm-Features: AX0GCFvJ7lveyQFDsHZcc2Ek0exFBVdLvd9_cvBpRWnOaFe3wPbYGeACI1AkpjM
Message-ID: <CAPDyKFpiQ7aAgHM8-QTDOgu2oBajg9vL-+RKw0VMqUPrMf6Qag@mail.gmail.com>
Subject: Re: [PATCH v3 00/36] mmc: Cleanup mmc_alloc_host() usage
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 14:25, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> Since the devm_mmc_alloc_host() helper was already available, I tried to
> start cleaning up the use of mmc_alloc_host().
>
> To make it easier to review the patchset, I decided to split it into two parts.
> As the first part, this patchset contains cleanup for drivers other than sdhci.
>
> Of course, the sdhci part I have ready in my repository.
>
> Thanks.
>
> -----
> V3:
> - Collect Reviewed-by and Acked-by tags.
> Patch-18
>   - Fix build warning by lkp:
>         https://lore.kernel.org/all/202505230421.P12fqPfB-lkp@intel.com/
>
> Link to V2:
> https://lore.kernel.org/all/cover.1747877175.git.zhoubinbin@loongson.cn/
>
> V2:
> - Collect Reviewed-by and Acked-by tags.
> Patch-24
>   - Correct subject title: ish_mmicf -> sh_mmicf.
> Patch-34
>   - Fix cheap build error.
>
> Link to V1:
> https://lore.kernel.org/all/cover.1747739323.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (36):
>   mmc: alcor: Use devm_mmc_alloc_host() helper
>   mmc: atmel: Use devm_mmc_alloc_host() helper
>   mmc: au1xmmc: Use devm_mmc_alloc_host() helper
>   mmc: bcm2835: Use devm_mmc_alloc_host() helper
>   mmc: cavium: Use devm_mmc_alloc_host() helper
>   mmc: cb710: Use devm_mmc_alloc_host() helper
>   mmc: davinci_mmc: Use devm_mmc_alloc_host() helper
>   mmc: dw_mmc: Use devm_mmc_alloc_host() helper
>   mmc: jz4740: Use devm_mmc_alloc_host() helper
>   mmc: litex_mmc: Use devm_mmc_alloc_host() helper
>   mmc: meson-mx-sdhc: Use devm_mmc_alloc_host() helper
>   mmc: mmci: Use devm_mmc_alloc_host() helper
>   mmc: moxart-mmc: Use devm_mmc_alloc_host() helper
>   mmc: mvsdio: Use devm_mmc_alloc_host() helper
>   mmc: mxcmmc: Use devm_mmc_alloc_host() helper
>   mmc: mxs-mmc: Use devm_mmc_alloc_host() helper
>   mmc: omap: Use devm_mmc_alloc_host() helper
>   mmc: omap_hsmmc: Use devm_mmc_alloc_host() helper
>   mmc: owl-mmc: Use devm_mmc_alloc_host() helper
>   mmc: pxamci: Use devm_mmc_alloc_host() helper
>   mmc: rtsx_pci: Use devm_mmc_alloc_host() helper
>   mmc: rtsx_usb_sdmmc: Use devm_mmc_alloc_host() helper
>   mmc: sdricoh_cs: Use devm_mmc_alloc_host() helper
>   mmc: sh_mmicf: Use devm_mmc_alloc_host() helper
>   mmc: tifm_sd: Use devm_mmc_alloc_host() helper
>   mmc: toshsd: Use devm_mmc_alloc_host() helper
>   mmc: usdhi6ro10: Use devm_mmc_alloc_host() helper
>   mmc: ushc: Use devm_mmc_alloc_host() helper
>   mmc: via-sdmmc: Use devm_mmc_alloc_host() helper
>   mmc: vub300: Use devm_mmc_alloc_host() helper
>   mmc: wbsd: Use devm_mmc_alloc_host() helper
>   mmc: wmt-sdmmc: Use devm_mmc_alloc_host() helper
>   mmc: tmio: Use devm_mmc_alloc_host() helper
>   mmc: sunxi: Use devm_mmc_alloc_host() helper
>   mmc: mmc_spi: Use devm_mmc_alloc_host() helper
>   mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
>
>  drivers/mmc/host/alcor.c             | 20 ++++---------
>  drivers/mmc/host/atmel-mci.c         |  7 ++---
>  drivers/mmc/host/au1xmmc.c           | 14 +++-------
>  drivers/mmc/host/bcm2835.c           |  5 +---
>  drivers/mmc/host/cavium.c            | 10 ++-----
>  drivers/mmc/host/cb710-mmc.c         |  5 +---
>  drivers/mmc/host/davinci_mmc.c       | 22 +++++----------
>  drivers/mmc/host/dw_mmc.c            | 15 ++++------
>  drivers/mmc/host/jz4740_mmc.c        | 40 +++++++++-----------------
>  drivers/mmc/host/litex_mmc.c         | 12 +-------
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 13 +--------
>  drivers/mmc/host/meson-mx-sdio.c     | 20 ++++++-------
>  drivers/mmc/host/mmc_spi.c           |  4 +--
>  drivers/mmc/host/mmci.c              | 31 ++++++++------------
>  drivers/mmc/host/moxart-mmc.c        | 40 ++++++++++----------------
>  drivers/mmc/host/mvsdio.c            | 24 +++++-----------
>  drivers/mmc/host/mxcmmc.c            | 31 +++++++-------------
>  drivers/mmc/host/mxs-mmc.c           | 31 ++++++++------------
>  drivers/mmc/host/omap.c              | 25 ++++++-----------
>  drivers/mmc/host/omap_hsmmc.c        | 17 ++++-------
>  drivers/mmc/host/owl-mmc.c           | 37 +++++++++---------------
>  drivers/mmc/host/pxamci.c            | 42 ++++++++++------------------
>  drivers/mmc/host/renesas_sdhi_core.c |  6 +---
>  drivers/mmc/host/rtsx_pci_sdmmc.c    |  5 +---
>  drivers/mmc/host/rtsx_usb_sdmmc.c    |  4 +--
>  drivers/mmc/host/sdricoh_cs.c        | 10 ++-----
>  drivers/mmc/host/sh_mmcif.c          | 17 ++++-------
>  drivers/mmc/host/sunxi-mmc.c         | 22 ++++++---------
>  drivers/mmc/host/tifm_sd.c           |  7 +----
>  drivers/mmc/host/tmio_mmc.h          |  1 -
>  drivers/mmc/host/tmio_mmc_core.c     | 18 ++----------
>  drivers/mmc/host/toshsd.c            |  4 +--
>  drivers/mmc/host/uniphier-sd.c       |  8 ++----
>  drivers/mmc/host/usdhi6rol0.c        | 30 +++++++-------------
>  drivers/mmc/host/ushc.c              |  4 +--
>  drivers/mmc/host/via-sdmmc.c         |  7 ++---
>  drivers/mmc/host/vub300.c            | 16 ++++-------
>  drivers/mmc/host/wbsd.c              |  4 +--
>  drivers/mmc/host/wmt-sdmmc.c         |  8 ++----
>  39 files changed, 195 insertions(+), 441 deletions(-)
>
>

It seems like you didn't conclude around the discussion with Martin
around patch36, hence I am deferring that a bit.

That said, patch 1->35 applied for next, thanks!

Kind regards
Uffe
