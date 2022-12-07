Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA2CC4708E
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Dec 2022 12:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLGMjM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLGMig (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2022 07:38:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E02842F75
        for <linux-mmc@vger.kernel.org>; Wed,  7 Dec 2022 04:38:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b11so17480762pjp.2
        for <linux-mmc@vger.kernel.org>; Wed, 07 Dec 2022 04:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ucvNHZNte/ZdRHeIRmgjHvKHWkFKvBMtaaEVe13Vh4M=;
        b=WXLZ+B2xPgSVbnqPZUiYGG3CqwtC1NjdTc4KccTYEB61d2MPMGQYcnXjW2aupfVDSN
         vGrz4D9LomnZmRGlC1GOpaQG2QXWX85rRSUecwQ9kIXRv8mi39pbrzG+R3L6H4x3wIbo
         YB9iW5Dlmd0vzQ38AfNHlP5yLLKHb7kO2mXrzfxuENZD72+OZeOQ4n3j+hAa7wmetG5U
         QRGPrIZWmCxTtVHpBFpk9by+m1AAtGTFzuXijHheFKgSvN9857Lxt78bKfqKSR6T5rHo
         R1RkD5fAyS32MMZGbjs/fARQ8tT1zFbXHXqCOfv1neOC3dDTbu09VEInB8d3kSmSd31m
         ANow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucvNHZNte/ZdRHeIRmgjHvKHWkFKvBMtaaEVe13Vh4M=;
        b=xG+iJP8hEV9xntByQ5gCZWgtcm/9HQFMDv6KIRJi82oIMrQLRILkJPUor2vTl2FgCE
         VqSE3tjU/jb7D2Rw98hfbaqcMl3vlNUJ/dGRCU1CfMBPTqYxNR2/0IfSPo1qL3/5J8z/
         nqBPJzBr47dsYS9MHqjh4vb9zgbbntczpM3OFdITvgbyZQrLP8uEc9TS+VA61+Wfjgcy
         I/GISOWAYk8GvHbXF9U6V7V+TJLOgo7nSsYjD0aFs9IRFzS6YLaz0xAncK0h9PtjHx4h
         IVpcuzK8Fyhab5HrTqu+wrKm9Vwlf5/4xZFNx5/eUVdOPuKQJIkiJHcaoVJP+B4Qgj8Y
         hQTA==
X-Gm-Message-State: ANoB5pkvkjYQjtmdifenbmhsvUkAbXPwh4ciiNyweawvWviOGhyJlrd2
        6evEmITuVDlJGp9XnNSK/UMDiQYR8YPrpkEZJOQaTA==
X-Google-Smtp-Source: AA0mqf6SUcJMcmPPi1fpbVuhMZR4wKThmpLCNdmqopUviXPKwN6Vv1y7eisnkhqwWTbpGuM/BEs7sUuqbx5CykbYh1U=
X-Received: by 2002:a17:90b:268b:b0:219:ff4d:b64b with SMTP id
 pl11-20020a17090b268b00b00219ff4db64bmr7547059pjb.164.1670416708665; Wed, 07
 Dec 2022 04:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20221206165945.3551774-1-thierry.reding@gmail.com>
In-Reply-To: <20221206165945.3551774-1-thierry.reding@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:52 +0100
Message-ID: <CAPDyKFr2BzeE6N+ZDXj2HE2SEL30CkpvbsRP4wAPnFRHjP=miQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/6] mmc: sdhci: Add Tegra234 support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Stephen Rothwell

On Tue, 6 Dec 2022 at 17:59, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Hi,
>
> This is an updated version of v12 from a few days ago:
>
>     https://lore.kernel.org/all/20221202152644.29450-1-thierry.reding@gmail.com/
>
> The only difference here is a fix for the included headers (bitops.h
> does not have all the definitions on all architectures, so we need
> bitfield.h instead) and an Acked-by from Robin on the new Tegra-specific
> helper.
>
> It'd be great to see this go in for v6.2 so that the new helper is
> available for the next release and the other patches that I have
> prepared can be merged.
>
> Ulf, given that Joerg has acked patch 1 and Robin has acked patch 2, I
> think the expectation is for you to pick up the whole set.

Applied for next, thanks!

Note that, it seems likely that we may encounter a merge conflict
between the mmc and iommu tree, due to changes in
include/linux/iommu.h. Although, if that's the case, I believe the
conflict should be trivial to resolve, so let's try this and see how
it goes.

Stephen, I added you here, just to let you know of what goes on.

>
> Thanks,
> Thierry
>
> Prathamesh Shete (3):
>   mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
>   mmc: sdhci-tegra: Add support to program MC stream ID
>   mmc: sdhci-tegra: Issue CMD and DAT resets together
>
> Thierry Reding (3):
>   iommu: Add note about struct iommu_fwspec usage
>   iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
>   mmc: sdhci-tegra: Sort includes alphabetically
>
>  drivers/mmc/host/sdhci-tegra.c | 69 ++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci.c       |  5 +++
>  drivers/mmc/host/sdhci.h       |  2 +
>  include/linux/iommu.h          | 25 ++++++++++++
>  4 files changed, 89 insertions(+), 12 deletions(-)

Kind regards
Uffe
