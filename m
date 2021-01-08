Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A4C433E6
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 21:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C531223A80
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 21:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbhAHVV6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbhAHVV6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jan 2021 16:21:58 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9B7C061796
        for <linux-mmc@vger.kernel.org>; Fri,  8 Jan 2021 13:21:17 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id b23so6305958vsp.9
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jan 2021 13:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XR8VpqhNvfyeOSjiVGS0Gw6y6Ox46JoGQ/emSYjsvjk=;
        b=AjRH6z5bgTXQmT6C30AB861Wlw5FHUKheGMZVGD8gYjod0dQ3o5VfJLtZeFhJuvoJ5
         WavBV44odXXue/TjtQTruTB7I3vowZx0iO1kXKgc8Tk0Y1GTU8H6UNmVXbPbcRBssPNa
         47U1Y10tNMnEC6216t1LAMqhVBEg4IpxVSqqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XR8VpqhNvfyeOSjiVGS0Gw6y6Ox46JoGQ/emSYjsvjk=;
        b=Tdx7x31E40cNd+xCeWFfoK6O1+miKD8eo4l8N5864tkUTmOnEjXmIhpj5+03Y/RVCZ
         hA9VvMWIVIrgTIOSv16/UlDmHWZsoX+6aOi79Zl9EoghVWzWYkdMBQ2SNMVgJ8JcI3HY
         Xd63t5ZxiEZ/okVlP4m2Km7OWe/kCqNiPOcAB3vWJxBaU3o3MXkMYdsIQtALZDVLebK2
         jMEEVpQqsXp7tCAnS8aMgx7Dlk6S3yERwWZNRkZs17cxWqvXa/qP4F9xnlA7FGNxQ4aO
         /uddJXyw0c2sNT4pTYYp4hoBPP4P3txUXm2W6a2wMdArZIvZbsZY6m3TrrOqhpQ8T/kF
         9Bwg==
X-Gm-Message-State: AOAM53282jR0gx0CqJ4pcbHAAc0+EETyXsbqep62vHV7i2dWu7A7PU7V
        7uqE2UjLscFWCtvxyHhag6gQGZLhETxx8g==
X-Google-Smtp-Source: ABdhPJz4jGKgOyscvyRRZZ3TmqRIQOpiJb3S5oenn4GaK3/iF9n4KEzRKxuCHgImEhfZ8rkMef2n+A==
X-Received: by 2002:a67:f407:: with SMTP id p7mr4776721vsn.11.1610140874844;
        Fri, 08 Jan 2021 13:21:14 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id q23sm379197vsm.27.2021.01.08.13.21.12
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 13:21:13 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id j59so3894751uad.5
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jan 2021 13:21:12 -0800 (PST)
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr4896052uaa.104.1610140872334;
 Fri, 08 Jan 2021 13:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20201214092048.v5.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
In-Reply-To: <20201214092048.v5.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 8 Jan 2021 13:21:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xt0O7WOe-hsiqJ7Jqhgs7TQ_c-_BtyAuj0D2Yxi-TqEg@mail.gmail.com>
Message-ID: <CAD=FV=Xt0O7WOe-hsiqJ7Jqhgs7TQ_c-_BtyAuj0D2Yxi-TqEg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mmc: sdhci-msm: Warn about overclocking SD/MMC
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Taniya Das <tdas@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf,

On Mon, Dec 14, 2020 at 9:23 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> As talked about in commit 5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use
> floor ops for sdcc clks"), most clocks handled by the Qualcomm clock
> drivers are rounded _up_ by default instead of down.  We should make
> sure SD/MMC clocks are always rounded down in the clock drivers.
> Let's add a warning in the Qualcomm SDHCI driver to help catch the
> problem.
>
> This would have saved a bunch of time [1].
>
> NOTE: this doesn't actually fix any problems, it just makes it obvious
> to devs that there is a problem and that should be an indication to
> fix the clock driver.
>
> [1] http://lore.kernel.org/r/20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - Emphasize in the commit message that this itself doesn't fix anything.
>
> Changes in v3:
> - Proper printf format code.
>
> Changes in v2:
> - Store rate in unsigned long, not unsigned int.
> - Reuse the clk_get_rate() in the later print.
>
>  drivers/mmc/host/sdhci-msm.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Is there anything you need me to do for this patch and the next one?
They are both reviewed / Acked and hopefully have sat around long
enough that folks who took a long holiday break had a chance to shout
if they were going to, so I think they could land.  ;-)  Please yell
if there's something you need me to do, or feel free to tell me to sit
quietly and be patient.

Thanks!

-Doug
