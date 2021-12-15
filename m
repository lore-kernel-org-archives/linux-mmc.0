Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06561C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Dec 2021 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhLOLEr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Dec 2021 06:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhLOLEq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2021 06:04:46 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C8FC06173E
        for <linux-mmc@vger.kernel.org>; Wed, 15 Dec 2021 03:04:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z7so42358858lfi.11
        for <linux-mmc@vger.kernel.org>; Wed, 15 Dec 2021 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Mxq4v2aa07cn7vmDque1vmJSPRI9q1+xfotPBgOEKw=;
        b=YYVSOtge5Ubs9/QdtAuGxXrCKYFLrjlM3KjC61oHbi35tATBP533nULGmmFdbr/Gvy
         4tK5sdKWdmzTQZoFtgo2YBjm2MjEONJK0mYJt6hi3UgQ0iMg88k53RtPGndnLhtVi/2N
         Oge5CcFSb1F6WZhg3zr87NahWwQR586UpuYU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Mxq4v2aa07cn7vmDque1vmJSPRI9q1+xfotPBgOEKw=;
        b=hxp+97va79FBtwDzIpg529Aq7qaOsxfHMB4CAaJpqt/QCDyPUo3OMInxkA8szUEW5s
         ktLg8MM+UsSsWVOwidhIViijR7qoDbKoT1cremmgcQ+Owb9p+/urv+x911+d3Ce3Ot6m
         2+Q+ONHim7FVZyEc1w27g9S7Ekr+D+QKnwO4DmlThBcwPH87DHqxlqkJcw19UjiAjVq4
         Dhwdg8Jhbu8U5Anmadt4uSqf/TaIZFd/Nnqyz05Q+83zosD72UFTzOLiFh5aB+V/f//d
         It/ol+guytt1dR/Hem51ZHSqbmmsH0xgL2yy0fahMzYYCvJmq4uVH0wD7/FjB7CypMEx
         RaAQ==
X-Gm-Message-State: AOAM533aoCpIxi37+A0jJEhvuRdsOeBcUU1Oi2CeIzPlkaa4qw9StzUn
        0m+q6BV8Vaw2Fr6QYa8589sHGRViu5heRxz74cSLXA==
X-Google-Smtp-Source: ABdhPJxWhA1IhaY2P5SVuTF/Dv2jmTo+wwNa0EsIvD5ISkU2YTob2I9LJQKrHWvVMA8n4dFomFv8yOt53VdRikP8LXc=
X-Received: by 2002:a05:6512:3f2:: with SMTP id n18mr9409898lfq.646.1639566284404;
 Wed, 15 Dec 2021 03:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20211210145430.3707463-1-gsomlo@gmail.com> <20211210145430.3707463-2-gsomlo@gmail.com>
In-Reply-To: <20211210145430.3707463-2-gsomlo@gmail.com>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Wed, 15 Dec 2021 12:04:07 +0100
Message-ID: <CAPk366RvYSdn8Y2Vy-qDh3wVsBqZgvJk+fZArze8u0s9oob5_A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] MAINTAINERS: co-maintain LiteX platform
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 10, 2021 at 3:54 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Add the litex_mmc (LiteSDCard) and LiteETH drivers to the list of files
> maintained under LiteX.
>
> Add Gabriel Somlo and Joel Stanley as maintainers; Joel authored
> the LiteETH driver, and Gabriel is currently curating the LiteX
> out-of-tree device drivers as they are tested and prepared for
> upstream submission, having also co-authored a number of them.
>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Acked-by: Joel Stanley <joel@jms.id.au>

Acked-by: Mateusz Holenko <mholenko@antmicro.com>

> ---
>
> New in v4:
>   - n/a
>
> > New in v3:
> >   - picked up acked-by Joel
> >   - added listing for liteeth driver
> >   - added Joel as additional co-maintainer (thanks!)
>
>  MAINTAINERS | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8691c531e297..7f59779bb5eb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11011,12 +11011,17 @@ F:    lib/list-test.c
>  LITEX PLATFORM
>  M:     Karol Gugala <kgugala@antmicro.com>
>  M:     Mateusz Holenko <mholenko@antmicro.com>
> +M:     Gabriel Somlo <gsomlo@gmail.com>
> +M:     Joel Stanley <joel@jms.id.au>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/*/litex,*.yaml
>  F:     arch/openrisc/boot/dts/or1klitex.dts
> -F:     drivers/soc/litex/litex_soc_ctrl.c
> -F:     drivers/tty/serial/liteuart.c
>  F:     include/linux/litex.h
> +F:     drivers/tty/serial/liteuart.c
> +F:     drivers/soc/litex/*
> +F:     drivers/net/ethernet/litex/*
> +F:     drivers/mmc/host/litex_mmc.c
> +N:     litex
>
>  LIVE PATCHING
>  M:     Josh Poimboeuf <jpoimboe@redhat.com>
> --
> 2.31.1
>


-- 
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
