Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA42580F8
	for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950708; cv=none; b=K5APl0QHJgxAqbBzrjwCBGtG/Ear5nLC1w1ERQnwPmW8bpXOuwpIvlH4yWs0MySX0jL0brLUeyCF2dQx2iRuJP8Yu826vAXDv4e1FpveaOaqBMJYMLerMVYF/F19shFUKxn+XKtkd0XoJMX8QnSTmvm9XL/Ns/G+WjUDhc3sN2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950708; c=relaxed/simple;
	bh=3Jr8JCDGmQS9FfLr4zOyEhOE0u699dOLZcXvcIGuHrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5+3R2hthoJ+03nPJ3JN8W1jPfd3JBeOi8rfkf92cMSOVpbbic3yDlGvBUGfv6KXgURoSB1zwvFRGMusiAiuESwXjX+ETPVWnruOs4sn6k0kDJ3ITS5nB8Fot3Zr9xA0DX6bGJ7iRIXaiDPnm3dMFpJvtcHFZwS6ILJRZtAyk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=po7bvnC1; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="po7bvnC1"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7d5f3e6169so2147727276.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 May 2025 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747950706; x=1748555506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UkivWT9Ld0hlb/HoHmyUxnID8s5NMTaxDEbnKxBUkT8=;
        b=po7bvnC1BCqVT7HYoz3k0+eJcUJG3M+JT2UkK2wuFSjDan2dU2cF9U3LaKCILpw16x
         Sd1409abfHBUfmh/Ev0kVTiaSURl3EiEppW2+mNoJOl8tvvVlJwUwCeeaTmtypsefSc3
         KWQU9/l52pOi2zjbQaCkXJDnqRbQEF5hKXTRWPeVoaiPcYRR6zlynmS3V6ns/AjsnIqs
         9pGymEBlRU/JezZEGEDs+EDkg9vb+KawmIYd3lp0aGZCnfBiKsk8dZaUX5xsJRTd3s2I
         gLJFs51ek/9AdS5n6723qVEfAANB1jBV10xjoG3rHqoFXq1MxEMcNYGln9fa1zJ+RdPz
         XA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747950706; x=1748555506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkivWT9Ld0hlb/HoHmyUxnID8s5NMTaxDEbnKxBUkT8=;
        b=ggDGAowjtDsgSTbk0Gg1qklQI6ti2CwHC7P5whdo48l61hGi8Xgmmr9OrKw76EtfT8
         5nCSu3svabz0hvHzyKynyWdkKv0xwERdO1rICchkZeoSD58dDVJJeZz9Vof5WzlFScZ6
         Q4BZRtgP+d46dl6JQdE0ZgCNB3rOUJQr/DQP6Ly6MP2VANKoNJjwqy63ENqk7DjFsHcD
         FOO7/4VUAuvGsoyq5VFfbewioANKfVphRQ9ux5Oqn75a/JevA+60q0cV3fbj7P72idlu
         I6EmOucoEi+6bud0Sr0kYqpZ/DYBCQVgliqWwwnL9Zi63+hkywk/Bk3lv7mSStY1tdxN
         ZlOg==
X-Forwarded-Encrypted: i=1; AJvYcCUVeRQ7tn+9VUDNm4KaFr+IE6RZln+mw+umNAbzwfAc0UGzZYNujxM2zyXxVZV5y1wqOJVRr81/orA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbEIHqPV36bAqYVS8dzxTyXisiAsIk/faaSO2iO5EGOKpGGpL
	VFtxeg+RtpFRMK71IPVvoVoYChvXTGcmJYmyhNAZAV56rLKlYhyphlcYR0Yy2a3VVLl0nAbBl2o
	zQeSfbY0dYYqiHDLp4wOtJN06vAaJoBwGJFrtSY1i6w==
X-Gm-Gg: ASbGncuIhYAQuE0R0GRryDsFCEsS8iDa0nYL7vMsVUzQJPiwqmoQQLCWF0DyeYB4Qyg
	zpUN0oZv+Ao3Jb3FPOwfUz+sItJ5TYE/QGPTzvBDQKt5QycwUytzjYps82UY1DNrwMYfMAeEKrO
	ScBMz5wbGS9vBHJSTg8GY//QdEZSI91Go4lw==
X-Google-Smtp-Source: AGHT+IH2xXFagCE/0IE3Twz63B5i1nk3b7l5hoA9PYsj2uyFxF/p6O2XRceGL4taA/CquAgM7ZubTgValGrP28se0EU=
X-Received: by 2002:a05:6902:2303:b0:e7b:82cf:e78c with SMTP id
 3f1490d57ef6-e7b82cff28bmr34621554276.27.1747950705690; Thu, 22 May 2025
 14:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747877175.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1747877175.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 May 2025 23:50:59 +0200
X-Gm-Features: AX0GCFssYF5UzQiwy8RemVCQnlGLV1HdmUiY49H9UOnQrCuEjyVegYCbalWfLu4
Message-ID: <CAPDyKFoan-z5A0b6OkR3=u6cEMt4BCedpYKZB-55Xnz-61v1Nw@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] mmc: Cleanup mmc_alloc_host() usage
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 08:59, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> First of all, I'm very sorry for the compilation failure issue due to my
> cheap mistake in v1 patchset.
>
> The patch series was tested by using lkp and cross compiling with different
> architectures (arm/mips/x86_64 etc architectures) and enabling COMPILE_TEST=y
> to ensure that each driver was compiled and tested.

No worries, it was my mistake too trying to rush this in for v6.16. I
have dropped the series from my next branch for now.

Assuming that Linus doesn't create another rc for v6.15 on Monday,
this will have to wait until after the merge window, thus for v6.17.

Kind regards
Uffe

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
>  drivers/mmc/host/omap_hsmmc.c        | 18 ++++--------
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
>  39 files changed, 195 insertions(+), 442 deletions(-)
>
>
> base-commit: 61bd8e76021e779f7ba3c761919b533fb3f6f584
> --
> 2.47.1
>
