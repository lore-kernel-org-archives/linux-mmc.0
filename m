Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB2C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09FE61371
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbhHXPdt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:33:49 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:42994 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbhHXPds (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 11:33:48 -0400
Received: by mail-ua1-f41.google.com with SMTP id m39so11833491uad.9;
        Tue, 24 Aug 2021 08:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44Y8+N+SnYtYOywdEreCzeQ16Qc35iaWv8K0CtlpfOM=;
        b=nJM5kY31leDkyGK4MtNkeOYv4MTyXvXLv9YjjKo9vf43Mwn/CMelztbpOzXok3kWaA
         8AtdMaZ6dEqg5+N5f4w83WsJy+MY1baERjIodoOdFsNFbYRWxI7uCO3KCRmE0FPj8R5m
         2oMtDJK9JbIj4/6bmJ74A1Lr3Gl80uonYmRtZXXZRU5+o0zok5jwA4g1eb1DQM5zUgMw
         +8HEqXVU/OyrJ8TLuKvL2GB2oBaMUTxaZ/6erQu+Dg66/oRzT8YiScBgAyJtb6nrm3T2
         2Y5MXjb4NTZp6Dcaw1cqenHT7S2DXDTjSd97PtWEccaj3e5GelncpqAQt53FBoYpzLGq
         ShJQ==
X-Gm-Message-State: AOAM532RlX4uWAqm7N/kY6RwXVxbLRoC7dnkSuh+FPvNBPOYpYbsZmNq
        eiVmn7lxK+O25gq+DSQUCdxWJ9UietWWKly87t8=
X-Google-Smtp-Source: ABdhPJx43ZwCwMlUtl1S7uSysr1dAaJDUFsrHb1A75ES/kPsKLv6OsWvOzGC+YT4ae4ieTdk/o5Bbk59uGjg6cLvkLI=
X-Received: by 2002:ab0:4d5b:: with SMTP id k27mr13478215uag.78.1629819183896;
 Tue, 24 Aug 2021 08:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-3-krzysztof.kozlowski@canonical.com> <4d0d6290-8341-56d8-7902-5a8c36bc7bb5@canonical.com>
In-Reply-To: <4d0d6290-8341-56d8-7902-5a8c36bc7bb5@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Aug 2021 17:32:52 +0200
Message-ID: <CAMuHMdWA3_c13dCVUm7o2QzBmDN4G4fA6B+xSftx9FtEyYtT7w@mail.gmail.com>
Subject: Re: [PATCH 3/6] riscv: microchip: mpfs: drop duplicated nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
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

On Thu, Aug 19, 2021 at 6:22 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> On 19/08/2021 17:44, Krzysztof Kozlowski wrote:
> > The DTSI file defines soc node and address/size cells, so there is no
> > point in duplicating it in DTS file.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 5 -----
> >  1 file changed, 5 deletions(-)
> >
>
> Now I wonder whether the subject prefix should be "riscv: dts:
> microchip:" instead?

Agreed.

For the actual patch contents:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
