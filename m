Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7B7C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A973D6108B
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 11:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhINLZn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhINLZn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2021 07:25:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7DC061574
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 04:24:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id i28so23124185ljm.7
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 04:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sQYFflwh2UscdO3zyTRqlybnH5iNH852O9o2kPEEpok=;
        b=yg3Jk74CEsgPN/LNHv15KV1CGB7SPRTuDArAUmTmr8G79zntKVNcBaAJj6IPozA8MZ
         rN1xuBvft0VS7+DHMGbP8hE9nXsJvOOrHWpWjDhbhtvjQtUvgqgaa78mSGrWX6s9OuCh
         wk7ETVZr2czjxf+M9dHc+8UC4kg8IYVlRmIyD1N/nMeGwN+x09s/ug8NYMT3ag6IALwM
         AlQtei/vR1GrXnb3/CflftanOjcM2d6YpQHdyHvDdOsp3C9oj9jSu3XC+K6GA3pavMxn
         rnNAQBbStbJv5sau5KYAHN51oJbzaSrVZ06CKs/CvfobyxAUJYf+8MPW3pmTQwWUK3X5
         R0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sQYFflwh2UscdO3zyTRqlybnH5iNH852O9o2kPEEpok=;
        b=6H0Od02ev9/+QHkHKLaGzyYVStDGrgLb0Pw0K3DXShqzP6yFpkTfWOdgG32FqtCr7g
         b9tUVWRIaGtAnRboER9Nv6IGKltTegUq5no8wCJur0Bj1qThku33c/GHQY+e130aiotp
         cl0MRXwdappShlBMyfM5EsthzIMzDZxZ7JmR8ynpzV05Jzd4sYdkfL/QFDOCRQeqzCyp
         7hzoM8IAvUQSs/y/YCD1/9LnKy6WQW48u5bLOuo3yvw6uvQ6pMTyICycbwCU3cqW1iUc
         o6ft+m4xN+txdeQdEdx0ePhSSwk1Ws4bmDgh8agjYBx4ztDfYEc/AjFQLXvOIErEK+Li
         MyDA==
X-Gm-Message-State: AOAM532Iw+T9ey2cbPqvyhzZyKnHUt0ZJlSMTz0ZZSsfPXRtnKxDYFKd
        DsNBzVQW02yNCW19nC1pwkcPaW4RKrHuzGhazVn53Q==
X-Google-Smtp-Source: ABdhPJxHkgRBr9/+9fH4dstW/KjkgkHVlu1Vx/B9P8GIGFA0lGklTTgO6ruxiP0tMTwe0McNkvfjGekJkulzdjWLUZ8=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr15108198ljh.4.1631618664062;
 Tue, 14 Sep 2021 04:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210829182443.30802-1-rashmi.a@intel.com>
In-Reply-To: <20210829182443.30802-1-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 13:23:47 +0200
Message-ID: <CAPDyKFq2VQ=khYnmfsQGPPcpRnxyATVSpwKSZ4MTbKn64rthVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
To:     "A, Rashmi" <rashmi.a@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org, Mark Gross <mgross@linux.intel.com>,
        kris.pan@linux.intel.com, "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 29 Aug 2021 at 20:24, <rashmi.a@intel.com> wrote:
>
> From: Rashmi A <rashmi.a@intel.com>
>
> This patch set enables the support for eMMC PHY on the Intel Thunder
> Bay SoC. eMMC PHY is based on arasan phy.
>
> Patch 1 Adds arasan sdhci support for eMMC in Intel Thunder Bay.
> Patch 2 Adds arasan sdhci dt bindings.
> Patch 3 Holds the device tree binding documentation for eMMC PHY
>         and listings of new files in MAINTAINERS file.
> Patch 4 Holds the eMMC PHY driver.
>
>
> Rashmi A (4):
>   mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan
>     eMMC driver
>   dt-bindings: mmc: Add bindings for Intel Thunder Bay SoC
>   dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings
>   phy: intel: Add Thunder Bay eMMC PHY support
>
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |  25 +
>  .../phy/intel,phy-thunderbay-emmc.yaml        |  46 ++
>  MAINTAINERS                                   |   7 +
>  drivers/mmc/host/sdhci-of-arasan.c            |  29 +-
>  drivers/phy/intel/Kconfig                     |  10 +
>  drivers/phy/intel/Makefile                    |   1 +
>  drivers/phy/intel/phy-intel-thunderbay-emmc.c | 512 ++++++++++++++++++
>  7 files changed, 629 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
>  create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c
>

Applied patch1 and patch2 for next, thus leaving the phy changes in
patch3 and patch 4 for Kishon/Vinod to pick up.

Thanks and kind regards
Uffe
