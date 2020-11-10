Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E4EC4742C
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BD920731
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWZvslnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgKJM0w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbgKJM0w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 07:26:52 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7BC0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:52 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id y78so6910890vsy.6
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4W8LktyG7onvhz7iuqk20AJIpUjKq3xMHse0pFWv98=;
        b=TWZvslnPz8YySVGpsO5yzHiBZEPMJlE/BBkXCxiGhbSeIPfjeP5XBWnMRmL2b4HabH
         ZwstAY4ZcX2J530b0eFNqRLCLxvE7ZbHrsMA8+puUlt98YqaqVGw1To1PCpF/RMYDSDF
         G3bMw+3EfOn3mKzxQhhiD16wRgnsC4sbKq3xYxGnQlkzm3mXnMuJmnW+9ZRYZJM8TT1i
         wcL/k6vF1LMF17OCgUeJ8S26T571vWGr5Jrby0GXWgti1diNpb9Juj2eNgR+CG8wlzI5
         3v/yJ1jmW9rxO4lZgkNNMfrU06euwONRU0SttI87Hl8RiYw94YQZkUaT3MZd1LHI69xK
         Iy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4W8LktyG7onvhz7iuqk20AJIpUjKq3xMHse0pFWv98=;
        b=NG8CplganlKTBFTXXjrIxxh89pk2HGXk8BlJiC3bYEIPZoF0bSDXtVTN/XvBAtOFFI
         YXA8tP+KiLVpf5FQbM8YjiYkgleEjkHtFeeMkfk85FWM1VQJf3X+dkUvwSKwFXZXMS93
         dysIw4UMyhvkipQ028DHKop54IBhXkbkK02jkS22Sl3TkPF7sjbMsfkFLLEu0+Q+VCU3
         6bVtlrXmpHpbjhMcvjt6in2PA6GH1hjgryNfS6m26UyF9gwav5thuU4PkQz72NawI9gd
         dK0LcsZbJ/lJsgRodBTR5zKyhFPoTruXae4zBNUUraABbFrFWgDhpVElAYdhTgJ0QClr
         iD2Q==
X-Gm-Message-State: AOAM533XrtpL8IWK25DpA50Y5j3yDNxheOA9HuqYM1O/LG5cC9zPUfVE
        nsr2vlQcDAMhtrpLCr6Vg82cPXeF9SHKmVy+Y1DZ3dEd5vvIeA==
X-Google-Smtp-Source: ABdhPJwOtgGMkdEQpWz6ZNlbahnehJWyICu6l/4/2k23omLt6ERWrBy8Yzz/zp9nDVm7BLtyfPL9pegmupXDHLm9ro4=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr11065383vsp.34.1605011211392;
 Tue, 10 Nov 2020 04:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20201110071314.3868-1-yangbo.lu@nxp.com>
In-Reply-To: <20201110071314.3868-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 13:26:14 +0100
Message-ID: <CAPDyKFpS-ZT+XuLcW3xekwS+ZT1hh0hr8YRQpfKNw-wdAnhm2g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: handle pulse width detection erratum
 for more SoCs
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Nov 2020 at 08:22, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> Apply erratum workaround of unreliable pulse width detection to
> more affected platforms (LX2160A Rev2.0 and LS1028A Rev1.0).
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for fixes, by adding a fixes+stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index bb09445..ab5ab96 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1324,6 +1324,8 @@ static struct soc_device_attribute soc_fixup_sdhc_clkdivs[] = {
>
>  static struct soc_device_attribute soc_unreliable_pulse_detection[] = {
>         { .family = "QorIQ LX2160A", .revision = "1.0", },
> +       { .family = "QorIQ LX2160A", .revision = "2.0", },
> +       { .family = "QorIQ LS1028A", .revision = "1.0", },
>         { },
>  };
>
> --
> 2.7.4
>
