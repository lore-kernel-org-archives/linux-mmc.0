Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B76C433E1
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826E522B45
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+hjsVhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHEGdA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgHEGc5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:32:57 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC360C061757
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:32:56 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q13so15206508vsn.9
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3i8XFESZihDO6mc3/4tfcR56mY/Nrg7Lzf+GDZhYM0g=;
        b=u+hjsVhIDKbvRcozTis1DkPn0ESZP+Sd8wJOYW7WIDQKDcD7a4CcJkAWutLduFx1Ac
         2jOZERHr/wrMd0HMCF3FNsxtJxv3fiLLKPX4kzcT9AOdYmXNV68G2Qzcjxj1YffFf50R
         2xg3/w5dyp8w+Dbj3V1/VawrbYwILC569f3qDEjI0SFAak1NcLF9cMesEXGrZ+XP3Xry
         WBn4lK7J2UIPYRV2SZtBvzCcdSQlRsWQo2/DuhaLoKYe/JQ7SM30i00eYs12UP0YBniE
         yl0hpANKnYMyu9U8yCOpAbgs+p5G3lAxsa2PEMhfyT2+RVpnQL4tDH5uxTswkKlYq0ky
         IcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3i8XFESZihDO6mc3/4tfcR56mY/Nrg7Lzf+GDZhYM0g=;
        b=uCkXwMOm2xsxdsW1YsOw3fog+1EJCbLKCb9BwG/5iGUpIckyErn6fx0NXhdwUwspaZ
         FRbnUhH5CGQRTV5bXWNCJZwk3LW/gzMTpJBvJIpaJ8t8XmpdP4SL9/cPcH0U1y83b3XN
         n4MldO7x4/8A67sZdnnAZTnnSgorKok1d6PCiUjo6LamJnpuJ8MNn12Ffd/geqyuhM/Y
         +YMoBGsjRn7UvUWnMT/ZKP5WFw33LzyyCVacINQbG6uvZhU+koGx45JH++xr2HU57+fF
         8SoZFZbQFC/HvMxp9z+K4rlZpuEWuDVPw5zyUBhFC72EUWavGCV/fCu1Fh2ciJoanQud
         514w==
X-Gm-Message-State: AOAM532YoUfQ4V5v6D8k3i1Lk3qud6Xub6s+dyzIOOYakLVTBrbRx+nT
        G54tMGrgBF2NmF2EIFff6nOzt3RQ4ZP5+RmGgUm6DA==
X-Google-Smtp-Source: ABdhPJwRtcGnWnSrfLNC1GRoMPhliXQgGipO4zbcYB0cTmrrdPOh4Q7PwFb5o1O0BAF8kY6G3DlVTaO3sR41MJVFDyg=
X-Received: by 2002:a05:6102:382:: with SMTP id m2mr883411vsq.34.1596609175004;
 Tue, 04 Aug 2020 23:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <1594230511-24790-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594230511-24790-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594230511-24790-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:32:18 +0200
Message-ID: <CAPDyKFqeiEUeajprG=Bx3Nion8bGpVrDOuM7q6-kLDpOMY-QbQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: mmc: renesas,sdhi: Add r8a774e1 support
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 8 Jul 2020 at 19:48, Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Document SDHI controller for RZ/G2H (R8A774E1) SoC, which is compatible
> with R-Car Gen3 SoC family.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Sorry, but this doesn't apply as the DT doc has been converted to
YAML. Can you please rebase and respin.

Kind regards
Uffe



> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
> index 0ca9a622cce0..779e484fa3ef 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.txt
> @@ -14,6 +14,7 @@ Required properties:
>                 "renesas,sdhi-r8a774a1" - SDHI IP on R8A774A1 SoC
>                 "renesas,sdhi-r8a774b1" - SDHI IP on R8A774B1 SoC
>                 "renesas,sdhi-r8a774c0" - SDHI IP on R8A774C0 SoC
> +               "renesas,sdhi-r8a774e1" - SDHI IP on R8A774E1 SoC
>                 "renesas,sdhi-r8a77470" - SDHI IP on R8A77470 SoC
>                 "renesas,sdhi-mmc-r8a77470" - SDHI/MMC IP on R8A77470 SoC
>                 "renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
> --
> 2.17.1
>
