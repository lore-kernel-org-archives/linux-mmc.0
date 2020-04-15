Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA22C2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 12:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61328206A2
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 12:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370256AbgDOMrX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:47:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34782 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370236AbgDOMrO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 08:47:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id x10so3902444oie.1;
        Wed, 15 Apr 2020 05:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLsRqGxN7CRUuHynugV/dOQpcFOuJNeks2tWDx1w9w0=;
        b=lR6pyNQwB5djVCJyHqDC6n37DtK4XtXUjXI0S4fOtdeTpXI37leQdm8sjA6pY7okeZ
         Lb/filwF82MoVkcGnM+mXeXSZDVrnqroGy37lQE2x0eiBNSgE+udNMZejpoo+wEl2xnU
         Y2NtAJouGExnsep993KUpsEXfHHg3hqXSQ28dxZnaQxfVj1/H9Ly/iJsMYeHQrk4NEht
         Hu91iwSeDivQyYTM6GZUt5Pk5zEVncxvURIpkYLa1D6dS+xuPBhcxg8KPC7BuR9VPtFe
         vvGsbclzyb/SjQlfn2CkKjpt8w7Y1YrE9TLY9FkAhSxiCldJWsM0N0HNTrQvjYVjlCeh
         XuIw==
X-Gm-Message-State: AGi0PuYIAqctRXvBAocb80JpzOW0X+Hh6DCV2qN56lyGKl8cg+4adn0R
        NFNztS3Er6L/G2yRZ8dHDhidj2gvONnzoT4hhYGjFQ==
X-Google-Smtp-Source: APiQypKwQYj/IHMbKmL5uShl0HH0tk8mYpgEAj+clJJq0K27C2jUSWNt2RXa/FGflGN19821/Un3Az0+822tmhAKTeY=
X-Received: by 2002:aca:f541:: with SMTP id t62mr4381212oih.148.1586954833052;
 Wed, 15 Apr 2020 05:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200408142252.21958-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200408142252.21958-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Apr 2020 14:47:01 +0200
Message-ID: <CAMuHMdU1XRQpnf7Q6XRPBLC0u-H84qw6=N3Szn1E6f-B-EDXPw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: simplify summary output
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Apr 8, 2020 at 5:17 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> No need to call platform_get_resource twice when we still have the
> pointer from before. Also, use '%pa' for a resource_size_t pointer.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
