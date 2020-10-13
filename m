Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CAC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 08:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24EE2137B
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 08:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEcfkO0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403923AbgJMIm2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403919AbgJMIm1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 04:42:27 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86799C0613D2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 01:42:27 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id f8so10607167vsl.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0tT/OxWzXToVda8iVCF76v2EDXGWGffzNusJWvss8M=;
        b=rEcfkO0NIHhLROvC5ZLcfK3iHqd8SalrVx1IENPSPL9L4RtFBwu78TU7BnEX+xg+cJ
         TP2HCQ4n6d55TeBhx9JsQsjtafrU9hn+eTCoGMgsb1Jq6YAGG6BvOFnj4gbfGDOm9CUr
         G4ySHoroeEO/K/MxVjyOD6J/IJBIGlTW8ug5DEqEPoxfo4e8AZzwxpqGovPe477I8wQx
         CWq4T7FOZb3HN5rNmiAvXGkr/RyeGMICqrHOW7uxrBDBq9nMjPiDIyu2uYHrj2QU7iCR
         V0dFbJdC++ZEw/nX1XvT2XJkZ4r53BoeC7XU6LoM2BfY3BCZ2w15qyKx1YZCVJ3GmDn0
         LBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0tT/OxWzXToVda8iVCF76v2EDXGWGffzNusJWvss8M=;
        b=ZG5HhNOdFt8qnhyJF5czhNND/nl0WUfB1vGfpIHdnC3sH01hVQ2/0MSMB+pusGfN9b
         qh+tN4cFjzyyP5dhyu+FgEDm3Vs5Sq8IJub7xpl8FPfgfeoiLs2A3ZFwUjHcRfJXn0Ni
         EBALortphZJDkEmPwijI9AJVYmcg1+ZjPWCi++5yTE+8OyaNhcnI1HLjeHtL8seHO95G
         Ow0hprX1XaTV1RkbLSsJenS8AEA8AL7zJEgwZnlvxL1OCeYj5NA1Y6pJcbDUNg7SJWPr
         Y/dxrYT2WtVuw/fDPnyBI0i1OBMnci4LjS4dpBEmJITFBURMybUIefllSHaLXBqUcoCG
         JBYQ==
X-Gm-Message-State: AOAM531IITYiZRiQcB65KlxMvC+gC8/0x3iivsRlHwu27k10nafhwlBv
        4dU7+aqUwqAn4pQcxMfoCop4Or2+n8aKsSkjEzh/bA==
X-Google-Smtp-Source: ABdhPJz5bidkohOEL1Mad90/4Mq0kOr+hJLXG0AGnTln12QW/VucJ7OezoBQnKjDG2AqA/MAFDjYNvTyBNcAmpZBNjI=
X-Received: by 2002:a67:f24e:: with SMTP id y14mr15972235vsm.55.1602578546349;
 Tue, 13 Oct 2020 01:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
 <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFptgKG8uvKUkN56sooFL4xqaBcNdbpo645xRQqPOH4BkQ@mail.gmail.com>
 <DM6PR11MB28761F10936FF0D2695FAF19B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFoRHsOiz9BFJ5jWyKqvdmNW9eeEmCGKYn0Q1jUzNwJZNg@mail.gmail.com> <DM6PR11MB2876DF701740F70FFD2B2D17B8080@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB2876DF701740F70FFD2B2D17B8080@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Oct 2020 10:41:49 +0200
Message-ID: <CAPDyKFqB5SCfNWumhDjvH+mQxMi6bYcHSg-vBV+gWEgDee0m1Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Oct 2020 at 19:50, Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi,
>
> >-----Original Message-----
> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >Sent: Friday, October 9, 2020 2:56 PM
> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >Cc: Hunter, Adrian <adrian.hunter@intel.com>; Michal Simek
> ><michal.simek@xilinx.com>; Shevchenko, Andriy
> ><andriy.shevchenko@intel.com>; linux-mmc@vger.kernel.org; Linux ARM
> ><linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> >kernel@vger.kernel.org>; Raja Subramanian, Lakshmi Bai
> ><lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
> >Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Arnd Bergmann
> ><arnd@arndb.de>
> >Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
> >Keem Bay SOC
> >
> >On Thu, 8 Oct 2020 at 19:21, Zulkifli, Muhammad Husaini
> ><muhammad.husaini.zulkifli@intel.com> wrote:
> >>
> >> Hi,
> >>
> >> >-----Original Message-----
> >> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >> >Sent: Thursday, October 8, 2020 11:19 PM
> >> >To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> >> >Cc: Hunter, Adrian <adrian.hunter@intel.com>; Michal Simek
> >> ><michal.simek@xilinx.com>; Shevchenko, Andriy
> >> ><andriy.shevchenko@intel.com>; linux-mmc@vger.kernel.org; Linux ARM
> >> ><linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> >> ><linux- kernel@vger.kernel.org>; Raja Subramanian, Lakshmi Bai
> >> ><lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
> >> >Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Arnd Bergmann
> >> ><arnd@arndb.de>
> >> >Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1
> >> >support for Keem Bay SOC
> >> >
> >> >On Thu, 8 Oct 2020 at 12:54, Zulkifli, Muhammad Husaini
> >> ><muhammad.husaini.zulkifli@intel.com> wrote:
> >> >>
> >> >> Hi,
> >> >>
> >> >> >-----Original Message-----
> >> >> >From: Ulf Hansson <ulf.hansson@linaro.org>
> >> >> >Sent: Thursday, October 8, 2020 5:28 PM
> >> >> >To: Zulkifli, Muhammad Husaini
> >> >> ><muhammad.husaini.zulkifli@intel.com>
> >> >> >Cc: Hunter, Adrian <adrian.hunter@intel.com>; Michal Simek
> >> >> ><michal.simek@xilinx.com>; Shevchenko, Andriy
> >> >> ><andriy.shevchenko@intel.com>; linux-mmc@vger.kernel.org; Linux
> >> >> >ARM <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing
> >> >> >List
> >> >> ><linux- kernel@vger.kernel.org>; Raja Subramanian, Lakshmi Bai
> >> >> ><lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan
> >Ahmad
> >> >> >Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Arnd Bergmann
> >> >> ><arnd@arndb.de>
> >> >> >Subject: Re: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1
> >> >> >support for Keem Bay SOC
> >> >> >
> >> >> >On Thu, 8 Oct 2020 at 04:12, <muhammad.husaini.zulkifli@intel.com>
> >> >wrote:
> >> >> >>
> >> >> >> From: Muhammad Husaini Zulkifli
> >> >> >> <muhammad.husaini.zulkifli@intel.com>
> >> >> >>
> >> >> >> Voltage switching sequence is needed to support UHS-1 interface.
> >> >> >> There are 2 places to control the voltage.
> >> >> >> 1) By setting the AON register using firmware driver calling
> >> >> >> system-level platform management layer (SMC) to set the register.
> >> >> >> 2) By controlling the GPIO expander value to drive either 1.8V
> >> >> >> or 3.3V for power mux input.
> >> >> >>
> >> >> >> Signed-off-by: Muhammad Husaini Zulkifli
> >> >> >> <muhammad.husaini.zulkifli@intel.com>
> >> >> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> >> >> >> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >> >> >> ---
> >> >> >>  drivers/mmc/host/sdhci-of-arasan.c | 126
> >> >> >> +++++++++++++++++++++++++++++
> >> >> >>  1 file changed, 126 insertions(+)
> >> >> >>
> >> >> >> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> >> >> >> b/drivers/mmc/host/sdhci-of-arasan.c
> >> >> >> index 46aea6516133..ea2467b0073d 100644
> >> >> >> --- a/drivers/mmc/host/sdhci-of-arasan.c
> >> >> >> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> >> >> >> @@ -16,6 +16,7 @@
> >> >> >>   */
> >> >> >>
> >> >> >>  #include <linux/clk-provider.h>
> >> >> >> +#include <linux/gpio/consumer.h>
> >> >> >>  #include <linux/mfd/syscon.h>
> >> >> >>  #include <linux/module.h>
> >> >> >>  #include <linux/of_device.h>
> >> >> >> @@ -23,6 +24,7 @@
> >> >> >>  #include <linux/regmap.h>
> >> >> >>  #include <linux/of.h>
> >> >> >>  #include <linux/firmware/xlnx-zynqmp.h>
> >> >> >> +#include <linux/firmware/intel/keembay_firmware.h>
> >> >> >>
> >> >> >>  #include "cqhci.h"
> >> >> >>  #include "sdhci-pltfm.h"
> >> >> >> @@ -136,6 +138,7 @@ struct sdhci_arasan_clk_data {
> >> >> >>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
> >> >> >>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
> >> >> >>   * @quirks:            Arasan deviations from spec.
> >> >> >> + * @uhs_gpio:          Pointer to the uhs gpio.
> >> >> >>   */
> >> >> >>  struct sdhci_arasan_data {
> >> >> >>         struct sdhci_host *host; @@ -150,6 +153,7 @@ struct
> >> >> >> sdhci_arasan_data {
> >> >> >>         struct regmap   *soc_ctl_base;
> >> >> >>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> >> >> >>         unsigned int    quirks;
> >> >> >> +       struct gpio_desc *uhs_gpio;
> >> >> >>
> >> >> >>  /* Controller does not have CD wired and will not function
> >> >> >> normally without
> >> >> >*/
> >> >> >>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST        BIT(0)
> >> >> >> @@ -361,6 +365,112 @@ static int
> >> >> >> sdhci_arasan_voltage_switch(struct
> >> >> >mmc_host *mmc,
> >> >> >>         return -EINVAL;
> >> >> >>  }
> >> >> >>
> >> >> >> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host
> >> >*mmc,
> >> >> >> +                                      struct mmc_ios *ios) {
> >> >> >> +       struct sdhci_host *host = mmc_priv(mmc);
> >> >> >> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> >> >> +       struct sdhci_arasan_data *sdhci_arasan =
> >> >sdhci_pltfm_priv(pltfm_host);
> >> >> >> +       u16 ctrl_2, clk;
> >> >> >> +       int ret;
> >> >> >> +
> >> >> >> +       switch (ios->signal_voltage) {
> >> >> >> +       case MMC_SIGNAL_VOLTAGE_180:
> >> >> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> >> >> +               clk &= ~SDHCI_CLOCK_CARD_EN;
> >> >> >> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> >> >> >> +
> >> >> >> +               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> >> >> >> +               if (clk & SDHCI_CLOCK_CARD_EN)
> >> >> >> +                       return -EAGAIN;
> >> >> >> +
> >> >> >> +               sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
> >> >> >> +                                  SDHCI_POWER_CONTROL);
> >> >> >> +
> >> >> >> +               /*
> >> >> >> +                * Set VDDIO_B voltage to Low for 1.8V
> >> >> >> +                * which is controlling by GPIO Expander.
> >> >> >> +                */
> >> >> >> +               gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio,
> >> >> >> + 0);
> >> >> >> +
> >> >> >> +               /*
> >> >> >> +                * This is like a final gatekeeper. Need to
> >> >> >> + ensure changed
> >> >voltage
> >> >> >> +                * is settled before and after turn on this bit.
> >> >> >> +                */
> >> >> >> +               usleep_range(1000, 1100);
> >> >> >> +
> >> >> >> +               ret =
> >> >keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
> >> >> >> +               if (ret)
> >> >> >> +                       return ret;
> >> >> >> +
> >> >> >> +               usleep_range(1000, 1100);
> >> >> >
> >> >> >No, sorry, but I don't like this.
> >> >> >
> >> >> >This looks like a GPIO regulator with an extension of using the
> >> >> >keembay_sd_voltage_selection() thingy. I think you can model these
> >> >> >things behind a regulator and hook it up as a vqmmc supply in DT
> >> >> >instead. BTW, this is the common way we deal with these things for
> >> >> >mmc
> >> >host drivers.
> >> >>
> >> >> The SDcard for Keem Bay SOC does not have its own voltage regulator.
> >> >> There are 2 places to control the voltage.
> >> >> 1) By setting the AON register calling system-level platform
> >> >> management
> >> >layer (SMC)
> >> >>    to set the I/O pads voltage for particular GPIOs line for clk,data and cmd.
> >> >>    The reason why I use this keembay_sd_voltage_selection() via
> >> >> smccc
> >> >interface it because during voltage switching
> >> >>    I need to access to AON register. On a secure system, we could
> >> >> not
> >> >directly access to AON register due to some security concern from
> >> >driver side, thus
> >> >>    cannot exposed any register or address.
> >> >> 2) By controlling the GPIO expander value to drive either 1.8V or
> >> >> 3.3V for
> >> >power mux input.
> >> >
> >> >I see, thanks for clarifying.
> >> >
> >> >To me, it sounds like the best fit is to implement a pinctrl (to
> >> >manage the I/O
> >> >pads) and a GPIO regulator.
> >> >
> >> Even with pinctrl, i still need to use the keembay_sd_voltage_selection()
> >thingy for AON register.
> >
> >Yes, I am fine by that.
> >
> >Although, as it's really a pinctrl, it deserves to be modelled like that. Not as a
> >soc specific hack in a mmc host driver.
> >
> >> Plus, the GPIO pin that control the sd-voltage is in GPIO Expander not using
> >Keembay SOC GPIO Pin.
> >> The best option is using the gpio consumer function to toggle the pin.
> >
> >As I said, please no.
> >
> >The common way to model this is as a GPIO regulator. In this way, you can even
> >rely on existing mmc DT bindings. All you have to do is to hook up a vqmmc
> >supply to the mmc node.
> >
> >To be clear, as long as there are no arguments for why a pinctrl and GPIO
> >regulator can't be used - I am not going to pick up the patches.
> As I mentioned The SDcard does not have its own voltage regulator.
> It only uses the voltage rails on the mux input.
>
> There are 2 things need to be configured before getting the output voltage:
>
> 1) V_VDDIO_B :
> Supplied voltage applied to I/O Rail which is controlled from the Always on domain using specific bits in AON_CFG1 register.
> This is where we set for V_VDDIO_B using the keembay_sd_voltage_selection() to set either 1.8v or 3.3v depending on the bit value.
> IMHO, we do not pinctrl to do this.
>
> 2) V_VDDIO_B_MAIN:
> The output V_VDDIO_B_MAIN (OUT1) will be either V_3P3_MAIN (IN1) or V_1P8_MAIN (IN2),
> depending on the state of GPIO expander Pin value. There is a POWER MUX involving here.
> IMHO, we do not need any gpio regulator/regulator api hook up for this.
> Most important thing, there is no regulator ic at all.
> We still need to manually control and toggle the pin value.
>
> The final IO voltage is set by V_VDDIO_B (= V_VDDIO_B_MAIN after passing through voltage sense resistor).
>
> Hope this will clarify.

I think I get it, thanks.

Again, I haven't seen any reasons for why this can't be modelled as a
pinctrl and a gpio-regulator. So, please convert it to that.

Kind regards
Uffe
