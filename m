Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B77AC433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 00:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A987123750
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 00:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbhAUAbO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:31:14 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:36281 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbhATVZ6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 16:25:58 -0500
Received: by mail-ej1-f48.google.com with SMTP id l9so29848874ejx.3;
        Wed, 20 Jan 2021 13:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Ssw+zjtZMLxcvdLjzPmT7CToAEOi56wCkeJfmxJW4I=;
        b=reK9Vs6ZJveOsiZ+AYNR45xB7RSF9kpcCT1K3LgONl/DPj8AK22Ycd2gpEnBuHuvmH
         7zXxYd8gepl38ROw72fWfe9LpqUpwDsVfU5GbRZ5OtlyigQOY0ChpeTkWAtjH6r5SbLA
         9yjbRJNYRDcZZ/xHoPgdMVuFPFJbqSpFyOE+6pF5I8zhY3lctxlj/Scq3e9MS/rjdmFX
         lkgdm5FHCK7jaej9Lqp8Y99SrtDKVAxvck4G4CZgI4OAuaIXUYcy0kXmj3vIGYc8Pz3W
         lwnuQljDj5bGhH8xphqwLZ/rBgHkEKWw/aHc7WVWhF36TsMfFWYD6wvUsviNXWoWjKxo
         23Aw==
X-Gm-Message-State: AOAM533UNnO17eAWyIOgTNh/c3ymkgiGGr6+kO6xUdRCuWxbwBeyITtg
        LIaDpLOHJxUKm5PWS0JSpGqnPe0Zj+2pPes/Klg=
X-Google-Smtp-Source: ABdhPJwA8jaJH1cue93hQcI8gC8bjDq5+XuGYA9A+xpAXXoZxgH1Db2zivwKW9byseEEx4hNwqVGZrpyrZvQD05sPkM=
X-Received: by 2002:a17:906:32d6:: with SMTP id k22mr7314707ejk.457.1611177914999;
 Wed, 20 Jan 2021 13:25:14 -0800 (PST)
MIME-Version: 1.0
References: <20210120142801.334550-1-arnd@kernel.org> <20210120142801.334550-3-arnd@kernel.org>
In-Reply-To: <20210120142801.334550-3-arnd@kernel.org>
From:   Barry Song <baohua@kernel.org>
Date:   Thu, 21 Jan 2021 10:25:03 +1300
Message-ID: <CAGsJ_4zSKAkGBMzGX7C1BfJU8ZLEsNwnhLq4EY+vxH2ZmODLoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: remove sirf prima/atlas driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> 于2021年1月21日周四 上午3:28写道：
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The CSR SiRF prima2/atlas platforms are getting removed, so this driver
> is no longer needed.
>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  .../devicetree/bindings/mmc/sdhci-sirf.txt    |  18 --
>  drivers/mmc/host/Kconfig                      |  12 -
>  drivers/mmc/host/Makefile                     |   1 -
>  drivers/mmc/host/sdhci-sirf.c                 | 235 ------------------
>  4 files changed, 266 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
>  delete mode 100644 drivers/mmc/host/sdhci-sirf.c
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
> deleted file mode 100644
> index dd6ed464bcb8..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* SiRFprimII/marco/atlas6 SDHCI Controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci-sirf driver.
> -
> -Required properties:
> -- compatible: sirf,prima2-sdhc
> -
> -Optional properties:
> -- cd-gpios: card detect gpio, with zero flags.
> -
> -Example:
> -
> -       sd0: sdhci@56000000 {
> -               compatible = "sirf,prima2-sdhc";
> -               reg = <0xcd000000 0x100000>;
> -               cd-gpios = <&gpio 6 0>;
> -       };
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 255d37e8bd3a..b67f6028b6f3 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -312,18 +312,6 @@ config MMC_SDHCI_S3C
>
>           If unsure, say N.
>
> -config MMC_SDHCI_SIRF
> -       tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
> -       depends on ARCH_SIRF || COMPILE_TEST
> -       depends on MMC_SDHCI_PLTFM
> -       select MMC_SDHCI_IO_ACCESSORS
> -       help
> -         This selects the SDHCI support for SiRF System-on-Chip devices.
> -
> -         If you have a controller with this interface, say Y or M here.
> -
> -         If unsure, say N.
> -
>  config MMC_SDHCI_PXAV3
>         tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
>         depends on CLKDEV_LOOKUP
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 43136d382d5f..d2ec428cc808 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -19,7 +19,6 @@ obj-$(CONFIG_MMC_SDHCI_ACPI)  += sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)  += sdhci-pxav3.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV2)  += sdhci-pxav2.o
>  obj-$(CONFIG_MMC_SDHCI_S3C)    += sdhci-s3c.o
> -obj-$(CONFIG_MMC_SDHCI_SIRF)           += sdhci-sirf.o
>  obj-$(CONFIG_MMC_SDHCI_F_SDH30)        += sdhci_f_sdh30.o
>  obj-$(CONFIG_MMC_SDHCI_MILBEAUT)       += sdhci-milbeaut.o
>  obj-$(CONFIG_MMC_SDHCI_SPEAR)  += sdhci-spear.o
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
> deleted file mode 100644
> index e9b347b3af7e..000000000000
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ /dev/null
> @@ -1,235 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * SDHCI support for SiRF primaII and marco SoCs
> - *
> - * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
> - */
> -
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/mmc/host.h>
> -#include <linux/module.h>
> -#include <linux/of.h>
> -#include <linux/mmc/slot-gpio.h>
> -#include "sdhci-pltfm.h"
> -
> -#define SDHCI_CLK_DELAY_SETTING 0x4C
> -#define SDHCI_SIRF_8BITBUS BIT(3)
> -#define SIRF_TUNING_COUNT 16384
> -
> -static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
> -{
> -       u8 ctrl;
> -
> -       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -       ctrl &= ~(SDHCI_CTRL_4BITBUS | SDHCI_SIRF_8BITBUS);
> -
> -       /*
> -        * CSR atlas7 and prima2 SD host version is not 3.0
> -        * 8bit-width enable bit of CSR SD hosts is 3,
> -        * while stardard hosts use bit 5
> -        */
> -       if (width == MMC_BUS_WIDTH_8)
> -               ctrl |= SDHCI_SIRF_8BITBUS;
> -       else if (width == MMC_BUS_WIDTH_4)
> -               ctrl |= SDHCI_CTRL_4BITBUS;
> -
> -       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> -}
> -
> -static u32 sdhci_sirf_readl_le(struct sdhci_host *host, int reg)
> -{
> -       u32 val = readl(host->ioaddr + reg);
> -
> -       if (unlikely((reg == SDHCI_CAPABILITIES_1) &&
> -                       (host->mmc->caps & MMC_CAP_UHS_SDR50))) {
> -               /* fake CAP_1 register */
> -               val = SDHCI_SUPPORT_DDR50 |
> -                       SDHCI_SUPPORT_SDR50 | SDHCI_USE_SDR50_TUNING;
> -       }
> -
> -       if (unlikely(reg == SDHCI_SLOT_INT_STATUS)) {
> -               u32 prss = val;
> -               /* fake chips as V3.0 host conreoller */
> -               prss &= ~(0xFF << 16);
> -               val = prss | (SDHCI_SPEC_300 << 16);
> -       }
> -       return val;
> -}
> -
> -static u16 sdhci_sirf_readw_le(struct sdhci_host *host, int reg)
> -{
> -       u16 ret = 0;
> -
> -       ret = readw(host->ioaddr + reg);
> -
> -       if (unlikely(reg == SDHCI_HOST_VERSION)) {
> -               ret = readw(host->ioaddr + SDHCI_HOST_VERSION);
> -               ret |= SDHCI_SPEC_300;
> -       }
> -
> -       return ret;
> -}
> -
> -static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
> -{
> -       int tuning_seq_cnt = 3;
> -       int phase;
> -       u8 tuned_phase_cnt = 0;
> -       int rc = 0, longest_range = 0;
> -       int start = -1, end = 0, tuning_value = -1, range = 0;
> -       u16 clock_setting;
> -       struct mmc_host *mmc = host->mmc;
> -
> -       clock_setting = sdhci_readw(host, SDHCI_CLK_DELAY_SETTING);
> -       clock_setting &= ~0x3fff;
> -
> -retry:
> -       phase = 0;
> -       tuned_phase_cnt = 0;
> -       do {
> -               sdhci_writel(host,
> -                       clock_setting | phase,
> -                       SDHCI_CLK_DELAY_SETTING);
> -
> -               if (!mmc_send_tuning(mmc, opcode, NULL)) {
> -                       /* Tuning is successful at this tuning point */
> -                       tuned_phase_cnt++;
> -                       dev_dbg(mmc_dev(mmc), "%s: Found good phase = %d\n",
> -                                mmc_hostname(mmc), phase);
> -                       if (start == -1)
> -                               start = phase;
> -                       end = phase;
> -                       range++;
> -                       if (phase == (SIRF_TUNING_COUNT - 1)
> -                               && range > longest_range)
> -                               tuning_value = (start + end) / 2;
> -               } else {
> -                       dev_dbg(mmc_dev(mmc), "%s: Found bad phase = %d\n",
> -                                mmc_hostname(mmc), phase);
> -                       if (range > longest_range) {
> -                               tuning_value = (start + end) / 2;
> -                               longest_range = range;
> -                       }
> -                       start = -1;
> -                       end = range = 0;
> -               }
> -       } while (++phase < SIRF_TUNING_COUNT);
> -
> -       if (tuned_phase_cnt && tuning_value > 0) {
> -               /*
> -                * Finally set the selected phase in delay
> -                * line hw block.
> -                */
> -               phase = tuning_value;
> -               sdhci_writel(host,
> -                       clock_setting | phase,
> -                       SDHCI_CLK_DELAY_SETTING);
> -
> -               dev_dbg(mmc_dev(mmc), "%s: Setting the tuning phase to %d\n",
> -                        mmc_hostname(mmc), phase);
> -       } else {
> -               if (--tuning_seq_cnt)
> -                       goto retry;
> -               /* Tuning failed */
> -               dev_dbg(mmc_dev(mmc), "%s: No tuning point found\n",
> -                      mmc_hostname(mmc));
> -               rc = -EIO;
> -       }
> -
> -       return rc;
> -}
> -
> -static const struct sdhci_ops sdhci_sirf_ops = {
> -       .read_l = sdhci_sirf_readl_le,
> -       .read_w = sdhci_sirf_readw_le,
> -       .platform_execute_tuning = sdhci_sirf_execute_tuning,
> -       .set_clock = sdhci_set_clock,
> -       .get_max_clock  = sdhci_pltfm_clk_get_max_clock,
> -       .set_bus_width = sdhci_sirf_set_bus_width,
> -       .reset = sdhci_reset,
> -       .set_uhs_signaling = sdhci_set_uhs_signaling,
> -};
> -
> -static const struct sdhci_pltfm_data sdhci_sirf_pdata = {
> -       .ops = &sdhci_sirf_ops,
> -       .quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> -               SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> -               SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -               SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> -};
> -
> -static int sdhci_sirf_probe(struct platform_device *pdev)
> -{
> -       struct sdhci_host *host;
> -       struct sdhci_pltfm_host *pltfm_host;
> -       struct clk *clk;
> -       int ret;
> -
> -       clk = devm_clk_get(&pdev->dev, NULL);
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "unable to get clock");
> -               return PTR_ERR(clk);
> -       }
> -
> -       host = sdhci_pltfm_init(pdev, &sdhci_sirf_pdata, 0);
> -       if (IS_ERR(host))
> -               return PTR_ERR(host);
> -
> -       pltfm_host = sdhci_priv(host);
> -       pltfm_host->clk = clk;
> -
> -       sdhci_get_of_property(pdev);
> -
> -       ret = clk_prepare_enable(pltfm_host->clk);
> -       if (ret)
> -               goto err_clk_prepare;
> -
> -       ret = sdhci_add_host(host);
> -       if (ret)
> -               goto err_sdhci_add;
> -
> -       /*
> -        * We must request the IRQ after sdhci_add_host(), as the tasklet only
> -        * gets setup in sdhci_add_host() and we oops.
> -        */
> -       ret = mmc_gpiod_request_cd(host->mmc, "cd", 0, false, 0);
> -       if (ret == -EPROBE_DEFER)
> -               goto err_request_cd;
> -       if (!ret)
> -               mmc_gpiod_request_cd_irq(host->mmc);
> -
> -       return 0;
> -
> -err_request_cd:
> -       sdhci_remove_host(host, 0);
> -err_sdhci_add:
> -       clk_disable_unprepare(pltfm_host->clk);
> -err_clk_prepare:
> -       sdhci_pltfm_free(pdev);
> -       return ret;
> -}
> -
> -static const struct of_device_id sdhci_sirf_of_match[] = {
> -       { .compatible = "sirf,prima2-sdhc" },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(of, sdhci_sirf_of_match);
> -
> -static struct platform_driver sdhci_sirf_driver = {
> -       .driver         = {
> -               .name   = "sdhci-sirf",
> -               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -               .of_match_table = sdhci_sirf_of_match,
> -               .pm     = &sdhci_pltfm_pmops,
> -       },
> -       .probe          = sdhci_sirf_probe,
> -       .remove         = sdhci_pltfm_unregister,
> -};
> -
> -module_platform_driver(sdhci_sirf_driver);
> -
> -MODULE_DESCRIPTION("SDHCI driver for SiRFprimaII/SiRFmarco");
> -MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> -MODULE_LICENSE("GPL v2");
> --
> 2.29.2
>
