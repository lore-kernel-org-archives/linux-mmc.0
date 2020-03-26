Return-Path: <SRS0=y6Wy=5L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751E1C43331
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 10:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1572070A
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 10:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwW61sst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgCZKv7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:51:59 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42399 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgCZKv7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2020 06:51:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id t21so4383425lfe.9
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2020 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIU/xURtDLn8PFigh0qvNQ4+V3T/fDVQQZYd8JhofKo=;
        b=bwW61sstDbKkr/nUVOTF/i+ve5q3YImVYIpUJ7NdpBsb2hQNqKmATfrut8TgCdpN0I
         6P+nYk0rSuiiKsFPDio/U5y2qk0J/Nq13fX1tbhwXczUjszuSSX7P7310txLNa7kqFNW
         6ounHw6bF+toLDPHYN8Dgr4kyKzzoYC9ugHQuQuhJYEC14FsN5C2x52ZSOqifbtoDdRd
         k+fOiAPlFg2WyLlotATTyDCdsn/3NpM8KZT64zh5sRGHFtGgW5q7aFeoZa4vxIWox/pD
         ZaLxFowV4I6e7egotXJvScE2RvZ22GP15fgaEsQ4gHQJuMlqCpHSzG5LdO4X9pTavVAG
         kwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIU/xURtDLn8PFigh0qvNQ4+V3T/fDVQQZYd8JhofKo=;
        b=K6hQ75+f/mZu/Kgql0j1YCyQ6GZScH91iw94zAi1OGbIvO/J/zkCgP7BY2+86IH73+
         W4xXFp3cIEkCEesTXEMj+tQLZLULBqpkAO6R8m5cFrbQHh9eh1i00P44g/K8sNs+CB7m
         BKA0bkmRwqkprMnhMYs/jNbaPnZFIVeF5N2ep0OnxKPTy8F51s8R9QZOJaQzXiitMfEF
         VPnLLs6JmGHvU9G10HrnER/9qlMbwanhB1fBGDEc2A5917uy/1WpznIRrg5hG/Lk75Rp
         cUrgsGILq29Q1y3a1jgmFIOztuMlVZL77kHVUfizu8lJGh3XmeqtIRMXhloqzOuukthb
         RHAA==
X-Gm-Message-State: ANhLgQ1roQiRnyaWPkIWN1JBWGp9Hs+5iR6BXojrKXF9N47YNfBwQaCb
        GiXUn3NxXAydCpSh7kNniM031imcWErbW4qGey4w7g==
X-Google-Smtp-Source: ADFU+vuc4u7Qq9hYKCXaP8KUhEDGcotTGV7qQ007wzkMl1hiLyHact9qf+t2BAOgG8Q5wJOE3MAb0Zd1AmKzabFfN7E=
X-Received: by 2002:a19:234f:: with SMTP id j76mr5401178lfj.105.1585219915896;
 Thu, 26 Mar 2020 03:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200324180650.28819-1-ulf.hansson@linaro.org> <20200326025132.GA4189@sasha-vm>
In-Reply-To: <20200326025132.GA4189@sasha-vm>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Mar 2020 11:51:44 +0100
Message-ID: <CADYN=9JS0fcM-B5XR9fCHiQGP1i7RSh2zUtJA+BSASGctDkJJg@mail.gmail.com>
Subject: Re: [PATCH 5.5.12 0/5] mmc: Fix some busy detect problems
To:     Sasha Levin <sashal@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-mmc@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Mar 2020 at 03:51, Sasha Levin <sashal@kernel.org> wrote:
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

Hi Sasha,

I've tested all three kernels, but replied to 5.5 and 5.4 with "Tested-by".
I did not reply "Tested-by" on 4.19 because I did not get a good result there.
I'm investigating why it did not boot. I'm not sure if you should
apply the patches
yet to 4.19, and if you do, please do not add my "Tested-by" on 4.19.

Cheers,
Anders
