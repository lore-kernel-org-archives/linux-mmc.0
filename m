Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A144C2BBCD
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4F24078
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 13:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389886AbgLKNrw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389237AbgLKNrm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 08:47:42 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98287C0613D3
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 05:47:02 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id s23so2856422uaq.10
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ6vQHJKZTiZ2neB0QETD39X3O36ySzuaJhj1IGyfyc=;
        b=NJB4v2zz4yNRj0vxmnECFk3OO77v0K7MHZWPaAIeYOxrBDXqv5IfPx/9Y8aIYybanK
         2uOjtOhwUklDbSdSSpy2FOHbgt7NJAlsSrHa2XQF4H8RENznWvDf9yuJNXhY5u7AEbNi
         54jgqJHb9Z/Ld3eYJ5z6pTvvh39IoGWTJu8oJsglxH3uWRG5gTewymRSKuje1/3aQC/W
         T5BmxG/SsNSUELu0V7b/oIx4sCj3kGXfJ2CgdH7E4a69S86SklCWHO7NRIaOowKQUpWw
         4jaNg8CSvE0AcI3DzSjbDr6kG3LhK+3Fkybda/eZHN7P5QNFA1kBSc7PBlRH9470AINW
         4C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ6vQHJKZTiZ2neB0QETD39X3O36ySzuaJhj1IGyfyc=;
        b=anaPjSo32SqJvTSHXAXGkr0LnxHD5B6XhneLC5Unjqd892ALh2G7ZGXgiCAoasY4+e
         hB8/5Ci7PNN9ErqsPx6LQS8eOzh9xPviS65JU/qeY04sqNNv3IbaLbGy3d8KoB9GQXL0
         FRAUN+HvNdMUfqxVyKVBctILpyXOivgrBhRyA00RvgKV0i8cr47LdcxjgYV3ajurhvEX
         dOSKNMXUCC88hO3MOi2YLcwgvrYpcUtMQUuPisEQAfuRCCa8ZET/MIa5Kf/HdrLlPSQr
         cCgd1S3bfYgdaIN1LIu4h7V6sXS2M1lx5u+wVeQTt8GA3ATXtye//HXgJkemuXLhpNPF
         zzcw==
X-Gm-Message-State: AOAM5321lgxi0RxqlUV5Ed/unQEm58Prj5KoeDmWO17KQXgY1tgp1kt7
        XLbEPNd8wem2kFV0htwYUf11QVY6V9MtsMNCf6YhBA==
X-Google-Smtp-Source: ABdhPJyMcAJGiEh2yGNmjbTir7D0bwRrjvDUGQ4zl8dEGa8gcjgCh3wN7tnbZ4EWFh80oTSdtLpxMiGwzhuE8yVJKCU=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr12418198uad.15.1607694421515;
 Fri, 11 Dec 2020 05:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20201204171626.10935-1-mw@semihalf.com>
In-Reply-To: <20201204171626.10935-1-mw@semihalf.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Dec 2020 14:46:24 +0100
Message-ID: <CAPDyKFooRuitBjVr7FoMbty3rmM3eOsLKqwF5=ZQ=Aj6r29h+A@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] sdhci-xenon ACPI support
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>, jaz@semihalf.com,
        tn@semihalf.com, ard.biesheuvel@arm.com,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Dec 2020 at 18:17, Marcin Wojtas <mw@semihalf.com> wrote:
>
> Hi,
>
> The fourth version of the sdhci-xenon ACPI support
> addresses a comment regarding clk handling in xenon_runtime_resume.
>
> The MacchiatoBin firmware for testing can be obtained from:
> https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp
>
> Changelog:
> v3->v4
>   * [3/4] Call clk_prepare_enable unconditionally in xenon_runtime_resume.
>   * Add Adrian's Acked-by to all patches.
>
> v2->v3
>   * [3/4] Call clk_disable_unprepare unconditionally.
>   * Add Adrian's Acked-by to all patches.
>
> v1->v2
>   * Split single commit to 4
>   * Use device_match_data and dedicated ACPI ID's per controller
>     variant
>
> Marcin Wojtas (4):
>   mmc: sdhci-xenon: use match data for controllers variants
>   mmc: sdhci-xenon: switch to device_* API
>   mmc: sdhci-xenon: use clk only with DT
>   mmc: sdhci-xenon: introduce ACPI support
>
>  drivers/mmc/host/sdhci-xenon.h     | 12 ++-
>  drivers/mmc/host/sdhci-xenon-phy.c | 40 +++++----
>  drivers/mmc/host/sdhci-xenon.c     | 91 +++++++++++++-------
>  3 files changed, 91 insertions(+), 52 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
