Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB35C433E3
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE84E207DA
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NTh8RyTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHUNED (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgHUNEA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 09:04:00 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7C4C061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:03:58 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b16so428885vsl.6
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wesd22SaH/Yu10jo2mpmrtMJ3o0MXxuO8DPBgj5gKOU=;
        b=NTh8RyTmUKZNAmfZCw6zvzkEfSZHiAjvFUksKtYHD9TnfvQJFcp3drW1N1ohf4v59c
         fzW6R+NZvRVRHuIs0w+PDW6Z1phFENujlIcqHtsxcoxRWcWwWmAscNXamwwebnA3s7ZU
         Tsd8cNpWy+0YDRE9JyoKJ84DmhPtIJ2Bl/6edB9mLYbPJqYKjDMRzg4JR7iWZfDlUf4W
         jxwdnX06nKNxAxlaodBuk2F8NlYfimmto9oXah5BuaaMb+MiJPOeaCJuwF6XBUwp0XYS
         YjGYuEBuhv+YE+ulZfg1oiD2Jdsh/typWpzRG0q3UDPiKOXld+KXIzXh2tdGjUclim0S
         VO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wesd22SaH/Yu10jo2mpmrtMJ3o0MXxuO8DPBgj5gKOU=;
        b=KlrunXB2jeKB1xF7V7w8WSiAFnTJBrhKWnwW11CIgnxHFicHg25/XH7iydDfDQCVVA
         Rn4No2bs7+lh9SvhII3sEqLVdDh6R/jazL8dU85MOE8khHNlxL6A7EOE5AP3wwdzipxS
         bL1cBo0N5hiyULrN4s/kslqkakLBS+mmz9zAiNdJna9S5j4TuwrD00ykB90Rd418phYw
         QGFouWDsCFdBqwrJUPuZFCFIny8bK7XLc8DFc7a3JigMoGWrRfCGVOk9cbWi5afc6pi3
         0nvSd2wuGE9dWfnjl9WJpND6unqI+ILPI38ETtjTbMrWmAAKX+mI9ggimgVl0wAN0tyc
         LVag==
X-Gm-Message-State: AOAM531usJA8KUMVPnEYQCkhg7ChM9diFqoagrUnI07OYwBAZFHZLn00
        TJWKTTMZMWh9O5rRaGeyiYgFxjlZo9sHA+v/Z/BcaA==
X-Google-Smtp-Source: ABdhPJxKQlNajf9FNzPaKAATRgV0WhnFcDv8qBxSJNGexjRHXge8jJrzZV66RbH0DI/FiCkxBez3kUyWKFq8jMAyaAQ=
X-Received: by 2002:a67:e9d8:: with SMTP id q24mr1516889vso.165.1598015037799;
 Fri, 21 Aug 2020 06:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200802070114.9624-1-faiz_abbas@ti.com>
In-Reply-To: <20200802070114.9624-1-faiz_abbas@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:19 +0200
Message-ID: <CAPDyKFq79ZdseQkgP9XxwdmQTBzMsfRPz54663njXrbzKgsFxg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Document bindings for the
 host controllers on TI's J7200 devices
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 2 Aug 2020 at 09:01, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Add binding documentation for mmc host controllers present on
> TI's J7200 SOC
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> index 6d202f4d9249..b49cbfdd679f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> @@ -12,6 +12,8 @@ Required Properties:
>                         "ti,am654-sdhci-5.1": SDHCI on AM654 device.
>                         "ti,j721e-sdhci-8bit": 8 bit SDHCI on J721E device.
>                         "ti,j721e-sdhci-4bit": 4 bit SDHCI on J721E device.
> +                       "ti,j7200-sdhci-8bit": 8 bit SDHCI on J7200 device.
> +                       "ti,j7200-sdhci-4bit": 4 bit SDHCI on J7200 device.
>         - reg: Must be two entries.
>                 - The first should be the sdhci register space
>                 - The second should the subsystem/phy register space
> @@ -33,7 +35,9 @@ Required Properties:
>           These bindings must be provided otherwise the driver will disable the
>           corresponding speed mode (i.e. all nodes must provide at least -legacy)
>
> -Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
> +Optional Properties (Required for ti,am654-sdhci-5.1,
> +                                 ti,j721e-sdhci-8bit,
> +                                 ti,j7200-sdhci-8bit):
>         - ti,trm-icp: DLL trim select
>         - ti,driver-strength-ohm: driver strength in ohms.
>                                   Valid values are 33, 40, 50, 66 and 100 ohms.
> --
> 2.17.1
>
