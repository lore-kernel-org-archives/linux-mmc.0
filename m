Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1694CC433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 12:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0462376F
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 12:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbhAVKz1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbhAVJ1o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 04:27:44 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97BEC061786
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:27:02 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id u27so1615717uaa.13
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jan 2021 01:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1OaG7ryvioLgmZ8BmwevSwg84t2pSQg8vMbP0+UiP0=;
        b=FzdovL8pedW1EGTRQAn5/nzwscKjRd9z22SyVGPQQ9V1RYg2rGHC0PnaiCqw4mTrbZ
         xIkeDXRsHnyL3bgoPYVgbcPH1owFWTiHaMTCaz6Ltz5A9owQx3y7yZV8tYoAcBr0czFR
         yUEj0IIoSpbRwoElxpNolfOzbglz6y4y64VlKbHixYwIhnfPH9micI3AwPB4aInHABpH
         GY1R8+rI5lyU24Y+4h59p6x4/jDP2yrBmAyRhnaLhF1FdEERsj5wgZjtnTCr1yJVz+lf
         EBcvS6XVBQ9LNb3T1GwxcmKWrx+Ljh9+KdQa9fz/Qj5ncQtP68hmDLOyj4V13OyciKuy
         k5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1OaG7ryvioLgmZ8BmwevSwg84t2pSQg8vMbP0+UiP0=;
        b=K3hD44S2txuYGc1C6FgxF4J9qvlTEKBfp8+R7oR1wIQMKlB/tLNXhOQMPQE6Sl8Cv5
         bauIlYdlsj7D6i/XTfkGmJ1CZ9cBIjSyf5RpN1G+OW81VjS3qGn16m4r6YTdvg+7Rv5v
         xVwq179mEEHBucOzVhjnpSytVBzT980zT1m65NexsPfu6e45cFFiosI+HqiOR89c0LnI
         veMPz9T8Tn+ee58/zA1kOFdEzl/iT/xQvlf4vMH7SrVQFCoExHiAFB2aLn1gqTXeMQ3M
         9tsYoXdxc9Knyxg6HKSiI+6Gqx8jCxkSVdd5zJ209GR+0TpRlzZrKwVJkWdj13Q4mcnC
         aBRA==
X-Gm-Message-State: AOAM533UrUQjJb2bIGACPfbmCNnecqlVNNgBVbZqenHPbgZqnqJr82HX
        v5ZaxZdVTuGkEQuxCELn7MqzGRwAhp4/jza0s/euKg==
X-Google-Smtp-Source: ABdhPJxGHo6L6iouAbCf6roRPrHn9HTCIERTtLiL2eNSzMh06D8wj3RxbBbFh+YdHQ3u3awZn2dTQI+JIdaaER7XuKg=
X-Received: by 2002:ab0:768:: with SMTP id h95mr2544908uah.104.1611307621937;
 Fri, 22 Jan 2021 01:27:01 -0800 (PST)
MIME-Version: 1.0
References: <20210122032334.3663056-1-andrew@aj.id.au>
In-Reply-To: <20210122032334.3663056-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 22 Jan 2021 10:26:25 +0100
Message-ID: <CAPDyKFoFBoeA0aqnFTNh83QGvb9j6QRwnacXcYFYzKMa_Y9iBg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Fix kunit-related build error
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        brendanhiggins@google.com, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Jan 2021 at 04:23, Andrew Jeffery <andrew@aj.id.au> wrote:
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
> ---
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  9 ++++++++-
>  drivers/mmc/host/sdhci-of-aspeed.c      | 27 ++++++++++++++++++++-----
>  2 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> index 34070605b28b..e5edda6c6e60 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed-test.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> @@ -95,4 +95,11 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
>         .name = "sdhci-of-aspeed",
>         .test_cases = aspeed_sdhci_test_cases,
>  };
> -kunit_test_suite(aspeed_sdhci_test_suite);
> +
> +static struct kunit_suite *aspeed_sdhci_test_suite_array[] = {
> +       &aspeed_sdhci_test_suite,
> +       NULL,
> +};
> +
> +static struct kunit_suite **aspeed_sdhci_test_suites
> +       __used __section(".kunit_test_suites") = aspeed_sdhci_test_suite_array;
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 3b0d381e1215..1446f23a2bfb 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -556,6 +556,10 @@ static struct platform_driver aspeed_sdc_driver = {
>         .remove         = aspeed_sdc_remove,
>  };
>
> +#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> +#include "sdhci-of-aspeed-test.c"
> +#endif
> +
>  static int __init aspeed_sdc_init(void)
>  {
>         int rc;
> @@ -566,7 +570,20 @@ static int __init aspeed_sdc_init(void)
>
>         rc = platform_driver_register(&aspeed_sdc_driver);
>         if (rc < 0)
> -               platform_driver_unregister(&aspeed_sdhci_driver);
> +               goto cleanup_sdhci;
> +
> +#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)

I would like us to avoid #if defined" in code like this.

Can you instead declare a function that you can stub in case
CONFIG_MMC_SDHCI_OF_ASPEED_TEST is unset?

> +       rc = __kunit_test_suites_init(aspeed_sdhci_test_suites);
> +       if (rc < 0) {
> +               platform_driver_unregister(&aspeed_sdc_driver);
> +               goto cleanup_sdhci;
> +       }
> +#endif
> +
> +       return 0;
> +
> +cleanup_sdhci:
> +       platform_driver_unregister(&aspeed_sdhci_driver);
>
>         return rc;
>  }
> @@ -574,15 +591,15 @@ module_init(aspeed_sdc_init);
>
>  static void __exit aspeed_sdc_exit(void)
>  {
> +#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> +       __kunit_test_suites_exit(aspeed_sdhci_test_suites);
> +#endif
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

Kind regards
Uffe
