Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33C1C11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 08:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1CA661411
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 08:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGBIeh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 04:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhGBIeg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 04:34:36 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CB3C061762
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jul 2021 01:32:04 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l26so5363917vsm.9
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jul 2021 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvKH7IIpuJAEdgs32qZwiaP5LHq3XTcSeuuaSInGOQY=;
        b=MrOU425CS8c7RefYtct13RICCJwWKv6Ah2UITIbzGCIZMnKovZwvyky073spt7RCjZ
         sYfoGRNDFir1uwAutc6TmwaHHHJemVpl+w65O2PMqb1l+r2CuBOmOYWyBR+gyVjwBzQV
         +HWpXmXyC8dJvSSvDgvGuMIxPy0qF03BhmRkQiiBFxb+wEkuVdvWJ+6/2sM9sKTjPGKz
         0rs/1sVJmxzdaUyBCi7K/AU2W50EpkvJ7eVggL8DgpxiHHW41OgS6FJBQ0UlwCnlJkZN
         lJdcldrfq/JtVlEvaqEDI56K+UBimHdZuuhvWHmfdvn/dd9uBV00qvxY5WfYUUJ6EbwU
         Lw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvKH7IIpuJAEdgs32qZwiaP5LHq3XTcSeuuaSInGOQY=;
        b=sE25m3mEYXB53Q0D5dXaoxeZAMdvitBSBu8diNawWJTpW7H4NGdjPWxNWmku7ZvXOt
         YXN5TdzUoLtbPLp0WSLOwRsAQWrZixyGSJ1piLUUJpuskXpQE2EbIoXnt67IsKlLURvL
         pIHjjonsO0eh7qgIAyplxb2QJxOZcShaTS4cYgRanYr1KWoQJPOZFiSW2cKUhc77d1v+
         gkpkPimY+hYMk1hYL0tPLVtDMliCSH1FZYncQwpatzPf+9iSuA3VIrcSV6d4BcKCzVxe
         hWHRvqrs7HuiqAziNdCNUjCdCigd48lathBdxZuuqnar4P6iwvaZNItAQC/yNaYsvxAU
         pauw==
X-Gm-Message-State: AOAM531F4SfsfVZbjzKkPuYQkwJ2ssSaWX43jTvGnq8yF/9+EqLloFGJ
        ODVp2hbLar/4oUDX7ORVDAMOukNuof4hNJRWhwa06w==
X-Google-Smtp-Source: ABdhPJzQakvY0KLDzXhlOhKRUimDMNEqgH7KgkF95g8jAkDqWMcLpQvTkt8SPtG0ROHJ0P/karXYTx30SDAju4yHXCU=
X-Received: by 2002:a67:8783:: with SMTP id j125mr5325660vsd.42.1625214723333;
 Fri, 02 Jul 2021 01:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210225170352.76872-1-ulf.hansson@linaro.org> <20210225170352.76872-3-ulf.hansson@linaro.org>
In-Reply-To: <20210225170352.76872-3-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Jul 2021 10:31:26 +0200
Message-ID: <CAPDyKFrjSNW9fYDrTB4sJZBkncBFHj1u-VOT4RfgHPv_ZMpCqg@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: core: Prepare to support SD UHS-II cards
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ben Chuang <benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Jul 2021 at 08:58, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> Hi Ulf,
>         You added one bit definition 'MMC_CAP2_SD_UHS2' in struct mmc_host.caps2.
>         But there already had a bit definition 'MMC_CAP_UHS2' in struct mmc_host.caps.
>                 #define MMC_CAP_UHS2    (1 << 26)    /* Host supports UHS2 mode */
>
>         This bit was first appearred in [RFC PATCH V3 01/21] mmc: add UHS-II related definitions in public headers.
>         These 2 bits seems to be defined for the same purpose, which one should I use?

The series that $subject patch is part of isn't based on any other
UHS-II series that has been posted. Its main goal is to put the
foundation in place for the mmc core to support UHS-II, but more
developments are certainly needed on top.

Moreover, Akashi-san posted another version of the series [1] you are
referring to, which should be rebased on top of my series. But that's
not sufficient, as additional changes is needed to make this play, I
suppose you already knew that.

>
> kindly regards,
> Jason Lai

[...]

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/cover/20201106022726.19831-1-takahiro.akashi@linaro.org/
