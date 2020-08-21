Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134BDC433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E302A207BB
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 13:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oye/IAhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHUND6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgHUNDx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Aug 2020 09:03:53 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88561C061385
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:03:53 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g20so506034uap.8
        for <linux-mmc@vger.kernel.org>; Fri, 21 Aug 2020 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+UdDeZ/2tqE7MfvVL8jobOjZYYl/iWCp3SMwXE+pYI=;
        b=oye/IAhwoGHhUTKN0VDCeB9+n7Ej5BVwsxTVFBrPEUrAH3agaKG/a8gY/MpxPCDPQL
         RhDAZBl1ESEo046+/7L962m/G0G9ZBoKssMsZ+UiQwq2KTW5KSLNgdLqtsdWuBFMNoSA
         O9WJmv6LyF5YRFDFll1a4lw6Q7JgIPX7ffEvBu28jH1DXV46fBULX011gWhf2xqU7yOY
         +cM47S3PVLc7HRUZz2U+fCtvWaLE2sp9piQtHatgqWV/iNGFqMxPXQ2LHxvfPCGwhYms
         o6DrsY5zx0QTBIDLTElUd4P5ONhgafNb8/ZRgmSFJu1EF/r9N+KAZPUXAYrqBvv7Ifs/
         yvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+UdDeZ/2tqE7MfvVL8jobOjZYYl/iWCp3SMwXE+pYI=;
        b=OwLgYY6CYMI14Jr6Rx/+U5q1Xee5dieh9aee1gCsm7pAUB36NrFR5m9I7oy/N96u6i
         9oIzqn/aFPJfF4PUtL+6vFvhunoDDra62gGC6LxVNb2sVW8UGOQcDMGqwN+MKL2WFtyX
         6q6CzNI3qn9tgBPHn+A+hYM2L842FJ2+ggwLPpQeKLCOMXDWYKFQ8OJIDuLQahwnjIFW
         Yg4mtGb8RPXX3hMP8zBcyQWwVoGgxIlTAEHU9fhhX67CHCDOSnS3Z7tHTtwvypt3D2pW
         1wsKVCJWtB1EgTXGitk2pG0s++PdQHWDhXVtniCBiM95Ho17zXI2LETzuU1zUGCEc5wi
         yU3g==
X-Gm-Message-State: AOAM532UpvYvJJeSpLHg7oxophIHWXdRwaQP6x013+BoajD3PF1yiMvh
        jbrsclB4r6so2IBa1HF2LTSw1EVRgn90zCytzjYqQg==
X-Google-Smtp-Source: ABdhPJxDTEfIcRtV8RMQHOwlZMFRP/4rR96hCwMj4qXIk7uEX+dsYaSghRhbtxsDlt6Dcfzr8CA6M9pC/tkoV/n7lWU=
X-Received: by 2002:ab0:65c3:: with SMTP id n3mr1386883uaq.100.1598015032299;
 Fri, 21 Aug 2020 06:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200718090614.88946-1-grandmaster@al2klimov.de>
In-Reply-To: <20200718090614.88946-1-grandmaster@al2klimov.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:14 +0200
Message-ID: <CAPDyKFrzq0dGKJtR4Ncp670-EdsoHBhWQQ=30dUnK3FM_TmWQQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci_am654: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 18 Jul 2020 at 11:06, Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
>
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
>
>  If you apply the patch, please let me know.
>
>
>  drivers/mmc/host/sdhci_am654.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 061b4398a4f1..f2c89f0c0263 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -2,7 +2,7 @@
>  /*
>   * sdhci_am654.c - SDHCI driver for TI's AM654 SOCs
>   *
> - * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com
> + * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com
>   *
>   */
>  #include <linux/clk.h>
> --
> 2.27.0
>
