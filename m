Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E8C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A674061214
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242782AbhIWSoX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbhIWSoX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 14:44:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1DC061574
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:42:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i4so29806915lfv.4
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLd/BdaqZlC0KRB/JkCwEu5Y3OBwFONiTRcJuhLnYDE=;
        b=mQ3D8nWr8Anm6V9Tt5JigeZHH2N11yXwU72+0TjsPkRqIry+DpbExoz5z2HvyuFM/K
         x/R8GkxeaeA+bpUJwiopaJIL3d3JL6iodn++HjBOI1Mltw0ZhyoK3SJUX/OyHhxAI8UO
         AsSeJ81K5XkNQ8fOYaA5vYmvEudjCidUxvrnxi0biNOw5iL0UH1STY31kE41d7gAQdyP
         P4ng7lsjQzNTzIpws0bbVlMeRqjgBWVsdszTnk06gs37/3TVkUUCUM2nVzb0TjXzsNIf
         EqDUT7kfalS2lWofrn6g06CJSMzXWVevhmIkmYZggdN5adxDj2egDSqn3/byVNORFhjt
         kBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLd/BdaqZlC0KRB/JkCwEu5Y3OBwFONiTRcJuhLnYDE=;
        b=K3mSL4RdRwsnAOEa/oSAWMUFJ6zKLoLs90F6FPiAX3k80W8RXj1QQ6Z7YLUnUmStge
         Mjo2EcomvxvI5rwtDiTGRLYJN6pfbw5DtWPRSnUtaFgw3w+YNzfHLEFkYpS7PGIv9esY
         WiWkY1U90+78MfOVAS6bIz7ODlOpiCVTuhPc6vjJqoCnrkrj818100KDIEOpX/g4ywRP
         Q8F4yp3XQg9OSqGEI9kNphVTzNUFCqfyE/N+yhhG1sVFoOzoHk+WPz0rhRXEMAy+IdLs
         jmJHCHxkLWx/QrGq3L63jC5MkjIEVFxCBuAHRzdw6/jT2akyC9K9i9oLcKtF0qpBWAFd
         ZiVw==
X-Gm-Message-State: AOAM531Kln2YmCrRWRvVHywRqAYi+0WctZXis29GXKcgWi9gHQKwfk2n
        i6+FMm+Yztrhz8Yh+zsyljuMFtpQJVJfNPLDcNXgRg==
X-Google-Smtp-Source: ABdhPJwKC/ceZVeFkHVDWpsiUL2AuORS0rQm5OnsSuTJfc6qjT4zjYVWQocFPvAt9/ZvZW+6iOHfIzVFCWpUSzGmWIc=
X-Received: by 2002:a2e:898c:: with SMTP id c12mr6964298lji.16.1632422569302;
 Thu, 23 Sep 2021 11:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210921110029.21944-1-tony@atomide.com> <20210921110029.21944-5-tony@atomide.com>
In-Reply-To: <20210921110029.21944-5-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:42:12 +0200
Message-ID: <CAPDyKFoxheP2BjGBwf+MMt6hzURi2ymFrB8X9zzO9aQWzatJog@mail.gmail.com>
Subject: Re: [PATCH 4/5] mmc: sdhci-omap: Parse legacy ti,non-removable property
To:     Tony Lindgren <tony@atomide.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Sept 2021 at 13:00, Tony Lindgren <tony@atomide.com> wrote:
>
> We need to support the legacy ti,non-removable property too. Let's warn
> about the legacy property and mark the device as non-removable.
>
> Naturally all the mainline kernel devicetree files will get updated to use
> the standard non-removable property with the sdhci-omap conversion. But we
> also have folks updating their kernels with custom devicetree files that
> we need to consider.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mmc/host/sdhci-omap.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1213,6 +1213,11 @@ static int sdhci_omap_probe(struct platform_device *pdev)
>         if (of_find_property(dev->of_node, "dmas", NULL))
>                 sdhci_switch_external_dma(host, true);
>
> +       if (device_property_read_bool(dev, "ti,non-removable")) {
> +               dev_warn_once(dev, "using old ti,non-removable property\n");

Perhaps we should document this property for sdhci-omap and thus also
set it as deprecated. What do you think?

> +               mmc->caps |= MMC_CAP_NONREMOVABLE;
> +       }
> +
>         /* R1B responses is required to properly manage HW busy detection. */
>         mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>
> --
> 2.33.0

Kind regards
Uffe
