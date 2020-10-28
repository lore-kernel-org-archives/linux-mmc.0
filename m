Return-Path: <SRS0=bNNl=ED=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CDFC4363A
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA56E207DE
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Oct 2020 23:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvnCwIef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgJ1XoL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389649AbgJ1XoK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Oct 2020 19:44:10 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0946C0613CF
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2020 16:44:10 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p17so393980pli.13
        for <linux-mmc@vger.kernel.org>; Wed, 28 Oct 2020 16:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmTfdAqJelGk4mThvToPB+vvFy/o2Riv909vC5Pwsvc=;
        b=PvnCwIef6PZCTFzgkQOE6JXpb70433VKOlFqHWLlBDtiPS9mCm8oVghA+eXAC6KxjB
         j5R3n3VjyjW4vD3eVLDjTBVf1/lCrGPrAwyAGG8NFmzunydB3WwepFlnjhYNpJc4cvdl
         WK6xIrldFzHeKcCCMKPLPErRCYpr4qMwZmjQVpYAlw/P2+XKWk4oM88xJLIx07qmVhlG
         vVP4MBcP9wvJpKuwvN31PU+45Fh8W0+q9tF9hEWpvDZfxjq57UcwOkRZru/5mR7uwm8B
         UGpPz2KxfASR16wNtW1LoSLgnwJiuykxEaWXRcZeji/OlQGhQMqWXSK5n5+ayycZGeN8
         EX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmTfdAqJelGk4mThvToPB+vvFy/o2Riv909vC5Pwsvc=;
        b=kYedbEzriOK3RTY3s254plDJDrlBnczdmkuCw0+hXDZLL53IZggauAIcH8r7JM3icO
         QxoDe4iNE1UCcjX+CvAXJcRccg1ehuDD3e14VB736/KKUsF3IDpNkT38ypGlLDRCS4L2
         qetWHe93sxhdl+wUVOo01Y/2AAyaR/fOl87IfaRJVdxfbVP/xnLT2yq2SQi3GtB/oTP/
         +WoIZ7Yrbv+69kpW8lBP07xrsRq5fGVgyi1J/sihrC1Fq+Kv7fvMVhbdhUBv2NTyXAm5
         EjMIcz5cpVds96SZiRk2UxrtnfrQAWkImxOXZfUPwyoiv5ej8wMRTWSsNQ/m8OQQVzEn
         0PAw==
X-Gm-Message-State: AOAM530uVcdyEvfoLO3KBPQbjI/+QH/lrqwVvocqaAa8mDAZjGJXq1DV
        ong3RkR7ezjlNUUI9IowFJxFwQGj7+kcu72i6GShILWuth1I6i0e
X-Google-Smtp-Source: ABdhPJxA6mva6c9AuQcMDkfN09APtSH2RneKpFr1NrXpPaeWepLTqSsiRntY8LrK5rP3qon0g31a7FFbXKcv2+GSxOA=
X-Received: by 2002:a05:6122:10eb:: with SMTP id m11mr4439593vko.8.1603878079032;
 Wed, 28 Oct 2020 02:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201023122950.60903-1-fparent@baylibre.com> <CAPDyKFrMwLeuQoFDgXYo_-T_e2AzfqM-rgp3-SgeuC6Qn6rxMA@mail.gmail.com>
 <87wnzbg7on.fsf@baylibre.com> <1603869682.6198.23.camel@mhfsdcap03>
In-Reply-To: <1603869682.6198.23.camel@mhfsdcap03>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Oct 2020 10:40:42 +0100
Message-ID: <CAPDyKFrjov40BxHRrG6WoUVLaVbPbvPPf_ot2xybVEfGerST9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: mtk-sd: enable recheck_sdio_irq for MT8516 SoC
To:     "yong.mao@mediatek.com" <yong.mao@mediatek.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Oct 2020 at 08:22, yong.mao@mediatek.com
<yong.mao@mediatek.com> wrote:
>
> On Tue, 2020-10-27 at 13:44 +0100, Mattijs Korpershoek wrote:
> > Hi Ulf,
> >
> > Ulf Hansson <ulf.hansson@linaro.org> writes:
> >
> > > + Yong Mao, Chaotian Jing
> > >
> > > On Fri, 23 Oct 2020 at 14:29, Fabien Parent <fparent@baylibre.com> wrote:
> > >>
> > >> MT8516 SoC suffers from sometimes losing SDIO IRQs, this makes SDIO
> > >> devices sometimes unstable. Make use of the new property
> > >> recheck_sdio_irq to fix the SDIO stability issues on MT8516.
> > >>
> > >> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > >
> > > Maybe this is a common problem, thus I am thinking that potentially we
> > > should enable the workaround for all variants?
> > Not sure if this is of any help, but: we use the btmtksdio driver on a
> > MT8183 soc with an Android kernel based on upstream.
> >
> > With that kernel, we did not to apply this work-around in order to
> > have a stable bluetooth experience (pairing with a remote controller)
> >
> > However, on the MT8516 SoC, it's impossible for us to use btmtksdio
> > without Fabien's fix.
> >
> Yes. For mt8516 SoC,recheck_sdio_irq should be set to true for avoiding
> SDIO dat1 irq lost issue. But for mt8183 SoC, it does not need recheck
> sdio irq mechanism.

Okay, thanks for confirming.

>
> > >
> > > I have looped in Yong Mao (who invented the workaround) and Chaotian
> > > Jing, to see if they can advise us how to proceed.
> > >
> > > In any case, I think we should add a stable tag and a fixes tag.
> > >
> > > Kind regards
> > > Uffe
>
> Hi Ulf,
> Sorry. On the patch "mmc:mediatek:fix SDIO irq issue", I only consider
> fixing the issue on mt8173 SoC.But for the whole MTK upstream SoC,
> mt8183, mt2712, mt6779 and mt8192 does not need this mechanism,
> but the other upstream Soc such as mt8135, mt8173, mt2701, mt7622,
> mt8516 and mt7620 need this recheck mechanism. And all future SoC of our
> company does not need this mechanism.
> If it's convenient for you, please help me to revise it.
> Or I will submit a new patch to correct the value of setting.
> Thanks.

Please submit a new patch to enable the "recheck_sdio_irq" flag for
those variants that need it.

I would also add a fixes+stable tag and add reported-by tags from
Fabien and Mattijs.

Kind regards
Uffe

> > >
> > >> ---
> > >>  drivers/mmc/host/mtk-sd.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > >> index a704745e5882..3dc102eefe49 100644
> > >> --- a/drivers/mmc/host/mtk-sd.c
> > >> +++ b/drivers/mmc/host/mtk-sd.c
> > >> @@ -524,7 +524,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
> > >>
> > >>  static const struct mtk_mmc_compatible mt8516_compat = {
> > >>         .clk_div_bits = 12,
> > >> -       .recheck_sdio_irq = false,
> > >> +       .recheck_sdio_irq = true,
> > >>         .hs400_tune = false,
> > >>         .pad_tune_reg = MSDC_PAD_TUNE0,
> > >>         .async_fifo = true,
> > >> --
> > >> 2.28.0
> > >>
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
