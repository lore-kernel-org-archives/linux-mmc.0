Return-Path: <SRS0=Un3z=CS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93510C433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Sep 2020 17:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410CC21D7E
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Sep 2020 17:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDxiHWdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgIIRUI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgIIP0h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2020 11:26:37 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509AC061756
        for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2020 04:11:02 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x203so1080299vsc.11
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2020 04:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khWyhAe+lN07SqtNkMSWgvbuoeZTuOj4AYam/mxcJqA=;
        b=VDxiHWdoA6M16HlkWBnXofA9gCh5u4mUs3a4g7d3yx3bXnwWeVnhEbXVxfNOJ2jsWI
         uZA6+5fKK7Wyj/Va++px8gtMcgyBMzUXpSQNPXFXZoueO33i291qK/z2eKBpKr1mchb6
         e6n8SewJ4hFBL6xSc7xSUF4yHAb2r9JosEIGXan6ZOo61vc8lvHt6bA1IEC/WfNjFdcs
         Kr7VLRW4ih/5x974ps3zfEJuQiSfzL6vMkLq617OQhkXn3yvy3PN6PhgF6W+6+s8Ni0+
         p1+FZHQqiwk1Dac+xzQf5H/1Gn2022/S8eQFdX7jRVHQyldLJc0Qszr8GfxwgOLcUllm
         5llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khWyhAe+lN07SqtNkMSWgvbuoeZTuOj4AYam/mxcJqA=;
        b=szhe3l30+8bdQj8at24+8WHh5gE6r3FStM9I0eyOXmbFEkd/i7u+maGbtDkf+QxTW3
         wgled2K96QCzC/OPJK8SYt4DRQn5jWJ74TjONDipvsPxsMtlpdVUvZCndmg6oT4FPi7V
         cF9sUrM3dL1PssEsvABmovX9kh2zNMMzXDjkov9p4SFGM4dYEjEWji6CpmfM199ItGRt
         7/bCWAVcgihWsvtjm4lm1zo28sYNeqrU4r+EO0w9u4bZEBBy3sQBpOlCk1srK78QUxXL
         7XDzRdn6UVL03AilBqZbnWteFlFlilFFm6Hbga6lCc0sllDMw4YKHr8WGlywm34gmIOI
         BIbA==
X-Gm-Message-State: AOAM533v88kSOmQBISTool8yMllDZrDZKlUXQjbRlrt0ooFQlwkO9+NQ
        eo/J4IUNE9nD8B3LAByqPx7DkrRW/Ra5WhIQHClN8g==
X-Google-Smtp-Source: ABdhPJyrhzUCjcXsxzlSgTTgLnzBPVGFjXoK2d+f6coDVgjEfNWL7TMizPQxlX5earJnYx3MmYEBFJXkH/Ia4T3/tI0=
X-Received: by 2002:a67:e355:: with SMTP id s21mr123357vsm.50.1599649861771;
 Wed, 09 Sep 2020 04:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200902081812.1591-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200902081812.1591-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Sep 2020 13:10:25 +0200
Message-ID: <CAPDyKFq6NiK1dopS=mBd2r8Eq3TwbT8ZfRG7ujWbYEKeAbDokg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: renesas_sdhi: support manual calibration
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Sep 2020 at 10:18, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Some R-Car Gen3 SoCs need corrections after they tuned to HS400. This
> series implements that. Please have a look at the patch descriptions for
> details. The origins were patches in the BSP from Takeshi Saito.
>
> Changes since v1:
>         * correction is now enabled after tuning is complete not when it
>           is initiated
>         * rebased to new version of "fix stalled SCC series" which is a
>           dependency for this
>
> There is a branch for testing here (with the debug patch on top):
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib-for-5.10
>
> Current test results (little different to v1):
> ----------------------------------------------
>
> An SDHI instance with a HS400 capable eMMC connected (R-Car M3-N):
>
> When preparing HS400 tuning, a calib table is found. So, (potential) old
> HS400 tuning gets reset and the manual adjustment gets disabled. Unlike
> previous series, the runtime flag is not enabled yet.
>
>      kworker/1:2-139   [001] ....     4.160517: renesas_sdhi_reset_hs400_mode: ee140000.mmc: calib table ffff800010bc15f8
>      kworker/1:2-139   [001] ....     4.160522: renesas_sdhi_reset_hs400_mode: ee140000.mmc: adjustment disabled
>
> Lots of tuning CMDs, runtime flag still disabled:
>
>      kworker/0:1-21    [000] ....     4.160630: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.160725: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.160831: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.160936: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161024: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161122: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161214: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161305: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161407: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161496: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161579: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161669: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161762: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161845: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.161927: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.162011: renesas_sdhi_fixup_request: ee140000.mmc: opcode 21, flag 0
>      kworker/0:1-21    [000] ....     4.162074: renesas_sdhi_fixup_request: ee140000.mmc: opcode 6, flag 0
>      kworker/0:1-21    [000] ....     4.162612: renesas_sdhi_fixup_request: ee140000.mmc: opcode 13, flag 0
>      kworker/0:1-21    [000] ....     4.162671: renesas_sdhi_fixup_request: ee140000.mmc: opcode 6, flag 0
>      kworker/0:1-21    [000] ....     4.162722: renesas_sdhi_fixup_request: ee140000.mmc: opcode 13, flag 0
>      kworker/0:1-21    [000] ....     4.162778: renesas_sdhi_fixup_request: ee140000.mmc: opcode 6, flag 0
>
> Tuning was successful, now the runtime flag gets enabled:
>
>      kworker/1:2-139   [001] ....     4.163274: renesas_sdhi_hs400_complete: ee140000.mmc: flag enabled
>
> First CMD13 after successful tuning, enable adjustment, clear runtime
> flag, show replacement value. The replacement value is now also around
> 16 which is what Shimoda-san said to be an expected value at room
> temerature. It used to be 31 in v1 of the series.
>
>      kworker/0:1-21    [000] ....     4.163416: renesas_sdhi_fixup_request: ee140000.mmc: opcode 13, flag 1
>      kworker/0:1-21    [000] ....     4.163421: renesas_sdhi_fixup_request: ee140000.mmc: adjustment enabled, flag disabled
>      kworker/0:1-21    [000] ....     4.163422: renesas_sdhi_fixup_request: code 17 replacement 18
>
> Normal operation continues. Some switching and block reads:
>
>      kworker/0:1-21    [000] ....     4.163592: renesas_sdhi_fixup_request: ee140000.mmc: opcode 6, flag 0
>      kworker/0:1-21    [000] ....     4.163645: renesas_sdhi_fixup_request: ee140000.mmc: opcode 13, flag 0
>      kworker/0:1-21    [000] ....     4.163700: renesas_sdhi_fixup_request: ee140000.mmc: opcode 6, flag 0
>      kworker/0:1-21    [000] ....     4.163747: renesas_sdhi_fixup_request: ee140000.mmc: opcode 13, flag 0
>      kworker/0:1-21    [000] ....     4.217134: renesas_sdhi_fixup_request: ee140000.mmc: opcode 17, flag 0
>      kworker/0:1-21    [000] ....     4.217357: renesas_sdhi_fixup_request: ee140000.mmc: opcode 17, flag 0
>         ...
>
> And then checksumming a large file works without performance
> regressions. Unlike the previous version, retunes do not happen
> occasionally, so the new replacement value is indeed better.
>
> So, again a lot of text but I want interested parties to verify results.
>
> Looking forward to comments, although I won't complain if this is the
> final version ;)
>
> Thanks and kind regards,
>
>    Wolfram
>
>
> Wolfram Sang (2):
>   mmc: tmio: add generic hook to fixup after a completed request
>   mmc: renesas_sdhi: support manual calibration
>
>  drivers/mmc/host/renesas_sdhi.h      |   5 +
>  drivers/mmc/host/renesas_sdhi_core.c | 152 ++++++++++++++++++++++++++-
>  drivers/mmc/host/tmio_mmc.h          |   1 +
>  drivers/mmc/host/tmio_mmc_core.c     |   3 +
>  4 files changed, 159 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>

Applied for next, thanks!

Kind regards
Uffe
