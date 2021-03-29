Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA3AC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 01:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776DD61878
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Mar 2021 01:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhC2BIT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 28 Mar 2021 21:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhC2BIC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Mar 2021 21:08:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9A1C061756
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:08:02 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id jy13so16892111ejc.2
        for <linux-mmc@vger.kernel.org>; Sun, 28 Mar 2021 18:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=349fMBgcvLa2+pNSfzfycVChb5yT8zGK3bjeXkh2b54=;
        b=tYAV3AJw8goKt1/I7O4N9gCWAgwEW8sSZRa14XT9mZfyxwEeObMDl3W42OIKtzffuv
         hU4x0UFkFi8+rMG3TDwCTx3teYcimezXli/2hwxG0Q2DxNIRn5b697BGR1AIzhlrC3xd
         X2UxFk3DpKTYoYgAbJUWRKnszi8byKrP6EDHBMYS2BLEUN80cmWm+KjJZyYtfjLgZePW
         Vuuvf2SDnJJ14TroALOxjjQEqhnZe5Q9qqrfXSQjR6BM4oC0QryXWiTXQA9AbisGjsc/
         NFRXKpaM31T02m1hkP+9CX+F+RsEb4rigy77KDGuIdsJ8HQzes+kWnK4njaFgdwZwWu1
         y1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=349fMBgcvLa2+pNSfzfycVChb5yT8zGK3bjeXkh2b54=;
        b=sHIWDRFhDKKB46ZYln+kgZX4bVU8tuHNAgQYtJ6U5i42YiaaKRxFtSVremO2jq3faF
         PMjoG9TR/FLsNdzqeftipiFxXPqXpMPMhRk41fHs8/wNIrMRsy4huPxl85VA0rEIZBrO
         FQq2IzDJ704WN31ZXFYpm1Dysub7Sy2eHLAXvxQsttn3nZiMfINhDz2SjQ33GJ6MM6Zk
         4uPEX9wG8VKaQLSnCYjXQY7P303+SxM225ff0+ugbTMwteKVVoxV4L8QUCBavptNtMuG
         nS05rZRDj/13oxbmwolyBKKf7QzjAZok1eXI3bgt1g7N4+El052wmdvV25hp1ahScF6m
         BeXA==
X-Gm-Message-State: AOAM532/jtnyq+lmVWTGmkTJK4RX3JHUGf9oZ/tzDT3x1v4HxJ4EQHf2
        9TqZrafDdNT1EzqOCy4OtT7cLyXtXhrhmJ2u/4Q4Bw==
X-Google-Smtp-Source: ABdhPJzkNiPyCnBppUUGbv5MVnPLDaLWeyH5f2w/Q4QJP77DBRiwNOzHDtPrBNoUB6HHPhXJcxOs61+ET0MKzh7YrWk=
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr25994658ejn.172.1616980080843;
 Sun, 28 Mar 2021 18:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-8-brad@pensando.io>
 <20210304080355.cc37g7jagswro3dg@mobilestation>
In-Reply-To: <20210304080355.cc37g7jagswro3dg@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 28 Mar 2021 18:07:50 -0700
Message-ID: <CAK9rFnwwo6Ww_r4rxcs+QHev4DtqZ-46BTyr3TkePZuoc=fUbw@mail.gmail.com>
Subject: Re: [PATCH 7/8] arm64: dts: Add Pensando Elba SoC support
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 4, 2021 at 12:03 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Wed, Mar 03, 2021 at 07:41:40PM -0800, Brad Larson wrote:
> > Add Pensando common and Elba SoC specific device nodes
> > and corresponding binding documentation.
>
> This also needs to be split up into sub-patches seeing these are
> unrelated changes like device bindings update, new platform DT file.

In patchset v2 this is split into sub-patches.

> What about converting this file to DT-schema and adding new HW
> bindings in there?

Converted existing file devicetree/bindings/spi/cadence-quadspi.txt to
YAML schema.

> > +&spi0 {
> > +     num-cs = <4>;
>
> > +     cs-gpios = <&spics 0 0>, <&spics 1 0>, <&porta 1 0>, <&porta 7 0>;
>
> Oh, you've got four peripheral SPI devices connected with only two native CS
> available. Hmm, then I don't really know a better way, but just to forget about
> the native DW APB CS functionality and activate the direct driving of
> all the CS-pins at the moment of the DW APB SPI controller probe
> procedure. Then indeed you'll need a custom CS function defined in the DW APB
> SPI driver to handle that.

Yes, with an Elba SoC specific gpio driver.

> So that GPIO-controller is just a single register which provides a way
> to toggle the DW APB SPI CS-mode together with their output value.
> If so and seeing there are a few more tiny spaces of config
> registers added to eMMC, PCI, etc DT node, I suppose all of them
> belong to some bigger config space of the SoC. Thus I'd suggest to at
> least implement them as part of a System Controller DT node. Then use
> that device service to switch on/off corresponding functionality.
> See [2] and the rest of added to the kernel DTS files with
> syscon-nodes for example.
>
> [2] Documentation/devicetree/bindings/mfd/syscon.yaml

To us it was more understandable to implement a standard gpio driver
for the spi chip-selects.
