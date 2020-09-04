Return-Path: <SRS0=Rn8H=CN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE36C433E2
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 09:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B28F205CB
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Sep 2020 09:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20150623.gappssmtp.com header.i=@timesys-com.20150623.gappssmtp.com header.b="SwjWcxsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgIDJfA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgIDJe5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Sep 2020 05:34:57 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD37C061244
        for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2020 02:34:57 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j188so3315721vsd.2
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2020 02:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SfYrlt1pTThedsoIZe2QLRXAwAaeRlWqrDY4GdWYjI=;
        b=SwjWcxsbWuDyttEtxSIAeypJyyg99LX/GpJxpD6wWiLprg4jddcEGkpL+oOmOHa9GP
         g5Z56yBB14f2sPNqUf5Rdw59GdOiHghSkGP9/OjWkc3Qyqe7mr7koH1gX9RRJiWoQ7Hy
         2GaTzbeQbMo/WssCBp+jfrlTU8qQpy9cliZ4FwQ3IPAzqZuV0Udeh99BVTkxxrXN2On5
         nBojWBFq84ba5bNdXoW8v14edMdR77JM+dML2fBKrsByg17JAxhsojAG0fsz7cBFXj+I
         0Y797VjYIFPbTXciWlSHyASRHG5oZXxHfCNgkCTB8Vj5EIuPuqkH/ehC0lmhfU6/qxGP
         +Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SfYrlt1pTThedsoIZe2QLRXAwAaeRlWqrDY4GdWYjI=;
        b=M2WNsFNVeqeWwVwr5PI0c2UB+GNB5sk8mjocNQ7MZ4HhR8jKPDRquMVJ2Yh7LiyHGl
         gFp8qX8nH/Sqd679uc7tz2Y/EIQ038atPA2wgTDbnwhEI9x+cebexJNH//qw/IAIPuXr
         8Yp4Ovl6Tf8lU5ijHAcCEb39eWsL1a0xY7ND1zdiYxO98G5n8Moff61h683Hq3LvsUXy
         k5qA3q3+sSeOVK1I1lmsVmw3rNepRzvFd7I2bQTaT9gMI60uo6w787B/uPKRbxzQCQ9F
         4MHeIUrH7Z0XDSkSoosKTFzs52peipbOQ1zzzllote7ONc3ZWOFVaVve2GDzTbkkSooe
         YwFw==
X-Gm-Message-State: AOAM531bY+z4MtJFE/V6pnM5ytS9PtqYo5SK6nHx4gHnvuD1RqoAhekQ
        Celm+3N2HY72LfO0uYDzFIXvOaOm9nfYQXeedUd+GA==
X-Google-Smtp-Source: ABdhPJxacwu3pL1dM+zWIp7Ijxi6mSRw1vnot6j0sDxK1j9djr5kKljWunjtcdBgDV9jaFt9vJGeXmbRsSvwHTuJsBc=
X-Received: by 2002:a67:b90c:: with SMTP id q12mr4898758vsn.171.1599212094639;
 Fri, 04 Sep 2020 02:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200903232441.2694866-1-dianders@chromium.org> <20200903162412.6.Ib121debfb18e5f923a3cd38fe9c36aa086c650c5@changeid>
In-Reply-To: <20200903162412.6.Ib121debfb18e5f923a3cd38fe9c36aa086c650c5@changeid>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Fri, 4 Sep 2020 11:33:58 +0200
Message-ID: <CALJHbkBKQKzqB=m5h8FtRkYptH6pd8UDbfhg0i6QmjyjMi9yzw@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that
 are newer than 5.4
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, swboyd@chromium.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 4, 2020 at 1:25 AM Douglas Anderson <dianders@chromium.org> wrote:

> This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
> probe") but applied to a whole pile of drivers.  This batch converts
> the drivers that appeared to have been added after kernel 5.4.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 1 +
>  drivers/mmc/host/owl-mmc.c           | 1 +
>  drivers/mmc/host/sdhci-esdhc-mcf.c   | 1 +
>  drivers/mmc/host/sdhci-milbeaut.c    | 1 +
>  drivers/mmc/host/sdhci-of-sparx5.c   | 1 +
>  5 files changed, 5 insertions(+)


[snip]

>
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-esdhc-mcf.c
> index 71bf086a9812..ca7a1690b2a8 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -509,6 +509,7 @@ static int sdhci_esdhc_mcf_remove(struct platform_device *pdev)
>  static struct platform_driver sdhci_esdhc_mcf_driver = {
>         .driver = {
>                 .name = "sdhci-esdhc-mcf",
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>         },
>         .probe = sdhci_esdhc_mcf_probe,
>         .remove = sdhci_esdhc_mcf_remove,
>

Acked-by: Angelo Dureghello <angelo.dureghello@timesys.com>
