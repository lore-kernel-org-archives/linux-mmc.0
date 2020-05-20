Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1FFC433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 17:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C710D2072C
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 17:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETRzT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 13:55:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42742 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETRzT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 13:55:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id z3so3195525otp.9;
        Wed, 20 May 2020 10:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5m951R59Hwg4L11IEuOHoFFikYCWHfdiPMHD72cEVHk=;
        b=dggr86313V3QhUks8vfIrOb50aXldtvrp5UH2sOz2Xzbtz+rF6+uOF69q5jY8PTxZQ
         snjF5GC0981qMXbUza31XphZGv3xGeJTdotLlVI9JQfQJh1hw15xr3Eyo0lVYW8p9xuu
         xn1q52Cm3ukEVmq3tsUWNONQcqUMHXcPprU8T3pqvlERFO0UnKQcZLGc1nUxKlP0paDG
         RwjOau7h4TyDcuG6d67tr39OrFidqo8BLggQfG+OyUALCv6dKSEvoHzRuc/OCGwwu67z
         rR5ABarhbzvbwiOffZJFdfBZUN4qz8pNGXAziTRuXIfW+BngeRBamhj6NiFEayng/kOA
         WUZg==
X-Gm-Message-State: AOAM530WcFOYKRYPtIyHNc8KFN+9e2GdktuCii51xRLjBzsVtuau5Qvp
        deQ8L5apjsCOgdPKNgSnwfjC13AXEe0az23C+D8OBg==
X-Google-Smtp-Source: ABdhPJxEo3oNn9amEBgLDhtlYslm+GZaONC8aNPzNSGVxSwxUDtdZFk9eNWRSBnamNVmnCkecgP38YqpNhgFP81BPJc=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr3828028ote.107.1589997318173;
 Wed, 20 May 2020 10:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200519164251.5430-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200519164251.5430-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 May 2020 19:55:06 +0200
Message-ID: <CAMuHMdXiMwo7BN5TJAwea1d-LYb09jGtTe90BEc+3zdzTN1J4w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: remove manual clk handling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 19, 2020 at 6:42 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The SDHI driver en-/disabled its main clock on its own, e.g. during
> probe() and remove(). Now, we leave all handling to RPM.
>
> clk_summary before:
> sd0                   1        1        0    12480000          0     0  50000
>    sdif0              2        2        0    12480000          0     0  50000
>
> clk_summary after:
> sd0                   1        1        0    12480000          0     0  50000
>    sdif0              1        1        0    12480000          0     0  50000
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
