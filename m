Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596D0C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CCE233F7
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbhAMLkI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhAMLkI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:40:08 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053DC061575
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:39:27 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id u7so908900vsg.11
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnJvzz1onvjf/ovL1HapCYJD/m4iJ8h4N/uFHWbTT5Q=;
        b=qmXilFV2jORIehQZZQ++Yc8/7hBNzXdn4lef9aaXCovusRWiUeAKi+9BxRR7X4i2BV
         IjqDtIW29mesYumIU5lrLKxUmkRq+glX3yc3G5Sc5+ONN3t5EU3l9gtNQQVHi+jrGBbf
         Bip+f75NnDfs6/P4uKNeAyQ3FGiRjcNFAmvqIYY+SIC4gA+NFwu9nZs39mMdfLuZ4qpV
         fXIcxjwbdHVP8PqHmut02ARRVhgy6PWn0U7cgstolhnXyCSUlsjw6j3/OLCj/ethWXPM
         56wEbujAv5ElZp3bzepzDtv+QfZfdleiyYnh23EdjDgpm8q1KE+qXyHUQJ9cJXwelJJX
         gS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnJvzz1onvjf/ovL1HapCYJD/m4iJ8h4N/uFHWbTT5Q=;
        b=KrL9d3t1WJlqoSjNYOUjkff5WUzqePKfR27FzQ7MSVgRvzVetCC2Xpjbqtwu5lGS6x
         XexrFPhFfQQ3O7M2F9Gbv3XkT20vcmY6cJRNrV3HsI2gjfgULBQS+/hZMInPCMtqVqnC
         J2FTtwR5HhzCYTd3yEMYo1+JQJMKet53a0hFGcLq/wA+SNolFzifZiO3laMZ+uMjOma5
         2HJh69YrLFbcgCGK3meUViqIRIBHImde4twOZo2tEuLhhSs5IJRQriOVKOD/DsKz8CZI
         lslTyBgALsMwYNUDO6VBUc3zH2yTlQQxoq891ptyCji4VskWZ7LeoFO/cmWGp2QtCYPB
         NcNg==
X-Gm-Message-State: AOAM5337gjmQJvNd4H0Y2O7aJz4R2jWCCbfI4gi4brNYn8w9vrYQzmX0
        1gHYNLx9Zxot9ijofMjVCb/zz5E0RoXq/QK9nrwYlQ==
X-Google-Smtp-Source: ABdhPJx4S/BIeSIjCYMnkwf3JxdYaOGYDFl17mvox5ktXMbxztu2q0aTGetaE0lOlKARgT91O0X3uTgeBiXzmmM6wUg=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr1419027vsd.55.1610537967081;
 Wed, 13 Jan 2021 03:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20210105140718.122752-1-marex@denx.de> <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
 <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
In-Reply-To: <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:38:50 +0100
Message-ID: <CAPDyKFo5Sqxj31owrnmz1sTZqgW_PtZM2H=pDPBz+9hc0W0hHA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mmc: mmci: Add support for probing bus voltage
 level translator
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Jan 2021 at 12:34, Marek Vasut <marex@denx.de> wrote:
>
> On 1/13/21 11:44 AM, Ulf Hansson wrote:
>
> [...]
>
> >> NOTE: I would prefer this solution over having a custom DT per SoM,
> >>        since it reduces the amount of DT combinations.
> >> ---
> >>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi | 32 ++++++++-
> >>   drivers/mmc/host/mmci.c                      | 70 ++++++++++++++++++--
> >
> > Please avoid mixing DTS changes with changes to code in drivers.
>
> With RFC patch you likely want to see the whole picture, so I kept it in
> one patch.
>
> >>   2 files changed, 96 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> >> index dc70ddd09e9d..a69cae19d92d 100644
> >> --- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> >> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> >> @@ -401,15 +401,45 @@ &rtc {
> >>          status = "okay";
> >>   };
> >>
> >> +&pinctrl {
> >> +       sdmmc1_b4_init_pins_a: sdmmc1-init-b4-0 {
> >> +               pins1 {
> >> +                       pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
> >> +                                <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
> >> +                                <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
> >> +                                <STM32_PINMUX('C', 11, AF12)>; /* SDMMC1_D3 */
> >> +                       slew-rate = <1>;
> >> +                       drive-push-pull;
> >> +                       bias-disable;
> >> +               };
> >> +       };
> >> +
> >> +       sdmmc1_dir_init_pins_a: sdmmc1-init-dir-0 {
> >> +               pins1 {
> >> +                       pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
> >> +                                <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
> >> +                                <STM32_PINMUX('B', 9, AF11)>; /* SDMMC1_CDIR */
> >> +                       slew-rate = <1>;
> >> +                       drive-push-pull;
> >> +                       bias-pull-up;
> >> +               };
> >> +       };
> >> +};
> >> +
> >>   &sdmmc1 {
> >> -       pinctrl-names = "default", "opendrain", "sleep";
> >> +       pinctrl-names = "default", "opendrain", "sleep", "init";
> >
> > Apologize for my ignorance, but my understanding of "init" vs
> > "default" is that "init" should be treated as the legacy name for the
> > pinstate. I would appreciate Linus' opinion on this.
>
> My understanding is that "init" is the way pins are configured before
> the driver reconfigures them to whatever the driver needs to configure
> them to. The "default" state is the normal operational state of the
> hardware, which often is the same as "init".
>
> [...]
>
> >>   static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
> >>   {
> >>          struct mmci_host *host = mmc_priv(mmc);
> >> @@ -1913,7 +1973,7 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
> >>          if (of_get_property(np, "st,neg-edge", NULL))
> >>                  host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
> >>          if (of_get_property(np, "st,use-ckin", NULL))
> >> -               host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
> >> +               mmci_probe_level_translator(mmc);
> >
> > I think you can make this change bit less invasive. Rather than having
> > to shuffle code around in ->probe(), I suggest you call
> > mmci_probe_level_translator() outside and after mmci_of_parse() has
> > been called.
> >
> > In this way, you can also provide mmci_probe_level_translator() with a
> > struct mmci_host *, rather than having to pick it up from
> > mmc_priv(mmc), if you see what I mean.
> >
> > Of course, this also means in mmci_probe_level_translator() you will
> > have to check if MCI_STM32_CLK_SELCKIN has been set, and if not then
> > do an early return.
>
> Testing the translator presence when checking whether its enabled in DT
> seems like the right place, but that's really just an implementation detail.
>
> I am more interested in knowing whether adding
> mmci_probe_level_translator() is even acceptable in the first place. Is it ?

Honestly, I don't know.

I think I need to defer that question to Linus Walleij. And of course,
it would be nice to get the opinion from Ludovic as well.

Kind regards
Uffe
