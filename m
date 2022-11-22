Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9E8C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Nov 2022 16:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiKVQar (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Nov 2022 11:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiKVQaj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2022 11:30:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEA56037F
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 08:30:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vv4so27730056ejc.2
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQWta9b89snKxW5vZ+qDHR+s3nQOGeodYtA88E30Q2M=;
        b=XsitaLb2pQkV76VbwWsD/Rh5Ob7kMSLsmOSEI8FGeTdPXYaePt7mkFRBDSPlrQvFR3
         t7pALd/x8ZuS08CFZOLnbaL9ABplB+CollqTSNa/y0qz9hxLFodb7dGoKS0mm1HC42iZ
         toiOxPeVSSaI2J7HGuXSqtmvu8y7kvMR5vmSB2r6PSvQFf+yDElId6K34vX+pPlpuHW+
         +JUBvHvWl9Ym6JWHl3Us2ilHUK9XAusyCzIGaEWxevgAkArrabCO7yrapgW7hKK80OVZ
         YWKSQK/l6oREaGauH4BiIJ7xLR1Z8axOPoXowJTCzQls/3JcG6GJIGkmt22z0Utjpm25
         ft2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQWta9b89snKxW5vZ+qDHR+s3nQOGeodYtA88E30Q2M=;
        b=Fr0idv07EpHPljqvDVqS8M8lja5FIpvbUUkWbWZuSfXp6yeQeFEw8ZCpiWZwMopMDM
         dlQ2zfHjBVtnzyJDv5XyFfQAGqr4Upqo1QZqQS25yt7oocmqGQlxSHySBsLS+a2pXZ2g
         oTa4vJEv4RJVfpklOEM9ogc4ehQnJVnVkxe3pwC0YjeDOm985hS/Pflg4WGmcZkUib/4
         lyCzeosTR9nseZTuGjnML+IE+vxVhssVuk48OQMmliVecz/fMCq4YaVvZyb1bd5TjgKd
         kmY0rFAeS2qCJhEx+oK2wP0uSTksmmcp6VhAf2C2JmYb6ar9/cPwcc/8Rg9tJPj1v3yf
         4CHw==
X-Gm-Message-State: ANoB5pkn5YvGFciz/X3H0ESU0IdkZn/Fq89129aNGHMOChJVyv7hgRK2
        8SRtro3o1xz02yF+6GxyKiN9ewE93Y382ahiTFIVbkGh2y4NtQ==
X-Google-Smtp-Source: AA0mqf709LP7PGo8BHBCPBKiHJuz464PPuce0C9NUPIYYZDRIrmaUVQ+BF7JQcBmCxVR881PRmhJWgalcvM/rhuTo8Y=
X-Received: by 2002:a17:907:98e3:b0:7af:883:ec72 with SMTP id
 ke3-20020a17090798e300b007af0883ec72mr20832081ejc.727.1669134636194; Tue, 22
 Nov 2022 08:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20221110025530.4106568-1-yangyingliang@huawei.com>
 <cd06c6cc-fd5a-1fe4-9570-4266f34918cd@huawei.com> <CAPDyKFrYk9Gr3Fa5mJ2KPebCWXxGFJxZtP47EmXge3CRMtEYQg@mail.gmail.com>
In-Reply-To: <CAPDyKFrYk9Gr3Fa5mJ2KPebCWXxGFJxZtP47EmXge3CRMtEYQg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Nov 2022 17:29:58 +0100
Message-ID: <CAPDyKFqb_Yx26yZ2Ak=q1YTEQBm6rS4r8FXqa5nV5VUf-hMh-g@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mmc: sdio: fixes some leaks
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Nov 2022 at 09:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 18 Nov 2022 at 08:54, Yang Yingliang <yangyingliang@huawei.com> wrote:
> >
> > Hi,
> >
> > On 2022/11/10 10:55, Yang Yingliang wrote:
> > > This patchset fix a refcount leak and two memory leaks about
> > > SDIO function.
> > >
> > > v3 -> v4:
> > >    Drop patch1, keep calling put_device() to free memory,
> > >    set 'func->card' to NULL to avoid redundant put.
> > >
> > > v2 -> v3:
> > >    Change to call of_node_put() in remove() function to
> > >    fix node refcount leak.
> > >
> > > v1 -> v2:
> > >    Fix compile error in patch #2.
> > >
> > > Yang Yingliang (2):
> > >    mmc: sdio: fix of node refcount leak in sdio_add_func()
> > >    mmc: sdio: fix possible memory leak in some error path
> > >
> > >   drivers/mmc/core/sdio.c     | 1 +
> > >   drivers/mmc/core/sdio_bus.c | 6 +++---
> > >   drivers/mmc/core/sdio_cis.c | 3 ++-
> > >   3 files changed, 6 insertions(+), 4 deletions(-)
> > Is this look good to you, or any suggestions?
>
> I need some more time to review them, so I will get back to this early
> next week.

I have re-started to look into these patches, so I will provide you
with some comments very soon.

Although, may I ask how you have tested these changes? Or are the
changes done from a pure code inspection point of view?

Kind regards
Uffe
