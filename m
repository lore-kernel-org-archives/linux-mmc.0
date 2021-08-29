Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA2DC43216
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Aug 2021 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731A060F38
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Aug 2021 21:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbhH2VK0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Aug 2021 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhH2VKZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Aug 2021 17:10:25 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6F8C061756
        for <linux-mmc@vger.kernel.org>; Sun, 29 Aug 2021 14:09:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y6so22403976lje.2
        for <linux-mmc@vger.kernel.org>; Sun, 29 Aug 2021 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxGuGUCOWFryUZD+MaZ59To0anU+4+sFudo5C46Dub0=;
        b=nfV4aILK8Dhh0ahV+TeoNvDhnE+SFerHJVlQxUxDjik6lEG0UgGuflyvtwuZM3YQdm
         4qQpuazJBdWnkrpt4pxqeGR2ZFUjui1ttQiGi0NSY0EcDZ4jZ3R/AQRXWUCIgJP7OVwK
         O45bi3/RbDPtmOwEU4zDvmLxZdYW0R+TNFfnmNx1w2z0ehUmRJXYhtjzBs7s/KsczncH
         QkM250uLLIMG0o3c+ZFspIKI8WbWDbWAIYHmTNRLyNh6FDls+xLNU4mhI437adrXa7+e
         IlBSD8RjKAm0Uyce5YAKTJcXYTWGPHLc5TE08oh4vmz/ETInqZxez23f0cGw8+TXNDTo
         OS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxGuGUCOWFryUZD+MaZ59To0anU+4+sFudo5C46Dub0=;
        b=Dit2qyVzeG37FjCmmuHmM+pxjKhIkSBzZ9H5czz1JqUm6+mwRP71EQzy3ZPubV85oh
         v6BhaFyIv3vLTNWbbLUASWBfw0zRAy6+fV6HhHUFK4ehdm4ID4T+/dPTX1d7T7f5v4tG
         qm45EHRAQP0nq689v396QEyfjxkRYl3E58nXqYjYO/pUwLg/Vvx/GuWbTTpJBnMyubQ3
         Y3U7fclVuyki1Hirbz2toBQ8Tj8evvWI+FHo2Mi+sazLgYXd6bT+9jwVK+JJbWO+AW77
         mgQ8dir66RwjcrBgK7VYvKVqEOmKsc57+5clH2hUxvLaiDO+0RzfTCQNXh3yDqhkq7bR
         PzIQ==
X-Gm-Message-State: AOAM533M0Uo2JNuFho4tukxEndJL1RKLB6JATcoli2q7UeWqOhPaFKNg
        +cyfmsm84gIbuJIoCm0WreNa15dTKhmW9nJaLhJHow==
X-Google-Smtp-Source: ABdhPJyLBGZC3w/XZYPqVgq7E9XJqzge4fnt3b3JacxNwyWo1sRegJwGgEN+8tVF7EFU69+xMuu7WMDdF20ZdQXFkk0=
X-Received: by 2002:a2e:54f:: with SMTP id 76mr17978352ljf.326.1630271370403;
 Sun, 29 Aug 2021 14:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <CACRpkdbQD6p7fbGtuu1c92uXfSFDCTwqjqsXHpgnD5Lg4v0Okw@mail.gmail.com>
 <20210304091025.ny52qjm7wbfvmjgl@mobilestation> <CACRpkdZroi+_oHqipS71MAGif190y7jWU5Myf55vz=_um4w5cQ@mail.gmail.com>
 <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
In-Reply-To: <CAK9rFnzDZ4MNm68AJ75g7zegLD-7UMHyoVR-4ssitYTTEeQm5g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Aug 2021 23:09:19 +0200
Message-ID: <CACRpkdZEURRTe15HGf93SvyHej=_6qhfP9KWPSQbCM=SLUVKmA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     Brad Larson <brad@pensando.io>, Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 23, 2021 at 3:06 AM Brad Larson <brad@pensando.io> wrote:

> The gpio pins being used for the Elba SoC SPI CS are dedicated to this
> function.  Are you recommending that the code in
> drivers/gpio/gpio-elba-spics.c be integrated into
> drivers/spi/spi-dw-mmio.c?

That makes most sense does it not?

Special purpose pins should be managed by that special purpose
hardware driver, DW SPI in this case.

The compatible string etc should be enough to determine that we
need some extra GPIO control here, possibly specify extra registers
for the SPI host etc.

The struct spi_master has a special callback .set_cs() and you
should make this behave special for your special hardware.
In the case of the DW driver it appears that even subdrivers can
pass a custom version of this call in struct dw_spi.

Yours,
Linus Walleij
