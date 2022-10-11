Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDEDC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Oct 2022 12:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJKMeJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Oct 2022 08:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJKMeI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2022 08:34:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D073C1A
        for <linux-mmc@vger.kernel.org>; Tue, 11 Oct 2022 05:34:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x6so13042537pll.11
        for <linux-mmc@vger.kernel.org>; Tue, 11 Oct 2022 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GRrUWenaqh6VKLU3VCogfj+LN1gtoIMhQ34n8miswGo=;
        b=n0TisemITtLvCmpzeT6B1nL6BL12hI4RRK9BKQFG1JVrNkUU8xHqBr/kj/0P6dQe4c
         MqFvQHAm4sV/IXQx3BMgj6I0p5flUIthSaeCB/97sZlDG0JwxJFnt6M+QkTZ5Y2Zh384
         XOr9VtMH9mFi01UfYhHPHVE0IMfydTzvN6nhIwXvRJ17g4A5pw5uJkYL4kXtKPNhvkE2
         GJVB9mhejySWuaHnJM9kfcVWObCn4PKXPbWd1nvUH/WurVnea1Z+nLh3GIvueI3XXAVQ
         eccDewB/409zbCo9O2ApzsmFQ8kN0Do3D/GRDTa7Qm/PT1qCzVTsNtynyMoia/3ZneL0
         bSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRrUWenaqh6VKLU3VCogfj+LN1gtoIMhQ34n8miswGo=;
        b=RVzdtLzlXX2pFRxRCtHZ5dDlkkh6nTanjkufZy+rigOi+8qli/dRsmcQIeM4PN47b8
         aWqCTXfM13Y97NF7WsIxlyIOSrgp+RmvHeT7fk5maERXHCIV27iXE2u+RNEbx5f5inpF
         fwDtSpNWVzFL03D3tO58ANAj9b6xsJvGybYIZZHsX6ORG8XC7BmxXTV3+LP/rNYcIznl
         6CONiKMPr4R2U/2B6cdXnBdEYVeKKwe9Ushi1674iftyvdon5O/qfNRz9OHlboxJOa7m
         +yTBPheYZfNHCmr6v4j5vU5MXADRW1q5a+h432q/Kt8q/9avrdciAy5N0EQg4WRNIfbQ
         c5Dw==
X-Gm-Message-State: ACrzQf3w06qtPkjgZBP9IlU5E0TqpYNfZhyaWfniinW1qccrfnXIL87i
        IH0D8+mWg9aItLNLAkalbcqGaS/z95gfg4S98RCFmw==
X-Google-Smtp-Source: AMsMyM5kGpIgK+2qkllcQJjzHDW3VzrbrE5bqXlGS+Qs+8V81zFp5lKejVOw50LHSxGOvdI7ObVrjHDu7c99rO7fI1w=
X-Received: by 2002:a17:90b:1d8b:b0:20d:30a5:499e with SMTP id
 pf11-20020a17090b1d8b00b0020d30a5499emr14653471pjb.84.1665491647339; Tue, 11
 Oct 2022 05:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6zfrVq9cP/wrJb@orome> <20221006130622.22900-1-pshete@nvidia.com>
 <20221006130622.22900-2-pshete@nvidia.com> <CAPDyKFr_Yi2EgrBUzsORnM4mOkf25WR8+7_dfF2h4XzRDPm9-w@mail.gmail.com>
 <DM5PR12MB2406610AB26183BACB19EED6B7239@DM5PR12MB2406.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2406610AB26183BACB19EED6B7239@DM5PR12MB2406.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Oct 2022 14:33:30 +0200
Message-ID: <CAPDyKFqn2jMVQ5BAOZPFx2OOyMRQvsQ1E7mGAQp82x5+v6aSGQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC stream ID
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 Oct 2022 at 13:44, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> Hi Ulf
>
> The initial patches were without the #ifdef. #ifdef is being added as per review comments and kernel robot errors.
> Following error was detected by kernel robot
> >>
> All errors (new ones prefixed by >>):
>
>    drivers/mmc/host/sdhci-tegra.c: In function 'sdhci_tegra_probe':
> >> drivers/mmc/host/sdhci-tegra.c:1794:54: error: 'struct iommu_fwspec' has no member named 'ids'
>     1794 |                         tegra_host->streamid = fwspec->ids[0] & 0xffff;
>          |                                                      ^~
>
>
> vim +1794 drivers/mmc/host/sdhci-tegra.c
> >>
> Adrian also pointed out this issue so to address these issues #ifdef was added

I see!

In that case, perhaps we can add a "depends on IOMMU_API" in the
Kconfig instead? Or is the tegra driver used on platforms where
IOMMU_API could be unset?

[...]

Kind regards
Uffe
