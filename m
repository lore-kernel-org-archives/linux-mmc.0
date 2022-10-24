Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF22C38A2D
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 18:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiJXSbu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiJXSbZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 14:31:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637D43AF8
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:13:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g24so3992467plq.3
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HFOq1WhYAdMIHmNNqmBBatEb3gGOtuofcAw6JbKXCd8=;
        b=QkhyoxIoz9JFnsrwUpJ7NL9g7VWfxM+f1BTF6YO9wsHIseXlqguOyf7AgQdJAUcWNz
         G/yvrF9BKDO7tmDUkPgJuomD3OAKGuovI1VzUj8ZQ9THMte1SNxEGZj6f/mNLJsjHShb
         xYTGUwXNSai0wFq837GNNAQVDHtAFGl13INHIByAf6wUjJKrJjmNU721S2D1a2RUgtmh
         NJ+uAu/sqZbTWjIYIBLVjDFvHYstiTE1BHklviCf99g0zeDrY8URcb+tEGOCe157JDsK
         t4FWIXz8HNfjWH+t4ffHC955Nk9PXTZSul9ByjCycbFyskGg6suOPQXb+tcg08XJ0hGy
         NOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFOq1WhYAdMIHmNNqmBBatEb3gGOtuofcAw6JbKXCd8=;
        b=v1asW5Eoj/UqHPkO9MMn9mR3sF+IX3WlqPJntdhMJzaZFImaDlx2nwiDUCoo0Wc0eL
         /+tjt+SqKn1OnYCDT6T0tyPIoY0ikEWTM2eSJ5cobZAYebnEGYTOpM4xCew7NwFuu1MQ
         L+oUiKPRwFuUPceBDXUCPdS9F2K89prkMm8Az5SoPPWzR4arFgBnPsCtQPSlEVoj6Z3I
         po5rIYl/8/wzwazuBwohUJ+jDQbiHPiRtDsdJASpHoOEoGZ+B3/ul6juf1PuyfF+vpWm
         p3Ki7sK3FQU4iQbTz6Css1q2I8jrmcDaDgTIWa+XJdXkwUEMZI3tXq0ECMGocPYCkfix
         SacA==
X-Gm-Message-State: ACrzQf1HLnc07cF4mDPPO3KJmaFCd53OFJspuM+OHHBuNRyDsOlkuAd0
        TXL/FRVJ+XJZllpNJ/W12gLjrGKKjrPKMaCMEtqnrw==
X-Google-Smtp-Source: AMsMyM7Etk5qTccoEtIr88n829aJemLivIr0zg50GPpXfan8f5AlG792mRVnU0yqyUAu+rcmo2L9wb25c/hfPjMKBvE=
X-Received: by 2002:a17:902:70c7:b0:183:3e66:fe48 with SMTP id
 l7-20020a17090270c700b001833e66fe48mr33137987plt.165.1666631512005; Mon, 24
 Oct 2022 10:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221005101951.3165-1-adrian.hunter@intel.com>
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Oct 2022 19:11:14 +0200
Message-ID: <CAPDyKFrJsHcA0OrMTWbQXPgTYkH5G=0uaO1Jzcig9ZMGEbk0qA@mail.gmail.com>
Subject: Re: [PATCH 00/14] mmc: Replace kmap_atomic() with kmap_local_page()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 5 Oct 2022 at 12:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are patches primarily aimed at replacing kmap_atomic() with
> kmap_local_page().
>
> kmap_local_page() is equivalent to kmap_atomic() except that it does not
> disable page faults or preemption. Where possible kmap_local_page() is
> preferred to kmap_atomic() - refer kernel highmem documentation.
>
> In these cases, there is no need to disable page faults or preemption, so
> kmap_atomic() is replaced with kmap_local_page(), and, correspondingly,
> kunmap_atomic() with kunmap_local().
>
> That work raised the question of why local_irq_{save,restore}() was being
> used with k[un]map_atomic().  It turns out to be for legacy reasons that
> have gone away.
>
> A long time ago the kmap_atomic API required a slot to be provided which
> risked the possibility that other code might use the same slot at the
> same time. Disabling interrupts prevented the possibility of an interrupt
> handler doing that. However, that went away with
> commit 3e4d3af501cc ("mm: stack based kmap_atomic()").
>
> The work is mostly divided into separate patches, to enable separate review
> for driver reviewers and to enable separate reverts if necessary.
>
>
> Adrian Hunter (14):
>       mmc: sdhci: Remove local_irq_{save,restore}() around k[un]map_atomic()
>       mmc: sdhci: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
>       mmc: sdhci: Replace kmap_atomic() with kmap_local_page()
>       mmc: bcm2835: Remove local_irq_{save,restore}() around k[un]map_atomic()
>       mmc: bcm2835: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
>       mmc: bcm2835: Replace kmap_atomic() with kmap_local_page()
>       mmc: mmc_test: Remove local_irq_{save,restore}() around sg_copy_{from,to}_buffer()
>       mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_transfer_data()
>       mmc: tifm_sd: Remove local_irq_{save,restore}() around tifm_sd_bounce_block()
>       mmc: tifm_sd: Replace kmap_atomic() with kmap_local_page()
>       mmc: tmio_mmc_core: Remove local_irq_{save,restore}() around k[un]map_atomic()
>       mmc: tmio_mmc_core: Replace kmap_atomic() with kmap_local_page()
>       mmc: au1xmmc: Replace kmap_atomic() with kmap_local_page()
>       mmc: wbsd: Replace kmap_atomic() with kmap_local_page()
>
>  drivers/mmc/core/mmc_test.c              |  5 -----
>  drivers/mmc/host/au1xmmc.c               |  8 ++++----
>  drivers/mmc/host/bcm2835.c               | 12 ++----------
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c |  5 ++---
>  drivers/mmc/host/sdhci.c                 | 30 ++++++++----------------------
>  drivers/mmc/host/tifm_sd.c               | 28 ++++++++++------------------
>  drivers/mmc/host/tmio_mmc.h              | 11 ++++-------
>  drivers/mmc/host/tmio_mmc_core.c         | 10 ++++------
>  drivers/mmc/host/wbsd.c                  | 10 +++++-----
>  9 files changed, 39 insertions(+), 80 deletions(-)
>
>
> Regards
> Adrian

Applied for next, thanks!

Kind regards
Uffe
