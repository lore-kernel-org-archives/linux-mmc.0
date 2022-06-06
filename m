Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4060C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jun 2022 07:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiFFHZc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jun 2022 03:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiFFHZc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2022 03:25:32 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C43151F
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jun 2022 00:25:30 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-30ec2aa3b6cso134289957b3.11
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2022 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zlzaValp4VwBzlkmsUiBpSoeHrVtKniXWHeWkfzuZCc=;
        b=fsA/4pW2UnKptw6JNGrd6U9Z1VcldkWInnaJ5yruBs8a2nY/EsG91pC+pB6sGHkvg6
         BvHTLOx9r1/WWLVaJiCZhasUY0WPa/7kuFvXQrZFhlgiS5WRQWP2bKQUzevGBqfJb2a3
         B2oWFusVmh/oLhhop54/qFTnVpOzQ2Hpz71xDdGkBXMGSztVYvSbcFrfBYngb/9Kzwre
         Dke19fD8/62UFywIq21px6DPS7Mzi0Decg59U+rJzfvTu8KlpUFXbL6vdMWlXrFzTHBM
         8t4+NVrPVU9N6C9jQeS4/j1bvIjvG8r/k7G8xnuiqZhcAIpf/h4hyKQliNVods/vsebW
         Q8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zlzaValp4VwBzlkmsUiBpSoeHrVtKniXWHeWkfzuZCc=;
        b=PO0Hf6EP+4owWnWlOEGy+wiojdGe7mYA/ZMESQMZnW9CWdmrdMTrJmq1AEpBZlACok
         2nGwB2+SrNDsT+7AWBzC+//IZf/uVAGJ3vsxJ8LHf2cSruGU8/FLYPS3s1k+CivxeB5T
         6CcobOkGL4krCgeY42zcFi4xsR0EH798Gfe5GBiaXqAnGj7Jj+9Len55ncb/GRie4tM+
         t6w8qwmQYVpEBTDNjJrbeVHwe1fKTEJBGehhfShGn95/Q2BFnocGm2OYw1xQN0B7qtnW
         p6FBdfoItCzul3754MbZGnSkXTsHpUosCgrT0Lbw9Kvxk57YjF88pDuleS+pR/jAG+Tb
         +/Mw==
X-Gm-Message-State: AOAM532BEU+FLtqql11oKf9sMUINu6unh9RqcutymUTvXa303BOgr+Zo
        2Df1+QiLU/6sovEGyMtPRBmFDyvSISr8e4/Oy9o=
X-Google-Smtp-Source: ABdhPJyXI1af4SOOt1H/I8vBP6RrgkWV6Y82oARAeVVLErJ5z4bVENG1R/NytKPhv1il+BH1LK9RcuVvPesk+U3qcG4=
X-Received: by 2002:a81:a0d:0:b0:30c:2422:7931 with SMTP id
 13-20020a810a0d000000b0030c24227931mr24704581ywk.53.1654500329786; Mon, 06
 Jun 2022 00:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Mon, 6 Jun 2022 15:25:19 +0800
Message-ID: <CAG0XXUF_YrNHNHPPNRjLSiycYyaAZuwaeCG3XpP_HVJrqYsy-w@mail.gmail.com>
Subject: Re: [PATCH V4 0/6] Preparations to support SD UHS-II cards
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        SeanHY.chen@genesyslogic.com.tw,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        victor.shih@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

Do you have any comments for this patch set?
If you think this patch set is ok, we will proceed to integrate UHS2 host part
of code with this patch set.

kind regards,
Jason Lai

On Mon, Apr 18, 2022 at 7:58 PM Jason Lai
<jasonlai.genesyslogic@gmail.com> wrote:
>
> Series [1] that has been posted by Ulf Hansson which provided some
>  guidance and an overall structure.
>
> Series [2] focused on UHS-II card control side to address Ulf's intention
>  regarding to "modularising" sd_uhs2.c.
>
> Series [3] is based on series [2] and adopt most of Ulf's comments.
>
> Series [4] is based on series [3] and refined by Ulf Hanssion.
>
> This series is the successor version of post [4], which is base on Ulf's
>  "wip_uhs_v3" branch:
>   1. Implement call back functions in sd_uhs2_ops.
>   2. Adopt Ulf's comments for V3.
>
> [1]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=438509
>
> [2]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=589827
>
> [3]
> https://patchwork.kernel.org/project/linux-mmc/list/?series=606241
>
> [4]
> https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/log/?h=
> wip_uhs_v3
>
> Jason Lai (2):
>   mmc: core: Add definitions for SD UHS-II cards
>   mmc:core: Support UHS-II card control and access
>
> Ulf Hansson (4):
>   mmc: core: Cleanup printing of speed mode at card insertion
>   mmc: core: Prepare to support SD UHS-II cards
>   mmc: core: Announce successful insertion of an SD UHS-II card
>   mmc: core: Extend support for mmc regulators with a vqmmc2
>
>  drivers/mmc/core/Makefile    |    2 +-
>  drivers/mmc/core/block.c     |    5 +-
>  drivers/mmc/core/bus.c       |   38 +-
>  drivers/mmc/core/core.c      |   33 +-
>  drivers/mmc/core/core.h      |    1 +
>  drivers/mmc/core/host.h      |    4 +
>  drivers/mmc/core/mmc_ops.c   |   24 +-
>  drivers/mmc/core/mmc_ops.h   |    1 +
>  drivers/mmc/core/regulator.c |   34 +
>  drivers/mmc/core/sd.c        |   11 +-
>  drivers/mmc/core/sd.h        |    3 +
>  drivers/mmc/core/sd_ops.c    |    9 +
>  drivers/mmc/core/sd_ops.h    |    3 +
>  drivers/mmc/core/sd_uhs2.c   | 1377 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/card.h     |   47 ++
>  include/linux/mmc/core.h     |   13 +
>  include/linux/mmc/host.h     |   83 ++
>  include/linux/mmc/sd_uhs2.h  |  263 +++++++
>  18 files changed, 1916 insertions(+), 35 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.c
>  create mode 100644 include/linux/mmc/sd_uhs2.h
>
> --
> 2.35.1
>
