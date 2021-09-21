Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D028C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F6E361166
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhIULn7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:43:59 -0400
Received: from mail-ua1-f41.google.com ([209.85.222.41]:40637 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhIULn6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 07:43:58 -0400
Received: by mail-ua1-f41.google.com with SMTP id g16so13237607uam.7;
        Tue, 21 Sep 2021 04:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdpYVMEOAHnNRkmR0T8flhT/zcYkeLeqbkwxnc5Ce/A=;
        b=oRkMxyNiOKJz/dUK8vJW0vJcSacEbuX+ErqIwShI94tkzWHf1awEwAEqKHlFQTzIkU
         GlmTKTDgQa35/tDzYLHr8BjeAOg2FhGIM9jqaIVg/9xfr1EVdX5+CtYHE+U0ODzPRR4B
         Mqzxq9NJ3LiujK2E1avfzmaYO6IuCvn1f6NqUfnzcTb4RxgLvrZ5VXskNLa3gYkvDzWu
         G/v9gLz2aHUzQvh++BgHX4gRGHPSNPBM7qO2qhXi7CkefldgClbaWFAFgKSOf/motX/o
         ue6SsLZv1SWyKtMfG4ipvmzu/H/cnQVue+R0CjgfoXegxW7gquWqhOnw/LptcEv3PVcW
         Zhzw==
X-Gm-Message-State: AOAM531yvUP5eQvhFzQMY3hmFqbfZKFOxaByRtHEzh4va+5C1+TAoc+3
        PpT/wQwSkrCVe93NPrtRhIbkGTZT8CnAzAemeO4V767w
X-Google-Smtp-Source: ABdhPJz660eJ8xFUWw21pLpoUoGUDUdkLS+vBfnrRwGe4YQC/sE0pLYK6sPltWQcEv22OrTdq3COoRkKQwR/vpyKOic=
X-Received: by 2002:ab0:6ec9:: with SMTP id c9mr17013019uav.114.1632224550054;
 Tue, 21 Sep 2021 04:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com> <20210920150807.164673-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920150807.164673-2-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Sep 2021 13:42:19 +0200
Message-ID: <CAMuHMdXH2rKKWmMF9PT3V54kiyO9qOJXEUwYYm9UunXdG3Vbjw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] riscv: dts: microchip: drop duplicated nodes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
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

On Mon, Sep 20, 2021 at 5:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> The DTSI file defines soc node and address/size cells, so there is no
> point in duplicating it in DTS file.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

(from v1)
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
