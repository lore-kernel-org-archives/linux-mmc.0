Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62566C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Mar 2022 13:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241723AbiCWNr2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244475AbiCWNr0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2022 09:47:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3894D13EA3
        for <linux-mmc@vger.kernel.org>; Wed, 23 Mar 2022 06:45:54 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t33so2734820ybt.12
        for <linux-mmc@vger.kernel.org>; Wed, 23 Mar 2022 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKU5wfW4PB31LJ0AB8h55tno/fURIb50R1y2s5kr40Q=;
        b=joQSXFny/tpCaDcsmhQSDieB8aEEh83y83q+BdYdHOinmh1jW3qEbOdozquDHgCbAg
         BnjcswltjIBy0o2N/9nKhNqiaSRuIIDslX2E2IC0+WgSnTtQFJDZw+yXj6qtgvebJVRh
         idHRnSozINRpUeCT/tRll2CKx9KHYItfMF8vCrkSxqscI5qbWzLBCTIwB6P3u6gxe+Qh
         ZJHiXdjW5gqerctMMenWVatMZr42VYbsj/kF7ncFKn3NsRiCqbrcWe1JZcMNYAJ9+UTR
         cI7tKXgGo7TAuoZ7ONy9r123ldnfRpZva9Xr45sRsGxioIYxAy55KrHI1njv1kgxr10Z
         E3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKU5wfW4PB31LJ0AB8h55tno/fURIb50R1y2s5kr40Q=;
        b=TFnyi/gF07Droizd6sEyQ9CPzhepjADTNFxR/GkVneLa+/1paqbEK1ZzxDGSIQvdLX
         tA9qGeB5i7wJ1/4Jaw/URQXSokXmLl3K/G80CTwhog0HXkrzitJQ8kWhn6ZZbZgNS26U
         oJBZDvKTJqgxFra6ySee0hJIhPFf/GRH3eJe6O4fiBZx6OCdksZVqn4AGRHa3SEnuxB8
         JTl1qqfGDB47RQj16Mlz+5XEQcob5I32VHY8Wun3Wcap4Z/e2Ff2qsde2aHBS88gej+G
         cobkNfgvueia5Ou+94wjivcamVsGoPjq9PmkdBDj08UzeMQj24QQtM0aA3GCsrjAsPBf
         +DUw==
X-Gm-Message-State: AOAM531p6f5RM29phfw7CAE/QUh6qAr4ZqbEnoJqO9DsnaYOOKnU6r4l
        4iUIjVaGcUxY/+fzJgx/aT3zpNjxcohF55ajRt8GAw==
X-Google-Smtp-Source: ABdhPJwbhBBmF3qXvGDZ7hoOgXRItNFoJ0N3smkCnJhXxHLNAPH5LyehJWaKyLl/PGkIq0fKDInVNCu7HWowankYGiw=
X-Received: by 2002:a25:c5d2:0:b0:636:e78a:866d with SMTP id
 v201-20020a25c5d2000000b00636e78a866dmr271469ybe.225.1648043153768; Wed, 23
 Mar 2022 06:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com> <CAPDyKFo95H+AjoD5Z4TgYwALt1akSbv=E0i_QbKr3tdARMCdtg@mail.gmail.com>
In-Reply-To: <CAPDyKFo95H+AjoD5Z4TgYwALt1akSbv=E0i_QbKr3tdARMCdtg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 23 Mar 2022 14:45:17 +0100
Message-ID: <CAPDyKFpoX9-yiuw3U-ggOUUrjZ2KLRrJLBC8YgBS=ETc0KZqgg@mail.gmail.com>
Subject: Re: [PATCH V3 0/7] Preparations to support SD UHS-II cards
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     takahiro.akashi@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Jason.Lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Mar 2022 at 14:16, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Hi Jason,
>
> On Tue, 22 Feb 2022 at 04:39, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > Series [1] that has been posted by Ulf Hansson which provided some guidance
> > and an overall structure.
> >
> > Series [2] focused on UHS-II card control side to address Ulf's intention
> > regarding to "modularising" sd_uhs2.c.
> >
> > Series [3] is based on series [2] and adopt most of Ulf's comments.
> >
> > This series is the successor version of post [3], which is base on Ulf's "next" branch 2022/02/14):
> > 1. Modify settings in uhs2_config_write().
> > 2. Fix some compilation errors.
> > 3. Fix some warnings and errors when executing checkpatch.pl.
> >
> > Kind regards
> > Jason Lai
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-mmc/list/?series=438509
> >
> > [2]
> > https://patchwork.kernel.org/project/linux-mmc/list/?series=589827
> >
> > [3]
> > https://patchwork.kernel.org/project/linux-mmc/list/?series=606241
> >
> > Jason Lai (3):
> >   mmc: add UHS-II related definitions in headers
> >   mmc: Implement content of UHS-II card initialization functions
> >   mmc: core: Support UHS-II card access
> >
> > Ulf Hansson (4):
> >   mmc: core: Cleanup printing of speed mode at card insertion
> >   mmc: core: Prepare to support SD UHS-II cards
> >   mmc: core: Announce successful insertion of an SD UHS-II card
> >   mmc: core: Extend support for mmc regulators with a vqmmc2
> >
> >  drivers/mmc/core/Makefile    |    2 +-
> >  drivers/mmc/core/bus.c       |   38 +-
> >  drivers/mmc/core/core.c      |   43 +-
> >  drivers/mmc/core/core.h      |    1 +
> >  drivers/mmc/core/host.h      |    4 +
> >  drivers/mmc/core/regulator.c |   34 ++
> >  drivers/mmc/core/sd_uhs2.c   | 1088 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/core/sd_uhs2.h   |   16 +
> >  include/linux/mmc/card.h     |   35 ++
> >  include/linux/mmc/core.h     |    6 +
> >  include/linux/mmc/host.h     |   69 +++
> >  include/linux/mmc/sd_uhs2.h  |  198 +++++++
> >  12 files changed, 1514 insertions(+), 20 deletions(-)
> >  create mode 100644 drivers/mmc/core/sd_uhs2.c
> >  create mode 100644 drivers/mmc/core/sd_uhs2.h
> >  create mode 100644 include/linux/mmc/sd_uhs2.h
> >
>
> I decided to help out a bit and are working on some improvements to
> some of the patches from this series.
>
> Although, rather than me reposting new versions of these patches, I
> will share a public branch via my mmc git tree within a few days. It
> will be based upon the v3 series, but incorporating some new changes
> from my side. The changes will be explained as a part of the commit
> messages. I will let you know as soon as the branch is available and I
> am also reviewing your series, so will provide you with some comments
> soon.

Hi Jason,

So I have worked on some various improvements for this series and have
amended the patches here in v3. It's mostly cosmetic changes along
with some restructuring of the code. I have described the changes in a
specific section in each of the commit messages (please remove these
parts before posting a new version).

git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git wip_uhs2_v3

Going forward, I will continue to review the series and provide you
with some additional comments.

For the next submission, I suggest you start from the branch I
provided above. I would also appreciate it if you can provide some
information of what has changed for each of the patches in the series,
when you post a new version. This makes it easier to review.

Kind regards
Uffe
