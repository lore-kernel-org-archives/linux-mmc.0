Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C71C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhL1Qle (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhL1Qle (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:41:34 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3CDC061574
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:41:33 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id by39so31578759ljb.2
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCSd08N8apttmGIqlZ5H59v2FEIrStRWMN8xIiicDhM=;
        b=M9LcGIEr/DWRgc7C8F1wdgY2d1HGjZeolXixmmBH1/rWtTc3oEAW0AvZpnTYNY4ovi
         uDhsuN9bK9ACnM1AShfgGvZezIE9VHglxDNVMfMwMbtXrEUmbdhDl3k5a4ox0Jbgt0Rf
         zOyT43KnEAJbxA61YZduk1eiYHDsHrpN42Rm+daRg2rOhqH0uCgakjXYCVTOJU9CMFc+
         UEO01z7v84xxf79/o3/pev+pGcL4IaX5J+jbe+ORKldU0+HtJ7+sxyFCoAlRSHGuSl6Y
         Cz05QLbpJ/3AKMkiGNiGM7/PwLGxYA5Uput/WJCxNw3+yQ1NUAWEv+NJtIrDF2ztgG5v
         dYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCSd08N8apttmGIqlZ5H59v2FEIrStRWMN8xIiicDhM=;
        b=Xwun7UyShjuEsolXB5arhg122vDVdXRQk6fQV8g486RTr8h5wwXPQ9UtCpfuGII5Sy
         JccI6sT5ARo9D957wjkbHqXILE20bvBHDnEMMuZQoHsLblp1Hdf0TiCi61KYpnGB5vW9
         57nPY6GOQNa6N88D9EOLqDKH6Y6e/E2R/dJcahzhUq+RDUm7ar0uSoI1EJf+GKVRfb9G
         5vggTtt8WtP5tGyNk+7xku/bEEXhn0AAxpb9rdM+GW6sBRQKInGIa2k6hW9KIZvFHL38
         2CJp/Ff78Qz0h/ujKHa7XQSjd5s83+ASkZktiltLWIslLS5UZ5wU6jOXPoBUptWMRhus
         IPvg==
X-Gm-Message-State: AOAM532+VuFJNUbyxfSPW/HOgXlNmef8k5LdHVNDZUSZTEkQ3i5qnnGJ
        mG5bayLFQ/rQsdPrP7pBiF85HUwMj7KUIfywP78EXWdNs2Bf5Q==
X-Google-Smtp-Source: ABdhPJyJrD4RfXrnVr/rYSse9uSa1kC4/hW8bZv/sZ9ZkcTbWIBLTjmEAj1/TJAIZ8oRrxRsBbCqAuMi/cyK82o1Pns=
X-Received: by 2002:a2e:93c4:: with SMTP id p4mr18463122ljh.367.1640709692068;
 Tue, 28 Dec 2021 08:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
In-Reply-To: <20211223171202.8224-1-s.shtylyov@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:40:55 +0100
Message-ID: <CAPDyKFq+7YzNpO67JQuwqL11J43ZXFrfmo+QLBnY3v3a4etR-w@mail.gmail.com>
Subject: Re: [PATCH RFC 0/13] Fix deferred probing in the MMC/SD drivers
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Dec 2021 at 18:12, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Here are 13 patches against the 'fixes' branch of Ulf Hansson's 'usb.git' repo.
> The affected MMC/SD drivers call platform_get_irq() but override its result
> in case of error which prevents the deferred probing from working. Some of
> these patches logically depend on the previously posted (and yet unmerged)
> patch:
>
> https://marc.info/?l=linux-kernel&m=163623041902285

Alright, so until we get some more progress on the above patch, I will
simply defer this until later.

Please re-submit the series, when it's ready to be picked up for me.

Kind regards
Uffe

>
> Because of that dependency the patches are marked as RFC.
>
> Sergey Shtylyov (13):
>   mmc: bcm2835: fix deferred probing
>   mmc: meson-gx: fix deferred probing
>   mmc: mtk-sd: fix deferred probing
>   mmc: mvsdio: fix deferred probing
>   mmc: omap: fix deferred probing
>   mmc: omap_hsmmc: fix deferred probing
>   mmc: owl: fix deferred probing
>   mmc: s3mci: fix deferred probing
>   mmc: sdhci-acpi: fix deferred probing
>   mmc: sdhci-spear: fix deferred probing
>   mmc: sh_mmcif: fix deferred probing
>   mmc: sunxi: fix deferred probing
>   mmc: usdhi60rol0: fix deferred probing
>
>  drivers/mmc/host/bcm2835.c      | 4 ++--
>  drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>  drivers/mmc/host/mtk-sd.c       | 2 +-
>  drivers/mmc/host/mvsdio.c       | 2 +-
>  drivers/mmc/host/omap.c         | 2 +-
>  drivers/mmc/host/omap_hsmmc.c   | 6 ++++--
>  drivers/mmc/host/owl-mmc.c      | 2 +-
>  drivers/mmc/host/s3cmci.c       | 4 ++--
>  drivers/mmc/host/sdhci-acpi.c   | 2 +-
>  drivers/mmc/host/sdhci-spear.c  | 4 ++--
>  drivers/mmc/host/sh_mmcif.c     | 2 +-
>  drivers/mmc/host/sunxi-mmc.c    | 4 ++--
>  drivers/mmc/host/usdhi6rol0.c   | 6 ++++--
>  13 files changed, 24 insertions(+), 20 deletions(-)
>
> --
> 2.26.3
>
