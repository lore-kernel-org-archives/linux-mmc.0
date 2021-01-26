Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A102FC433E6
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 13:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710652311D
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 13:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390929AbhAZMpb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391766AbhAZJ7F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 04:59:05 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1691C0613ED
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:24 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id i3so1932912uai.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pE2rA9pdzYN1jBerf3WiNVIJAFytpn0jAo9ZFgxO1/M=;
        b=PWynW+CXh4hXQAiqu5QjPRxngJOpBWu8mFFfD1LOUterEjJP2JA3bcmpjyDxfsJj1v
         CxlZ80374cIpax4j4WcF1MhZYkttvyOzEW6oo8S7X9BwVgxxCfBSSUWjBMPZMJzs9PEA
         N660RJ5CFORLMi7jxTE7YVPH1CRRn3Ozv/qDV2pUR6s9MOQd0pOW3S9TH5r1R2kyoo1M
         vSGf3ptxoVDugLJnGO1LhyqQKJp7HxV6iRFqOfZNLAuA29sKSDrublGMOiflxafyVhZo
         lcg1wkryF89SBr5FKK0X+vPIOcjiIocWH1iqYizURpvpd5ZR61qnz63iYdQZVabFx1Db
         TdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pE2rA9pdzYN1jBerf3WiNVIJAFytpn0jAo9ZFgxO1/M=;
        b=j37izSY4W9i1rxuyA4xvm3+17/hlyVZspqgtKVDoy3br0UNrH9ZltTj3JJ1wJ+zQtR
         aC85ITXRq6/O+Yl3RSICs5YHJQSwjqW4sK4q7KJK2I76OH0o1+S9UZrxPt3kA1dNHomd
         rULjdNtGMNo+/WCtJ2OrG4nc/cGKweZPbo0/ZM8aKqWrQn3fSCKlQgcqcCbRCJ1MyUqM
         42KYFLN13/yqbxG4PFP2orHKDeTWAMK1ATZ3CmbAG91zs8PRitW35oSu5dzXFTx4sBc1
         aYJNeLRlquzFzhuhintKBEI/UdBu2sS21MBGeG6SAF7FpmJhdvjTsArBqURkz7H3KHlD
         xkKg==
X-Gm-Message-State: AOAM533SlyH6wzuuA54EDssfkhLTyTHDE/7AOharEkjn3FbO3KQkdgE7
        FYvVZkdJkZFWGWL1lUw2RAs6DO1WGTJFv2nFOn+khA==
X-Google-Smtp-Source: ABdhPJyae6ot/tF1YthYUzztpa6Ynp/4MbV/UMtT5N93AAj1C0LLx6XcahAnytC2zAArK4hVwS1/v1d1JNI/LGAKv5k=
X-Received: by 2002:a9f:2271:: with SMTP id 104mr3460350uad.15.1611655103984;
 Tue, 26 Jan 2021 01:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20210122114852.3790565-1-andrew@aj.id.au>
In-Reply-To: <20210122114852.3790565-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:57:47 +0100
Message-ID: <CAPDyKFomiPX36kyK9mConSJTpRnbKYZaKiSz5pyKGaTJpNE0-Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-aspeed: Fix kunit-related build error
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Jan 2021 at 12:49, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Randy found that with the following Kconfig settings we have duplicate
> definitions (e.g. __inittest()) in sdhci-of-aspeed due to competing
> module_init()/module_exit() calls from kunit and driver the itself.
>
> ```
> CONFIG_MMC_SDHCI_OF_ASPEED=m
> CONFIG_MMC_SDHCI_OF_ASPEED_TEST=y
> ```
>
> Conditionally open-code the kunit initialisation to avoid the error.
>
> Fixes: 7efa02a981d6 ("mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v2:
> * Collapse the #ifdef-ery
>
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  9 +++++-
>  drivers/mmc/host/sdhci-of-aspeed.c      | 42 ++++++++++++++++++++++---
>  2 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> index 34070605b28b..bb67d159b7d8 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed-test.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> @@ -95,4 +95,11 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
>         .name = "sdhci-of-aspeed",
>         .test_cases = aspeed_sdhci_test_cases,
>  };
> -kunit_test_suite(aspeed_sdhci_test_suite);
> +
> +static struct kunit_suite *aspeed_sdc_test_suite_array[] = {
> +       &aspeed_sdhci_test_suite,
> +       NULL,
> +};
> +
> +static struct kunit_suite **aspeed_sdc_test_suites
> +       __used __section(".kunit_test_suites") = aspeed_sdc_test_suite_array;
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 3b0d381e1215..7d8692e90996 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -556,6 +556,29 @@ static struct platform_driver aspeed_sdc_driver = {
>         .remove         = aspeed_sdc_remove,
>  };
>
> +#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> +#include "sdhci-of-aspeed-test.c"
> +
> +static inline int aspeed_sdc_tests_init(void)
> +{
> +       return __kunit_test_suites_init(aspeed_sdc_test_suites);
> +}
> +
> +static inline void aspeed_sdc_tests_exit(void)
> +{
> +       __kunit_test_suites_exit(aspeed_sdc_test_suites);
> +}
> +#else
> +static inline int aspeed_sdc_tests_init(void)
> +{
> +       return 0;
> +}
> +
> +static inline void aspeed_sdc_tests_exit(void)
> +{
> +}
> +#endif
> +
>  static int __init aspeed_sdc_init(void)
>  {
>         int rc;
> @@ -566,7 +589,18 @@ static int __init aspeed_sdc_init(void)
>
>         rc = platform_driver_register(&aspeed_sdc_driver);
>         if (rc < 0)
> -               platform_driver_unregister(&aspeed_sdhci_driver);
> +               goto cleanup_sdhci;
> +
> +       rc = aspeed_sdc_tests_init();
> +       if (rc < 0) {
> +               platform_driver_unregister(&aspeed_sdc_driver);
> +               goto cleanup_sdhci;
> +       }
> +
> +       return 0;
> +
> +cleanup_sdhci:
> +       platform_driver_unregister(&aspeed_sdhci_driver);
>
>         return rc;
>  }
> @@ -574,15 +608,13 @@ module_init(aspeed_sdc_init);
>
>  static void __exit aspeed_sdc_exit(void)
>  {
> +       aspeed_sdc_tests_exit();
> +
>         platform_driver_unregister(&aspeed_sdc_driver);
>         platform_driver_unregister(&aspeed_sdhci_driver);
>  }
>  module_exit(aspeed_sdc_exit);
>
> -#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> -#include "sdhci-of-aspeed-test.c"
> -#endif
> -
>  MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
>  MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
>  MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> --
> 2.27.0
>
