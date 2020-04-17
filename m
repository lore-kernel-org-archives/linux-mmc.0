Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E217C38A2B
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38938207FC
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UuOfXI5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgDQL3r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730324AbgDQL3q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 07:29:46 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA3C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:45 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id r7so940545vso.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lc+0dA5ZQ6U/TmJnVIFeGMJ1UgmxFTvQYOdMP2cGglY=;
        b=UuOfXI5pPysHol9zXgk317NJuZvCfQiXWDHh5nA1sEItDgTUCsp4xF/1omvUhOEakt
         ULf37ERYsiG1pKtq4hkc6WS8i1WkCjzKIUdXT1NxEULrCnEbEZX3TWIJzCWJlo0fHYxh
         frrHJXWGFayKHUcS6NuATF30wpb41eWLL6wYk8LnNVhEJiQJ9YYWHvpYdH710VbJgUMg
         mGFbalwNVkD2CP6jJ8GUznERRygLYYEjEAm4UQSUdC0GkAC1WPRnLkFHl7L25Krhi9ap
         VC1fh5Y4Nfy434MpX8ah2yd/isxal1+Lwk1/hKcJz/DSkhLpWCjFlVp5RkRZM5+v3WvK
         ocpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lc+0dA5ZQ6U/TmJnVIFeGMJ1UgmxFTvQYOdMP2cGglY=;
        b=j/4COE61Z53crFbgNOkPCUW5VWsNyMiwwpyiQNlMGzdUAGMj/xV+8skUplY+AYj9/g
         17EKiIf3TqCrTBnKGPPIvznEgR12MU90bCCqF0ReHDHAXDLLX6ytbEYXJuNcm+ZVjnkY
         NCgNKYIXkNFMnbnhelgEKTQ1Dwwi+ODZBM13tt/2/F/U3u/YhpKgo1LngTCjVf9Idud4
         0kEO9YG1Ej1s93ALpzSPM86r1Z6UD71BQG3Udu2ewQ1Gy/xkUGIis0j3e80aCJu8kS9N
         WGobM6eckLD2hUaq2re+HiNXASM9EBFucrCZUs52CEQPHWhz6E8gF+6EQMmXk48JrRl9
         IQyg==
X-Gm-Message-State: AGi0PuZpydSCPH+ZM/Q1Gv/eSVrhiSWlzZ5bUJuamN07iBqjcA2qoyjh
        wAZ2lgoptqoqmPXEOgBjf2Mxq4gSksZ5zds3RuHO45J3
X-Google-Smtp-Source: APiQypIOp3J008s/bXB9WKJub9sYBgZQSDtFNy6ifDOoslHH7Jbc679wSfxiWRv9bj/JvDoEvcOEy6Gs///EOUjlB+g=
X-Received: by 2002:a05:6102:72d:: with SMTP id u13mr1662810vsg.35.1587122984277;
 Fri, 17 Apr 2020 04:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200410145643.630b0731@xhacker.debian>
In-Reply-To: <20200410145643.630b0731@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 13:29:08 +0200
Message-ID: <CAPDyKFpmcXt2oikzz8hKCLecctnZo9PLNZgu-FRnO8y2jfc-kA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sd: use HIGH_SPEED_BUS_SPEED in mmc_sd_switch_hs()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Apr 2020 at 08:57, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Use the well defined HIGH_SPEED_BUS_SPEED macro in mmc_sd_switch_hs()
> to make code more readable.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 76c7add367d5..43de3190d718 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -376,11 +376,11 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>         if (!status)
>                 return -ENOMEM;
>
> -       err = mmc_sd_switch(card, 1, 0, 1, status);
> +       err = mmc_sd_switch(card, 1, 0, HIGH_SPEED_BUS_SPEED, status);
>         if (err)
>                 goto out;
>
> -       if ((status[16] & 0xF) != 1) {
> +       if ((status[16] & 0xF) != HIGH_SPEED_BUS_SPEED) {
>                 pr_warn("%s: Problem switching card into high-speed mode!\n",
>                         mmc_hostname(card->host));
>                 err = 0;
> --
> 2.26.0
>
