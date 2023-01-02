Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A190AC4708E
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Jan 2023 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjABPI2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Jan 2023 10:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjABPIE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2023 10:08:04 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719F69585
        for <linux-mmc@vger.kernel.org>; Mon,  2 Jan 2023 07:07:58 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id b12so18470580pgj.6
        for <linux-mmc@vger.kernel.org>; Mon, 02 Jan 2023 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32Padg+6hCGNbUOr+i7YKPADHH8ODZ6PAm/7FSi080w=;
        b=o3kDDhSg/4BKw0h3LN7nnLkP5n88azR2T4lMg++jOkvPcpSodWFNVySeZn/di7Am3V
         bqtdiloyy3vTewr7iJBrM6xBwS5XXAH2591syXmn+EhDHVviuhjY6IIA/Ds1XbPRbgC4
         s3RtRmJAESNNku6+O0hM7I0wQtGJ9S51lfufmw1xxtCYMvjBbQ+fBDl6JPTSvjGg98x1
         OyNFxauuEy/Tvo2N3R6gn1d8R7t+YfbbQW9ukSSYbDYYWW4sE7b6J9hwHJy+xS/f8ER8
         9gIt1RIivbqyypaNKHlN2gqu7/JiwPoGpzlfrtZeJgQqATh/aFNzXc3Fdx0yMeBj5yxn
         yAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32Padg+6hCGNbUOr+i7YKPADHH8ODZ6PAm/7FSi080w=;
        b=4zamR3W4QZ+HQpZoTZn4s+AyqGL+DD9tOr+dqRv/r3sEVXTCWPghqBeCW+ghHaFoBl
         C5VXTT2Gl7jzFapqq8WpEmuu1BKNDIL3EwHM1SdgFn5yRtr3fmMiIDap5uDTs+LExHBy
         aqzTYcIDH/WAHVsMecdpqRsDQcudORlUFNvaIsKZGUZnBszLjvIOxoBFIXeowIYjIhNx
         0CZX94M9jsfAr0arjIdAl5ogMfGXTpDhzjcNE0L/r7A8gcHhiqknx5yNQxDWSH15Yvf8
         nlZHzTH0791Nq47CsSgxK0fEhJFo2nb8/PfGncDvD9H/0hytTcwyxB8apGn1T6XyT3ny
         9Edg==
X-Gm-Message-State: AFqh2kqhGWO9PGC23gS6xW1Orj7i43b4OLJoWjWvorqhnY44hDsH3HNe
        KBzgz2HjbMBszMT+B92awG0i8sjXKX8NyJm0xwgqrw==
X-Google-Smtp-Source: AMrXdXvlgdZ1EhWM9+BrEgG6jEOHpwPMS0nCd80DKfupgv9iB+pTOd4h4gP1SRBOJ+HG1yaubXmSSDuGkMJKN2+wG9I=
X-Received: by 2002:a63:5841:0:b0:477:b650:494b with SMTP id
 i1-20020a635841000000b00477b650494bmr2406813pgm.434.1672672077956; Mon, 02
 Jan 2023 07:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20220810022509.43743-1-samuel@sholland.org> <CAPDyKFqg0BUbpQwKvZxuMrqoiwBKzZxbgP-e=50yLpKRhQ+zPw@mail.gmail.com>
 <5a6a65c6-6df3-0d24-b28a-324b28fd4756@sholland.org>
In-Reply-To: <5a6a65c6-6df3-0d24-b28a-324b28fd4756@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:07:21 +0100
Message-ID: <CAPDyKFpiuWY+vC1cY8xLozFucsTA0vMHVk_KTpzCfOcXntcBZg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix clock refcount imbalance during unbind
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 1 Jan 2023 at 20:25, Samuel Holland <samuel@sholland.org> wrote:
>
> On 8/15/22 05:11, Ulf Hansson wrote:
> > On Wed, 10 Aug 2022 at 04:25, Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> If the controller is suspended by runtime PM, the clock is already
> >> disabled, so do not try to disable it again during removal. Use
> >> pm_runtime_disable() to flush any pending runtime PM transitions.
> >>
> >> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>
> >>  drivers/mmc/host/sunxi-mmc.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> >> index b16e12e62e72..3db9f32d6a7b 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -1492,9 +1492,11 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
> >>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> >>
> >>         mmc_remove_host(mmc);
> >> -       pm_runtime_force_suspend(&pdev->dev);
> >> -       disable_irq(host->irq);
> >> -       sunxi_mmc_disable(host);
> >
> > Perhaps a better option than the below, would just be to drop the
> > above calls to disable_irq() and sunxi_mmc_disable(), as that is
> > already managed through the call to pm_runtime_force_suspend().
>
> I like the idea, but it will not work for !CONFIG_PM builds, which this
> driver currently supports.

Good point! I have applied the patch for fixes and added a stable tag
to it, thanks!

[...]

Kind regards
Uffe
