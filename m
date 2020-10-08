Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CC2C433E7
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D352168B
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 09:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWNSCN5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgJHJ2I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJHJ2H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2020 05:28:07 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661FCC0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2020 02:28:07 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id r78so1157736vke.11
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2020 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Haly/m6B5uEAQZZGswDUFxf1Joe6+/u8n74/f04RGA=;
        b=DWNSCN5nnMXdNcjanEut1aXQ9keVYjEND78LHgNsHgRaX1z/9uvib3C8CbT9zos1Gp
         q3QP9+Va8blGKIs0+W5Zc+Ei/fAeEP7dkRT0jbDXbFpusvZT2dlBCVq5g+wt4MZxoudC
         0gYQulFOp4EQJ/4OFOPR4trCoRNaaX5k6tQaAaVIg/Rk6Op9onCI1fv3yZCf/Fjl5CbS
         Kob5Y9TiRDorwgcdHATtxtQ0pd+Pxgj8Nt6PsjdTG0NDrNFxTVIdyWUQp9XC1VOEkFEv
         2kUhocglC9GqEzqMaVRUkSX47gRd++6ql0bOREX67wdFZfx2in5c6/p/7VjbcqaP2YpE
         88Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Haly/m6B5uEAQZZGswDUFxf1Joe6+/u8n74/f04RGA=;
        b=U6FRZvzRXBXSSPwSjUap7vrvMkcAHqK0fJDd/TFrGk30kWtLVgJ0QBnVzIaxdxNkvZ
         kHDDOpuTvT+UM4L1zApNCccYnghjFo7/pdDTn/qDFjmY7cjqurTfuMdXVuoS+6E/xL+c
         3Iju1CkQfAoirnR5bjfAKGxbFMjG8RbWC4w8hKfUw8lC9+eZIY6P0BfZJ4dYcG7XV9GD
         aIejFGt0K+BHpUdJKdcWFoevFKikMMlHRIfJB8GNcUIKUvdf5/3eTQfs4XwRCFZR70n5
         kdUzmqPKj5/1frfFB8hOlkYTqC1ve33PMQq+7vTPK5U3cX2/Foyuf/2Fn4/BX8fM4s60
         vvCQ==
X-Gm-Message-State: AOAM533uKi6Xjc048wqWmiNFm4/YZSXDtxQ9tRLAtJWjESwwzxUSHPii
        iNMJAA+Xmv3+9Hv1RARQYYjbqmPSDlI/EOSmq7ck3w==
X-Google-Smtp-Source: ABdhPJyGT+f5K0NlflRmr0Oujg9N8RzDRyq2G3QJRww1A0zSLrRBClj7br0zFW3BcP+Cmdijt0LNuXoQJvgjp6Hu0pQ=
X-Received: by 2002:a1f:ae85:: with SMTP id x127mr615243vke.8.1602149286384;
 Thu, 08 Oct 2020 02:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com> <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Oct 2020 11:27:30 +0200
Message-ID: <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     muhammad.husaini.zulkifli@intel.com
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        andriy.shevchenko@intel.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lakshmi.bai.raja.subramanian@intel.com,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 8 Oct 2020 at 04:12, <muhammad.husaini.zulkifli@intel.com> wrote:
>
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Voltage switching sequence is needed to support UHS-1 interface.
> There are 2 places to control the voltage.
> 1) By setting the AON register using firmware driver calling
> system-level platform management layer (SMC) to set the register.
> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V
> for power mux input.
>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 126 +++++++++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 46aea6516133..ea2467b0073d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -16,6 +16,7 @@
>   */
>
>  #include <linux/clk-provider.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -23,6 +24,7 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/firmware/intel/keembay_firmware.h>
>
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -136,6 +138,7 @@ struct sdhci_arasan_clk_data {
>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
>   * @quirks:            Arasan deviations from spec.
> + * @uhs_gpio:          Pointer to the uhs gpio.
>   */
>  struct sdhci_arasan_data {
>         struct sdhci_host *host;
> @@ -150,6 +153,7 @@ struct sdhci_arasan_data {
>         struct regmap   *soc_ctl_base;
>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>         unsigned int    quirks;
> +       struct gpio_desc *uhs_gpio;
>
>  /* Controller does not have CD wired and will not function normally without */
>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
> @@ -361,6 +365,112 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>         return -EINVAL;
>  }
>
> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
> +                                      struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       u16 ctrl_2, clk;
> +       int ret;
> +
> +       switch (ios->signal_voltage) {
> +       case MMC_SIGNAL_VOLTAGE_180:
> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               clk &= ~SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               if (clk & SDHCI_CLOCK_CARD_EN)
> +                       return -EAGAIN;
> +
> +               sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
> +                                  SDHCI_POWER_CONTROL);
> +
> +               /*
> +                * Set VDDIO_B voltage to Low for 1.8V
> +                * which is controlling by GPIO Expander.
> +                */
> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
> +
> +               /*
> +                * This is like a final gatekeeper. Need to ensure changed voltage
> +                * is settled before and after turn on this bit.
> +                */
> +               usleep_range(1000, 1100);
> +
> +               ret = keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
> +               if (ret)
> +                       return ret;
> +
> +               usleep_range(1000, 1100);

No, sorry, but I don't like this.

This looks like a GPIO regulator with an extension of using the
keembay_sd_voltage_selection() thingy. I think you can model these
things behind a regulator and hook it up as a vqmmc supply in DT
instead. BTW, this is the common way we deal with these things for mmc
host drivers.

> +
> +               ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +               ctrl_2 |= SDHCI_CTRL_VDD_180;
> +               sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +               /* Sleep for 5ms to stabilize 1.8V regulator */
> +               usleep_range(5000, 5500);
> +
> +               /* 1.8V regulator output should be stable within 5 ms */
> +               ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +               if (!(ctrl_2 & SDHCI_CTRL_VDD_180))
> +                       return -EAGAIN;
> +
> +               clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +               clk |= SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +               break;
> +       case MMC_SIGNAL_VOLTAGE_330:
> +               /*
> +                * Set VDDIO_B voltage to High for 3.3V
> +                * which is controlling by GPIO Expander.
> +                */
> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 1);
> +
> +               /*
> +                * This is like a final gatekeeper. Need to ensure changed voltage
> +                * is settled before and after turn on this bit.
> +                */
> +               usleep_range(1000, 1100);
> +
> +               ret = keembay_sd_voltage_selection(KEEMBAY_SET_3V3_VOLT);
> +               if (ret)
> +                       return ret;
> +
> +               usleep_range(1000, 1100);
> +
> +               /* Set 1.8V Signal Enable in the Host Control2 register to 0 */
> +               ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +               ctrl_2 &= ~SDHCI_CTRL_VDD_180;
> +               sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +               /* Sleep for 5ms to stabilize 3.3V regulator */
> +               usleep_range(5000, 5500);
> +
> +               /* 3.3V regulator output should be stable within 5 ms */
> +               ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +               if (ctrl_2 & SDHCI_CTRL_VDD_180)
> +                       return -EAGAIN;
> +
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int sdhci_arasan_keembay_select_drive_strength(struct mmc_card *card,
> +                                       unsigned int max_dtr, int host_drv,
> +                                       int card_drv, int *drv_type)
> +{
> +       if (card->host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +               *drv_type = MMC_SET_DRIVER_TYPE_C;
> +
> +       return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_arasan_ops = {
>         .set_clock = sdhci_arasan_set_clock,
>         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -1601,6 +1711,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>         }
>
> +       if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
> +               struct gpio_desc *uhs;
> +
> +               uhs = devm_gpiod_get_optional(dev, "uhs", GPIOD_OUT_HIGH);
> +               if (IS_ERR(uhs))
> +                       return dev_err_probe(dev, PTR_ERR(uhs), "can't get uhs gpio\n");
> +
> +               sdhci_arasan->uhs_gpio = uhs;
> +
> +               host->mmc_host_ops.start_signal_voltage_switch =
> +                       sdhci_arasan_keembay_voltage_switch;
> +
> +               host->mmc_host_ops.select_drive_strength =
> +                       sdhci_arasan_keembay_select_drive_strength;
> +       }
> +
>         sdhci_arasan_update_baseclkfreq(host);
>
>         ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
> --
> 2.17.1
>

Kind regards
Uffe
