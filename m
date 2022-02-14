Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124CEC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Feb 2022 12:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353346AbiBNMnR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:43:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbiBNMnP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2022 07:43:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58867BCB2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2022 04:43:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u16so853266ljk.2
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2022 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lby/Xq3zeSdwLYFqFcNCZex0NU9UDxdlMx4IZhnNetU=;
        b=aZpkT/KqmcamTV8KiwEHo1S9IiELeX4JE4aA8Fabn93WtY53TDmdSGwTcVDRQl0pOX
         1nUHpgKKlDZZigBKDcpcuicotu0YpO2R0BxpUzW9VNF0xamZSENPvr3cP19Pmf3Gy1Sb
         WTF9R2F4Hc9vtEr52wZkwgnb/FGeL9pT7r3MqGab3E64tenFs7P0yJpffSUq13aSjZJG
         6ylQmJnvqkoBOTiszsJ3WlSOZO4Fyg8UZuSkANOhHE6Z4pBTZJKOYuY9Uj06Lkro3/OE
         gV7uaYUJfhpVn0m2ESdfGXoma37/3weQlJTYFW5rqJ3Kw9a+lMqvexA8pt/QXhdf6ybJ
         fzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lby/Xq3zeSdwLYFqFcNCZex0NU9UDxdlMx4IZhnNetU=;
        b=lxWvL4rVUghXmO+YcHWi9iNzi+RsaLZP97ww2vgHTikN1K47HfPyl9ciR/JQjnNJXY
         buE2Bqbp4xlZGNXSMLTZWnut9yoDYJQFR1IdLHXewRMeo4oXx020H4/QyU00Gyk/zuek
         mwrXLXzEZ36Q8bap6aHZvc5zdH7vQz17Lzn/mtf0Hg9X8xwKt/vpA2ScjkWsVw9n0G6J
         YsL3wifpy9Al4qPg+GgTAmcCDMESiGjfLxR8hK+vhM4DnX1zO2k9U/rY9MYDeXkkkzSX
         Bxd46Su0EQtp08xJKqa0azlr9TJMlTeEwCQ4UUsPhb1UBsz1tvypl1tjG2kIz8ZzAu+c
         oZ/A==
X-Gm-Message-State: AOAM532fDSpYkWZiF+sEeEuP07MHF8JhKU399CDcUYmYLrokavqHO4dg
        zlQPlTWdDEUX9AbEAlWIx5hbDETB+RFDDJWFIfzWVg==
X-Google-Smtp-Source: ABdhPJyDVBRyQt1+0dL+8+fMjWHZj37iJbjDmriFwn0ROM8UHoYxWAyxtm+qvJvXcTdIx8zl+BruZLuOQ2VQbLJLx3U=
X-Received: by 2002:a2e:9656:: with SMTP id z22mr4908404ljh.273.1644842585462;
 Mon, 14 Feb 2022 04:43:05 -0800 (PST)
MIME-Version: 1.0
References: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Feb 2022 13:42:29 +0100
Message-ID: <CAPDyKFo-yGcnmwyHzzRBnR33=1HSxYeJ9rBnKXY8AkK148Lofw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Preparations to support SD UHS-II cards
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     takahiro.akashi@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, Jason.Lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 18 Jan 2022 at 13:44, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> Series [1] that has been posted by Ulf Hansson which provided some guidance
> and an overall structure.
>
> Series [2] focused on UHS-II card control side to address Ulf's intention
> regarding to "modularising" sd_uhs2.c.
>
> Series [3] is based on series [2] and adopt most of Ulf's comments.
>
> This series is the successor version of post [3], which adopts Ulf's
> comments about series [3]:
> 1. Remove unnecessary debug print.
> 2. Rephrase description about uhs2_cmd_assemble() in sd_uhs2.c
> 3. Place UHS-II variables in the appropriate structure.
> 4. Integrate 5 callback functions in host->uhs2_host_operation().
>
> Kind regards
> Jason Lai

Hi Jason,

I have looked through the series, but I again find it a bit difficult
to review, sorry. I couldn't apply the patches to my next branch (so I
fixed that manually), the patches don't build and I get a lot of
checkpatch errors/warnings.

I tried to help out and worked on fixing these issues and to improve
the series. However in the end it turned out to be more work than
expected and time I don't have at the moment.

To move forward, may I suggest rebasing the series on top of my latest
next branch, run checkpatch and make sure it doesn't give
errors/warnings, then of course you also need to make sure that each
patch can be compiled. Then we can take it from there.

Kind regards
Uffe

>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=438509
>
> [2]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=539737
>
> [3]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=589827
>
> Jason Lai (3):
>   mmc: add UHS-II related definitions in headers
>   mmc: Implement content of UHS-II card initialization functions
>   mmc: core: Support UHS-II card access
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
>
>  drivers/mmc/core/Makefile    |    2 +-
>  drivers/mmc/core/bus.c       |   38 +-
>  drivers/mmc/core/core.c      |   43 +-
>  drivers/mmc/core/core.h      |    1 +
>  drivers/mmc/core/host.h      |    4 +
>  drivers/mmc/core/regulator.c |   34 ++
>  drivers/mmc/core/sd_uhs2.c   | 1113 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h     |   35 ++
>  include/linux/mmc/core.h     |    1 +
>  include/linux/mmc/host.h     |   68 +++
>  10 files changed, 1319 insertions(+), 20 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>
> --
> 2.34.0
>
