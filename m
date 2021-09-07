Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBEC433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 11:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C74F610FE
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 11:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhIGLFt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Sep 2021 07:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245295AbhIGLFt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Sep 2021 07:05:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D208AC061757
        for <linux-mmc@vger.kernel.org>; Tue,  7 Sep 2021 04:04:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id z2so18767982lft.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Sep 2021 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VShFRjHzNcuAWHeJUWKIUGVP036CFrdM4OfUPcIlap0=;
        b=dvmBhVIk5MXvJ8FsoriquSimSJAT6oA8RFqWGEfOXtwsn5xwVT+/vxCeKQo1K2v5L0
         cdBDnfXGHTeA7jEsr1/UQEiDR6eP934wTyeJKe6JV0g0dGWuKoMU0C/brMTCitNSqUnN
         vadBzPoFzMjeE6WWi/H+8cI2bp9GDYWs977Y7kyhzgmpNkrO9CYtbdCJ2VCADCTt+53z
         US9WTZ2QDKArdL52hpy2jW2T34M7rGKa2VQeAXo1BIJG8T8UyD0ZzL2el83dnBezerXu
         bAA/CQID6HRBuy8Q5nrjDG/MywXjxgxxIX6gi7yakq9/QhB7T9kq3oUQ28LGBxDEw2QP
         50Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VShFRjHzNcuAWHeJUWKIUGVP036CFrdM4OfUPcIlap0=;
        b=PHDc04nPpHzCBYeyNG211W2TCa4oAxF+7x9e57+i+NuKwsZ9u369QXT1sUTDLWwEa+
         rzgi/oLI6CVsBaQmwWTjRXgS2H33MsjOLmKw36B+ZCv3F4D0iKetPgigXnH1ByuzwV38
         b2rzvWA9vlC5jqcMtE+1sgMrI/CzUjynFeAxR8E1MxG7HqO/7vlaR5Gf5uV7E89A90EE
         FTykB0dzQvvop3b5MByASeXhT5CLQEhJtjr1MoZWY/bNIKSvAfr4yoBQZDKF1RpgPX6K
         aVVYGLrP51F16n615f1tLbkOnIaGkVOeg+JCHTFRv9tJ+o8LCFnfTLlDj+HcJzLjW3sO
         nUCw==
X-Gm-Message-State: AOAM533ZbYCWzG/pPwTmAYeS6FXxYaj2iFuVNb/yLhyyXXJThZlRgxR+
        k5NktVAbA5m2p7gjNUaOwD7WWp5AV8KZ9TzgTRB/xw==
X-Google-Smtp-Source: ABdhPJzrIBJ453v24gu4fSmjoH9kSyiEtB6w/D4Dki5/dag1F6KSztvNRFMbRc2JZecWcyIdRRvcAwpu4dyxAwtLnRQ=
X-Received: by 2002:a05:6512:31c7:: with SMTP id j7mr12184412lfe.373.1631012680336;
 Tue, 07 Sep 2021 04:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210831110043.50447-1-jasonlai.genesyslogic@gmail.com> <CAG0XXUH9N4nRpGM=Dg5rCVWU3CNc0TJ0SY7vXq7S=aLEMuTDpg@mail.gmail.com>
In-Reply-To: <CAG0XXUH9N4nRpGM=Dg5rCVWU3CNc0TJ0SY7vXq7S=aLEMuTDpg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Sep 2021 13:04:04 +0200
Message-ID: <CAPDyKFpJCOE8YXVR2VGODFqotfRviAud_5A2tsBCgWgZo8crWQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mmc: core: Preparations to support SD UHS-II cards
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Sept 2021 at 05:58, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
>
> Dear Ulf,
>     Do you have any comment or suggestion about this series of patches?

I will have a look soon, been busy with other assignments and the merge window.

Kind regards
Uffe

>
> kind regards,
> Jason Lai
>
> On Tue, Aug 31, 2021 at 7:00 PM Jason Lai
> <jasonlai.genesyslogic@gmail.com> wrote:
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> >
> > A series [2] that has been posted by Ulf Hansson which provided some
> > guidance and an overall structure. This post is the successor version of
> > series [2]. It is focused on UHS-II card control side to address Ulf's
> > intention regarding "modularising" sd_uhs2.c.
> >
> > Some functions in mmc host part must be modified in order to support UHS-II
> > card control. Those changes are not included in this post.
> >
> > Kind regards
> > Jason Lai
> >
> > [2]
> > https://patchwork.kernel.org/project/linux-mmc/list/?series=438509
> >
> > Ulf Hansson (4):
> >   mmc: core: Cleanup printing of speed mode at card insertion
> >   mmc: core: Prepare to support SD UHS-II cards
> >   mmc: core: Announce successful insertion of an SD UHS-II card
> >   mmc: core: Extend support for mmc regulators with a vqmmc2
> > Jason Lai (3):
> >   mmc: add UHS-II related definitions in headers
> >   mmc: Implement content of UHS-II card initialization functions
> >   mmc: core: Support UHS-II card access
> >
> >  drivers/mmc/core/Makefile    |    2 +-
> >  drivers/mmc/core/bus.c       |   38 +-
> >  drivers/mmc/core/core.c      |   43 +-
> >  drivers/mmc/core/core.h      |    1 +
> >  drivers/mmc/core/host.h      |    4 +
> >  drivers/mmc/core/regulator.c |   33 +
> >  drivers/mmc/core/sd_uhs2.c   | 1184 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/core/sd_uhs2.h   |   21 +
> >  include/linux/mmc/card.h     |    7 +
> >  include/linux/mmc/host.h     |   31 +
> >  include/linux/mmc/sd_uhs2.h  |  269 ++++++++
> >  11 files changed, 1613 insertions(+), 20 deletions(-)
> >  create mode 100644 drivers/mmc/core/sd_uhs2.c
> >  create mode 100755 drivers/mmc/core/sd_uhs2.h
> >  create mode 100755 include/linux/mmc/sd_uhs2.h
> >
> >  ------ original cover letter from Ulf's series ------
> > A series [1] that has been collaborative worked upon by Takahiro Akashi
> > (Linaro) and Ben Chuang (Genesys Logic) is targeting to add SD UHS-II
> > support
> > to the mmc subsystem.
> >
> > Throughout the reviews, we realized that the changes affecting the mmc core
> > to
> > support the UHS-II interface/protocol might not be entirely straightforward
> > to
> > implement. Especially, I expressed some concerns about the code that
> > manages
> > power on/off, initialization and power management of a SD UHS-II card.
> >
> > Therefore, I have posted this small series to try to help to put some of
> > the
> > foundation in the mmc core in place. Hopefully this can provide some
> > guidance
> > and an overall structure, of how I think the code could evolve.
> >
> > More details are available in the commit messages and through comments in
> > the
> > code, for each path.
> >
> > Kind regards
> > Uffe
> >
> > [1]
> > https://lkml.org/lkml/2020/11/5/1472
> >
> >
> > Ulf Hansson (4):
> >   mmc: core: Cleanup printing of speed mode at card insertion
> >   mmc: core: Prepare to support SD UHS-II cards
> >   mmc: core: Announce successful insertion of an SD UHS-II card
> >   mmc: core: Extend support for mmc regulators with a vqmmc2
> >
> >  drivers/mmc/core/Makefile    |   2 +-
> >  drivers/mmc/core/bus.c       |  38 +++--
> >  drivers/mmc/core/core.c      |  17 ++-
> >  drivers/mmc/core/core.h      |   1 +
> >  drivers/mmc/core/host.h      |   5 +
> >  drivers/mmc/core/regulator.c |  34 +++++
> >  drivers/mmc/core/sd_uhs2.c   | 289 +++++++++++++++++++++++++++++++++++
> >  include/linux/mmc/card.h     |   6 +
> >  include/linux/mmc/host.h     |  30 ++++
> >  9 files changed, 404 insertions(+), 18 deletions(-)
> >  create mode 100644 drivers/mmc/core/sd_uhs2.c
> >
> > --
> > 2.32.0
> >
