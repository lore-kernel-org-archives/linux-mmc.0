Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A50C2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D564520775
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 10:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZo1BZx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408530AbgDOKYL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896474AbgDOKXh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 06:23:37 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F70C03C1A6
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:31 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id u10so1113128ual.9
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuGBbMoDh6W2a9p0xXuJ+PPx7Ir4Bj61daY341TPdbw=;
        b=QZo1BZx+QGh50qm5qUZHPbW4xyX1pvVlc8h4GRwBgrQ/jNtgQyPKvVxDbu41FPPpZi
         RnEE2WMuN6aG7hz5eGI8P/470aR90LFk/+e8zNj6Rlbpf3gvCfDKkzOPJKfLxnRZ/7QO
         QC7+1IlaLHU3cDKsEqj7B4INPipTqWMmcUrG1lXH9lxipwwdhylK/qAd1nKMZiYWbz9f
         yg9FWqyqg/SAgBLrX1jPq7XBOnfXET6qaHuEiFccIQngOHZRqZV6lY/JKJg5ODMDDR9D
         T+Ll8xjgGAfDGnsHaQz+QfbmdNHSN15qnj42zUtvdwjaoERLl7kN6nZZe9IAFjsUCjfT
         3o5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuGBbMoDh6W2a9p0xXuJ+PPx7Ir4Bj61daY341TPdbw=;
        b=qJHB3IzwOkb3EQcw5C/jZCBVFOeoyz2qJO9Hku0JMm7mXXloQ+PeHtIswrhcOXqUfX
         nO1/zH0kl99HAcrEV6Me101V02WsatJu0T3GhN/RIvkA6otWobzkRHMyRtv3HiBtr7H1
         XVXtAPFznp7GtqEw007VJvLrDT1v6JH/BD984N0Dl89SpdSrbND/dWWFOhGUiJGmOsAZ
         nIjZ8WxDs5/Td8jxAbbXUyk6T6NX9KN5+16scDY1z5CkJLTCw6SmIZrCNYxDFtPMdJ21
         hJBRRudUVlYI0jC1wgzuGilJWsGL5oT0xqumuNz3D3pe/cpJhciJkHb+zkkV9k3kX1qO
         1SSQ==
X-Gm-Message-State: AGi0PubPI4c3wjIDEjLt6UI7VtRt1ILBT7vFRjkqyX4xSfeQuiXZXv9t
        Jq90D/VyCGVjSiqYySljGMCvBZXQm//Yk0Z1thyFM37Y
X-Google-Smtp-Source: APiQypKkEAIbUpmbVejhcwkLz3HtHZcBJQnkgevDEQsukLrhkH4TNtn4QHd2XnNHeQxb93SciLjElrPG4Ql0HQNfwlw=
X-Received: by 2002:ab0:6449:: with SMTP id j9mr3734076uap.19.1586946150691;
 Wed, 15 Apr 2020 03:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200408094638.10375-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200408094638.10375-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 12:21:54 +0200
Message-ID: <CAPDyKFoqWgxrGBO14T6V6MyZx33r+Ln4cnxBjrvXJE+H+-8twA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: renesas_sdhi: improve TAP selection if all
 TAPs are good
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Apr 2020 at 11:46, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> SDHI (with SCC) has a mechanism to select an optimal TAP even if all
> were considered good during the tuning process. This series implements
> support for it. Before that, some refactoring of 'best TAP selection' is
> done to avoid code duplication and get more understandable code.
>
> This work is based on BSP patches by Masaharu Hayakawa and Takeshi
> Saito. It is built on top of mmc/next. For convenience, a branch is
> here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib
>
> It has been tested on Renesas Salvator-XS boards (R-Car M3-N and R-Car
> H3 ES2.0). There were no regressions detected. HS400 could be tuned the
> same way, and checksumming large files still works.
>
> And while this series is useful by itself, it is also the last
> prerequisite to implement some 'bad tap avoidance' on top which is what
> we are originally aiming for.
>
> Note about backporting: The super useful iterator
> bitmap_for_each_set_region() is only available since v5.6. If you want
> that before, you need to backport the needed bits of e837dfde15a4
> ("bitmap: genericize percpu bitmap region iterators"), too.
>
> Thank you to Shimoda-san for his valuable input since the RFT version
> of this patchset (see patch 1 for details)!
>
> Kind regards,
>
>    Wolfram
>
> Wolfram Sang (3):
>   mmc: renesas_sdhi: refactor calculation of best TAP
>   mmc: renesas_sdhi: clarify handling of selecting TAPs
>   mmc: renesas_sdhi: improve TAP selection if all TAPs are good
>
>  drivers/mmc/host/renesas_sdhi.h      |  2 +
>  drivers/mmc/host/renesas_sdhi_core.c | 64 ++++++++++++++--------------
>  2 files changed, 34 insertions(+), 32 deletions(-)
>
> --
> 2.20.1
>

Applied for next, thanks!

Kind regards
Uffe
