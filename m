Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17114C53210
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Jan 2023 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjAEPCO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Jan 2023 10:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjAEPCK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2023 10:02:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61944D70C
        for <linux-mmc@vger.kernel.org>; Thu,  5 Jan 2023 07:02:08 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z4-20020a17090a170400b00226d331390cso1169026pjd.5
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jan 2023 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Woholkq4tbWZOCvL5MlgF6N+F+liG0Lx4w+ScCVbbIE=;
        b=JECYtY7R70n+T3jxQEnqPzICsy0aX1nXmy2pfCicKpY46UUasuZfg+BPJvlqTH6BGq
         YFJktz/FERYRxxr56I6tIPdElSvRzKYIhxJvY5O0ebqxNq2gNBp2ywRCX20FZq6E2Cq3
         rl35odF4mskjzkLUkAobQRko3XhWyN9la0DVtl3lQRZTkhAe63mRuUUzGjX+lPM4HUeI
         i5RImEJIOVg5xii8Tg+QGxm3c+4JlPVGsMC6BGwxQ/dJwEOufamN4WSFvc022Xaqt8y7
         92SgRYv6aNZLSE42kd2rpSmMHE0IOC5xqLPXc1255JeyG5PZY3tQtXi8BmHmYN+m31fZ
         2guA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Woholkq4tbWZOCvL5MlgF6N+F+liG0Lx4w+ScCVbbIE=;
        b=r7Iww+U0cw/CL1Kuf5F30KfwjN8Gm1lt3i0RCVJfnfQ2qlVcPseRcktCSZjvu2ifwv
         xO8+sKbDg8fBB+1BBqnWp9Ib+6wY5Ctan4hXVvFTFVZTZgnQj4kzCgf39JO9OEOIjrP2
         oYENdBGrK8f6IoYsjA8GPLI9ptS96OeD427chSdkRPUZMyDg3tW6jSENr5Gqy8e7H0D8
         A8jwz2VdlAjNpWDP31vAZTcICzrpl6XnTP/u6eRPVh41Q6HfIkA3phL4NpP2II/VfXKZ
         3YrpScOE0OLjwnEB2g9tZYhn0ej2U+iqOH4KP+j0yWSyQPwAxWoIQeXSMr9BaHt5eVDo
         JqXg==
X-Gm-Message-State: AFqh2kpjR3/9NTdUS89SMwrr/geL+OAefOw7njC2rc6Hw6qnN1FfPmT8
        Uq4gC1wepS7JO2IVM6/feeluD521UqHOEmFMDwJ9IQ==
X-Google-Smtp-Source: AMrXdXsSuoJY57l9ZlEQV1F0I5f0cCXSdjGeaPBKURvWWyh75lyJSyq7EXTCiPZGjgKztlHHX0kkV/YFtsZD7ZE52TE=
X-Received: by 2002:a17:90a:c083:b0:226:6c53:fc27 with SMTP id
 o3-20020a17090ac08300b002266c53fc27mr1171333pjs.202.1672930928112; Thu, 05
 Jan 2023 07:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20230105134622.254560-1-arnd@kernel.org> <20230105134622.254560-22-arnd@kernel.org>
In-Reply-To: <20230105134622.254560-22-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jan 2023 16:01:31 +0100
Message-ID: <CAPDyKFoNrtZSDm2Ry+7_74uGLqz8KpbtEC0Z6WNxv7G9JruKtA@mail.gmail.com>
Subject: Re: [PATCH 21/27] mmc: remove tmio_mmc driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Ian Molton <spyro@f2s.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Jan 2023 at 14:47, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> With the TMIO MFD support gone, the corresponding MMC host driver can
> be removed as well. The remaining tmio_mmc_core module however is still
> used by both the Renesas and Socionext host drivers.
>
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I intend to pick this up via my mmc tree, just awaiting an ack from Wolfram.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig    |   8 --
>  drivers/mmc/host/Makefile   |   1 -
>  drivers/mmc/host/tmio_mmc.c | 227 ------------------------------------
>  3 files changed, 236 deletions(-)
>  delete mode 100644 drivers/mmc/host/tmio_mmc.c
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f0456ad4b597..e1b88b51cc80 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -655,14 +655,6 @@ config MMC_SDHCI_SPRD
>  config MMC_TMIO_CORE
>         tristate
>
> -config MMC_TMIO
> -       tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
> -       depends on MFD_TMIO || MFD_ASIC3 || COMPILE_TEST
> -       select MMC_TMIO_CORE
> -       help
> -         This provides support for the SD/MMC cell found in TC6393XB,
> -         T7L66XB and also HTC ASIC3
> -
>  config MMC_SDHI
>         tristate "Renesas SDHI SD/SDIO controller support"
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 063d87764966..b498c17cd124 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -35,7 +35,6 @@ obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
>  obj-$(CONFIG_MMC_SPI)          += mmc_spi.o
>  obj-$(CONFIG_MMC_SPI)          += of_mmc_spi.o
>  obj-$(CONFIG_MMC_SDRICOH_CS)   += sdricoh_cs.o
> -obj-$(CONFIG_MMC_TMIO)         += tmio_mmc.o
>  obj-$(CONFIG_MMC_TMIO_CORE)    += tmio_mmc_core.o
>  obj-$(CONFIG_MMC_SDHI)         += renesas_sdhi_core.o
>  obj-$(CONFIG_MMC_SDHI_SYS_DMAC)                += renesas_sdhi_sys_dmac.o
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> deleted file mode 100644
> index 53a2ad9a24b8..000000000000
> --
> 2.39.0
>
