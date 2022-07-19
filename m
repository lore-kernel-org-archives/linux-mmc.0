Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC8CCA485
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jul 2022 08:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbiGSImM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jul 2022 04:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiGSImK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2022 04:42:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039462CDEF
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 01:42:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u19so14748266lfs.0
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2022 01:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wnu/3vIy/EyKk8Ed8D6cTFH8iy5jebDSZ/AanZy9t/s=;
        b=do2BHwMsu7F2Z1rq1MpWG2gqnQ1DcjmoS4NUR8B6n3WDVOaTCFynyNxyt7SrK/HPcF
         eAb5C+TWX4ITxCWjvZyUEut0VRjv/liUxMP9/uqWFoPiH51O9kqVxqdyCF1SKGqwRRYN
         T75oPSUR8mkUZG6aiELNof7Cki7xb4PA43XK3eDIw/ZyPZQ6PdJtVOWsvNDuOFYcudfv
         wE3Yw9zDe2wjbyycIDp/TT4XdalYKTI4MVRyYiJB31jqelmjAXki91jHV2sW8AmSfxvS
         IPYv180w7UDXDdWD/sbn6oD/hRfzAk/2CdPpZMP2QLJcmB0Qc1KD24/VnM7zt68lgAuI
         Caig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wnu/3vIy/EyKk8Ed8D6cTFH8iy5jebDSZ/AanZy9t/s=;
        b=jg4LmlG07USRDk9vMtI9Rp/f4Sn3hg+NxzpjMULNMAydU1WSg8PGg1K+e4y5t/0Nur
         U9w19dVtcdzTWuigImC+UfDMbOLc/NLxG8CP88z74ZfaMOZvkG8Dahn6YlL9PsVmvfvD
         rZ4H9d5qB1PA+8tMOd93sR/emoX9thkdCIZMM4UmanvvmTyW+dEtTnKrj0SDfbpAqVnZ
         inl1oEe+Tx6qhyTErdCq+s6aDfkGwFQU/ZWUq8kfH3Ehoi5GNTxePf8kbb+paBLuF+kn
         IjAE7X5z8RnozgxL5Nguu125Sm8OlxxsNymSNZaUZB3RM4A8rRkVOLLOn5BysdGvVPtd
         FK5A==
X-Gm-Message-State: AJIora9tp0Jn+Ci0dHGLAKwu8gj66s9glwotKfdAcKbqsarsxuERytTe
        mxpGEFfKna55TrTp5MLX6apTskHigoHquhOuBO0vzw==
X-Google-Smtp-Source: AGRyM1tIw/nL1JsDz+rLmh9KoRcKXbYbJHhm6a4Q9+Si0H00rIVXplg0s5C+t128uWGdB1HIEC93R143WyiOpvIzb54=
X-Received: by 2002:a05:6512:2522:b0:489:daa9:467 with SMTP id
 be34-20020a056512252200b00489daa90467mr17375016lfb.71.1658220126191; Tue, 19
 Jul 2022 01:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220715040354.2629856-1-davidgow@google.com>
In-Reply-To: <20220715040354.2629856-1-davidgow@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jul 2022 10:41:28 +0200
Message-ID: <CAPDyKFo0AcNayzJa3SZOS4HX3tSBPT57Z+h8cJ9i56uz5ympRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, Sadiya Kazi <sadiyakazi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Jul 2022 at 06:04, David Gow <davidgow@google.com> wrote:
>
> While the sdhci-of-aspeed KUnit tests do work when builtin, and do work
> when KUnit itself is being built as a module, the two together break.
>
> This is because the KUnit tests (understandably) depend on KUnit, so a
> built-in test cannot build if KUnit is a module.
>
> Fix this by adding a dependency on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y),
> which only excludes this one problematic configuration.
>
> This was reported on a nasty openrisc-randconfig run by the kernel test
> robot, though for some reason (compiler optimisations removing the test
> code?) I wasn't able to reproduce it locally on x86:
> https://lore.kernel.org/linux-mm/202207140122.fzhlf60k-lkp@intel.com/T/
>
> Fixes: 291cd54e5b05 ("mmc: sdhci-of-aspeed: test: Use kunit_test_suite() macro")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

I assume this should go together with the other recent kunit patches,
so please add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 10c563999d3d..e63608834411 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
>  config MMC_SDHCI_OF_ASPEED_TEST
>         bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
>         depends on MMC_SDHCI_OF_ASPEED && KUNIT
> +       depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)
>         default KUNIT_ALL_TESTS
>         help
>           Enable KUnit tests for the ASPEED SDHCI driver. Select this
> --
> 2.37.0.170.g444d1eabd0-goog
>
