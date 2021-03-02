Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9174FC4361B
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4898564E66
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241279AbhCCBrw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447014AbhCBMly (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 07:41:54 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ECAC0611C1
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 04:41:08 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id b6so10498051vsf.8
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FA0+xDkpxWpMTD6/VNtezp6e2q2PIvD54UVdpD6N/k=;
        b=eAYWvB2fbTL7xQgjImFyAVq47B8XROotdRd9UQW/zhAg5SPZocGLjbpJP71Y1jWqZn
         clCZOrJtqn+o9fSfk+OGPZ2c55ErdCH6OsG49QlOSvdQzFS0bAeTTM70+pVmbIwcP2Yq
         ik9FfyKHRVqP5PTqTS+K2dLz9Lm28b8j8n8ItsyFRnZWRN4t5vdc79mHWdKQ4byBm70u
         milP4MsNXTXFqZZntJ4oxrXOXO050MqcvVSaiXOef2DXZ5OGdktPRUxpdVuDjDeU04V0
         uk5fp4/SLWvuNd1uc5yOIgO1oC0BEs136JdJb9gaxcEjtLRlc49lbo8ysqCa0CXswyM9
         jEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FA0+xDkpxWpMTD6/VNtezp6e2q2PIvD54UVdpD6N/k=;
        b=mv2H51kgchH4gipM2BV2GQxfGmW0zVqgL6H5XH9SaGPWX0R0j2+dAEWjQVQ7vQuE2N
         oe/GGAcloo9q75Z3AwXHNljWGuISWbLs29Gvlc3zVBamg/1oEVoUwhRCZYNsuoZAQH+/
         CJCZO63l0vvLER7tosGtGNd0rkbzT7sJ5QALPELn9aU7X17erYw0Do6Dcc0MfLGjStxa
         HdQ+eoWAaagbAVLY5HAZFliXSGXTl19bwiwff9i8HRBmm/RvP12qfnaSQVMNKFmVrJJG
         qaEk6Qb/FN6wh+18BGeVpw43WgmrjD7YKWnnV65aM6f0t3IGaCL3KyqOBDkSmPSc4tNL
         kO6w==
X-Gm-Message-State: AOAM533JOhH14YwiJXubAJO9oWCnClh6GKjtWi79BCQqw+JfUwaTybYP
        W99gnLy7bmRqBRbpIam9pG+VAJWEUMqjWjXpvpn63Q==
X-Google-Smtp-Source: ABdhPJy36yv7rZG1Hq9VCXSpJ+QrpfcEaWmsdvckuxrX6gCuYFzdjWMXC2BLkUw9NQWF10uqG3A49GSCNOS2Gfx+kFo=
X-Received: by 2002:a67:8c6:: with SMTP id 189mr1797005vsi.55.1614688867294;
 Tue, 02 Mar 2021 04:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20210302024557.4868-1-peng.zhou@mediatek.com> <YD3OFkjS8a6EUOHM@google.com>
In-Reply-To: <YD3OFkjS8a6EUOHM@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 13:40:31 +0100
Message-ID: <CAPDyKFp9Uu69i7_0rDm2=c26GCagkjyuzp=avdVd2RcpoC2ZYA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: mediatek: add Inline Crypto Engine support
To:     Satya Tangirala <satyat@google.com>,
        Peng Zhou <peng.zhou@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wulin Li <wulin.li@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2 Mar 2021 at 06:33, Satya Tangirala <satyat@google.com> wrote:
>
> On Tue, Mar 02, 2021 at 10:45:57AM +0800, Peng Zhou wrote:
> > - add crypto clock control and ungate it before CQHCI init
> > - set MMC_CAP2_CRYPTO property of eMMC
> >
> > Signed-off-by: Peng Zhou <peng.zhou@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index de09c6347524..1a5894ec551f 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -442,6 +442,7 @@ struct msdc_host {
> >       struct clk *src_clk_cg; /* msdc source clock control gate */
> >       struct clk *sys_clk_cg; /* msdc subsys clock control gate */
> >       struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];
> > +     struct clk *crypto_clk; /* msdc crypto clock */
> >       u32 mclk;               /* mmc subsystem clock frequency */
> >       u32 src_clk_freq;       /* source clock frequency */
> >       unsigned char timing;
> > @@ -802,6 +803,7 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
> >
> >  static void msdc_gate_clock(struct msdc_host *host)
> >  {
> > +     clk_disable_unprepare(host->crypto_clk);
> >       clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host->bulk_clks);
> >       clk_disable_unprepare(host->src_clk_cg);
> >       clk_disable_unprepare(host->src_clk);
> > @@ -822,7 +824,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
> >               dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
> >               return;
> >       }
> > -
> > +     clk_prepare_enable(host->crypto_clk);
> >       while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
> >               cpu_relax();
> >  }
> > @@ -2510,6 +2512,16 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >               goto host_free;
> >       }
> >
> > +     /* only eMMC has crypto property */
> > +     if ((mmc->caps2 & MMC_CAP2_NO_SD) &&
> > +         (mmc->caps2 & MMC_CAP2_NO_SDIO)) {
> > +             host->crypto_clk = devm_clk_get(&pdev->dev, "crypto");
> > +             if (IS_ERR(host->crypto_clk))
> > +                     host->crypto_clk = NULL;
> > +             else
> > +                     mmc->caps2 |= MMC_CAP2_CRYPTO;
> > +     }
> > +
> >       host->irq = platform_get_irq(pdev, 0);
> >       if (host->irq < 0) {
> >               ret = -EINVAL;
> > @@ -2580,6 +2592,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >               host->dma_mask = DMA_BIT_MASK(32);
> >       mmc_dev(mmc)->dma_mask = &host->dma_mask;
> >
> > +     /* here ungate due to cqhci init will access registers */
> > +     msdc_ungate_clock(host);
> >       if (mmc->caps2 & MMC_CAP2_CQE) {
> >               host->cq_host = devm_kzalloc(mmc->parent,
> >                                            sizeof(*host->cq_host),
> > @@ -2616,7 +2630,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >       spin_lock_init(&host->lock);
> >
> >       platform_set_drvdata(pdev, mmc);
> > -     msdc_ungate_clock(host);
> >       msdc_init_hw(host);
> >
> >       ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> > --
> > 2.18.0
> Somehow I can't apply this patch using git am. It looks like the mail
> isn't completely plain text (there's some html it seems), which may be
> why git am is complaining.

I assume this is why patchwork didn't accept them. Please re-post in
plain/text and use "git send-email".

Kind regards
Uffe
