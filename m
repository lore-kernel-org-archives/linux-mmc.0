Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BAC433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 03:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF05E6109F
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Sep 2021 03:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhIGD7r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhIGD7r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 23:59:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44DBC061575
        for <linux-mmc@vger.kernel.org>; Mon,  6 Sep 2021 20:58:41 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id z18so17182259ybg.8
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2021 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQ4QoSTYj21ISfjM9eDJUQR9IYQt0dq5bvuYxxR/hGM=;
        b=A9OaIAMPad6jjkwEiSic0rNWc5AToTIwaKyDjqjyLmgkAyUs3yNfa9oNm+q+mNYP6n
         OgHi6rC1jLV6GI80x3w86xJbRrG5hOVgq6alcJOC08/8WlOpWm4jyWN0Aoj4ZGP7yi1U
         FnmlZ+pPcp3pxHLBo0x41GwjfDiFW9DPizNSlOaEDLQVf2fCKrQoN7/zcN7IRWKMLEyq
         1aCpfMwnCbUGzBBXWKP+W4ciSvj5lWe/VKwx9EUiWyP5pMwkFoqHMxwOThR1vIAX0/Dg
         VWezfcwvEyGRMPa0admcz1utB0VPqHkdfnIFvKVEtsSscSaB0Dp5yuMFQQvAVBccFflD
         PhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQ4QoSTYj21ISfjM9eDJUQR9IYQt0dq5bvuYxxR/hGM=;
        b=Q+xQyq4ykJYaxxHoLk1qlNfPWyK1kKcWJDdoXZTHYp6SFFJ0PCSLqQJlpwgd+RTPaA
         F2XgGJMmaA+bP5IyxGD2FQDIcx3l+nhdiG4CvVCzCF9tVNQ1B6UzTdVEbt8Kwc37gI0/
         eMWYNFWYksyfm3DkveonfFUCLR7miVHCkV2wd3KZuKHbS6LKcwnDfu15C0vnqS86Yh5/
         gCzRd1uR35Vv/PbAtu6kF3gekcKP+YpFl/D5Y37EI9arEap8X2P4Cv7xFg4IjoNqwwF3
         GsHOuRWJMf4tv/NEJ89E4l3DO9u19BNBXcfFJcdPpJm29XvZoWi9rJ4eBB9Cqfp2quWE
         lhZA==
X-Gm-Message-State: AOAM5310i4NIYO6ABW/4H6mCK3at12/ZZgGCgZdyWmACzKmcJOq2tIWd
        gelCk+XKBt1ck0QHUt/s6mvBohmoyptWaHRREfc=
X-Google-Smtp-Source: ABdhPJzH4xWfTOUWi5EW/kieTQOAM9s9On7d/LLh9lCipJF5JATreofvdlEGpoKnhUNNp21DZYvLZL7lCZTjV5twTKU=
X-Received: by 2002:a25:16c6:: with SMTP id 189mr19574289ybw.27.1630987120819;
 Mon, 06 Sep 2021 20:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210831110043.50447-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20210831110043.50447-1-jasonlai.genesyslogic@gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Tue, 7 Sep 2021 11:58:29 +0800
Message-ID: <CAG0XXUH9N4nRpGM=Dg5rCVWU3CNc0TJ0SY7vXq7S=aLEMuTDpg@mail.gmail.com>
Subject: Re: [PATCH 0/7] mmc: core: Preparations to support SD UHS-II cards
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear Ulf,
    Do you have any comment or suggestion about this series of patches?

kind regards,
Jason Lai

On Tue, Aug 31, 2021 at 7:00 PM Jason Lai
<jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> A series [2] that has been posted by Ulf Hansson which provided some
> guidance and an overall structure. This post is the successor version of
> series [2]. It is focused on UHS-II card control side to address Ulf's
> intention regarding "modularising" sd_uhs2.c.
>
> Some functions in mmc host part must be modified in order to support UHS-II
> card control. Those changes are not included in this post.
>
> Kind regards
> Jason Lai
>
> [2]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=438509
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
> Jason Lai (3):
>   mmc: add UHS-II related definitions in headers
>   mmc: Implement content of UHS-II card initialization functions
>   mmc: core: Support UHS-II card access
>
>  drivers/mmc/core/Makefile    |    2 +-
>  drivers/mmc/core/bus.c       |   38 +-
>  drivers/mmc/core/core.c      |   43 +-
>  drivers/mmc/core/core.h      |    1 +
>  drivers/mmc/core/host.h      |    4 +
>  drivers/mmc/core/regulator.c |   33 +
>  drivers/mmc/core/sd_uhs2.c   | 1184 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/core/sd_uhs2.h   |   21 +
>  include/linux/mmc/card.h     |    7 +
>  include/linux/mmc/host.h     |   31 +
>  include/linux/mmc/sd_uhs2.h  |  269 ++++++++
>  11 files changed, 1613 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>  create mode 100755 drivers/mmc/core/sd_uhs2.h
>  create mode 100755 include/linux/mmc/sd_uhs2.h
>
>  ------ original cover letter from Ulf's series ------
> A series [1] that has been collaborative worked upon by Takahiro Akashi
> (Linaro) and Ben Chuang (Genesys Logic) is targeting to add SD UHS-II
> support
> to the mmc subsystem.
>
> Throughout the reviews, we realized that the changes affecting the mmc core
> to
> support the UHS-II interface/protocol might not be entirely straightforward
> to
> implement. Especially, I expressed some concerns about the code that
> manages
> power on/off, initialization and power management of a SD UHS-II card.
>
> Therefore, I have posted this small series to try to help to put some of
> the
> foundation in the mmc core in place. Hopefully this can provide some
> guidance
> and an overall structure, of how I think the code could evolve.
>
> More details are available in the commit messages and through comments in
> the
> code, for each path.
>
> Kind regards
> Uffe
>
> [1]
> https://lkml.org/lkml/2020/11/5/1472
>
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
>
>  drivers/mmc/core/Makefile    |   2 +-
>  drivers/mmc/core/bus.c       |  38 +++--
>  drivers/mmc/core/core.c      |  17 ++-
>  drivers/mmc/core/core.h      |   1 +
>  drivers/mmc/core/host.h      |   5 +
>  drivers/mmc/core/regulator.c |  34 +++++
>  drivers/mmc/core/sd_uhs2.c   | 289 +++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h     |   6 +
>  include/linux/mmc/host.h     |  30 ++++
>  9 files changed, 404 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>
> --
> 2.32.0
>
