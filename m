Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D5AC04EBE
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 15:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6000F20782
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3+iGaEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgJHPNE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 11:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgJHPNE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2020 11:13:04 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBACAC061755
        for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2020 08:13:03 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id e5so1399400vkm.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2020 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsPwsTl/hAvDoxdVSq6VH5qAHlyEl+VKWN+4G8Q2WOQ=;
        b=s3+iGaEsVITyDA7YZovcQvYscw4EjPjWOCEJT6rKSq1KDPf+ha55v3LiLzlgk3arv3
         f1t4gMJ1jg1x8B8c2TjMHfn6n98VLEiDa4W0kR175b3mrUz/3u+jS6Y11ta9gFMmZun4
         uI/4ljpbnWGXI7aGQCKMOaujD8rnXq4yQTrvenvACQ49VN6X/fwVY+7OUi87dyauylOW
         JFVG/gaaoLasrA541feJDtIv9X+uS8PXYIUw+MRowHzzA4vrj80/G2Bg+ootk3eJ/jBN
         JEunId1ia3jNICZ6G9I2rookeL5+xZG7ere0myXr68+Eo1bxrU6rW3a8X3IHaqMzEG33
         X5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsPwsTl/hAvDoxdVSq6VH5qAHlyEl+VKWN+4G8Q2WOQ=;
        b=spd0F+f2AdPC+NywtykKF9+wsibr3+5H4F94m5vvcW9fu3zpWUrS8XYlk4HDv8KXQd
         tkuzeAOOAlvCwrX/m0aENPVWy+Eggppxew+BL7VYIailXZXfMv5B68oBuUHjfEQ8fpuP
         Rre+mwGwri7FoxCrhd7Kw1qUUnvNhXy64zIR8GUqvD+AVAS11qD+VW7950iUMQ6ktPp9
         YOIodusqnSdthMManZss40JIEmwPCz0jAiDXrIwQNRwQI/qbEd9dR/IZ7xtuwFEyRQw/
         3/VYLN2zW+qHU/frfTbdfuOA6M11hs5HLHunI6h/a3Zt+khhNqRV1sS+CStYfSDAeL10
         CBqg==
X-Gm-Message-State: AOAM533Sk3ITu2THyKrf9NSDS2VtkcJvUjt/ILuhDIS2QqTcric+BmyC
        GEAD/0Ihwh+oB55cqRHwjG02WJfML5znzuyRxQHbjQ==
X-Google-Smtp-Source: ABdhPJwEjGnJf7ZCkTSVlSm0STvrBQYCiSWeuqvCe29hXNIC4YsoSyZw/x3HwLnhyDvaFcM5tgClpCqZEqy/KFuvln0=
X-Received: by 2002:a1f:ae85:: with SMTP id x127mr1703271vke.8.1602169983032;
 Thu, 08 Oct 2020 08:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com> <35692f1c-62a4-6c71-d67a-2a216e97e7d5@intel.com>
In-Reply-To: <35692f1c-62a4-6c71-d67a-2a216e97e7d5@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Oct 2020 17:12:26 +0200
Message-ID: <CAPDyKFqy5jhbRWmcc-rMSzendMnkj2MQ-MQYu+=fVAZufTWbOQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     muhammad.husaini.zulkifli@intel.com,
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

On Thu, 8 Oct 2020 at 12:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 8/10/20 12:27 pm, Ulf Hansson wrote:
> > On Thu, 8 Oct 2020 at 04:12, <muhammad.husaini.zulkifli@intel.com> wrote:
> >>
> >> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> >>
> >> Voltage switching sequence is needed to support UHS-1 interface.
> >> There are 2 places to control the voltage.
> >> 1) By setting the AON register using firmware driver calling
> >> system-level platform management layer (SMC) to set the register.
> >> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V
> >> for power mux input.
> >>
> >> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  drivers/mmc/host/sdhci-of-arasan.c | 126 +++++++++++++++++++++++++++++
> >>  1 file changed, 126 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> >> index 46aea6516133..ea2467b0073d 100644
> >> --- a/drivers/mmc/host/sdhci-of-arasan.c
> >> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> >> @@ -16,6 +16,7 @@
> >>   */
> >>
> >>  #include <linux/clk-provider.h>
> >> +#include <linux/gpio/consumer.h>
> >>  #include <linux/mfd/syscon.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of_device.h>
> >> @@ -23,6 +24,7 @@
> >>  #include <linux/regmap.h>
> >>  #include <linux/of.h>
> >>  #include <linux/firmware/xlnx-zynqmp.h>
> >> +#include <linux/firmware/intel/keembay_firmware.h>
> >>
> >>  #include "cqhci.h"
> >>  #include "sdhci-pltfm.h"
> >> @@ -136,6 +138,7 @@ struct sdhci_arasan_clk_data {
> >>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
> >>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
> >>   * @quirks:            Arasan deviations from spec.
> >> + * @uhs_gpio:          Pointer to the uhs gpio.
> >>   */
> >>  struct sdhci_arasan_data {
> >>         struct sdhci_host *host;
> >> @@ -150,6 +153,7 @@ struct sdhci_arasan_data {
> >>         struct regmap   *soc_ctl_base;
> >>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> >>         unsigned int    quirks;
> >> +       struct gpio_desc *uhs_gpio;
> >>
> >>  /* Controller does not have CD wired and will not function normally without */
> >>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
> >> @@ -361,6 +365,112 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
> >>         return -EINVAL;
> >>  }
> >>
> >> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
> >> +                                      struct mmc_ios *ios)
> >> +{
> >> +       struct sdhci_host *host = mmc_priv(mmc);
> >> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> >> +       u16 ctrl_2, clk;
> >> +       int ret;
> >> +
> >> +       switch (ios->signal_voltage) {
> >> +       case MMC_SIGNAL_VOLTAGE_180:
> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +               clk &= ~SDHCI_CLOCK_CARD_EN;
> >> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> >> +
> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> +               if (clk & SDHCI_CLOCK_CARD_EN)
> >> +                       return -EAGAIN;
> >> +
> >> +               sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
> >> +                                  SDHCI_POWER_CONTROL);
> >> +
> >> +               /*
> >> +                * Set VDDIO_B voltage to Low for 1.8V
> >> +                * which is controlling by GPIO Expander.
> >> +                */
> >> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
> >> +
> >> +               /*
> >> +                * This is like a final gatekeeper. Need to ensure changed voltage
> >> +                * is settled before and after turn on this bit.
> >> +                */
> >> +               usleep_range(1000, 1100);
> >> +
> >> +               ret = keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
> >> +               if (ret)
> >> +                       return ret;
> >> +
> >> +               usleep_range(1000, 1100);
> >
> > No, sorry, but I don't like this.
> >
> > This looks like a GPIO regulator with an extension of using the
> > keembay_sd_voltage_selection() thingy. I think you can model these
> > things behind a regulator and hook it up as a vqmmc supply in DT
> > instead. BTW, this is the common way we deal with these things for mmc
> > host drivers.
>
> It seemed to me that would just result in calling regulator API instead of
> GPIO API but the flow above would otherwise be unchanged i.e. no benefit
>

To me, the benefit is about avoiding platform specific code in drivers
- but also about consistency. For I/O signal voltage, the common
method here, is to model this as a GPIO regulator. This means we can
use these available helpers from the core:

mmc_regulator_set_vqmmc()
mmc_regulator_get_supply()

Kind regards
Uffe
