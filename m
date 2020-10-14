Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E38C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A1C20878
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 09:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvLyi1IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgJNJTk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgJNJTi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Oct 2020 05:19:38 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2342C041E43
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 20:07:09 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id d19so1238028vso.10
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 20:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VspsiIK9WGEgWmx3VPfOzr6gUq8707awunHZRI7g+Q=;
        b=cvLyi1IV3Yd9Ab6BBpPkihXFqFVcxMH10kXKIYL/8WgURQfV6FuTUqvOyVq8LvP2ei
         NqZq13IkcKyUv3YwI7baIBlVpRlaL4yKy3oFzDF3l0ehrcc6hhotR2w4/BWR8mr4tGnu
         TZToqAlyMre5CFErC+95FpvEhQJUuG75l9qUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VspsiIK9WGEgWmx3VPfOzr6gUq8707awunHZRI7g+Q=;
        b=AGNX6E6daEKvqqrzWemuD8uzXvNl22oSa/7Mnp5+0KTgrNzULq7GfseozkuPKodUnD
         pQhatLxzyp/ZTActdmP6WWSK+6oEuqzlOzqkh5bEkAjajGTGZuG4tXaNN+Mq1wyXE/Js
         LvkPq/C5N0zoylbCJdjNOlJr/kKDoKfS+pP6qrwyFK1NUdf6qAVIJaA0xMFvOHextm7q
         ElPgXuzjx2yJJXKUsJ6nxkXptXrSLVhygpagwbeESn/5TX/nlkqlAjYfePy59QyIW2RP
         OFEUS5iKw4OQZlGTT72eGwlnnboDNaQQx1PFfjh9wavhwQy8y4smAZe0tYIBSlx361mR
         s9mg==
X-Gm-Message-State: AOAM533f3A8lnbG1kxw6pXtisSifYsljTwCukaQUCblFjWET+Q595a97
        npMedJ9fIdotISocmZwSCA1hm2/V/9926CnjQjltjA==
X-Google-Smtp-Source: ABdhPJyeztC0cKlxpxJbcdpKGnjLokQ5Hbk3yut4wnAn+KbU58QE/bDjZToy72mqLJB3xoj//4U1Nx1Wmu2jQvyz1Ho=
X-Received: by 2002:a67:2f81:: with SMTP id v123mr2278664vsv.16.1602644828982;
 Tue, 13 Oct 2020 20:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
 <20201012124547.16649-5-wenbin.mei@mediatek.com> <72ae1d89-fe31-4f50-15c0-29119d662ea1@gmail.com>
 <1602642530.11864.3.camel@mhfsdcap03>
In-Reply-To: <1602642530.11864.3.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 14 Oct 2020 11:06:58 +0800
Message-ID: <CANMq1KBe9u25yDxg8UtmOX4vhr8De=5-pJyMRkSBF4O=FpBN9A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 14, 2020 at 10:29 AM Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> On Tue, 2020-10-13 at 17:10 +0200, Matthias Brugger wrote:
> >
> > On 12/10/2020 14:45, Wenbin Mei wrote:
> > > MT8192 msdc is an independent sub system, we need control more bus
> > > clocks for it.
> > > Add support for the additional subsys clocks to allow it to be
> > > configured appropriately.
> > >
> > > Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> > > ---
> > >   drivers/mmc/host/mtk-sd.c | 74 +++++++++++++++++++++++++++++----------
> > >   1 file changed, 56 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > > index a704745e5882..c7df7510f120 100644
> > > --- a/drivers/mmc/host/mtk-sd.c
> > > +++ b/drivers/mmc/host/mtk-sd.c
> > [...]
> > > +static int msdc_of_clock_parse(struct platform_device *pdev,
> > > +                          struct msdc_host *host)
> > > +{
> > > +   int ret;
> > > +
> > > +   host->src_clk = devm_clk_get(&pdev->dev, "source");
> > > +   if (IS_ERR(host->src_clk))
> > > +           return PTR_ERR(host->src_clk);
> > > +
> > > +   host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > > +   if (IS_ERR(host->h_clk))
> > > +           return PTR_ERR(host->h_clk);
> > > +
> > > +   host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
> > > +   if (IS_ERR(host->bus_clk))
> > > +           host->bus_clk = NULL;
> > > +
> > > +   /*source clock control gate is optional clock*/
> > > +   host->src_clk_cg = devm_clk_get_optional(&pdev->dev, "source_cg");
> > > +   if (IS_ERR(host->src_clk_cg))
> > > +           host->src_clk_cg = NULL;
> > > +
> > > +   host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
> > > +   if (IS_ERR(host->sys_clk_cg))
> > > +           host->sys_clk_cg = NULL;
> > > +
> > > +   /* If present, always enable for this clock gate */
> > > +   clk_prepare_enable(host->sys_clk_cg);
> > > +
> > > +   host->bulk_clks[0].id = "pclk_cg";
> > > +   host->bulk_clks[1].id = "axi_cg";
> > > +   host->bulk_clks[2].id = "ahb_cg";
> >
> > That looks at least suspicious. The pointers of id point to some strings defined
> > in the function. Aren't they out of scope once msdc_of_clock_parse() has returned?
> >
> These constants are not in stack range, so they will not be lost.
> And I have confirmed it after msdc_of_clock_parse() has returned, these
> ids still exist.

Yes I guess the constants end up in .rodata (or similar section), but
I'm not sure if this is absolutely guaranteed.

In any case, this is a commonly used pattern, so I'd hope it's fine
(just a sample, there are more):
https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pcie-qcom.c#L266
https://elixir.bootlin.com/linux/latest/source/sound/soc/codecs/wm8994.c#L4638
https://elixir.bootlin.com/linux/latest/source/drivers/mfd/madera-core.c#L467
https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpio-dwapb.c#L675

>
> > Regards,
> > Matthias
>
