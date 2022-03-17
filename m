Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD6C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Mar 2022 08:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiCQIjy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Mar 2022 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCQIjx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2022 04:39:53 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411339D4D9;
        Thu, 17 Mar 2022 01:38:37 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id r1so3686174qvr.12;
        Thu, 17 Mar 2022 01:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kg3cLhfEIzxREyrRkZPbj7XQr5LmYlIgtgNtsk2nRuw=;
        b=v0gMliPbHDDFngulsBdZyLouXmNvc1Mhe5bX0uTjPr83vOBd6mzrjNLRPTnfF31zKR
         8v0DD3lWnwJonQYyB4vhK/b3LIi8sAp9JZswrW3oXHgzSc9W73jfzSdrGHA9pRD70IbO
         XGST9EvFPzuTkto+ZQ1DzsY/C+JCwotzRyDAaACBaP1tom/IEcWG4vtGaBwvhZYy3DfK
         rOboIQcT8GHoSMOZpgxquXedIGnF35+St0YzWebBszDf2FaukqarEX2pExu8KJTMzOOS
         j+dq3jlFY7ksdrWix/svqeBujgfZ1OzUY5wCGbvlwY6V+JOO9TiG358U+zbGDDv9H4Vo
         X+vg==
X-Gm-Message-State: AOAM530cF2EqPD0NzHv3scTa7B8kyNf9bBh4z9krXlHFqdxxvsKRnsKJ
        trxD6QDAO6HoamIG/JqyD1+ABMkpyPF9fw==
X-Google-Smtp-Source: ABdhPJzvMdOoZ1VxOZniou8URpdKNq7YufV4lKy1jsDESwduvPEOnBbmwNj85nJ8NHTIC8m+Vb1WhQ==
X-Received: by 2002:a05:6214:a8a:b0:430:8fbc:6be2 with SMTP id ev10-20020a0562140a8a00b004308fbc6be2mr2328389qvb.7.1647506315902;
        Thu, 17 Mar 2022 01:38:35 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id n7-20020a05622a040700b002e1b8be0985sm3079067qtx.35.2022.03.17.01.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 01:38:35 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2e592e700acso49983767b3.5;
        Thu, 17 Mar 2022 01:38:34 -0700 (PDT)
X-Received: by 2002:a0d:f1c7:0:b0:2db:d2bc:be11 with SMTP id
 a190-20020a0df1c7000000b002dbd2bcbe11mr4541208ywf.62.1647506314522; Thu, 17
 Mar 2022 01:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220315153258.21097-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220315153258.21097-1-biju.das.jz@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Mar 2022 09:38:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaS0PDYxmhkF2myBknRLoyPgy9DSMdKO_dSiVjvizkDg@mail.gmail.com>
Message-ID: <CAMuHMdVaS0PDYxmhkF2myBknRLoyPgy9DSMdKO_dSiVjvizkDg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/G2UL SoC
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 15, 2022 at 4:33 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> Document RZ/G2UL SDHI bindings. RZ/G2UL SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
