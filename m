Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91103C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FC222AAD
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbhAKR2z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 12:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbhAKR2y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2021 12:28:54 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BDFC06179F
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 09:28:14 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id x26so5407vsq.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 09:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxtrHWxEn5bUMT1YsS4xJak6WZ3LC5ZFwiKlIgL1omo=;
        b=A71gURFG+JAwMFNI6I5WAK9XANDMhNAWr4POn2AUQlEdvkwsJ7/VSQdCGErjKXV5qp
         EmUM6zK1BBwo6veYfGpPSqqo8zWMMowJtouUY3jLZ/8FVVIvSj3LBrPXgnlUzB9iiHe2
         2AUn5ipC81UQWtVh+TFCI7pmd07qDT4WA7aEQNs5BtHA73qiXbLa6xjQY87y5lei+SYZ
         puM8Qvp00Ji6ClScOOEEDrYOAYlUKReoQiH4b3cLcQd9QQAV4RoZUi6okPhkewzDQKTg
         899Nq5C5sbZ4i5ff81RuGlf7MytTl3rGk25Y50E1/dbbKmvmAahiBzlVW548zn3X6Q4u
         kFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxtrHWxEn5bUMT1YsS4xJak6WZ3LC5ZFwiKlIgL1omo=;
        b=cSIcAewzxbmJh2CJlS/NHGEIXXZiJzJe/42CgUL2UXGRbtpwNm+MacmElhqn9TtcJR
         sLhlyshCQogj0iXyt3YZAro72pKrpWP3fMsy9o7KWYSpKmNOSHK0QighD08kLizdMUUn
         4WoTZRomsnWpanecPR1kP1r889TPxqikDLxOo56Pn6Pn7bwfHBwDP4lwyiutuxiLOtIu
         P2uw08pLAPiWYvUPW4YEmyxf+Y0EyWocH5eGKrlxtJqryE8PpMUJSQc2zRJDkkRMM6Od
         4J/FFDvv5UdfL4AobA20WAu+Z0AT/ny3ZVLEJsuXdltN4PodvewlOlOh8nsxMak55gUh
         7S0A==
X-Gm-Message-State: AOAM532X3QaKTpe2xIFsRDAvYIHXIP1QzCf9AU6iBhzjKVGtFLR+GfgN
        B65kk3g3cyx/Pkxw8eQq9l+XyZ2hyx51KHwzHEkjxQ==
X-Google-Smtp-Source: ABdhPJz2PaUNjWqohTtK5NDP9MmebHCZkDl6ea631hbTIeDalI6uPANY7p3HgAiMRq0UZvgsY4mymk0qA+XIS/26kfQ=
X-Received: by 2002:a67:fe85:: with SMTP id b5mr648394vsr.19.1610386093673;
 Mon, 11 Jan 2021 09:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20201216074540.30616-1-kostap@marvell.com> <20201216074540.30616-3-kostap@marvell.com>
In-Reply-To: <20201216074540.30616-3-kostap@marvell.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 18:27:37 +0100
Message-ID: <CAPDyKFqDRFoNVKc2e_GYb67dZRUyBu67hOdK_q6Ln3PUAJufqg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: xenon: add AP807 compatible string
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marcin Wojtas <mw@semihalf.com>, jaz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Dec 2020 at 08:46, <kostap@marvell.com> wrote:
>
> From: Marcin Wojtas <mw@semihalf.com>
>
> This patch adds new compatible string to differentiate
> between the controllers versions included in the AP807
> north bridge. Thanks to this change, the SoCs which use
> AP807 will not run unintentionally in the 'slow mode'
> with disabled UHS modes.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 4 ++++
>  drivers/mmc/host/sdhci-xenon.c                | 1 +

Please split this patch, one for arm64 (for SoC maintainers) and one
for mmc (which I will pick).

Kind regards
Uffe


>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> index 623010f3ca89..e9a740ec22cb 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> @@ -27,3 +27,7 @@
>                 #clock-cells = <1>;
>         };
>  };
> +
> +&ap_sdhci0 {
> +       compatible = "marvell,armada-ap807-sdhci";
> +};
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index c67611fdaa8a..add1b4dcd5e5 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -684,6 +684,7 @@ static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
>
>  static const struct of_device_id sdhci_xenon_dt_ids[] = {
>         { .compatible = "marvell,armada-ap806-sdhci", .data = (void *)XENON_AP806},
> +       { .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>         { .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>         { .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
>         {}
> --
> 2.17.1
>
