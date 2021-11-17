Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D2C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 11:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC863241
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 11:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhKQLGs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 06:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhKQLGr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 06:06:47 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70535C061570
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 03:03:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bu18so6572401lfb.0
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGszPtOceAbegmnVkD6OoZ0csNfW6t/mFlSuDP0gjWc=;
        b=xl3l+CiGKVRR4IXp1c86MrjPvqJfn/ODrGL1hLDg/vS4MrCm7rz1v1xX4MWM8UlqvT
         rFbzXMGVOWTYtrtlIyFgKukTHDDlhGIb+qXkrfRj2EMJMlRd0Cqm/SXL+7dWjEVtLMR3
         WyOhKtzKEmg7zxOGRszGAGW07ytMAPw0WPu/nv1cPMJ7LSB9IB5lMhV9KBPrbngh3226
         fOZisjHy3ae4dKpFtEUcV+gJrQQsLzwO9dnrqHiOkYP6oOLNv+Guk4XT35n6JIb8S8ZK
         FgzVFENstSe4TyZraOFYxz3qPqZZiK6IxS6/OXIdzjfPFqhA1lBnGg5ErnVsyEnXR9I0
         devw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGszPtOceAbegmnVkD6OoZ0csNfW6t/mFlSuDP0gjWc=;
        b=320OpksAlL2SyWvjwrlckFpNQ17+88auLh2Knqkak3lWnaWLGuB3sFMpRPoq5RftxB
         CBDAjSJvYUgLj1rMiIS5UYy1tdfSIUzkMfAZLEBoy0CZizKXA9i1RiDRExGlr9g9URW9
         gHWK2EsZvCtHHQQAfVStPDc6Yt2CotnMm0l5NIWy6tp4wxqFcxAx90HZeBvavuGqvFSN
         dp3VvKxh++6vHkdOt4EtpeqtTA8SeawwDY8ZDvnj8d2mBrmt58kdzC6afX80WBMjBxG8
         BJ5L1qFsvtvHq0ZgBMl6KHcwq9kd46GSnfSnt5siyXnkxNKTweA5OV5Kcdr9Xoy0WLg9
         tKSA==
X-Gm-Message-State: AOAM531rTJL9jLKqpuXeLdX5V3WX67sNps9agzEmyRj+XViuQP11WiUP
        fD2uG5qW3Nq8M9nG6EXDmr3yLFTYzCXnoodapyvNAg==
X-Google-Smtp-Source: ABdhPJxPyzuqmdehmZW1HkriKdkpQMAsQy/dOXECGrTuPidvPZuT+6F9z8t4KDv8xlKyHHpdf+SBQoUSgXea+AGbShk=
X-Received: by 2002:ac2:5a46:: with SMTP id r6mr14635901lfn.358.1637147026694;
 Wed, 17 Nov 2021 03:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20210414085121.28951-1-peng.zhou@mediatek.com>
 <20210414085121.28951-2-peng.zhou@mediatek.com> <CAPDyKFpOzmYxstRwSrD6tWKLMwxFPvHNfpDPDCrogzRah5iZtA@mail.gmail.com>
 <1628219664.14221.7.camel@mbjsdccf07> <CAPDyKFo6r9LX5h2OaW1+2=LvKeXLaRBXGSx89MeZA5QVPJh3rQ@mail.gmail.com>
 <02c914ee3fbfb6d548669ca02d95f89d0997f7ae.camel@mediatek.com>
In-Reply-To: <02c914ee3fbfb6d548669ca02d95f89d0997f7ae.camel@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Nov 2021 12:03:10 +0100
Message-ID: <CAPDyKFqiN74C0TG3b6UpFuGyaAdZSz97FSTKVaTq_247H_6k1w@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 1/3] mmc: Mediatek: add Inline Crypto Engine support
To:     "Peng.Zhou" <peng.zhou@mediatek.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <chaotian.jing@mediatek.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Satya Tangirala <satyat@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?V3VsaW4gTGkgKOadjuatpuaelyk=?= <wulin.li@mediatek.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Nov 2021 at 08:23, Peng.Zhou <peng.zhou@mediatek.com> wrote:
>
> On Mon, 2021-08-09 at 17:29 +0200, Ulf Hansson wrote:
> > On Fri, 6 Aug 2021 at 05:16, Peng.Zhou <peng.zhou@mediatek.com>
> > wrote:
> > >
> > > Hi Ulf,
> > >
> > > Thank you for your advise, I have a question about genpd provider,
> > > is it
> > > a mandatory DT node for eMMC? Why I confuse it due to I found we
> > > only do
> > > enable/disable clock during used eMMC in our platforms without any
> > > power
> > > releated actions....it seems that there is no any "pwner-domain"
> > > used
> > > for eMMC in our platforms.
> >
> > A power-domain is optional for an eMMC controller to use.
> >
> > It then sounds like you should add it, in cases when you have mmc
> > crypto support.
> >
> > Hope this helps!
> >
> > Kind regards
> > Uffe
>
> Hi Ulf,
>
> Sorry for long time no response. I have checked eMMC power domain with
> our SoC designers and power experts in the past period of time, both
> past and present, our power domain hardware design doesn't include
> any eMMC part and the future will be same...so I am not sure is
> there is any idea in your view? Do you think put atf smc call in genpd
> hook is mandatory for us?

Yes. To me, it seems best suited to be managed from a genpd provider.
Moreover, the corresponding crypto clock can then also be nicely
abstracted and managed outside of the driver.

Or perhaps you see some other concerns with this approach?

Kind regards
Uffe

>
> Thanks!
> >
> > >
> > > On Mon, 2021-05-10 at 19:57 +0800, Ulf Hansson wrote:
> > > > On Wed, 14 Apr 2021 at 11:12, Peng Zhou <peng.zhou@mediatek.com>
> > > > wrote:
> > > > >
> > > > > From: Peng Zhou <Peng.Zhou@mediatek.com>
> > > > >
> > > > > 1. add crypto clock control and ungate it before CQHCI init
> > > > >
> > > > > 2. set MMC_CAP2_CRYPTO property of eMMC
> > > > >
> > > > > Signed-off-by: Peng Zhou <Peng.Zhou@mediatek.com>
> > > >
> > > > As discussed [1], I think the ARM SMC call should be managed
> > > > together
> > > > with the crypto clock, from a PM domain (a genpd provider).
> > > >
> > > > These are the steps I think should help to get this supported:
> > > >
> > > > 1)
> > > > Add a new generic mmc DT property for crypto support. Make it
> > > > being
> > > > parsed from mmc_of_parse() and let it set MMC_CAP2_CRYPTO.
> > > >
> > > > 2)
> > > > Start by adding a genpd provider in DT and implement support for
> > > > it in
> > > > drivers/soc/*. See
> > > > Documentation/devicetree/bindings/power/power-domain.yaml, for
> > > > generic
> > > > DT bindings.
> > > >
> > > > If you already have a genpd provider for the device, you may
> > > > either
> > > > extend it to cope with the below or implement a new and model the
> > > > it
> > > > as a child (subdomain) of the existing one.
> > > >
> > > > 3)
> > > > To fetch the crypto clock during probe, the genpd provider should
> > > > implement the ->attach|detach_dev() callbacks. The ->attach_dev()
> > > > callback is invoked from genpd_add_device(), which is called
> > > > while
> > > > probing the device. Vice verse for the ->detach_dev() callback.
> > > >
> > > > 4)
> > > > Ungating/gating the clock should be implemented from the genpd
> > > > provider's ->start|stop() callbacks. These callbacks are called
> > > > from
> > > > genpd_runtime_suspend|resume(), thus when the device gets runtime
> > > > suspended/resumed. As the mmc host driver already supports
> > > > runtime PM,
> > > > only a minor update in the driver's ->probe() is needed, which is
> > > > to
> > > > call dev_pm_domain_start(). This turns on the crypto clock and
> > > > allows
> > > > its registers to be accessed.
> > > >
> > > > 5)
> > > > Add also the ARM SMC calls to the genpd provider's ->start|stop()
> > > > callbacks. This means those gets called from SoC specific code,
> > > > which
> > > > helps to keep the driver portable.
> > > >
> > > > 6)
> > > > Add the crypto clock DT binding for the mmc host.
> > > >
> > > > 7)
> > > > Wire up the mmc host device node in DT to be attached to the
> > > > genpd
> > > > provider (see power-domains and power-domain-names properties).
> > > > Make
> > > > sure to also specify the crypto clock and the new mmc crypto
> > > > property
> > > > for it.
> > > >
> > > > Please, just ask if there is anything unclear. I will do my best
> > > > to help!
> > > >
> > > > Kind regards
> > > > Uffe
> > > >
> > > > [1]
> > > >
> https://patchwork.kernel.org/project/linux-mmc/patch/20210309015750.6283-1-peng.zhou@mediatek.com/
> > > >
> > > > > ---
> > > > >  drivers/mmc/host/mtk-sd.c | 15 ++++++++++++++-
> > > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-
> > > > > sd.c
> > > > > index 898ed1b023df..1c90360d6cf2 100644
> > > > > --- a/drivers/mmc/host/mtk-sd.c
> > > > > +++ b/drivers/mmc/host/mtk-sd.c
> > > > > @@ -442,6 +442,7 @@ struct msdc_host {
> > > > >         struct clk *src_clk_cg; /* msdc source clock control
> > > > > gate */
> > > > >         struct clk *sys_clk_cg; /* msdc subsys clock control
> > > > > gate */
> > > > >         struct clk_bulk_data bulk_clks[MSDC_NR_CLOCKS];
> > > > > +       struct clk *crypto_clk; /* msdc crypto clock */
> > > > >         u32 mclk;               /* mmc subsystem clock
> > > > > frequency */
> > > > >         u32 src_clk_freq;       /* source clock frequency */
> > > > >         unsigned char timing;
> > > > > @@ -802,6 +803,7 @@ static void msdc_set_busy_timeout(struct
> > > > > msdc_host *host, u64 ns, u64 clks)
> > > > >
> > > > >  static void msdc_gate_clock(struct msdc_host *host)
> > > > >  {
> > > > > +       clk_disable_unprepare(host->crypto_clk);
> > > > >         clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host-
> > > > > >bulk_clks);
> > > > >         clk_disable_unprepare(host->src_clk_cg);
> > > > >         clk_disable_unprepare(host->src_clk);
> > > > > @@ -822,6 +824,7 @@ static void msdc_ungate_clock(struct
> > > > > msdc_host *host)
> > > > >                 dev_err(host->dev, "Cannot enable pclk/axi/ahb
> > > > > clock gates\n");
> > > > >                 return;
> > > > >         }
> > > > > +       clk_prepare_enable(host->crypto_clk);
> > > > >
> > > > >         while (!(readl(host->base + MSDC_CFG) &
> > > > > MSDC_CFG_CKSTB))
> > > > >                 cpu_relax();
> > > > > @@ -2512,6 +2515,15 @@ static int msdc_drv_probe(struct
> > > > > platform_device *pdev)
> > > > >                 goto host_free;
> > > > >         }
> > > > >
> > > > > +       /* only eMMC has crypto property */
> > > > > +       if ((mmc->caps2 & MMC_CAP2_NO_SD) && (mmc->caps2 &
> > > > > MMC_CAP2_NO_SDIO)) {
> > > > > +               host->crypto_clk = devm_clk_get(&pdev->dev,
> > > > > "crypto");
> > > > > +               if (IS_ERR(host->crypto_clk))
> > > > > +                       host->crypto_clk = NULL;
> > > > > +               else
> > > > > +                       mmc->caps2 |= MMC_CAP2_CRYPTO;
> > > > > +       }
> > > > > +
> > > > >         host->irq = platform_get_irq(pdev, 0);
> > > > >         if (host->irq < 0) {
> > > > >                 ret = -EINVAL;
> > > > > @@ -2582,6 +2594,8 @@ static int msdc_drv_probe(struct
> > > > > platform_device *pdev)
> > > > >                 host->dma_mask = DMA_BIT_MASK(32);
> > > > >         mmc_dev(mmc)->dma_mask = &host->dma_mask;
> > > > >
> > > > > +       /* here ungate due to cqhci init will access registers
> > > > > */
> > > > > +       msdc_ungate_clock(host);
> > > > >         if (mmc->caps2 & MMC_CAP2_CQE) {
> > > > >                 host->cq_host = devm_kzalloc(mmc->parent,
> > > > >                                              sizeof(*host-
> > > > > >cq_host),
> > > > > @@ -2618,7 +2632,6 @@ static int msdc_drv_probe(struct
> > > > > platform_device *pdev)
> > > > >         spin_lock_init(&host->lock);
> > > > >
> > > > >         platform_set_drvdata(pdev, mmc);
> > > > > -       msdc_ungate_clock(host);
> > > > >         msdc_init_hw(host);
> > > > >
> > > > >         ret = devm_request_irq(&pdev->dev, host->irq, msdc_irq,
> > > > > --
> > > > > 2.18.0
