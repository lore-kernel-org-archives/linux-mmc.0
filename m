Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5141C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8008161101
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhKHTFD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbhKHTFC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 14:05:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0346DC061570
        for <linux-mmc@vger.kernel.org>; Mon,  8 Nov 2021 11:02:18 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f4so66320675edx.12
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2021 11:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VD+leqfaw7cvxdr0hdFUU2DCytmZoC8d64RVpkQq7Mc=;
        b=QZxWU12BBlyzV83NZ0nj9FJqE578Gabv8/gbF+d7mLGZ5cQX8AgfwZMd/klbb4Q7nC
         PAFQCWFzxcoO/K4BCuUpp+PjpDMIElcMArXLIRhJcmba/ZnjBsX1DS17Q26OAo2maj+U
         Ppdz+/ge3amaVKLu8Ik9xygjmi+PArEtI3PJbN0TLKBEqgZKrxvWTBHohz5qteRRIRKi
         kMJa4u2ZWtDi4J6FsvAneMAo1DhkXbiNqXeGa8O9eyAvgrcteZ+Ftr3FEUB/ufGHmurG
         xto0fd8hVfFGFGn5C47G6yTijEG16i4Mi4jKLSQh/zc13i5aIjodWmKJN/z85gHv+eNw
         JLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VD+leqfaw7cvxdr0hdFUU2DCytmZoC8d64RVpkQq7Mc=;
        b=GkXddEpnXdezYyBJ84X8uzyub4LhGQl95qTJNblrL+wl+5UZT9VMLfJiOJG0AoEA2O
         Arn8rzIN+9lJamlSac3YOkoAajCGpdTArsBfiRe7es5K8rac2imYOesUOStgK+FXU95B
         MWr6vbr6Wpo6z4quzEnYqSEjxdXqhpTVohJ+msndOet9KPvf8wy1ikHMUlsQ+or7NxTK
         ccBNQt2NUkxFw7XpCHDWVxY3VaG7P+N7wi1cmhWRRQgYg7hdc0SD8MQuo/Ys2kzxK02M
         pcmzSEGdh3xtivSe4jF2Dmbe59u6K1B0OF/OKUHk3WtoddlUHhSb/W7LHFeiVzVGdj6N
         DQvQ==
X-Gm-Message-State: AOAM533/CQ8lBWGbqHQGYZ8x3zflC1lwW6eGae0R94YG3Eun5QiF3PtW
        zUJrcN3mfUvGhNL8kJOAMeWNJF9PORLLEUoqlKVPjA==
X-Google-Smtp-Source: ABdhPJzMqefrKaXcq09jbz4WokOBxPmGYf48od5DTPAH1Xprc6tdW5gTGoen6SETdNxoSREsXucD53VYWn7EbFB3k7w=
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr1896295ejc.330.1636398136568;
 Mon, 08 Nov 2021 11:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-12-brad@pensando.io>
 <20211025091731.GA2001@C02TD0UTHF1T.local> <CAK9rFnx7DgS3TYMmu5NBacV_6WC_UwJ=u7n3e_fGd0RpEcg3kA@mail.gmail.com>
 <YYj7MA4D1zCF39lh@FVFF77S0Q05N>
In-Reply-To: <YYj7MA4D1zCF39lh@FVFF77S0Q05N>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 8 Nov 2021 11:02:05 -0800
Message-ID: <CAK9rFnxzZJyVOtG7kkWkHiOD6_bcZqDp3SXYMiHeCY4RDAsKLA@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] arm64: dts: Add Pensando Elba SoC support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Mark,

On Mon, Nov 8, 2021 at 2:26 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> No; as above, you should *not* use GIC_CPU_MASK_SIMPLE() at all for GICv3. i.e.
>
> >         timer {
> >                 compatible = "arm,armv8-timer";
> >                 interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> >                              <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> >                              <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> >                              <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> >         };
>
> Please see the GICv3 binding documentation:
>
>   Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>
> ... and note that it does not have the cpumask field as use by the binding for
> prior generations of GIC:
>
>   Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
>
>
> If you've seen other dts files using GIC_CPU_MASK_SIMPLE() with GICv3, those
> are incorrect, and need to be fixed.
>
> Thanks,
> Mark.

I'll use the bindings documentation as the primary reference.  The use of
GIC_CPU_MASK_SIMPLE() is removed and tests ok.  These arm64 dts files in
linux-next are gic-v3 and use GIC_CPU_MASK_SIMPLE(1, 2, 4, 8)

./nvidia/tegra234.dtsi
./renesas/r9a07g044.dtsi
./renesas/r8a779a0.dtsi
./qcom/sm8350.dtsi
./qcom/sm8250.dtsi
./freescale/fsl-ls1028a.dtsi
./freescale/imx8mp.dtsi
./freescale/imx8mn.dtsi
./freescale/imx8mm.dtsi

Thanks,
Brad
