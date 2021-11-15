Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF1C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 22:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FC16321B
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 22:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbhKOW5S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 17:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348790AbhKOWyf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 17:54:35 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A1C03AA38
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 14:06:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so12240216edc.6
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DydRu7SpBSGXsY1o+1JsxVZaNRTPESv1WbRFhErfJMM=;
        b=NsZfxABNmHEDn3cAEnxfzvehuxWUKowwXgKM2/RzHN1gLJBC2Xbn4Kmf7YkcAbdSQY
         Wvjred1hNAkJMPqPI74nlx9auc5zLsTgpHtzZA9DgkYndFOWzEF/M6Xo9y7ScSKQAiRT
         4x6aB4KBn0QPgpWdz6ZmI+xN6jJ9m0Sg72N+L1tk6h2fqM/BY5nX10HGkE9zYHLaZvIb
         QjwndfZqoBl8hupCCgNgE8JcrZ9WWx4h1sIEjiCXAu9KivroAGA8boMT9Q+mTdiBYQmC
         wX+OZ8qBocm1oEPw2/9/Vzz719VkQEz5/GWml2T3umjZ7AgD1MtLVw+rZeRTgQSIQXSP
         Nfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DydRu7SpBSGXsY1o+1JsxVZaNRTPESv1WbRFhErfJMM=;
        b=k4/ADyUQRsW0KYL+vw/V2qXrZcK7f+OvlI7NMVw0jShsFVDg8wS+mnzLGBhW+M7RDt
         Zn5G7vzmmzrTyElDbbMfBO+R/zV7l2la/hsAP1o09s0GpLDD4lkVc9+AAAxtNjGW8Zon
         Td6KGd/g16ps6HJVcQ5geGD4wALVZ7Lb7LPvkFnh8Uox9PIslDGE72KKO4emlI/Zzitp
         JLavRPakmCJbQvkCVrhr9Oiso5PYsA0IYLY7J6K8cPf1ebBbUgV63PfbXnSEX3WVZkZu
         1d568OJVbY/cHv/wsOb0gDRf8q2uTZLLQEzZSfyGjilQbnzeRiDKPbGyWq0WVnRb6Z7B
         FsCw==
X-Gm-Message-State: AOAM5315c3RPw8vTvtJxooCXluZfzZm1tu4028iqtEkl5FcCFbnww+i0
        WKdDmRcAEhYn6ciVALXVhIIh8Mk0Vmpgthgp/QJ4yw==
X-Google-Smtp-Source: ABdhPJwSi1BR2b9pVA2sLcVwhXu9OEXIKNaFyg+koHsL/tNEQcgfiypLJF0L+hXMaCL8HnPm+3CzHQPwuJd+6mtEA64=
X-Received: by 2002:a17:907:1dd5:: with SMTP id og21mr3099771ejc.233.1637013965985;
 Mon, 15 Nov 2021 14:06:05 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-5-brad@pensando.io>
 <20211028072616.p3mazud3vi5jgynk@mobilestation>
In-Reply-To: <20211028072616.p3mazud3vi5jgynk@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 15 Nov 2021 14:05:55 -0800
Message-ID: <CAK9rFnwjDrGO5u83vc19QenFoCmYs07Nzo1N76SsKC8BLXHbvw@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] dt-bindings: spi: Add compatible for Pensando
 Elba SoC
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sergey,

On Thu, Oct 28, 2021 at 12:26 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello Brad
>
> The patch name "dt-bindings: spi: Add compatible for Pensando Elba
> SoC" doesn't mention to what bindings it is referring to. For the sake
> of having a more representative git log I'd suggest at least to add
> "cdns" vendor name in the title, like: "dt-bindings: spi: cdns: Add ..."
> Otherwise it's impossible to understand to what bindings you're adding
> a new compatibility especially seeing you are doing the similar thing
> for the DW SPI in the next patch.

I'll add "cdns" to the git log for the re-spin.

Thanks
Brad
