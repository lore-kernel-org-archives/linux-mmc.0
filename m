Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6DAC54FCB
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B682075B
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 16:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fEHgLHot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgD0Qd6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726499AbgD0Qd6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 12:33:58 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A467C0610D5;
        Mon, 27 Apr 2020 09:33:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so14581307eje.13;
        Mon, 27 Apr 2020 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cf6K3gKCGK+tevU6SOIQu2ZyhbrY799GzvMTpffec20=;
        b=fEHgLHotmQ2/QZ9izNQI6Vaz8wS10CiCmWkvWWqUdsrKNl3IllAOIGjxPmPHDbKZmn
         oRJ77Jcoq+oxmN+XLL6SJm0VlYl3X0Xl2ilO8OS3cK1T4w7BDCrYFwTmGr2HE1x96bZf
         bIKAbQVM6yyXK8MHg4AUaJE3af9PkXwIl/27vAh64P3TZDA/SkshLtrD3ea1beLLX8EY
         jCGatrJEfR8rnqop+kn5Ua6Jx4IAeIUwp9jsBSCDsSwa7r/FACxpEZRydrLYzbiZ7lAn
         VxWYFeNWvvkQcsthLYaHlA+p+TKz0GViDKM/qP2boJDJITlanRqF5FgeT7wKGxOPC2kZ
         EPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cf6K3gKCGK+tevU6SOIQu2ZyhbrY799GzvMTpffec20=;
        b=nLN2lFmLPGuTqTISDsyNlCaK2Ceuf8o1dBZrD+j2fLP3CjTgRW7sPJ+WsrpK8IPsKr
         bhq4TbHZIH0lAjVPM9BuiQrZw6+6fH8Pk9XSgIJmCBGthslmcdKy5x+PLSEOfE5Xc7N5
         Rh2WfFq647MPOo1c/YxJ5txbF+iUyqUbKd08n75A4qadIXZz80NF1s9CqcyPYMRvEW6t
         IilsIGBPrp7GDSy1H3PzV0V6+BgzzpOauuyyy5DApvCCUTgLZLx6hHi0hOwR6G3k/Jw6
         nixjPOutkgtigxb5ZUqDWThWRHC2K2TxiicNkWBuUypmI4ZCwteK5FV+R0Hb9Eo8wtH6
         C4qA==
X-Gm-Message-State: AGi0PuZq7Ai85fMaKtjkFH5nWd3JvZk8In8nli4EYaP7jtPDKIbS7ydv
        CcbzZDfZB7pj9z5WfKiIOJhpfCUBWLi6LvVoi08=
X-Google-Smtp-Source: APiQypIxi9PVa6BSrsdK7HKl/F5E9nNV2Zxh8LSFeUs6LEBcQQ6x7m+p/fR1cdSqN4+y8qa2TCS1gaPOrQrL2MFzQ2M=
X-Received: by 2002:a17:906:1199:: with SMTP id n25mr21359264eja.30.1588005236702;
 Mon, 27 Apr 2020 09:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
 <20200328003249.1248978-3-martin.blumenstingl@googlemail.com> <1jd07t2ucy.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jd07t2ucy.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Apr 2020 18:33:45 +0200
Message-ID: <CAFBinCCRE9ceErVVQJ=prDp5+srpcSM6oqNkgwznYq8awNpQ3Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] clk: meson: add a driver for the Meson8/8b/8m2
 SDHC clock controller
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, yinxin_1989@aliyun.com,
        linux-arm-kernel@lists.infradead.org, lnykww@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Jerome,

thank you for looking into this!

On Mon, Apr 27, 2020 at 10:41 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> > +#include "clk-regmap.h"
> > +#include "clk-pll.h"
>
> If you need the pll clocks, it should probably appear in the Kconfig
> deps as well
this driver does not need "clk-pll.h"
good catch - thank you

> > +
> > +#define MESON_SDHC_CLKC                      0x10
> > +
> > +static const struct clk_regmap meson_mx_sdhc_src_sel = {
> > +     .data = &(struct clk_regmap_mux_data){
> > +             .offset = MESON_SDHC_CLKC,
> > +             .mask = 0x3,
> > +             .shift = 16,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "sdhc_src_sel",
> > +             .ops = &clk_regmap_mux_ops,
> > +             .parent_data = (const struct clk_parent_data[]) {
> > +                     { .fw_name = "clkin0", .index = -1, },
> > +                     { .fw_name = "clkin1", .index = -1, },
> > +                     { .fw_name = "clkin2", .index = -1, },
> > +                     { .fw_name = "clkin3", .index = -1, },
>
> When fw_name is specified, setting the index is not necessary
noted, will fix this

[...]
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "sdhc_div",
> > +             .ops = &clk_regmap_divider_ops,
> > +             .parent_data = (const struct clk_parent_data[]) {
> > +                     { .name = "sdhc_src_sel", .index = -1, },
>
> Any reason for using the lagacy names and not the clk_hw pointers ?
> Same comment for the rest of the clocks
indeed, there is a reason and it took me a while to figure out
__clk_register will set hw->init = NULL;
This means: if we unregister the driver and register it again all
hw->init will be lost (as it's now NULL)
This is why I am effectively cloning (devm_kzalloc + memcpy) these
clocks which only serve as a template
Due to this I can't easily use a reference to another clk_hw

We don't have this problem in any of our other clock controller
drivers because these cannot be unloaded

[...]
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "sdhc_mod_clk_on",
> > +             .ops = &clk_regmap_gate_ops,
> > +             .parent_data = (const struct clk_parent_data[]) {
> > +                     { .name = "sdhc_div", .index = -1, },
> > +             },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_GATE,
>
> Why can't the clock change rate unless gated ? Maybe you prefer to
> change the rate in the mmc while clock is gated, but this is the
> handling of the clock by the mmc driver, not a constraint of the actual
> clock HW, isn't it ?
>
> Also, this is a gate so I suppose the rate propagates through it ?
> Can you explain why CLK_SET_RATE_PARENT is not set  ?
[...]
> Ok so apparently you only want to set the rate through the RX clock.
> You are free to call set_rate() only on this clock in the mmc driver.
> However, I don't think this should reflect as clock constraints.
I think these two belong together
looking back at this I believe that you are right:
- CLK_SET_RATE_GATE should be dropped because that's not a constraint
of the clock but of the clock consumer (MMC driver)
- CLK_SET_RATE_PARENT should be added to all clocks because rate
propagation will work for all clocks

> > +     },
> > +};
> > +
> > +static const struct clk_regmap meson_mx_sdhc_sd_clk_en = {
> > +     .data = &(struct clk_regmap_gate_data){
> > +             .offset = MESON_SDHC_CLKC,
> > +             .bit_idx = 12,
> > +     },
> > +     .hw.init = &(struct clk_init_data){
> > +             .name = "sdhc_sd_clk_on",
> > +             .ops = &clk_regmap_gate_ops,
> > +             .parent_data = (const struct clk_parent_data[]) {
> > +                     { .name = "sdhc_div", .index = -1, },
> > +             },
> > +             .num_parents = 1,
> > +             .flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
>
> ... now I lost with these flags. I'm sure there is an idea related to
> the mmc driver. Clockwise, I don't get it.
indeed, just like above I'll fix these


Martin
