Return-Path: <SRS0=y6Wy=5L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA8C2D0EC
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371AA20719
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 04:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BSsmzr6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgCZEix (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Mar 2020 00:38:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36620 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCZEix (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2020 00:38:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id g12so5026478ljj.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2020 21:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGs2Fkq+JYwqsVvuiDWV5GE6EV18e6pUOVPfSl4Vkws=;
        b=BSsmzr6IQUuTjeowtedlu9tNNgVPDr+nYNScnZkr85pdX6ZmVQss+TJQopSDkzUeP1
         +MDVcvdFtmunqrK+0huuUuWRu0EytgvDvq1AWSOu3cmVzD/QMkrEopgaT3XMVRZm7rk8
         FALLNJ7rBV3mMyd5r4R7V4SIsR+f2FnCvYWvqro59pQ8N+VefOkZpshcYhSX/UVzmpAt
         lcJnQm3xCIYt/zYnfe7fiiuQLN+JpHdXQNp2DxAPWTcCJps6u6Qm5FQALtX/EIJ0ixrQ
         ey06pINwKwa5Wt4Jc4ltm12Qoa0kFbzwkgwKP6h4oi5GSI+NrC5JfUv/NajDR7fhq0wy
         PTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGs2Fkq+JYwqsVvuiDWV5GE6EV18e6pUOVPfSl4Vkws=;
        b=lk3zxVJdj3BPf3jNcv98EyLC+S+byVZhiLOeEWnc09wgkXFwS7lwKNL1POEyVc4t4h
         nE8dJsHSOF0XaP7mk9pkk7tzw5QyQUcC9pHYA9FmMD4tDYcYkqjEEPUm4ZOuuGrn7MVs
         HMlq/PdhuymNsBL7dwFWi/dGzDChlbq7+t/617H7FTyAh9GgmMAvGZFcPSMIQiH6e7Dk
         lNc3GjIMT/GgmRcIiwaJxDAUnPKBFdwG11+69617Fg8C9bupzyBHplsIY7KC7R+CyJ+N
         1Zsi5+8QQoiPLC8wQff+UuFCsVxrbz2E69JzzBYcz/cbMt1xpLcQ/noXbI4vJ3SlvzrN
         +G6g==
X-Gm-Message-State: AGi0PuYXqHkbgNTXDGu4hD8Mk44oCBnZ3UIVgQWGAfSlESGuNTRXWlem
        EjxqnmsrP+AZqAkrVHTQJ+jAI74QPa5VCFFm0tLAJg==
X-Google-Smtp-Source: APiQypKLx0qGen5VpCIUnaclGGr5pVb8zOTvau+T484s06BImCVFsm0HyLLdPILkq5Kr/8LBazJqb8ae9NZwH/fJsc8=
X-Received: by 2002:a2e:990b:: with SMTP id v11mr4095616lji.243.1585197531085;
 Wed, 25 Mar 2020 21:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200324180650.28819-1-ulf.hansson@linaro.org> <20200326025132.GA4189@sasha-vm>
In-Reply-To: <20200326025132.GA4189@sasha-vm>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 26 Mar 2020 10:08:39 +0530
Message-ID: <CA+G9fYvGbNuTY0rNh_W5HzxtTjUBb8YXkixG5DCseXppTVGJzA@mail.gmail.com>
Subject: Re: [PATCH 5.5.12 0/5] mmc: Fix some busy detect problems
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux- stable <stable@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Mar 2020 at 08:21, Sasha Levin <sashal@kernel.org> wrote:
>
> On Tue, Mar 24, 2020 at 07:06:45PM +0100, Ulf Hansson wrote:
> >This series provides a couple of manually backported mmc changes that fixes some
> >busy detect issues, for a couple of mmc host drivers (sdhci-tegra|omap).
> >
> >Ulf Hansson (5):
> >  mmc: core: Allow host controllers to require R1B for CMD6
> >  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
> >  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
> >  mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
> >  mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
> >
> > drivers/mmc/core/core.c        | 5 ++++-
> > drivers/mmc/core/mmc.c         | 7 +++++--
> > drivers/mmc/core/mmc_ops.c     | 8 +++++---
> > drivers/mmc/host/sdhci-omap.c  | 3 +++
> > drivers/mmc/host/sdhci-tegra.c | 3 +++
> > include/linux/mmc/host.h       | 1 +
> > 6 files changed, 21 insertions(+), 6 deletions(-)
>
> I've queued this, the 5.4, and the 4.19 series. Thanks!

I think this was tested for 5.4 branch.
Not sure about 4.19

Anders and Ulf,
Was it validated against 4.19 branch ?

- Naresh
