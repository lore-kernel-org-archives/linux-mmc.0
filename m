Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69DCC001B0
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 20:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbjHHUbl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjHHUbV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 16:31:21 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84544F58
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:46:07 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56ced49d51aso22301eaf.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513163; x=1692117963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=ApJ2WAUD4XAwk5NFWf0n9JN43OKCDDCCvBvAkSpvprb3HsaG9kn/5nMO61QSU/jOXm
         vgXDJrHZdMzGBL6NFZ7eJoL3k5MNo7IlGNbt5iYyvcTE0ezoeNVQ+lvUUy5EHoRGiatK
         F+1b878qHcRbFkuiQkIVkg2mrPRSYWCnfPgvXuim/6yyxKZDVDfp2j6kHnVrECOtEJb5
         vinZ4RTet6FJ16M2yaZkcTDsOfwPAUrBtvZ8rOHtoncoRuI0GyO5hV/9QqkQrHtvp3a1
         ZOtN78hZgK9WlNtTgwCC5lPvzHawwQvf47ltirvjb1FMUmGdotGz6ae/N0hdM3eVxkL9
         pD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513163; x=1692117963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb4epZ0hVQjvrS5RqNy38MOhVst2cqtQlkC7YBmZyjc=;
        b=ao/FJz4c0ty0/UnbZf6VQJn9LZ2lHVD5SJFKiUMY14Gaq0s3MrkSzeVAQl3qBkirXt
         IVuzmcsWJK9nib9UcfgE2msXCb2rJZFrvngoA1C5BmqO3mYTbJwCPK8zyPRJ9dJk/2+2
         BKXU2R3phRT7txXf4LLLkmZkukfpvUdkUAzSIt6VXbDEIJ81LyAzOHPfPfq39MbYSsZ6
         tb9U15LumLA5ZWElREu0GH7LS2xr2ee/bPrSRk0QHTfRfu9RsJ+2ITokBa/49rl9iUGU
         Gb+iV+v0PUDLpx6qCXRzPkO71mbeUG8tyL34xVgcKfh89Ab6gE7DSyVzqP55mA428LoO
         NgfQ==
X-Gm-Message-State: AOJu0Yx89IfH4rqK4+G+gZJ1c2iATjptYbJFMTNt9oB6pk/bUvcPryty
        l8Dcs5/1ALzz//VCngTw9sQoEuLp4kSc2H1NRPoItoj8oUxvSumK
X-Google-Smtp-Source: AGHT+IF66ZIg71BsvfIXpCtaWYgCcZU8SNpF3fi8QtXBlp/Ozl2bOkN0RcX0VeXVj4YAJiEXbN2H1G1ZyCw5KxmnN8o=
X-Received: by 2002:a25:aa21:0:b0:d15:3761:3513 with SMTP id
 s30-20020a25aa21000000b00d1537613513mr9704045ybi.19.1691486159218; Tue, 08
 Aug 2023 02:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230801173544.1929519-1-hch@lst.de> <20230801173544.1929519-3-hch@lst.de>
In-Reply-To: <20230801173544.1929519-3-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:15:23 +0200
Message-ID: <CAPDyKForXd2GFVmXXM8hsnAYSQcKhp84t1aOunppUY+MFe0qag@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: au1xmmc: force non-modular build and remove
 symbol_get usage
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Aug 2023 at 19:36, Christoph Hellwig <hch@lst.de> wrote:
>
> au1xmmc is split somewhat awkwardly into the main mmc subsystem driver,
> and callbacks in platform_data that sit under arch/mips/ and are
> always built in.  The latter than call mmc_detect_change through
> symbol_get.  Remove the use of symbol_get by requiring the driver
> to be built in.  In the future the interrupt handlers for card
> insert/eject detection should probably be moved into the main driver,
> and which point it can be built modular again.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

If not too late, feel free to add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  arch/mips/alchemy/devboards/db1000.c |  8 +-------
>  arch/mips/alchemy/devboards/db1200.c | 19 ++-----------------
>  arch/mips/alchemy/devboards/db1300.c | 10 +---------
>  drivers/mmc/host/Kconfig             |  4 ++--
>  4 files changed, 6 insertions(+), 35 deletions(-)
>
> diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
> index 79d66faa84828d..012da042d0a4f7 100644
> --- a/arch/mips/alchemy/devboards/db1000.c
> +++ b/arch/mips/alchemy/devboards/db1000.c
> @@ -14,7 +14,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/leds.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/spi/spi.h>
> @@ -167,12 +166,7 @@ static struct platform_device db1x00_audio_dev = {
>
>  static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(500));
> -       symbol_put(mmc_detect_change);
> -
> +       mmc_detect_change(ptr, msecs_to_jiffies(500));
>         return IRQ_HANDLED;
>  }
>
> diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
> index 1864eb935ca57f..76080c71a2a7b6 100644
> --- a/arch/mips/alchemy/devboards/db1200.c
> +++ b/arch/mips/alchemy/devboards/db1200.c
> @@ -10,7 +10,6 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> -#include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/leds.h>
> @@ -340,14 +339,7 @@ static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1200_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1200_SD0_INSERT_INT)
> @@ -431,14 +423,7 @@ static irqreturn_t pb1200_mmc1_cd(int irq, void *ptr)
>
>  static irqreturn_t pb1200_mmc1_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       if (mmc_cd) {
> -               mmc_cd(ptr, msecs_to_jiffies(200));
> -               symbol_put(mmc_detect_change);
> -       }
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == PB1200_SD1_INSERT_INT)
> diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
> index e70e529ddd914d..ff61901329c626 100644
> --- a/arch/mips/alchemy/devboards/db1300.c
> +++ b/arch/mips/alchemy/devboards/db1300.c
> @@ -17,7 +17,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/ata_platform.h>
>  #include <linux/mmc/host.h>
> -#include <linux/module.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/platnand.h>
>  #include <linux/platform_device.h>
> @@ -459,14 +458,7 @@ static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
>
>  static irqreturn_t db1300_mmc_cdfn(int irq, void *ptr)
>  {
> -       void (*mmc_cd)(struct mmc_host *, unsigned long);
> -
> -       /* link against CONFIG_MMC=m.  We can only be called once MMC core has
> -        * initialized the controller, so symbol_get() should always succeed.
> -        */
> -       mmc_cd = symbol_get(mmc_detect_change);
> -       mmc_cd(ptr, msecs_to_jiffies(200));
> -       symbol_put(mmc_detect_change);
> +       mmc_detect_change(ptr, msecs_to_jiffies(200));
>
>         msleep(100);    /* debounce */
>         if (irq == DB1300_SD1_INSERT_INT)
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 159a3e9490aed8..f7afd179dd10bf 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -526,11 +526,11 @@ config MMC_ALCOR
>           of Alcor Micro PCI-E card reader
>
>  config MMC_AU1X
> -       tristate "Alchemy AU1XX0 MMC Card Interface support"
> +       bool "Alchemy AU1XX0 MMC Card Interface support"
>         depends on MIPS_ALCHEMY
>         help
>           This selects the AMD Alchemy(R) Multimedia card interface.
> -         If you have a Alchemy platform with a MMC slot, say Y or M here.
> +         If you have a Alchemy platform with a MMC slot, say Y here.
>
>           If unsure, say N.
>
> --
> 2.39.2
>
