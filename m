Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05DC4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B4661360
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbhHXPfq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:35:46 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:44751 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhHXPfp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 11:35:45 -0400
Received: by mail-ua1-f44.google.com with SMTP id x6so8345881uai.11;
        Tue, 24 Aug 2021 08:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SO1JeZD+prSQ7WyrjqxTZfIfxtg1ME/49fxSx/MfbeU=;
        b=exn7VTOoy8n5w4F1TmcyswV9UO+ahrqV/8oH3uqxcmm1j8IAqD8MnnQGvEuF6sbkV5
         v1+35i035p1L//wEgftuJWYjSKnyQZSjiFrUX7wyyWa1TiIlNUOjrDoFyDPsC8OJrT6Q
         vQtoQTL9vuTV0OrcbBLsK7LrvvyH3AklCRvw51NTj8UDQ2VqZ834l0g0cmkTCTN3wk9K
         Hhk9IchGdsJncGHSUXLgrFGyiQbYhDbfeawHDBCmuxgUH4w1BAdQ8ImVgAt1RQWGiVNh
         HojIZfA7Sdm1AK9UNoWU71n8476wH4s6s1mRcOxx/PmppKIOiOs9n037fbalzDUFCAG6
         ofLQ==
X-Gm-Message-State: AOAM533ahRuOX+o5t0WHIHahJM7SbflHOFtntIScdB/Wqdloh2yJrvRJ
        zCDPEjyqLUrQ6vUQI1VQ+F6NAMw4Kb/mhtmCK18=
X-Google-Smtp-Source: ABdhPJzmHT/n0lISZoeJtMpWln/4dUiLqfkUG3WtJfXA8i8iEMfKEc8sIVswpKnwlWgWdf8L4I/GsedoiP6Yl26y2EQ=
X-Received: by 2002:a67:ce90:: with SMTP id c16mr6942743vse.7.1629819301044;
 Tue, 24 Aug 2021 08:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com> <20210819154436.117798-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210819154436.117798-6-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Aug 2021 17:34:49 +0200
Message-ID: <CAMuHMdUkxRQks9B+QgExeogJQtLgVcMtXfsh50Xtsag-GfcjCA@mail.gmail.com>
Subject: Re: [PATCH 6/6] riscv: microchip: mpfs: drop unused pinctrl-names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof,

On Thu, Aug 19, 2021 at 5:45 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> pinctrl-names without pinctrl-0 does not have any sense:
>
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Indeed, and pin control properties should be in the board .dts, not in the
SoC .dtsi.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
