Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02176C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Mar 2022 08:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbiCAIOi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiCAIOh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2022 03:14:37 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A247AC0;
        Tue,  1 Mar 2022 00:13:57 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id 10so7086114uar.9;
        Tue, 01 Mar 2022 00:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hup4l0SCQpzYB1UP/0yN4hi6PPxy4Oe80sl6oWpNdRw=;
        b=LKIZuCD5HBVGllMBty9EVsxmSAsANbjpqJ+Ydv8DOivMDR2/wgr+oAVWZ6fXGFUu4b
         50r6rnlOAohqtdwtyGvg0MZQG3m2rRW3LVQ4ybIQ7OK5SiYRcsU2W7wuKkM+tdU8QPOO
         vrZKMFNGhJwiAgjJcPaHKXgBGFMlHLlkpW4tdvA9myvsnQGLEtli2zvZxfE3VuXzZ79U
         Lnjwf+EXSTRArfrCwu2snvg34vilh33ilXZ1ZSS+sol9nBNrV6Oycy1IqWxZdaqqRVXY
         XnE5kIULiibc9kw35PmVoqDnsHkn3DBbsrlSV3t0nGK3bVZgqLRAVTBUcP5Ekp2b2R4S
         SAqw==
X-Gm-Message-State: AOAM532n+lj6EWU1R69imGuYdgFfWiDM1ttblotiXcIsAWdDybtQ21Pf
        uTZEjlmGaaiyZphRhGqkS6PDe3gM9hXW6Q==
X-Google-Smtp-Source: ABdhPJy7liRlf8SpUvscezMptczIa9SRDyzDD7vIqEt4LC1fLEJEbUBosbsC8206e07VoDXmtoavfA==
X-Received: by 2002:ab0:70c7:0:b0:340:5421:a0c2 with SMTP id r7-20020ab070c7000000b003405421a0c2mr9360173ual.40.1646122436301;
        Tue, 01 Mar 2022 00:13:56 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a6-20020a056102094600b0031b3c620df5sm1574261vsi.1.2022.03.01.00.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 00:13:55 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id b37so7072226uad.12;
        Tue, 01 Mar 2022 00:13:51 -0800 (PST)
X-Received: by 2002:ab0:3da4:0:b0:306:a7f8:f28b with SMTP id
 l36-20020ab03da4000000b00306a7f8f28bmr9979160uac.47.1646122430945; Tue, 01
 Mar 2022 00:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220227212330.22262-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Mar 2022 09:13:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXNrRO2HaZ2pR6eH=6SH+j9fC-72Z3eUjNVwSQyTKQR9w@mail.gmail.com>
Message-ID: <CAMuHMdXNrRO2HaZ2pR6eH=6SH+j9fC-72Z3eUjNVwSQyTKQR9w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/V2L SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Feb 27, 2022 at 10:23 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document RZ/V2L SDHI bindings. RZ/V2L SDHI is almost identical to one
> found on the R-Car Gen3. No driver changes are required as generic
> compatible string "renesas,rcar-gen3-sdhi" will be used as a fallback.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
