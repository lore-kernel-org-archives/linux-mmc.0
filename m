Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868031AE0AC
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896501; cv=none; b=Jr3VXxhLa5J9uOEq1YIrd96KDR3u1zUKrvZKrNS5M0pFMwXjyAm+7/QmDtw5udbFTOlwVr74ZDtVFwWFXZfLppa4r7/FplZPf9NpF1wYZZ7MstZ/e8sKUhNGKM4xYwE9jSmwCFvgCzKwrAPGpWEcNyKym6MnM+1ANzzVkkzjKEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896501; c=relaxed/simple;
	bh=lz3BOHPbrV9ue2IQ/GjEc7GK+aOqkc6HCQO4gNYk5xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6tHfon0aOGKKSllwjklxrlxUd6JgOGSkmBSlgid6CQQpGMsl6KuQG94BFEZGMcQF9tXY7qzBEJGJ3OJei5G+keFINeMYYoYbX8x9kzpiHWEndJn8bYBC+bmJxsBdWgOVjPLJAYNaF8GY1vZK1gy4MHyforjczmJ+xidlMxycOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLrfSJwk; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLrfSJwk"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df481bf6680so958353276.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896498; x=1719501298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9guc84Gchla6fWBOTCy+Mf9QLNavuevhtReJrUxDmLY=;
        b=XLrfSJwkdg+puXlRQOcaraTiVymhfdyXMnZq11jSIleLrKpqTojHmtjdPlu6LuOhyx
         3wWl0c4BWTb9OM0g+GqMvRXVTsXCTNwT8HpM222f4t13h4Ev/icUUR5jfynrDJs/6z1g
         nZpDFGyoVaZrvEW20MnTv0Gj5CtJIf7OSLy8MX3Vlid6pw35EoWqgpDCGLVFLgzLU/c9
         TF80SqsDxBrY13ut3MUzncJbDnGabppr7P82COFr8l4mYEQUu/c1Fucpm/NabLZeCvbC
         3PbSlQvB0Kgdl/QxBFBrCg/QfrzFoOJj6Zz8tJR9lOnCs/72HuUe7JPRwbbQ8jpfHn8J
         gfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896498; x=1719501298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9guc84Gchla6fWBOTCy+Mf9QLNavuevhtReJrUxDmLY=;
        b=rSO9c82WGEbLNqgATQmW/N7I4nQgC4WT2/ySycuG6Zj182e2YIDp/jgs6FTsCMf0ay
         FT1uCw1FJS3LVoIx5zpQss22ehOxMqTUZJKZo3kxuqxvBGnE6675bfZYKR4joharxVVg
         eI/S92Xp6Js4305n1mYEalZq4me+W26srEKc2UDMRHjpKWsP71pqqeXMrKDv8PskN77g
         u870acPOyEGr1P7Jbob9o1ebMHuHR/gC+ID1FzYECgbcfuicBjgXJCBsD+9BDh0pFyfr
         cQoCtx8mdXGKljztXL0k1yU6PyQGwb59dnCZKJIB7GNF/fwGTm0rBR626lMGZFefR4Bq
         31RA==
X-Forwarded-Encrypted: i=1; AJvYcCUIUd2DBlZOoBeTCEPPLaYITxyhODWmyLoGd7uvAZyC5Snnqh+kMNIZ+d7C806VhFYjqhpI6FsFE0X31C6LA9NeLXc2uwtSzRKW
X-Gm-Message-State: AOJu0YyMyb/2Rx08rwPpBBWusa6lSaPZCMYmg9nNo0ZOyfKm2NLpPCdT
	QNqQAEmt0tP3Urbr2dIHfPBwrJj6ot6Zxrh2Lz2fef4IIoZ7pTwXrLne4E9FjZdtktPC39vU6L2
	rFsEASCqAK1bQzQ+zgGurxpUf6GvlIrkWkHW8nA==
X-Google-Smtp-Source: AGHT+IH6LIN/vpcDotvk+Oh6j6vDVI1v3GEU01qU7DJ8PJNlH9KlHTY/JAb+18RbHiWT8y0dyadEsog30/o2UAJ03Zo=
X-Received: by 2002:a25:824a:0:b0:e02:b65d:6e11 with SMTP id
 3f1490d57ef6-e02be13b4c8mr6144708276.5.1718896498312; Thu, 20 Jun 2024
 08:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611-md-drivers-mmc-v2-1-2ef2cbcdc061@quicinc.com>
In-Reply-To: <20240611-md-drivers-mmc-v2-1-2ef2cbcdc061@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 17:14:22 +0200
Message-ID: <CAPDyKFqniea558arz-9tJm26Rx_KyOROtpwShq6MHUXsww=ptg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 17:50, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/of_mmc_spi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/tmio_mmc_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/renesas_sdhi_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/mmc_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_simple.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_sd8787.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_emmc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/sdio_uart.o
>
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for TMIO and SDHI
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> ---
> Changes in v2:
> - Updated descriptions in core/pwrseq_emmc.c, core/pwrseq_simple.c, and
>   host/renesas_sdhi_core.c per guidance from Dragan.
> - Link to v1: https://lore.kernel.org/r/20240610-md-drivers-mmc-v1-1-c2a2593e4121@quicinc.com
> ---
>  drivers/mmc/core/core.c              | 1 +
>  drivers/mmc/core/pwrseq_emmc.c       | 1 +
>  drivers/mmc/core/pwrseq_sd8787.c     | 1 +
>  drivers/mmc/core/pwrseq_simple.c     | 1 +
>  drivers/mmc/core/sdio_uart.c         | 1 +
>  drivers/mmc/host/of_mmc_spi.c        | 1 +
>  drivers/mmc/host/renesas_sdhi_core.c | 1 +
>  drivers/mmc/host/tmio_mmc_core.c     | 1 +
>  8 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a8c17b4cd737..d6c819dd68ed 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2362,4 +2362,5 @@ static void __exit mmc_exit(void)
>  subsys_initcall(mmc_init);
>  module_exit(mmc_exit);
>
> +MODULE_DESCRIPTION("MMC core driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index 3b6d69cefb4e..96fa4c508900 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -115,4 +115,5 @@ static struct platform_driver mmc_pwrseq_emmc_driver = {
>  };
>
>  module_platform_driver(mmc_pwrseq_emmc_driver);
> +MODULE_DESCRIPTION("Hardware reset support for eMMC");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
> index 0c5808fc3206..f24bbd68e251 100644
> --- a/drivers/mmc/core/pwrseq_sd8787.c
> +++ b/drivers/mmc/core/pwrseq_sd8787.c
> @@ -130,4 +130,5 @@ static struct platform_driver mmc_pwrseq_sd8787_driver = {
>  };
>
>  module_platform_driver(mmc_pwrseq_sd8787_driver);
> +MODULE_DESCRIPTION("Power sequence support for Marvell SD8787 BT + Wifi chip");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index df9588503ad0..154a8921ae75 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -159,4 +159,5 @@ static struct platform_driver mmc_pwrseq_simple_driver = {
>  };
>
>  module_platform_driver(mmc_pwrseq_simple_driver);
> +MODULE_DESCRIPTION("Simple power sequence management for MMC");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 575ebbce378e..6b7471dba3bf 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -1162,4 +1162,5 @@ module_init(sdio_uart_init);
>  module_exit(sdio_uart_exit);
>
>  MODULE_AUTHOR("Nicolas Pitre");
> +MODULE_DESCRIPTION("SDIO UART/GPS driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index bf54776fb26c..05939f30a5ae 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -19,6 +19,7 @@
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/host.h>
>
> +MODULE_DESCRIPTION("OpenFirmware bindings for the MMC-over-SPI driver");
>  MODULE_LICENSE("GPL");
>
>  struct of_mmc_spi {
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 12f4faaaf4ee..58536626e6c5 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1162,4 +1162,5 @@ void renesas_sdhi_remove(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
>
> +MODULE_DESCRIPTION("Renesas SDHI core driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 93e912afd3ae..c1a4ade5f949 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1319,4 +1319,5 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
>  #endif
>
> +MODULE_DESCRIPTION("TMIO MMC core driver");
>  MODULE_LICENSE("GPL v2");
>
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-md-drivers-mmc-cb5f273b5b33
>
