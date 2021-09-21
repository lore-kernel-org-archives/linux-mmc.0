Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A069EC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8642060F56
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhIULt4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:49:56 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:36417 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhIULtz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 07:49:55 -0400
Received: by mail-vk1-f170.google.com with SMTP id t186so7906439vkd.3;
        Tue, 21 Sep 2021 04:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZY77SgczzK0bsUC6Ya84YJ71YaPx+0lAvUQVie1eBTY=;
        b=qixs24mBgMqhUhif94CJayAbX0oacEjWAXpwASjuy9eRxm/LslvatIn1fmjvx2xVvO
         H613nwXnrkM0hM8uyjq51/abNArVsY/24iEhF3lrB2OlFwlZmSaFDcxSP0/tEq+P3pQV
         lrWxIGTTPvxwLdw9z4rZva2IBwP2OsJuHCSWBwzsULmjkItnKLqR52NtbDl2QvqO1uL+
         NvaAMfL0DZxZJRc93eayduQ91NmNYEPmUsbuMuiT0my+T6c5PBwsFzh1TKJ7ik0R/LXh
         gl2KJ11TtTRGE8QNhYEPNyYdlDGfojVsuNHjEtc0Ewd6MqxMQq39TsdAPzJ0W5Xs5jIA
         2jTA==
X-Gm-Message-State: AOAM530ClfydZ0qLBiT/g8lKx84a6KwDjfkKvKGeuBJ2FRYjyjdawScE
        SKyv+bot+NYNM9y2Wo5iX2aFgrc7wbB2M6E0PmU=
X-Google-Smtp-Source: ABdhPJwvWhOkK/Dn4XyVAIBiyM+kU2nDBozoeqRacNE353jwcOY5tsH/iuzWg/mPj1E4dTsiY68VzY2hkFxqhmm9GQg=
X-Received: by 2002:a1f:9187:: with SMTP id t129mr4959165vkd.15.1632224907211;
 Tue, 21 Sep 2021 04:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com> <20210920150807.164673-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920150807.164673-6-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Sep 2021 13:48:16 +0200
Message-ID: <CAMuHMdWxWUwBsZoCa1obb5qY4AH0BdC9zwao94aMV8tMw7VxyQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] riscv: dts: microchip: use vendor compatible for
 Cadence SD4HC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
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

On Mon, Sep 20, 2021 at 5:10 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> Licensed IP blocks should have their own vendor compatible.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
