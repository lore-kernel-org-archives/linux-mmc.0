Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5DC11F68
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 15:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833F761DC4
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Jun 2021 15:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhF2PMM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Jun 2021 11:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbhF2PMK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2021 11:12:10 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E6C061768
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:42 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id x12so12306582vsp.4
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2021 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXuvrGXYUxXy9/lulPSWcn0bolQxzyqDcFS2NkcYzFQ=;
        b=PsqWuA3MgKXFdeJpydSSaUX4iRJscYde4FYY9FC1Vp6SUApy3VS9jFIq44dWJDWy+G
         /qRAlYLPWN4IH0azuguGEt4XAk1Wm0m0ahPqsMgU5JAJ9iyIsQqMIAt8EUaZtj4d1uR+
         ltgPVmU9qCMuYOPPSRxOcoGExwXAPOs0l8Uw69bmGsXN9q1TDpIr7K8YG5QGOk0RINrl
         1DUnnuQt3zG5Cezr6xyHeqB4buf9bNPtLav292wBKOv27WB3wsdYrANPZT242GVfrqmZ
         Kk/ZBuyNfLr+/ZsGx1KoxlhjlY2SAEIVCeOWmctiBGGfKP+2KI2+n1iWEUZo8wdL7gD2
         A63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXuvrGXYUxXy9/lulPSWcn0bolQxzyqDcFS2NkcYzFQ=;
        b=pOLHoPwO+yMPerxfw7fx08v6UZ3X4DgW6xsyt+RQLp/ILwlOC5N1XUtG1U8hJUtjO4
         RG0j8cChjCVm4OFC4iLm9pF7+WlXuE1KskcAkwy+0KyAFWf1+djXrVdKx8ud5C6RZqh9
         HCmGT1BIrk8IrdRGcgAjHPS37kSC3WBdksibg7MsIO6aN76IfyhWyFpSAr5YVDTxNSCo
         LHVz4oIIAvusT+t6uou2IRY/JwVESHW7X74/zORkeLliVQ4bgFnzPFLvKsFvlThhhS2j
         8A69wHgn2Hp1J1lRbvkOx5Q1dCVfyhiOzYpNzv04w/MH3FnOhk6IOeoeKaDps7/5JWvo
         xVeA==
X-Gm-Message-State: AOAM530p3cSTuGTmbRFAxLD2OoviY7RvyysP0L4XpBi+cwpkhIrbWclP
        f7EeQQGXLPIPNv1IcsmSc7pt9U9OIIj99DXQWDQKtQ==
X-Google-Smtp-Source: ABdhPJw48x0xfIskx4l4Q7ieI3D1o6BYbLmZddG/rGW9xdUFWc1H4M7geSWAqhbbUc6zsmZx3Mwo/GcI2qN+jiraJWY=
X-Received: by 2002:a67:8783:: with SMTP id j125mr1851017vsd.42.1624979381926;
 Tue, 29 Jun 2021 08:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Jun 2021 17:09:04 +0200
Message-ID: <CAPDyKFqd13OZ75G98a2KjAc_KJpGu3b1Bw+Y0OiuUhB6gVBSGg@mail.gmail.com>
Subject: Re: [PATCH 0/7] sdhci-of-arasan driver updates for ZynqMP platform
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Jun 2021 at 12:44, Manish Narani <manish.narani@xilinx.com> wrote:
>
> This patch series has some bug fixes for sdhci-of-arasan driver with
> respect to ZynqMP platform. This series also has some code style changes
> in the driver.
>
> Manish Narani (6):
>   mmc: sdhci-of-arasan: Modified SD default speed to 19MHz for ZynqMP
>   mmc: sdhci-of-arasan: Add "SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12" quirk.
>   mmc: sdhci-of-arasan: Skip Auto tuning for DDR50 mode in ZynqMP
>     platform
>   mmc: host: sdhci-of-arasan: Check return value of non-void funtions
>   mmc: host: sdhci-of-arasan: Use appropriate type of division macro
>   mmc: host: sdhci-of-arasan: Modify data type of the clk_phase array
>
> Sai Krishna Potthuri (1):
>   mmc: arasan: Fix the issue in reading tap values from DT
>
>  drivers/mmc/host/sdhci-of-arasan.c | 51 ++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)
>
> --
> 2.1.1
>

Queued up for v5.15 (temporary on the devel branch) and by amending
the prefixes, thanks!

Kind regards
Uffe
