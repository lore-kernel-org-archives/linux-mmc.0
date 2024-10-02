Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F21C3F17
	for <linux-mmc@vger.kernel.org>; Wed,  2 Oct 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912222; cv=none; b=KUzwEbo5VYU+ImxBhJKZe4L4uXOO9qSa6iwI3YOyi7SWAoDXjBcaqz3ftr5QqpOhvwFAB6e2+Zh4yAwSQDBxAb7wXaraHXYgXD0tV72Qn9LZ1qk8AJDdcXQAnIuab2dhl6rrHbtozTOiDc+PsoODDOfg0VY+bLeBvN6V7zTKS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912222; c=relaxed/simple;
	bh=VTW9eXa6BJLHOgOG+c0CuP9p1IflIalKUGbv398u2QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMYn1WmzgcXppaOHlyBQAXY+P54DCpmAUsnW55X8PKzmnOYPsLwrftVqNkYY/BB2IL3bVtHCtkCYtvcNdMQ5PecWoUwGk9gfChyyWxCyPcnx9UjEQL37ywuscbJXl7ab+ne72QYeTsN3oko74zdCvx1gKAU+3+QLGCK/dL6z+oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oTM1QoxT; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTM1QoxT"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25ccdffcc5so343526276.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 Oct 2024 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912219; x=1728517019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4Fxljz2kQ/Pp/P9SaHyglLXXQ24iUp9GzJneiiThZ0=;
        b=oTM1QoxTzdat3VuV11KrhmIpO2K+Hx2rjtfwq/Yxk3cTfCQjIubpEnLtpbC4FcMDRo
         oOCS4I0XkKSKc6zyqSuzEInEhYzZ+vkLWE/PWyng//pzIhOTxfhJaaoGtzeVElz4/VUZ
         e80tRUnXg00wfP8zuufvUMb1w8KD0MH4pruZYq8Dn4HgN08/7I8dpJTpWqd2NFf07TZZ
         VHmQZ7nDn0ftw7DMB+wntsGe8NzN4O4eozGPoUf3UHnf98ot9OwpzY2/ZU5o6RXrzFwQ
         sv5ywdFhlKOyS1DFSV4OZv25Ec9bWz4xoqTlfLt8MOQFGtVdpmoVZ0u7A1EWwk4bTivZ
         Aq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912219; x=1728517019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4Fxljz2kQ/Pp/P9SaHyglLXXQ24iUp9GzJneiiThZ0=;
        b=TNJ8Pu7oP9SYC12se0e5iJlhJA74OWH6+N2LCWDiL3lie6FoExdPz5Ap5qnWV8Opas
         3UA1+RY9ykpRsOUvUNdzLJPMUwHsQwWDdIwUSKeeKAF8mIzuPw77OhgCF06BdkuHO7HS
         G0exbv9wThVl4E8dbvRl0g2mQ/kWDdBQr1ZViI2iEA4xOpS/AQ5PQfuMuUIrSTGwE+5B
         Ja1gEEmEgLujdO3sCD/ujqvyObiPJuRegJ1n982pUV7d34NGH4ah/GzePzPQrZWtnQ3z
         RoJCExrrl83GdJTqjNWAtVbUaBD1sTqcL51ymWd+Cti5BpnZij7Zer+pXKaFzkGn++AC
         brMA==
X-Gm-Message-State: AOJu0Yw2iyqnS0bCjcqBOC6r187lWJlRI17YgQAgiPyljWOX9+eyEXEi
	CFdaJpQ8kJ5LL449KLVTnljixWiYPae5hNuaupO4Ya03HL2obcaktmgtFEeBpSww8p6O6mRKbOa
	YNp317GfZoeqYzKRdagWmpaYBs6NLt4cNTosABQ==
X-Google-Smtp-Source: AGHT+IF00YCjrWvS7R5PqLB9SWw2DPTAIBYGt6uM4AaQUiMvauLkVCBFfqf26kgjuGLp9yv/rjNzAkDy9RH1d7lc1yk=
X-Received: by 2002:a05:6902:2289:b0:e22:63c4:8b7f with SMTP id
 3f1490d57ef6-e2638414aa5mr4385652276.41.1727912218206; Wed, 02 Oct 2024
 16:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927145832.754697-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20240927145832.754697-2-u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:22 +0200
Message-ID: <CAPDyKFoX5tEuGJYC=O_R4HHeegQnwoG8GLkrcLy8QbU6eUrVug@mail.gmail.com>
Subject: Re: [PATCH] mmc: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Sept 2024 at 16:58, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/mmc to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Hello,
>
> I did a single patch for all of drivers/mmc. While I usually prefer to
> do one logical change per patch, this seems to be overengineering here
> as the individual changes are really trivial and shouldn't be much in
> the way for stable backports. But I'll happily split the patch if you
> prefer it split.
>
> Note I didn't Cc: the maintainers of each driver as this would hit
> sending limits.
>
> This is based on today's next, if conflicts arise when you apply it at
> some later time and don't want to resolve them, feel free to just drop
> the changes to the conflicting files. I'll notice and followup at a
> later time then. Or ask me for a fixed resend.
>
> Best regards
> Uwe
>
>  drivers/mmc/core/pwrseq_emmc.c                | 2 +-
>  drivers/mmc/core/pwrseq_sd8787.c              | 2 +-
>  drivers/mmc/core/pwrseq_simple.c              | 2 +-
>  drivers/mmc/host/alcor.c                      | 2 +-
>  drivers/mmc/host/atmel-mci.c                  | 2 +-
>  drivers/mmc/host/au1xmmc.c                    | 2 +-
>  drivers/mmc/host/bcm2835.c                    | 2 +-
>  drivers/mmc/host/cavium-octeon.c              | 2 +-
>  drivers/mmc/host/cb710-mmc.c                  | 2 +-
>  drivers/mmc/host/davinci_mmc.c                | 2 +-
>  drivers/mmc/host/dw_mmc-bluefield.c           | 2 +-
>  drivers/mmc/host/dw_mmc-exynos.c              | 2 +-
>  drivers/mmc/host/dw_mmc-hi3798cv200.c         | 2 +-
>  drivers/mmc/host/dw_mmc-hi3798mv200.c         | 2 +-
>  drivers/mmc/host/dw_mmc-k3.c                  | 2 +-
>  drivers/mmc/host/dw_mmc-pltfm.c               | 2 +-
>  drivers/mmc/host/dw_mmc-rockchip.c            | 2 +-
>  drivers/mmc/host/dw_mmc-starfive.c            | 2 +-
>  drivers/mmc/host/jz4740_mmc.c                 | 2 +-
>  drivers/mmc/host/litex_mmc.c                  | 2 +-
>  drivers/mmc/host/meson-gx-mmc.c               | 2 +-
>  drivers/mmc/host/meson-mx-sdhc-mmc.c          | 2 +-
>  drivers/mmc/host/meson-mx-sdio.c              | 2 +-
>  drivers/mmc/host/moxart-mmc.c                 | 2 +-
>  drivers/mmc/host/mtk-sd.c                     | 2 +-
>  drivers/mmc/host/mvsdio.c                     | 2 +-
>  drivers/mmc/host/mxcmmc.c                     | 2 +-
>  drivers/mmc/host/mxs-mmc.c                    | 2 +-
>  drivers/mmc/host/omap.c                       | 2 +-
>  drivers/mmc/host/omap_hsmmc.c                 | 2 +-
>  drivers/mmc/host/owl-mmc.c                    | 2 +-
>  drivers/mmc/host/pxamci.c                     | 2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 +-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 2 +-
>  drivers/mmc/host/rtsx_pci_sdmmc.c             | 2 +-
>  drivers/mmc/host/rtsx_usb_sdmmc.c             | 2 +-
>  drivers/mmc/host/sdhci-acpi.c                 | 2 +-
>  drivers/mmc/host/sdhci-bcm-kona.c             | 2 +-
>  drivers/mmc/host/sdhci-brcmstb.c              | 2 +-
>  drivers/mmc/host/sdhci-cadence.c              | 2 +-
>  drivers/mmc/host/sdhci-dove.c                 | 2 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c            | 2 +-
>  drivers/mmc/host/sdhci-esdhc-mcf.c            | 2 +-
>  drivers/mmc/host/sdhci-iproc.c                | 2 +-
>  drivers/mmc/host/sdhci-milbeaut.c             | 2 +-
>  drivers/mmc/host/sdhci-msm.c                  | 2 +-
>  drivers/mmc/host/sdhci-npcm.c                 | 2 +-
>  drivers/mmc/host/sdhci-of-arasan.c            | 2 +-
>  drivers/mmc/host/sdhci-of-aspeed.c            | 4 ++--
>  drivers/mmc/host/sdhci-of-at91.c              | 2 +-
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c             | 2 +-
>  drivers/mmc/host/sdhci-of-hlwd.c              | 2 +-
>  drivers/mmc/host/sdhci-of-ma35d1.c            | 2 +-
>  drivers/mmc/host/sdhci-of-sparx5.c            | 2 +-
>  drivers/mmc/host/sdhci-omap.c                 | 2 +-
>  drivers/mmc/host/sdhci-pic32.c                | 2 +-
>  drivers/mmc/host/sdhci-pxav2.c                | 2 +-
>  drivers/mmc/host/sdhci-pxav3.c                | 2 +-
>  drivers/mmc/host/sdhci-s3c.c                  | 2 +-
>  drivers/mmc/host/sdhci-spear.c                | 2 +-
>  drivers/mmc/host/sdhci-sprd.c                 | 2 +-
>  drivers/mmc/host/sdhci-st.c                   | 2 +-
>  drivers/mmc/host/sdhci-tegra.c                | 2 +-
>  drivers/mmc/host/sdhci-xenon.c                | 2 +-
>  drivers/mmc/host/sdhci_am654.c                | 2 +-
>  drivers/mmc/host/sdhci_f_sdh30.c              | 2 +-
>  drivers/mmc/host/sh_mmcif.c                   | 2 +-
>  drivers/mmc/host/sunplus-mmc.c                | 2 +-
>  drivers/mmc/host/sunxi-mmc.c                  | 2 +-
>  drivers/mmc/host/uniphier-sd.c                | 2 +-
>  drivers/mmc/host/usdhi6rol0.c                 | 2 +-
>  drivers/mmc/host/wbsd.c                       | 2 +-
>  drivers/mmc/host/wmt-sdmmc.c                  | 2 +-
>  74 files changed, 75 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emm=
c.c
> index 96fa4c508900..35af67e26945 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -107,7 +107,7 @@ MODULE_DEVICE_TABLE(of, mmc_pwrseq_emmc_of_match);
>
>  static struct platform_driver mmc_pwrseq_emmc_driver =3D {
>         .probe =3D mmc_pwrseq_emmc_probe,
> -       .remove_new =3D mmc_pwrseq_emmc_remove,
> +       .remove =3D mmc_pwrseq_emmc_remove,
>         .driver =3D {
>                 .name =3D "pwrseq_emmc",
>                 .of_match_table =3D mmc_pwrseq_emmc_of_match,
> diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_s=
d8787.c
> index f24bbd68e251..30282155a0e1 100644
> --- a/drivers/mmc/core/pwrseq_sd8787.c
> +++ b/drivers/mmc/core/pwrseq_sd8787.c
> @@ -122,7 +122,7 @@ static void mmc_pwrseq_sd8787_remove(struct platform_=
device *pdev)
>
>  static struct platform_driver mmc_pwrseq_sd8787_driver =3D {
>         .probe =3D mmc_pwrseq_sd8787_probe,
> -       .remove_new =3D mmc_pwrseq_sd8787_remove,
> +       .remove =3D mmc_pwrseq_sd8787_remove,
>         .driver =3D {
>                 .name =3D "pwrseq_sd8787",
>                 .of_match_table =3D mmc_pwrseq_sd8787_of_match,
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_s=
imple.c
> index 154a8921ae75..9e016b0746f5 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -151,7 +151,7 @@ static void mmc_pwrseq_simple_remove(struct platform_=
device *pdev)
>
>  static struct platform_driver mmc_pwrseq_simple_driver =3D {
>         .probe =3D mmc_pwrseq_simple_probe,
> -       .remove_new =3D mmc_pwrseq_simple_remove,
> +       .remove =3D mmc_pwrseq_simple_remove,
>         .driver =3D {
>                 .name =3D "pwrseq_simple",
>                 .of_match_table =3D mmc_pwrseq_simple_of_match,
> diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
> index 42aa43740ba8..b6b6dd677ae5 100644
> --- a/drivers/mmc/host/alcor.c
> +++ b/drivers/mmc/host/alcor.c
> @@ -1175,7 +1175,7 @@ MODULE_DEVICE_TABLE(platform, alcor_pci_sdmmc_ids);
>
>  static struct platform_driver alcor_pci_sdmmc_driver =3D {
>         .probe          =3D alcor_pci_sdmmc_drv_probe,
> -       .remove_new     =3D alcor_pci_sdmmc_drv_remove,
> +       .remove         =3D alcor_pci_sdmmc_drv_remove,
>         .id_table       =3D alcor_pci_sdmmc_ids,
>         .driver         =3D {
>                 .name   =3D DRV_NAME_ALCOR_PCI_SDMMC,
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 6490df54a6f5..3ed86fda147a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2653,7 +2653,7 @@ static const struct dev_pm_ops atmci_dev_pm_ops =3D=
 {
>
>  static struct platform_driver atmci_driver =3D {
>         .probe          =3D atmci_probe,
> -       .remove_new     =3D atmci_remove,
> +       .remove         =3D atmci_remove,
>         .driver         =3D {
>                 .name           =3D "atmel_mci",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index 6e80bcb668ec..27c666eab506 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -1185,7 +1185,7 @@ static int au1xmmc_resume(struct platform_device *p=
dev)
>
>  static struct platform_driver au1xmmc_driver =3D {
>         .probe         =3D au1xmmc_probe,
> -       .remove_new    =3D au1xmmc_remove,
> +       .remove        =3D au1xmmc_remove,
>         .suspend       =3D au1xmmc_suspend,
>         .resume        =3D au1xmmc_resume,
>         .driver        =3D {
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 35d8fdea668b..349f1c50b096 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1459,7 +1459,7 @@ MODULE_DEVICE_TABLE(of, bcm2835_match);
>
>  static struct platform_driver bcm2835_driver =3D {
>         .probe      =3D bcm2835_probe,
> -       .remove_new =3D bcm2835_remove,
> +       .remove     =3D bcm2835_remove,
>         .driver     =3D {
>                 .name           =3D "sdhost-bcm2835",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-o=
cteon.c
> index 060ec4f4800f..72817c5f4578 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -326,7 +326,7 @@ MODULE_DEVICE_TABLE(of, octeon_mmc_match);
>
>  static struct platform_driver octeon_mmc_driver =3D {
>         .probe          =3D octeon_mmc_probe,
> -       .remove_new     =3D octeon_mmc_remove,
> +       .remove         =3D octeon_mmc_remove,
>         .driver         =3D {
>                 .name   =3D KBUILD_MODNAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index 902f7f20abaa..d741c1f9cf87 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -771,7 +771,7 @@ static void cb710_mmc_exit(struct platform_device *pd=
ev)
>  static struct platform_driver cb710_mmc_driver =3D {
>         .driver.name =3D "cb710-mmc",
>         .probe =3D cb710_mmc_init,
> -       .remove_new =3D cb710_mmc_exit,
> +       .remove =3D cb710_mmc_exit,
>  #ifdef CONFIG_PM
>         .suspend =3D cb710_mmc_suspend,
>         .resume =3D cb710_mmc_resume,
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mm=
c.c
> index 9cbde800685d..7ed533758dbe 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1400,7 +1400,7 @@ static struct platform_driver davinci_mmcsd_driver =
=3D {
>                 .of_match_table =3D davinci_mmc_dt_ids,
>         },
>         .probe          =3D davinci_mmcsd_probe,
> -       .remove_new     =3D davinci_mmcsd_remove,
> +       .remove         =3D davinci_mmcsd_remove,
>         .id_table       =3D davinci_mmc_devtype,
>  };
>
> diff --git a/drivers/mmc/host/dw_mmc-bluefield.c b/drivers/mmc/host/dw_mm=
c-bluefield.c
> index 24e0b604b405..3cf526ab0387 100644
> --- a/drivers/mmc/host/dw_mmc-bluefield.c
> +++ b/drivers/mmc/host/dw_mmc-bluefield.c
> @@ -68,7 +68,7 @@ static int dw_mci_bluefield_probe(struct platform_devic=
e *pdev)
>
>  static struct platform_driver dw_mci_bluefield_pltfm_driver =3D {
>         .probe          =3D dw_mci_bluefield_probe,
> -       .remove_new     =3D dw_mci_pltfm_remove,
> +       .remove         =3D dw_mci_pltfm_remove,
>         .driver         =3D {
>                 .name           =3D "dwmmc_bluefield",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-e=
xynos.c
> index 6dc057718d2c..53d32d0f2709 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -682,7 +682,7 @@ static const struct dev_pm_ops dw_mci_exynos_pmops =
=3D {
>
>  static struct platform_driver dw_mci_exynos_pltfm_driver =3D {
>         .probe          =3D dw_mci_exynos_probe,
> -       .remove_new     =3D dw_mci_exynos_remove,
> +       .remove         =3D dw_mci_exynos_remove,
>         .driver         =3D {
>                 .name           =3D "dwmmc_exynos",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_=
mmc-hi3798cv200.c
> index 6099756e59b3..0ccfae1b2dbe 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -189,7 +189,7 @@ static const struct of_device_id dw_mci_hi3798cv200_m=
atch[] =3D {
>  MODULE_DEVICE_TABLE(of, dw_mci_hi3798cv200_match);
>  static struct platform_driver dw_mci_hi3798cv200_driver =3D {
>         .probe =3D dw_mci_hi3798cv200_probe,
> -       .remove_new =3D dw_mci_hi3798cv200_remove,
> +       .remove =3D dw_mci_hi3798cv200_remove,
>         .driver =3D {
>                 .name =3D "dwmmc_hi3798cv200",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_=
mmc-hi3798mv200.c
> index 96af693e3e37..cce174b5249b 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> @@ -237,7 +237,7 @@ static void dw_mci_hi3798mv200_remove(struct platform=
_device *pdev)
>  MODULE_DEVICE_TABLE(of, dw_mci_hi3798mv200_match);
>  static struct platform_driver dw_mci_hi3798mv200_driver =3D {
>         .probe =3D dw_mci_hi3798mv200_probe,
> -       .remove_new =3D dw_mci_hi3798mv200_remove,
> +       .remove =3D dw_mci_hi3798mv200_remove,
>         .driver =3D {
>                 .name =3D "dwmmc_hi3798mv200",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index e8ee7c43f60b..0311a37dd4ab 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -470,7 +470,7 @@ static const struct dev_pm_ops dw_mci_k3_dev_pm_ops =
=3D {
>
>  static struct platform_driver dw_mci_k3_pltfm_driver =3D {
>         .probe          =3D dw_mci_k3_probe,
> -       .remove_new     =3D dw_mci_pltfm_remove,
> +       .remove         =3D dw_mci_pltfm_remove,
>         .driver         =3D {
>                 .name           =3D "dwmmc_k3",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pl=
tfm.c
> index 2353fadceda1..de820ffd2133 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -131,7 +131,7 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
>
>  static struct platform_driver dw_mci_pltfm_driver =3D {
>         .probe          =3D dw_mci_pltfm_probe,
> -       .remove_new     =3D dw_mci_pltfm_remove,
> +       .remove         =3D dw_mci_pltfm_remove,
>         .driver         =3D {
>                 .name           =3D "dw_mmc",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc=
-rockchip.c
> index f96260fd143b..baa23b517731 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -577,7 +577,7 @@ static const struct dev_pm_ops dw_mci_rockchip_dev_pm=
_ops =3D {
>
>  static struct platform_driver dw_mci_rockchip_pltfm_driver =3D {
>         .probe          =3D dw_mci_rockchip_probe,
> -       .remove_new     =3D dw_mci_rockchip_remove,
> +       .remove         =3D dw_mci_rockchip_remove,
>         .driver         =3D {
>                 .name           =3D "dwmmc_rockchip",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc=
-starfive.c
> index b4d81ef0f3af..34964b0dab21 100644
> --- a/drivers/mmc/host/dw_mmc-starfive.c
> +++ b/drivers/mmc/host/dw_mmc-starfive.c
> @@ -115,7 +115,7 @@ static int dw_mci_starfive_probe(struct platform_devi=
ce *pdev)
>
>  static struct platform_driver dw_mci_starfive_driver =3D {
>         .probe =3D dw_mci_starfive_probe,
> -       .remove_new =3D dw_mci_pltfm_remove,
> +       .remove =3D dw_mci_pltfm_remove,
>         .driver =3D {
>                 .name =3D "dwmmc_starfive",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.=
c
> index 6a45991ca056..596012d5afac 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1191,7 +1191,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, =
jz4740_mmc_suspend,
>
>  static struct platform_driver jz4740_mmc_driver =3D {
>         .probe =3D jz4740_mmc_probe,
> -       .remove_new =3D jz4740_mmc_remove,
> +       .remove =3D jz4740_mmc_remove,
>         .driver =3D {
>                 .name =3D "jz4740-mmc",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> index 4ec8072dc60b..b338ccfa8f33 100644
> --- a/drivers/mmc/host/litex_mmc.c
> +++ b/drivers/mmc/host/litex_mmc.c
> @@ -644,7 +644,7 @@ MODULE_DEVICE_TABLE(of, litex_match);
>
>  static struct platform_driver litex_mmc_driver =3D {
>         .probe =3D litex_mmc_probe,
> -       .remove_new =3D litex_mmc_remove,
> +       .remove =3D litex_mmc_remove,
>         .driver =3D {
>                 .name =3D "litex-mmc",
>                 .of_match_table =3D litex_match,
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index c7c067b9415a..a9e7c8ddc5a1 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1334,7 +1334,7 @@ MODULE_DEVICE_TABLE(of, meson_mmc_of_match);
>
>  static struct platform_driver meson_mmc_driver =3D {
>         .probe          =3D meson_mmc_probe,
> -       .remove_new     =3D meson_mmc_remove,
> +       .remove         =3D meson_mmc_remove,
>         .driver         =3D {
>                 .name =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meso=
n-mx-sdhc-mmc.c
> index 31f750301dc1..b4e56ccffca2 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -904,7 +904,7 @@ MODULE_DEVICE_TABLE(of, meson_mx_sdhc_of_match);
>
>  static struct platform_driver meson_mx_sdhc_driver =3D {
>         .probe   =3D meson_mx_sdhc_probe,
> -       .remove_new =3D meson_mx_sdhc_remove,
> +       .remove =3D meson_mx_sdhc_remove,
>         .driver  =3D {
>                 .name =3D "meson-mx-sdhc",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx=
-sdio.c
> index a11577f2ee69..ad351805eed4 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -754,7 +754,7 @@ MODULE_DEVICE_TABLE(of, meson_mx_mmc_of_match);
>
>  static struct platform_driver meson_mx_mmc_driver =3D {
>         .probe   =3D meson_mx_mmc_probe,
> -       .remove_new =3D meson_mx_mmc_remove,
> +       .remove =3D meson_mx_mmc_remove,
>         .driver  =3D {
>                 .name =3D "meson-mx-sdio",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.=
c
> index 8ede4ce93271..a12048e5de63 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -719,7 +719,7 @@ MODULE_DEVICE_TABLE(of, moxart_mmc_match);
>
>  static struct platform_driver moxart_mmc_driver =3D {
>         .probe      =3D moxart_probe,
> -       .remove_new =3D moxart_remove,
> +       .remove =3D moxart_remove,
>         .driver     =3D {
>                 .name           =3D "mmc-moxart",
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 89018b6c97b9..1a0f6b04d863 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -3112,7 +3112,7 @@ static const struct dev_pm_ops msdc_dev_pm_ops =3D =
{
>
>  static struct platform_driver mt_msdc_driver =3D {
>         .probe =3D msdc_drv_probe,
> -       .remove_new =3D msdc_drv_remove,
> +       .remove =3D msdc_drv_remove,
>         .driver =3D {
>                 .name =3D "mtk-msdc",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index af7f21888e27..1024b3ebff00 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -854,7 +854,7 @@ MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
>
>  static struct platform_driver mvsd_driver =3D {
>         .probe          =3D mvsd_probe,
> -       .remove_new     =3D mvsd_remove,
> +       .remove         =3D mvsd_remove,
>         .driver         =3D {
>                 .name   =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 1edf65291354..e7a286c3216f 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1225,7 +1225,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(mxcmci_pm_ops, mxcm=
ci_suspend, mxcmci_resume);
>
>  static struct platform_driver mxcmci_driver =3D {
>         .probe          =3D mxcmci_probe,
> -       .remove_new     =3D mxcmci_remove,
> +       .remove         =3D mxcmci_remove,
>         .driver         =3D {
>                 .name           =3D DRIVER_NAME,
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 6751da9b60f9..80e6f48c83aa 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -714,7 +714,7 @@ static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_susp=
end, mxs_mmc_resume);
>
>  static struct platform_driver mxs_mmc_driver =3D {
>         .probe          =3D mxs_mmc_probe,
> -       .remove_new     =3D mxs_mmc_remove,
> +       .remove         =3D mxs_mmc_remove,
>         .driver         =3D {
>                 .name   =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 335350a4e99a..62252ad4e20d 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1554,7 +1554,7 @@ MODULE_DEVICE_TABLE(of, mmc_omap_match);
>
>  static struct platform_driver mmc_omap_driver =3D {
>         .probe          =3D mmc_omap_probe,
> -       .remove_new     =3D mmc_omap_remove,
> +       .remove         =3D mmc_omap_remove,
>         .driver         =3D {
>                 .name   =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.=
c
> index e120aeb869b8..59e36e0ebbbf 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2121,7 +2121,7 @@ static const struct dev_pm_ops omap_hsmmc_dev_pm_op=
s =3D {
>
>  static struct platform_driver omap_hsmmc_driver =3D {
>         .probe          =3D omap_hsmmc_probe,
> -       .remove_new     =3D omap_hsmmc_remove,
> +       .remove         =3D omap_hsmmc_remove,
>         .driver         =3D {
>                 .name =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index fc08f25c34eb..797ef48d9204 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -692,7 +692,7 @@ static struct platform_driver owl_mmc_driver =3D {
>                 .of_match_table =3D owl_mmc_of_match,
>         },
>         .probe          =3D owl_mmc_probe,
> -       .remove_new     =3D owl_mmc_remove,
> +       .remove         =3D owl_mmc_remove,
>  };
>  module_platform_driver(owl_mmc_driver);
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index fae3192c3a14..2d0ad006913d 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -810,7 +810,7 @@ static void pxamci_remove(struct platform_device *pde=
v)
>
>  static struct platform_driver pxamci_driver =3D {
>         .probe          =3D pxamci_probe,
> -       .remove_new     =3D pxamci_remove,
> +       .remove         =3D pxamci_remove,
>         .driver         =3D {
>                 .name   =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/=
host/renesas_sdhi_internal_dmac.c
> index 1dcaa050f264..4b389e92399e 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -613,7 +613,7 @@ static struct platform_driver renesas_internal_dmac_s=
dhi_driver =3D {
>                 .of_match_table =3D renesas_sdhi_internal_dmac_of_match,
>         },
>         .probe          =3D renesas_sdhi_internal_dmac_probe,
> -       .remove_new     =3D renesas_sdhi_remove,
> +       .remove         =3D renesas_sdhi_remove,
>  };
>
>  module_platform_driver(renesas_internal_dmac_sdhi_driver);
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/=
renesas_sdhi_sys_dmac.c
> index 0ba3f62a9b49..822a310c9bba 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -471,7 +471,7 @@ static struct platform_driver renesas_sys_dmac_sdhi_d=
river =3D {
>                 .of_match_table =3D renesas_sdhi_sys_dmac_of_match,
>         },
>         .probe          =3D renesas_sdhi_sys_dmac_probe,
> -       .remove_new     =3D renesas_sdhi_remove,
> +       .remove         =3D renesas_sdhi_remove,
>  };
>
>  module_platform_driver(renesas_sys_dmac_sdhi_driver);
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pc=
i_sdmmc.c
> index 7dfe7c4e0077..e99f2bca3717 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1591,7 +1591,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_pci_sdmmc_ids);
>
>  static struct platform_driver rtsx_pci_sdmmc_driver =3D {
>         .probe          =3D rtsx_pci_sdmmc_drv_probe,
> -       .remove_new     =3D rtsx_pci_sdmmc_drv_remove,
> +       .remove         =3D rtsx_pci_sdmmc_drv_remove,
>         .id_table       =3D rtsx_pci_sdmmc_ids,
>         .driver         =3D {
>                 .name   =3D DRV_NAME_RTSX_PCI_SDMMC,
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_us=
b_sdmmc.c
> index ded9b6849e35..17e16d643b22 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1453,7 +1453,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_usb_sdmmc_ids);
>
>  static struct platform_driver rtsx_usb_sdmmc_driver =3D {
>         .probe          =3D rtsx_usb_sdmmc_drv_probe,
> -       .remove_new     =3D rtsx_usb_sdmmc_drv_remove,
> +       .remove         =3D rtsx_usb_sdmmc_drv_remove,
>         .id_table       =3D rtsx_usb_sdmmc_ids,
>         .driver         =3D {
>                 .name   =3D "rtsx_usb_sdmmc",
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.=
c
> index eb8f427f9770..d1ce9193ece9 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -1080,7 +1080,7 @@ static struct platform_driver sdhci_acpi_driver =3D=
 {
>                 .pm                     =3D &sdhci_acpi_pm_ops,
>         },
>         .probe  =3D sdhci_acpi_probe,
> -       .remove_new =3D sdhci_acpi_remove,
> +       .remove =3D sdhci_acpi_remove,
>  };
>
>  module_platform_driver(sdhci_acpi_driver);
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-b=
cm-kona.c
> index e067c7f5c537..fda911fb28e5 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -328,7 +328,7 @@ static struct platform_driver sdhci_bcm_kona_driver =
=3D {
>                 .of_match_table =3D sdhci_bcm_kona_of_match,
>         },
>         .probe          =3D sdhci_bcm_kona_probe,
> -       .remove_new     =3D sdhci_bcm_kona_remove,
> +       .remove         =3D sdhci_bcm_kona_remove,
>  };
>  module_platform_driver(sdhci_bcm_kona_driver);
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-br=
cmstb.c
> index 031a4b514d16..0ef4d578ade8 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -545,7 +545,7 @@ static struct platform_driver sdhci_brcmstb_driver =
=3D {
>                 .of_match_table =3D of_match_ptr(sdhci_brcm_of_match),
>         },
>         .probe          =3D sdhci_brcmstb_probe,
> -       .remove_new     =3D sdhci_pltfm_remove,
> +       .remove         =3D sdhci_pltfm_remove,
>         .shutdown       =3D sdhci_brcmstb_shutdown,
>  };
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-ca=
dence.c
> index be1505e8c536..a94b297fcf2a 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -608,7 +608,7 @@ static struct platform_driver sdhci_cdns_driver =3D {
>                 .of_match_table =3D sdhci_cdns_match,
>         },
>         .probe =3D sdhci_cdns_probe,
> -       .remove_new =3D sdhci_pltfm_remove,
> +       .remove =3D sdhci_pltfm_remove,
>  };
>  module_platform_driver(sdhci_cdns_driver);
>
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.=
c
> index 88ec23417808..77034b13fa66 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -106,7 +106,7 @@ static struct platform_driver sdhci_dove_driver =3D {
>                 .of_match_table =3D sdhci_dove_of_match_table,
>         },
>         .probe          =3D sdhci_dove_probe,
> -       .remove_new     =3D sdhci_pltfm_remove,
> +       .remove         =3D sdhci_pltfm_remove,
>  };
>
>  module_platform_driver(sdhci_dove_driver);
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index 8f0bc6dca2b0..ba3a81c04e74 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2015,7 +2015,7 @@ static struct platform_driver sdhci_esdhc_imx_drive=
r =3D {
>                 .pm     =3D &sdhci_esdhc_pmops,
>         },
>         .probe          =3D sdhci_esdhc_imx_probe,
> -       .remove_new     =3D sdhci_esdhc_imx_remove,
> +       .remove         =3D sdhci_esdhc_imx_remove,
>  };
>
>  module_platform_driver(sdhci_esdhc_imx_driver);
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-=
esdhc-mcf.c
> index 3ad87322f6a5..327662ba5bd9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -512,7 +512,7 @@ static struct platform_driver sdhci_esdhc_mcf_driver =
=3D {
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>         },
>         .probe =3D sdhci_esdhc_mcf_probe,
> -       .remove_new =3D sdhci_esdhc_mcf_remove,
> +       .remove =3D sdhci_esdhc_mcf_remove,
>  };
>
>  module_platform_driver(sdhci_esdhc_mcf_driver);
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-ipro=
c.c
> index 10235fdff246..80b2567a488b 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -424,7 +424,7 @@ static struct platform_driver sdhci_iproc_driver =3D =
{
>                 .pm =3D &sdhci_pltfm_pmops,
>         },
>         .probe =3D sdhci_iproc_probe,
> -       .remove_new =3D sdhci_pltfm_remove,
> +       .remove =3D sdhci_pltfm_remove,
>         .shutdown =3D sdhci_iproc_shutdown,
>  };
>  module_platform_driver(sdhci_iproc_driver);
> diff --git a/drivers/mmc/host/sdhci-milbeaut.c b/drivers/mmc/host/sdhci-m=
ilbeaut.c
> index 83706edc9796..a4675456f9c7 100644
> --- a/drivers/mmc/host/sdhci-milbeaut.c
> +++ b/drivers/mmc/host/sdhci-milbeaut.c
> @@ -335,7 +335,7 @@ static struct platform_driver sdhci_milbeaut_driver =
=3D {
>                 .of_match_table =3D mlb_dt_ids,
>         },
>         .probe  =3D sdhci_milbeaut_probe,
> -       .remove_new =3D sdhci_milbeaut_remove,
> +       .remove =3D sdhci_milbeaut_remove,
>  };
>
>  module_platform_driver(sdhci_milbeaut_driver);
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e113b99a3eab..8dd180a42f72 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2753,7 +2753,7 @@ static const struct dev_pm_ops sdhci_msm_pm_ops =3D=
 {
>
>  static struct platform_driver sdhci_msm_driver =3D {
>         .probe =3D sdhci_msm_probe,
> -       .remove_new =3D sdhci_msm_remove,
> +       .remove =3D sdhci_msm_remove,
>         .driver =3D {
>                    .name =3D "sdhci_msm",
>                    .of_match_table =3D sdhci_msm_dt_match,
> diff --git a/drivers/mmc/host/sdhci-npcm.c b/drivers/mmc/host/sdhci-npcm.=
c
> index 5bf9d18f364e..bee0585ba5c1 100644
> --- a/drivers/mmc/host/sdhci-npcm.c
> +++ b/drivers/mmc/host/sdhci-npcm.c
> @@ -85,7 +85,7 @@ static struct platform_driver npcm_sdhci_driver =3D {
>                 .pm     =3D &sdhci_pltfm_pmops,
>         },
>         .probe          =3D npcm_sdhci_probe,
> -       .remove_new     =3D sdhci_pltfm_remove,
> +       .remove         =3D sdhci_pltfm_remove,
>  };
>  module_platform_driver(npcm_sdhci_driver);
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-=
of-arasan.c
> index 5edd024347bd..5eacc78e2620 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -2046,7 +2046,7 @@ static struct platform_driver sdhci_arasan_driver =
=3D {
>                 .pm =3D &sdhci_arasan_dev_pm_ops,
>         },
>         .probe =3D sdhci_arasan_probe,
> -       .remove_new =3D sdhci_arasan_remove,
> +       .remove =3D sdhci_arasan_remove,
>  };
>
>  module_platform_driver(sdhci_arasan_driver);
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-=
of-aspeed.c
> index 37240895ffaa..d6de010551b9 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -519,7 +519,7 @@ static struct platform_driver aspeed_sdhci_driver =3D=
 {
>                 .of_match_table =3D aspeed_sdhci_of_match,
>         },
>         .probe          =3D aspeed_sdhci_probe,
> -       .remove_new     =3D aspeed_sdhci_remove,
> +       .remove         =3D aspeed_sdhci_remove,
>  };
>
>  static int aspeed_sdc_probe(struct platform_device *pdev)
> @@ -596,7 +596,7 @@ static struct platform_driver aspeed_sdc_driver =3D {
>                 .of_match_table =3D aspeed_sdc_of_match,
>         },
>         .probe          =3D aspeed_sdc_probe,
> -       .remove_new     =3D aspeed_sdc_remove,
> +       .remove         =3D aspeed_sdc_remove,
>  };
>
>  #if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of=
-at91.c
> index 23a9faad2ff8..97988ed37467 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -471,7 +471,7 @@ static struct platform_driver sdhci_at91_driver =3D {
>                 .pm     =3D &sdhci_at91_dev_pm_ops,
>         },
>         .probe          =3D sdhci_at91_probe,
> -       .remove_new     =3D sdhci_at91_remove,
> +       .remove         =3D sdhci_at91_remove,
>  };
>
>  module_platform_driver(sdhci_at91_driver);
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index 8999b97263af..13f5fb3e3740 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1618,7 +1618,7 @@ static struct platform_driver sdhci_dwcmshc_driver =
=3D {
>                 .pm =3D &dwcmshc_pmops,
>         },
>         .probe  =3D dwcmshc_probe,
> -       .remove_new =3D dwcmshc_remove,
> +       .remove =3D dwcmshc_remove,
>  };
>  module_platform_driver(sdhci_dwcmshc_driver);
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-o=
f-esdhc.c
> index 3ae9aa25745a..002d0d59b992 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1521,7 +1521,7 @@ static struct platform_driver sdhci_esdhc_driver =
=3D {
>                 .pm =3D &esdhc_of_dev_pm_ops,
>         },
>         .probe =3D sdhci_esdhc_probe,
> -       .remove_new =3D sdhci_pltfm_remove,
> +       .remove =3D sdhci_pltfm_remove,
>  };
>
>  module_platform_driver(sdhci_esdhc_driver);
> diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of=
-hlwd.c
> index 9c1c0ce610ef..5bb845d13599 100644
> --- a/drivers/mmc/host/sdhci-of-hlwd.c
> +++ b/drivers/mmc/host/sdhci-of-hlwd.c
> @@ -85,7 +85,7 @@ static struct platform_driver sdhci_hlwd_driver =3D {
>                 .pm =3D &sdhci_pltfm_pmops,
>         },
>         .probe =3D sdhci_hlwd_probe,
> -       .remove_new =3D sdhci_pltfm_remove,
> +       .remove =3D sdhci_pltfm_remove,
>  };
>
>  module_platform_driver(sdhci_hlwd_driver);
> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-=
of-ma35d1.c
> index b84c2927bd4a..1e6d180100ad 100644
> --- a/drivers/mmc/host/sdhci-of-ma35d1.c
> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
> @@ -305,7 +305,7 @@ static struct platform_driver sdhci_ma35_driver =3D {
>                 .of_match_table =3D sdhci_ma35_dt_ids,
>         },
>         .probe  =3D ma35_probe,
> -       .remove_new =3D ma35_remove,
> +       .remove =3D ma35_remove,
>  };
>  module_platform_driver(sdhci_ma35_driver);
>
> diff --git a/drivers/mmc/host/sdhci-of-sparx5.c b/drivers/mmc/host/sdhci-=
of-sparx5.c
> index 64b77e7d14cd..d2aa684e786f 100644
> --- a/drivers/mmc/host/sdhci-of-sparx5.c
> +++ b/drivers/mmc/host/sdhci-of-sparx5.c
> @@ -255,7 +255,7 @@ static struct platform_driver sdhci_sparx5_driver =3D=
 {
>                 .pm =3D &sdhci_pltfm_pmops,
>         },
>         .probe =3D sdhci_sparx5_probe,
> -       .remove_new =3D sdhci_pltfm_remove,
> +       .remove =3D sdhci_pltfm_remove,
>  };
>
>  module_platform_driver(sdhci_sparx5_driver);
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.=
c
> index 5841a9afeb9f..54d795205fb4 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1478,7 +1478,7 @@ static const struct dev_pm_ops sdhci_omap_dev_pm_op=
s =3D {
>
>  static struct platform_driver sdhci_omap_driver =3D {
>         .probe =3D sdhci_omap_probe,
> -       .remove_new =3D sdhci_omap_remove,
> +       .remove =3D sdhci_omap_remove,
>         .driver =3D {
>                    .name =3D "sdhci-omap",
>                    .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic3=
2.c
> index 7a0351a9c74e..d6a299f49900 100644
> --- a/drivers/mmc/host/sdhci-pic32.c
> +++ b/drivers/mmc/host/sdhci-pic32.c
> @@ -236,7 +236,7 @@ static struct platform_driver pic32_sdhci_driver =3D =
{
>                 .of_match_table =3D of_match_ptr(pic32_sdhci_id_table),
>         },
>         .probe          =3D pic32_sdhci_probe,
> -       .remove_new     =3D pic32_sdhci_remove,
> +       .remove         =3D pic32_sdhci_remove,
>  };
>
>  module_platform_driver(pic32_sdhci_driver);
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav=
2.c
> index 7b957f6d5588..45b6f0891c47 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -351,7 +351,7 @@ static struct platform_driver sdhci_pxav2_driver =3D =
{
>                 .pm     =3D &sdhci_pltfm_pmops,
>         },
>         .probe          =3D sdhci_pxav2_probe,
> -       .remove_new     =3D sdhci_pltfm_remove,
> +       .remove         =3D sdhci_pltfm_remove,
>  };
>
>  module_platform_driver(sdhci_pxav2_driver);
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav=
3.c
> index 3af43ac05825..990723a008ae 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -568,7 +568,7 @@ static struct platform_driver sdhci_pxav3_driver =3D =
{
>                 .pm     =3D &sdhci_pxav3_pmops,
>         },
>         .probe          =3D sdhci_pxav3_probe,
> -       .remove_new     =3D sdhci_pxav3_remove,
> +       .remove         =3D sdhci_pxav3_remove,
>  };
>
>  module_platform_driver(sdhci_pxav3_driver);
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index a71d56c7031f..bdf4dc0d6b77 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -774,7 +774,7 @@ MODULE_DEVICE_TABLE(of, sdhci_s3c_dt_match);
>
>  static struct platform_driver sdhci_s3c_driver =3D {
>         .probe          =3D sdhci_s3c_probe,
> -       .remove_new     =3D sdhci_s3c_remove,
> +       .remove         =3D sdhci_s3c_remove,
>         .id_table       =3D sdhci_s3c_driver_ids,
>         .driver         =3D {
>                 .name   =3D "s3c-sdhci",
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spea=
r.c
> index c81bdfa97b89..770dc12b9ae9 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -182,7 +182,7 @@ static struct platform_driver sdhci_driver =3D {
>                 .of_match_table =3D sdhci_spear_id_table,
>         },
>         .probe          =3D sdhci_probe,
> -       .remove_new     =3D sdhci_remove,
> +       .remove         =3D sdhci_remove,
>  };
>
>  module_platform_driver(sdhci_driver);
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.=
c
> index 8776f4287119..db5e253b0f79 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -975,7 +975,7 @@ static const struct dev_pm_ops sdhci_sprd_pm_ops =3D =
{
>
>  static struct platform_driver sdhci_sprd_driver =3D {
>         .probe =3D sdhci_sprd_probe,
> -       .remove_new =3D sdhci_sprd_remove,
> +       .remove =3D sdhci_sprd_remove,
>         .driver =3D {
>                 .name =3D "sdhci_sprd_r11",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index d12532b96b51..4973e08a98f8 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -507,7 +507,7 @@ MODULE_DEVICE_TABLE(of, st_sdhci_match);
>
>  static struct platform_driver sdhci_st_driver =3D {
>         .probe =3D sdhci_st_probe,
> -       .remove_new =3D sdhci_st_remove,
> +       .remove =3D sdhci_st_remove,
>         .driver =3D {
>                    .name =3D "sdhci-st",
>                    .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 1ad0a6b3a2eb..4d402b601883 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1930,7 +1930,7 @@ static struct platform_driver sdhci_tegra_driver =
=3D {
>                 .pm     =3D &sdhci_tegra_dev_pm_ops,
>         },
>         .probe          =3D sdhci_tegra_probe,
> -       .remove_new     =3D sdhci_tegra_remove,
> +       .remove         =3D sdhci_tegra_remove,
>  };
>
>  module_platform_driver(sdhci_tegra_driver);
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xeno=
n.c
> index 0e52867f6e91..098f0ea45cbe 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -734,7 +734,7 @@ static struct platform_driver sdhci_xenon_driver =3D =
{
>                 .pm =3D &sdhci_xenon_dev_pm_ops,
>         },
>         .probe  =3D xenon_probe,
> -       .remove_new =3D xenon_remove,
> +       .remove =3D xenon_remove,
>  };
>
>  module_platform_driver(sdhci_xenon_driver);
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am65=
4.c
> index 0aa3c40ea6ed..f75c31815ab0 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -1100,7 +1100,7 @@ static struct platform_driver sdhci_am654_driver =
=3D {
>                 .of_match_table =3D sdhci_am654_of_match,
>         },
>         .probe =3D sdhci_am654_probe,
> -       .remove_new =3D sdhci_am654_remove,
> +       .remove =3D sdhci_am654_remove,
>  };
>
>  module_platform_driver(sdhci_am654_driver);
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_=
sdh30.c
> index c58e7cb1e2a7..ee66e4f3683d 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -247,7 +247,7 @@ static struct platform_driver sdhci_f_sdh30_driver =
=3D {
>                 .pm     =3D &sdhci_pltfm_pmops,
>         },
>         .probe =3D sdhci_f_sdh30_probe,
> -       .remove_new =3D sdhci_f_sdh30_remove,
> +       .remove =3D sdhci_f_sdh30_remove,
>  };
>
>  module_platform_driver(sdhci_f_sdh30_driver);
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 08b4312af94e..864e345a39f6 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -1596,7 +1596,7 @@ static const struct dev_pm_ops sh_mmcif_dev_pm_ops =
=3D {
>
>  static struct platform_driver sh_mmcif_driver =3D {
>         .probe          =3D sh_mmcif_probe,
> -       .remove_new     =3D sh_mmcif_remove,
> +       .remove         =3D sh_mmcif_remove,
>         .driver         =3D {
>                 .name   =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mm=
c.c
> index 13c7cc0b6180..1cddea615a27 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -982,7 +982,7 @@ MODULE_DEVICE_TABLE(of, spmmc_of_table);
>
>  static struct platform_driver spmmc_driver =3D {
>         .probe =3D spmmc_drv_probe,
> -       .remove_new =3D spmmc_drv_remove,
> +       .remove =3D spmmc_drv_remove,
>         .driver =3D {
>                 .name =3D "spmmc",
>                 .pm =3D pm_ptr(&spmmc_pm_ops),
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d3bd0ac99ec4..564f5fefe62a 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1554,7 +1554,7 @@ static struct platform_driver sunxi_mmc_driver =3D =
{
>                 .pm =3D &sunxi_mmc_pm_ops,
>         },
>         .probe          =3D sunxi_mmc_probe,
> -       .remove_new     =3D sunxi_mmc_remove,
> +       .remove         =3D sunxi_mmc_remove,
>  };
>  module_platform_driver(sunxi_mmc_driver);
>
> diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-s=
d.c
> index 46ee8a0b2b85..4ad02cfdc238 100644
> --- a/drivers/mmc/host/uniphier-sd.c
> +++ b/drivers/mmc/host/uniphier-sd.c
> @@ -754,7 +754,7 @@ MODULE_DEVICE_TABLE(of, uniphier_sd_match);
>
>  static struct platform_driver uniphier_sd_driver =3D {
>         .probe =3D uniphier_sd_probe,
> -       .remove_new =3D uniphier_sd_remove,
> +       .remove =3D uniphier_sd_remove,
>         .driver =3D {
>                 .name =3D "uniphier-sd",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.=
c
> index 6e421445d56c..49efb960a052 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1899,7 +1899,7 @@ static void usdhi6_remove(struct platform_device *p=
dev)
>
>  static struct platform_driver usdhi6_driver =3D {
>         .probe          =3D usdhi6_probe,
> -       .remove_new     =3D usdhi6_remove,
> +       .remove         =3D usdhi6_remove,
>         .driver         =3D {
>                 .name   =3D "usdhi6rol0",
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 6e20405d0430..8b268e8a0ec9 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1896,7 +1896,7 @@ static struct platform_device *wbsd_device;
>
>  static struct platform_driver wbsd_driver =3D {
>         .probe          =3D wbsd_probe,
> -       .remove_new     =3D wbsd_remove,
> +       .remove         =3D wbsd_remove,
>         .suspend        =3D wbsd_platform_suspend,
>         .resume         =3D wbsd_platform_resume,
>         .driver         =3D {
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 860380931b6c..cdb36a9f9e38 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -982,7 +982,7 @@ static const struct dev_pm_ops wmt_mci_pm =3D {
>
>  static struct platform_driver wmt_mci_driver =3D {
>         .probe =3D wmt_mci_probe,
> -       .remove_new =3D wmt_mci_remove,
> +       .remove =3D wmt_mci_remove,
>         .driver =3D {
>                 .name =3D DRIVER_NAME,
>                 .probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>
> base-commit: 40e0c9d414f57d450e3ad03c12765e797fc3fede
> --
> 2.45.2
>
