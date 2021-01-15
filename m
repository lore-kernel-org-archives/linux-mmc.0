Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CFC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16342221E2
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbhAOWsA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWr7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 17:47:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6CC061757
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:47:19 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y22so12034605ljn.9
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JcunmaqxuV2RjWZuDakfWhxW78qDBNreP2tnmJNECY=;
        b=d4cYqIaW97sNeqddOMl6t4zbFsfSnOz6l2Q+adKCLOAKFDpIAwrp4SOPaWqeHFINIU
         p0WEJ/wlkhYhPTATAknESy/DdAq6dQDpR++DmECyVPZS0ylMaljSXvWVCgwT+DZkxLcz
         zSuk4wPeiFMLfPplPY4ifSjk/J/e5ucJLsw1//4KxGcCdiBdvM/k64QUULCZQtQuksFI
         rhZAo+mh8k959nEuIsEHnIqLhY/HMuLXo3Embd2c2GB4jjO9W2Zx/RwFLMnEFwdeIfRO
         coSfZFhysKyh/3uGlmheComNtQuz5QAONiMlcORVXOaL0JUmd/5lhMWN9ER1DZJngKgV
         RkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JcunmaqxuV2RjWZuDakfWhxW78qDBNreP2tnmJNECY=;
        b=fZ6wnYMJiA0La0aM5FMS20LysQqwro4Al0VnWMh1qAWr/0njbHY+IfwTF6jNeMdGKQ
         iMxgs1ubMP+5CYbfCybq+h8NU2RIsywq/lYrFQvYHZVhxskFZ//1i2O2/Y9HjY1ACRol
         iH+dK0qczFTTDh/n51ifS5cEcOv8CLlagnpV5ZhQ+bzmYejZx3r3zhpZpIvxG6Jnlxi8
         lPotDoi2agRApy0LXf5TjGGr1wRvI2FNjQWBQgai5uvNxjeRTqZEkzZT7xAhZY/JSuk7
         cN61796zSHTja4ZlQh7zqGzRaE5lorDDxqB/s8IDDbbqxh82yaQ4MYAhHvafvB+9Gbax
         fjZw==
X-Gm-Message-State: AOAM5335RIuIFM89xaS0HG7u7b4HKU44EmNTipHSzIj+Hmb6obFu0DFg
        9vgzbrhI4plgnNyvIFwM4Bp+5IRGHDpS53ec0BFstg==
X-Google-Smtp-Source: ABdhPJywHaYa2mFTmpDpAbt8I8/ZgHBOUBv+erYIpLSkGqiPcPpS/VQ3WtQXK20h9hLlVX/yH4Zxxq2jd8LM80+6p/g=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr6180188ljj.326.1610750837816;
 Fri, 15 Jan 2021 14:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20210105140718.122752-1-marex@denx.de>
In-Reply-To: <20210105140718.122752-1-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Jan 2021 23:47:06 +0100
Message-ID: <CACRpkda618dRmXKwJyvONoF1Bn-AOZRjaJfVCVPpPetfZny5xQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mmc: mmci: Add support for probing bus voltage
 level translator
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Marek,

thanks for your patch!

In general this patch is pretty much how I imagine I would
have solved it myself. It's a really fringe situation but STM32
is pushing the envelope with this block so here we are.

The pinmux core is definitely designed to handle stuff like
this and I'm happy that it seems to work for you.

On Tue, Jan 5, 2021 at 3:08 PM Marek Vasut <marex@denx.de> wrote:

> NOTE: I would prefer this solution over having a custom DT per SoM,
>       since it reduces the amount of DT combinations.

I don't see any problem with this approach.

>  &sdmmc1 {
> -       pinctrl-names = "default", "opendrain", "sleep";
> +       pinctrl-names = "default", "opendrain", "sleep", "init";
>         pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
>         pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_dir_pins_a>;
>         pinctrl-2 = <&sdmmc1_b4_sleep_pins_a &sdmmc1_dir_sleep_pins_a>;
> +       pinctrl-3 = <&sdmmc1_b4_init_pins_a &sdmmc1_dir_init_pins_a>;
>         cd-gpios = <&gpiog 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>         disable-wp;
>         st,sig-dir;
>         st,neg-edge;
> +       st,use-ckin;
> +       st,cmd-gpios = <&gpiod 2 0>;
> +       st,ck-gpios = <&gpioc 12 0>;
> +       st,ckin-gpios = <&gpioe 4 0>;

Fair enough, when submitting the final device tree, add som verbose
comments as to what is going on here so people get it.

I got reminded that the MMCI bindings are not converted to device
tree so I spent some time on that. I will send out an RFC.

> +static void mmci_probe_level_translator(struct mmc_host *mmc)

This probing function looks good.

>         if (of_get_property(np, "st,use-ckin", NULL))
> -               host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
> +               mmci_probe_level_translator(mmc);

This activates the probing based on solely the existance of this
device tree flag.

It's not a problem in this patch but we should probably only look
for some of these attributes if we determine that it's an
STM32 platform block.

Yours,
Linus Walleij
