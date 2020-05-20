Return-Path: <SRS0=coTY=7C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A0C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A07207D3
	for <linux-mmc@archiver.kernel.org>; Wed, 20 May 2020 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgETOar (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 May 2020 10:30:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33333 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETOaq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 May 2020 10:30:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id v17so2648222ote.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2020 07:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=25Ibcwww+BcN0/96boziMJavMAoQiNziLwFuwJDrUko=;
        b=EscRPFICkARagNBoH9QFZd+mrRvQ1bbi44irMicLX/ukzQrJL8+2sQUwqgjN4dpDzO
         eVoSew2n24UUyqcrTxcpR8cS/L7FdyFamiKDBz9jrS4bkNRP9NbXMSlf2eanroRN4BUl
         M4FMTeBN1n2uTzVE7Q/bJrwp5MnSJQ7pAJ9RICSFVcgZt26REqjusCwkmolLJvOzxraN
         HA7VIl6gbGTMRMoGwP2PGqqwviM+msBp2kjp5jfFft5rAOeTJ87eYCY0A1R0L/ZEQys2
         /9mlNsGxOtMGsp7p0QZWZpn7pTRMSOA1GyDE0GDl0s1WT4LKwNaEy4Crl4djjzDpLZTz
         +Zbg==
X-Gm-Message-State: AOAM533G7GMOk+F4IW6EI9y7YiZrDwCXDCN5HC1tN8hI7jCFOevu3m7H
        cVr4ph6FWnaMVSjxiHzrCs9Aezds+LBHm0hzA5Y=
X-Google-Smtp-Source: ABdhPJxUrlorzaEl5xk+OAN/4uiZlrr62u3pS+3TM7funhkQccEdpAGNARSsPE61JEHXFJBGWANKoOLZVDrZBKxnj0U=
X-Received: by 2002:a9d:564:: with SMTP id 91mr3409201otw.250.1589985044490;
 Wed, 20 May 2020 07:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200519152434.6867-1-ulf.hansson@linaro.org>
In-Reply-To: <20200519152434.6867-1-ulf.hansson@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 May 2020 16:30:33 +0200
Message-ID: <CAMuHMdXUuXLh1FWAoTTNraQQ7RGGmEOBFmaYdH71ccRovNEpgw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: tmio: Further fixup runtime PM management at remove
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

On Tue, May 19, 2020 at 5:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Before calling tmio_mmc_host_probe(), the caller is required to enable
> clocks for its device, as to make it accessible when reading/writing
> registers during probe.
>
> Therefore, the responsibility to disable these clocks, in the error path of
> ->probe() and during ->remove(), is better managed outside
> tmio_mmc_host_remove(). As a matter of fact, callers of
> tmio_mmc_host_remove() already expects this to be the behaviour.
>
> However, there's a problem with tmio_mmc_host_remove() when the Kconfig
> option, CONFIG_PM, is set. More precisely, tmio_mmc_host_remove() may then
> disable the clock via runtime PM, which leads to clock enable/disable
> imbalance problems, when the caller of tmio_mmc_host_remove() also tries to
> disable the same clocks.
>
> To solve the problem, let's make sure tmio_mmc_host_remove() leaves the
> device with clocks enabled, but also make sure to disable the IRQs, as we
> normally do at ->runtime_suspend().
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

(on R-Car Gen2, various Gen3, SH-Mobile AG5, R-Mobile A1, R-Mobile APE6,
 RZ/A1, and RZ/A2)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
