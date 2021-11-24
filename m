Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46F5C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 19:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbhKXT2u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 14:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245493AbhKXT2p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 14:28:45 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366DC061748
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2021 11:25:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m27so9938384lfj.12
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2021 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeS8gzA/xfPhh34ugNpumxJ4yVD03DKGSAXtYcv0CNY=;
        b=SAc/SLcjr/Co2yuN16R4GlaVzZSj3SGoLB+z8GEtc5h3aU8zidJIe+uJIfa5Bt3D1m
         nuadLC4dAavDlWMr1PeQuweQd+2WdTckNNsIconSEReAJErSpN6N4gfv9qVsidgXYX4W
         DgLzz9OtmsjjUCln49Mp1puk5J/PS0oP5pNQGW6/PODbWKgIQA2683kIWTMVDF2u1GaU
         zUk/hBrZv/Y5JYpAKGEZV59d7yKkGNXiC8ECZpl5WSyDCfVqbJatNNvZekBqH872CrLv
         DnkBT6Ag/Y+r1nbhQmm3dynY5ZAPZOqTB78XiVuqR4zUUwyampX0urGluugIt56Dj2tu
         WlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeS8gzA/xfPhh34ugNpumxJ4yVD03DKGSAXtYcv0CNY=;
        b=x/3tIthjRaEG/Jmj4wKQNiB/4C8Aw3/Rrt7t2ZDJUuLBkQf4i7PBi07d/eumU3b6cU
         JoTax4kCA0BKETg4K4v3keLU7BCaHdhca5U2aJ+bYfJe0Quaght6rX568USTu3AQs3zK
         a20u4qNZ9M1am8n6LS2ywY5gnTXxfu74nZ18tP2cctXQwonyCE4SxMyZNQVGQfHlFgrI
         6f/qSXe2x93ucTEkWtGue4UOzYLBZN7OEr9TMBMW8wDXtLXr7ZtoPBwEXTm5lPp3HNz7
         yy/9RqCApwXRLTwN3LQUyIv7sUjAD202jWafgiALyijTkP/283aD35BIAgKrLA3CReWy
         vssA==
X-Gm-Message-State: AOAM532D7LtF1Sz94T3BFgF32ocV8fXPDGQZknvXKic12+5Y2qXc18rj
        k2sI6La+fVxjBIMk5j+m/iateI04Pf2kd8MBXYQ3Z/BKYDk=
X-Google-Smtp-Source: ABdhPJzSEYCURJSiTw//vdik61HAkzTY0+VAOHaDC/VmX4bo1DEpc6xicGzGrpeh42Ukrn7jGcsGzS4EiBrSWD3re9Y=
X-Received: by 2002:ac2:5a46:: with SMTP id r6mr18103844lfn.358.1637781932136;
 Wed, 24 Nov 2021 11:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20211124184603.3897245-1-john@metanate.com>
In-Reply-To: <20211124184603.3897245-1-john@metanate.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Nov 2021 20:24:56 +0100
Message-ID: <CAPDyKFr=ok3uKXS8bWtZPvyLOeA2cF_4Z2c7ROcoMfBF2G1uhA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: start deprecating mshcN aliases
To:     John Keeping <john@metanate.com>
Cc:     linux-mmc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 Nov 2021 at 19:46, John Keeping <john@metanate.com> wrote:
>
> This series is prompted by discussion on a previous patch set [1] but is
> a totally different approach and only a partial solution.
>
> With these patches, the dependency on the mshcN alias is totally removed
> from dw_mmc-hi3798cv200 and dw_mmc-rockchip and dw_mmc-exynos moves
> towards being able to consider the mshcN aliases deprecated.
>
> I haven't changed dw_mci_hi6220_caps here, although it looks like it's
> possible to apply MMC_CAP_CMD23 to all controllers there with no change
> in behaviour as the final entry is SDIO for which CMD23 is not
> applicable IIUC.  But I'm not familiar with that hardware and don't feel
> confident making that change.
>
> [1] https://lore.kernel.org/all/20211116190244.1417591-1-john@metanate.com/
>
> John Keeping (4):
>   mmc: dw_mmc: add common capabilities to replace caps
>   mmc: dw_mmc: hi3798cv200: use common_caps
>   mmc: dw_mmc: rockchip: use common_caps
>   mmc: dw_mmc: exynos: use common_caps
>
>  drivers/mmc/host/dw_mmc-exynos.c      |  9 +++++----
>  drivers/mmc/host/dw_mmc-hi3798cv200.c |  9 +--------
>  drivers/mmc/host/dw_mmc-rockchip.c    | 11 +----------
>  drivers/mmc/host/dw_mmc.c             |  3 +++
>  drivers/mmc/host/dw_mmc.h             |  3 +++
>  5 files changed, 13 insertions(+), 22 deletions(-)
>
> --
> 2.34.0
>

This looks good to me, I intend to apply this later this week, unless
objections of course.

In the meantime, I will continue to look at what we can do to resolve
the exynos/k3 issues around this.

Kind regards
Uffe
