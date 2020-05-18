Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5DEC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 21:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0312B207C4
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 21:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgERVHy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 17:07:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38541 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgERVHy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 17:07:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id w22so9409921otp.5
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 14:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGYU2qbuDrZTZG4rU1LfswzXDHUpSVwbaFTzSY8sopg=;
        b=WNlxOnxpOGKMRMpCyk1YWzCsDgJ6QojId0rUSUNaP4qVFIBwpxWa2Rvp5ox5YWG722
         ONkjhVVgDYmUYzpTWOlP0mEyhf2AulV+d327BWwwZgB6uZACd3IpweaheSvAKShD4JGb
         +P9v8UizMQNCA0HV7EbxbkLdYd9I3zyAmOzRFBPi8zmYKArt1eKf86r5zhDDJPQkeBl8
         Y1uNnLLSeigz7qx6+sJUOREIfT8sNOI3Srz8IPcpwlQM9CWBHBQR6uYKkSpEKRD76bmA
         7rx+CHkn2fqINmRjO4I7IM7in0QAFawIZCutlGyDtKV1RrXEEojMpI5WqoglfUdYzMOU
         okPA==
X-Gm-Message-State: AOAM532LVk1cLOdswd2KaDTZjGqcRC8c2MSFbWm8XDx58uhXvip2awGW
        8iq4r4laAn1s6CAaZyywRzqWmqXeF1bAGMKXasedVJNw
X-Google-Smtp-Source: ABdhPJwxKb2wkLwKrstNO3GOklRf0rvQ82lmlADMaIX+qmGFPA/YLJEvDeS/abYb4wtfsDvOAADjbS4IBuq3yLldWAw=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr9654422ote.107.1589836073279;
 Mon, 18 May 2020 14:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
In-Reply-To: <20200515140459.15273-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 May 2020 23:07:41 +0200
Message-ID: <CAMuHMdWscejrUbfx0-C=WFC6-vECA9HTkKs0=osWGUPBY6yPxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Fri, May 15, 2020 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> If the tmio device is attached to a genpd (PM domain), that genpd may have
> ->start|stop() callback assigned to it. To make sure the device is
> accessible during ->probe(), genpd's ->start() callback must be invoked,
> which is currently managed by tmio_mmc_host_probe(). This is very likely to
> be too late for some cases, as registers may be read and written way before
> that.
>
> To fix this behaviour, let's drop the call to dev_pm_domain_start() from
> tmio_mmc_host_probe() - and let the tmio clients manage this instead.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

So this moves the call to dev_pm_domain_start(). No new calls are added.
If I get it right, dev_pm_domain_start() just calls into
genpd_dev_pm_start() through a function pointer, and starts the device
through the system-specific PM Domain handler.  On R-Car SoCs, that
is pm_clk_resume(), i.e. enabling the module clock through the clock
domain.

I have two questions there:
  1. What if the device is already started?
     There seems to be no reference counting involved.
  2. Who stops the device again?

I always thought the PM Domain was powered on (if still off), and the
device started, by calling pm_runtime_get_sync().

What am I missing?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
