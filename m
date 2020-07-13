Return-Path: <SRS0=k+AD=AY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25DFC433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FFA2075B
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGML1E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:27:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35799 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbgGML1D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jul 2020 07:27:03 -0400
Received: by mail-oi1-f195.google.com with SMTP id k4so10663442oik.2;
        Mon, 13 Jul 2020 04:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZfdrESmTkh44pExrcL33u4SHqgxscd/TdxVBNeiFI8=;
        b=M+fYUSfKfzooFJwQIN5/nEiopIrHweW3vPgROyrfqGWxKax1a7W9qe/zKdZPwKMy5m
         8WAkBNHHxRcZnMSZrcNGCf+9Xbcg6HLBzy3TB8vPjJNSJ6OAKF0r0MY0nbnoROXnoLHJ
         OTqdkMoqje3rVDgJmv+O10KZhoIJip+yq4/OXIBUSVBA/0BMfG7kIaAs6SrlCZl9QO8h
         x+ypS2hruvc2zUOetIaqrIzwvcxBdJVjUqz4kmXELbgjywFYXt98YAAW6E4ZrnOUoo7r
         UI+sGPJZ3rGvLOIt9qCTempoMqXvVMjslxWzGKRaIbJt11y1WiR+WI5CzpTK9eJ888+w
         YK8w==
X-Gm-Message-State: AOAM530gdG5dn8vqBYMhUkZxi29vPEnrDGC/f2AaYpIRz3tMSML9+4RA
        MBYnRNUYMXUsqww4zejj/yshQ38l16Bx5l71kjM=
X-Google-Smtp-Source: ABdhPJwAa+vsekdcbdiwbMA9snm8YofJa4TUmXKKH+oZAM2R4RD3MZVuzCKpKjtvYCyXBAHd59NorvzkCCAiGn3OcEM=
X-Received: by 2002:a05:6808:64a:: with SMTP id z10mr13558051oih.54.1594639622718;
 Mon, 13 Jul 2020 04:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1594230511-24790-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594230511-24790-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594230511-24790-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jul 2020 13:26:51 +0200
Message-ID: <CAMuHMdXppLj2Fc4AyNOoSrF9Vb5GJTZKJui3ahmGnTy533qp=A@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: mmc: renesas,sdhi: Add r8a774e1 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 8, 2020 at 7:48 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document SDHI controller for RZ/G2H (R8A774E1) SoC, which is compatible
> with R-Car Gen3 SoC family.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
