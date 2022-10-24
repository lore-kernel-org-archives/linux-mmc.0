Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15881C67871
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 19:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJXToX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiJXTnO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 15:43:14 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFB9357DF
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 11:11:59 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id x16so3078318ilm.5
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qmRRnyqrCvwVZ4E+oJVYPxgBWe3Nt02//jegX+ZgfXw=;
        b=kdHeBtjq4ZnpqOIg+37lgXyiiaV3XXQxNaZGixyhH4yGbriDik/YMamv1PIALwJB3S
         PIhDMnY/vm/pkGypr1P6W3mkZZj/2eaXU6mzGOoZcdl15PA9lATbTdansjVERGg0m6er
         TtwGBd743y163YzlUIa8+YRjEtr6k89CN001APSknZuojX58QHVySFt9nd7/w+vnOv9f
         9MUTXHe9sVFD7VrygaScnu1jgprdX2Aqdui4C5n0KQ+bWEAFClJIABGxkMxysD581Jg/
         YVGY7Nfdl3L+cCNFnRl2ww+khw7cJYfuDEfYxVJxuXDmnJj8xurh9sOI6++yZTCfq+pa
         VTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmRRnyqrCvwVZ4E+oJVYPxgBWe3Nt02//jegX+ZgfXw=;
        b=aQldW1f6ZE/3ARzy+jOHk6sqxFANlLnYrvYP7dkI/KtkswXaTNkg2w3u7YaMFL6179
         /hL0IiGSkUTKOh9XiUx7RFv+E9mD7ogjUR29Oar4vxm/1VPUlMUucoRwCArSj2kcSfXq
         4e4TnoJvN8QrLZgQdp3m3wZm7F21nNRCEBjINtZ7pwSR38mAdF2Qq0vOTY3F+A6f7CEu
         p65JjcGB8+Y4oMe0gC1Flwo8x2Qh1gNzKMpghrUyH9HA2i9A5ade7C8ya97Wqb4wFSPT
         TKFLullDB2l3Z9A5dfS6Bp7CUclClc+X9Jr/Hjb1ovYBVzSi+GqlsESS28Z0qQJhpJN6
         7A1Q==
X-Gm-Message-State: ACrzQf2xPu1wleXHq+G2+z6KZ8qkdWGvSUFBmsdoJMu5CAZtkAcmvItP
        w4d9Y9xJYX2orTz/Uhvu1kgC1Tl5KvOJlb2deYsB/zXoEc0=
X-Google-Smtp-Source: AMsMyM6z4NWUjsrgFdg2kbiI+O6qCein5eD6LUCQUgk6TnK5ysp32+5l+WsLYktaQ1Vb3USEOGT8E2HIVczRn7CUhKw=
X-Received: by 2002:a63:464d:0:b0:441:5968:cd0e with SMTP id
 v13-20020a63464d000000b004415968cd0emr29972204pgk.595.1666630413870; Mon, 24
 Oct 2022 09:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221021202254.4142411-1-arnd@kernel.org> <20221021203329.4143397-10-arnd@kernel.org>
In-Reply-To: <20221021203329.4143397-10-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Oct 2022 18:52:55 +0200
Message-ID: <CAPDyKFpUzDD7X0GhP4ahqF=AyCGCMfSXjPW0qZ5vUnJMc=iT6Q@mail.gmail.com>
Subject: Re: [PATCH 10/21] mmc: remove s3cmci driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 Oct 2022 at 22:45, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The s3c24xx platform is gone, so this driver can be removed as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  MAINTAINERS                              |    6 -
>  drivers/mmc/host/Kconfig                 |   43 -
>  drivers/mmc/host/Makefile                |    1 -
>  drivers/mmc/host/s3cmci.c                | 1777 ----------------------
>  drivers/mmc/host/s3cmci.h                |   75 -
>  include/linux/platform_data/mmc-s3cmci.h |   51 -
>  6 files changed, 1953 deletions(-)
>  delete mode 100644 drivers/mmc/host/s3cmci.c
>  delete mode 100644 drivers/mmc/host/s3cmci.h
>  delete mode 100644 include/linux/platform_data/mmc-s3cmci.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2caf42b0328a..503ebd9800db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17920,12 +17920,6 @@ S:     Supported
>  W:     http://www.ibm.com/developerworks/linux/linux390/
>  F:     drivers/s390/scsi/zfcp_*
>
> -S3C24XX SD/MMC Driver
> -M:     Ben Dooks <ben-linux@fluff.org>
> -L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:     Supported
> -F:     drivers/mmc/host/s3cmci.*
> -
>  SAA6588 RDS RECEIVER DRIVER
>  M:     Hans Verkuil <hverkuil@xs4all.nl>
>  L:     linux-media@vger.kernel.org
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 79d8ddf1f616..75e8c364243d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -619,49 +619,6 @@ config MMC_SPI
>
>           If unsure, or if your system has no SPI master driver, say N.
>
> -config MMC_S3C
> -       tristate "Samsung S3C SD/MMC Card Interface support"
> -       depends on ARCH_S3C24XX || COMPILE_TEST
> -       depends on S3C24XX_DMAC || COMPILE_TEST
> -       help
> -         This selects a driver for the MCI interface found in
> -         Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
> -         If you have a board based on one of those and a MMC/SD
> -         slot, say Y or M here.
> -
> -         If unsure, say N.
> -
> -config MMC_S3C_HW_SDIO_IRQ
> -       bool "Hardware support for SDIO IRQ"
> -       depends on MMC_S3C
> -       help
> -         Enable the hardware support for SDIO interrupts instead of using
> -         the generic polling code.
> -
> -choice
> -       prompt "Samsung S3C SD/MMC transfer code"
> -       depends on MMC_S3C
> -
> -config MMC_S3C_PIO
> -       bool "Use PIO transfers only"
> -       help
> -         Use PIO to transfer data between memory and the hardware.
> -
> -         PIO is slower than DMA as it requires CPU instructions to
> -         move the data. This has been the traditional default for
> -         the S3C MCI driver.
> -
> -config MMC_S3C_DMA
> -       bool "Use DMA transfers only"
> -       help
> -         Use DMA to transfer data between memory and the hardware.
> -
> -         Currently, the DMA support in this driver seems to not be
> -         working properly and needs to be debugged before this
> -         option is useful.
> -
> -endchoice
> -
>  config MMC_SDRICOH_CS
>         tristate "MMC/SD driver for Ricoh Bay1Controllers"
>         depends on PCI && PCMCIA
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 0baeb0b004f7..885e19e21e75 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -34,7 +34,6 @@ obj-$(CONFIG_MMC_MVSDIO)      += mvsdio.o
>  obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
>  obj-$(CONFIG_MMC_SPI)          += mmc_spi.o
>  obj-$(CONFIG_MMC_SPI)          += of_mmc_spi.o
> -obj-$(CONFIG_MMC_S3C)          += s3cmci.o
>  obj-$(CONFIG_MMC_SDRICOH_CS)   += sdricoh_cs.o
>  obj-$(CONFIG_MMC_TMIO_CORE)    += tmio_mmc_core.o
>  obj-$(CONFIG_MMC_SDHI)         += renesas_sdhi_core.o
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> deleted file mode 100644
> index 8d5929a32d34..000000000000
> diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
> deleted file mode 100644
> index 8b65d7ad9f97..000000000000
> diff --git a/include/linux/platform_data/mmc-s3cmci.h b/include/linux/platform_data/mmc-s3cmci.h
> deleted file mode 100644
> index bacb86db3112..000000000000
> --
> 2.29.2
>
