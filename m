Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC88CC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B849920720
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 08:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzUnGTMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHUIqM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgHUIqL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 04:46:11 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F10C061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 01:46:09 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id x17so330756uao.5
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 01:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBSyf+yXd7kiYAF9BZfiPGXH0tN6S8pKBPuNovCFIWg=;
        b=bzUnGTMpFMBlKFRo4KHl6EmHFbz2NNiN55TErkmKGkClkdBPW7M8o/cmJou7X3zh0E
         v5/1DmgNBKJFGQftdVexRCnYxq9PSrmpRxK9hFhyuewGRT8Q8cFKzskZTQqdYYppLPk0
         PZiCmQp/v/qeABwXaKmgFTkeK7NPzfMpZYgDekBA3fbM0fUDL2rGNjmycIungSLFP3l1
         Ixq4N3ChAyrt0ePjJF0OAvJhHeFgIx+uaM3OpcHRf3zaL08JxrD+npAW6F+jBN6DIat6
         s1CYxZufog8kBKhFOL9J93G+rlVALXH/IVTc4E4FDU3BbV9XSNuz+ZrIyb/g625Sc+bI
         A64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBSyf+yXd7kiYAF9BZfiPGXH0tN6S8pKBPuNovCFIWg=;
        b=XiIaJc8x3YXE6lnybC54ZvoaLR1BwAuSp5KCCx5HxRd9SfdlSGfQc4E5Iwr67ofG4I
         Pt5UQI76jzzBue9lvQfZaHyIIG8S+yELjHBAtk8Vj33gyzfDrB8upki3A0ubPJUe44aF
         j7s1xttVuUdoVO8R6Qm1fWGBRQMRBmzkBmqqnHbxD2l2pG9f8tuy0rBzUxnhQu0dS2b1
         /lQe22+OO8FgdWbym9oGmZa7cUiWx/E3jggrwolwTkEyTMgdoB1WonIIAirYWbVXokjY
         SMCDuaLMKFOTLYXUR9rVHUJkD5sKPNkC3DOIc0Yc2RhhCRSh2poBMIyYpWOea/3RIl0W
         CMrQ==
X-Gm-Message-State: AOAM532MfWa3qHInlGSfLTlIHN2Yq9hntj1IaxBlxKYEf+9HGfWLto7i
        ls47euyb4TWiSJinPycAlv9XGW8j0MluqwvNWbqbsfB3cwtO3Q==
X-Google-Smtp-Source: ABdhPJzrlAajobgpJPI56OVk2bDqzvfYUokRh11GmgukIRnTn43dOHrshkENdJIqI9aJ7hMomaPoCzr2mWE9EakgQ+E=
X-Received: by 2002:ab0:6341:: with SMTP id f1mr778421uap.19.1597999568563;
 Fri, 21 Aug 2020 01:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200814185011.3252020-1-t.schramm@manjaro.org>
In-Reply-To: <20200814185011.3252020-1-t.schramm@manjaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 10:45:31 +0200
Message-ID: <CAPDyKFruUf7BxrF3YeYnJn=U4vZKMoQhms4SC=Gp91Z3fzk0Sw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: fix timeout calculation
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 14 Aug 2020 at 20:50, Tobias Schramm <t.schramm@manjaro.org> wrote:
>
> Previously the cycle timeout was converted to a microsecond value but
> then incorrectly treated as a nanosecond timeout. This patch changes
> the code to convert both the nanosecond timeout and the cycle timeout
> to a microsecond value and use that directly.
>
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

This looks good to me, but before applying just wanted to check that
you tested this on some HW, to make sure it doesn't break anything?

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 39bb1e30c2d7..f85e0ad896a9 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -882,9 +882,9 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>         else
>                 clock_rate = spi->max_speed_hz;
>
> -       timeout = data->timeout_ns +
> +       timeout = data->timeout_ns / 1000 +
>                   data->timeout_clks * 1000000 / clock_rate;
> -       timeout = usecs_to_jiffies((unsigned int)(timeout / 1000)) + 1;
> +       timeout = usecs_to_jiffies((unsigned int)timeout) + 1;
>
>         /* Handle scatterlist segments one at a time, with synch for
>          * each 512-byte block
> --
> 2.28.0
>
