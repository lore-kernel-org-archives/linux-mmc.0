Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A3CC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCCA60FED
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbhI0WeH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbhI0WeG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 18:34:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE82C06176C
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m3so84286470lfu.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SAV2dI3X88ydfOMXbonZID2jQP48rETdyvNKxKLYNPg=;
        b=iOQKOZoBWu6aAtqdhuJBCPRE0R9IxoWYPjReXHRRDRkl5u0y3z+S++TOtHmkW418HH
         k+AXre6ePRj3ux1vuM+IBe/IHdZp31blTPXkVv00rYvqmvbSVz2Puuo6XN9q/SU0yJSP
         U9AnY2+DFE+bV4bYhz5raBwMjZSqYV3kTXOscgQyeiH+MxKkNTk1/rSJdEQM5uRMNhrr
         NFwkFu84W+kT5iiMt7st56R0oBbwGZ0lQd9/XVCy83d27KY7VCu3pheHI0PzUyhOcIPt
         x3UhcbrX4yIJLF/u8CsrGeGbHhfBS4MXjrSNbyjuCAzqmOQZqbS4VqvYDx1a4f3rgLxj
         jWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SAV2dI3X88ydfOMXbonZID2jQP48rETdyvNKxKLYNPg=;
        b=cRsNHMT7TPlOArr9SMrRIzTHZofP5tCfMFs9LoRElwpwh+0qtNYmWlIDjWWeoEk6GG
         F8INbwa3ayTPqGlUR6eVasPh8kSQycmSiJJI9O92NEEL5MugcNBY1+dngQU7Stm3EjcJ
         lFwAhBR0JFHzjzmx+clNKgxfz/iGu3BsNQPBi0OtR6H61a4kj6r+a6n5P68XNfP/WS7l
         r+Rrv0epfgjEzEpBZG7YE01WERUfcE6fRmsl7aefPSF42vxYBoGQw7ZXLUJu9zHqow2z
         fR5Vw35sajJUz+jEfeUusi7G5HRgTpi4+f5jyHCLl8/5qrog+0JdcRr+vallXxSri1H5
         /tgA==
X-Gm-Message-State: AOAM531Wsu1aL4ZToGyYZxEDyO1C2m4hWG4fcZd+gJ3KD8z7Qdb7DFGC
        YS03bj7JbGD1mIB67JiUwxlsOsOzIk7/VvYgZerZtQ==
X-Google-Smtp-Source: ABdhPJxKf8OveAlrAasR+aFk/YGcU6+uIQU0IZmKf/y0+7GbA0Rb/fU7JxpeqlFoOuE6gM97daTIsD26XiHsH04vjDs=
X-Received: by 2002:a05:651c:213:: with SMTP id y19mr2270930ljn.273.1632781946357;
 Mon, 27 Sep 2021 15:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
In-Reply-To: <20210924082851.2132068-1-claudiu.beznea@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:31:50 +0200
Message-ID: <CAPDyKFptb5infBgd1zEQC03kH3Z2sO8zvxV6LMO1fLtk5NZFkw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: sdhci-of-at91: fix for shdci-of-at91
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Eugen Hristev <eugen.hristev@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Sept 2021 at 10:29, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
>
> Hi,
>
> This series adds a fix for sdhci-of-at91 driver (patch 1/2). Along with
> it patch 2/2 replaces a while loop + timeout with read_poll_timeout().
>
> Changes in v2:
> - use read_poll_timeout() in patch 1/2
> - add patch 2/2
>
> Claudiu Beznea (2):
>   mmc: sdhci-of-at91: wait for calibration done before proceed
>   mmc: sdhci-of-at91: replace while loop with read_poll_timeout
>
>  drivers/mmc/host/sdhci-of-at91.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>

Applied for fixes and by adding tags for stable, thanks!

Kind regards
Uffe
