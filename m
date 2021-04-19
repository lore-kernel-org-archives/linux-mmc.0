Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C36C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C069061107
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Apr 2021 12:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhDSNAU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Apr 2021 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSNAU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Apr 2021 09:00:20 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0314C06174A
        for <linux-mmc@vger.kernel.org>; Mon, 19 Apr 2021 05:59:50 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 66so17501669vsk.9
        for <linux-mmc@vger.kernel.org>; Mon, 19 Apr 2021 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfOA2fJqrmUH0V6oeInMKkmh/Za44ba9W6xTvurj+Fg=;
        b=ZPCOd5rTk9IhUMyu4sOkEi9OUk4b17rIFqbKSWh1MU7CDJmpdr43mu007PIONyCmM5
         lVfRVHV8kjnLm8QToRcYwXtnuOYul94cPley36foigct7s2u7UKa1iHR/VGFuG0e2DKx
         VFUii2IRIwH/frKzMD1RtlATkgJUlgbUv7G4PO+oGTftEBSHsFc4NJ22varpbKHBs9+Q
         UoFClrHwKttWssaO04p6c9hnGmKNxrQF2u6sLFUhtQWzMxh4HNwHvg6BqJ3/UASCwE2r
         SQKAwtcDqdXwJsNeMdShk01vMJYAbsLj6ehrBVU57TneX3u2hFuRCjzd4WyJKcGLJblj
         54Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfOA2fJqrmUH0V6oeInMKkmh/Za44ba9W6xTvurj+Fg=;
        b=MnQ5h4pVC46RAovSUjm49ai/En4JPSAy+rcCP5wML+zzIrB8BztlqmZgu7W15MHp2Y
         rSDGXoBx8w/cYEP3zz3Q0RyAhE0Y6uBKNJDLBp2U2xe2E9U2+Logi8o1C4LTvmBOEIkt
         pOiDppQFJ6tvrEE5ssoWSWCX/Ke6WzgsehzuqlUVg5GSwzOITc563VMNjnxLBxLiwPEr
         3TLMeGvo4KsbPSbUi2Iy+pAwwuWTjyDtNpZQJ5+XcsCa9W6Cr78FQ7IavOJjngum9Z/p
         KzpkibL4Apjb3h3PrWa1ilg4BtdVpZeSTL+l4WwodQzCPOP6flEinzJXDKy1eo7oy9VL
         XZXw==
X-Gm-Message-State: AOAM5311PwdB620Kttsh5k08PM9JusdGbM5gBwfLYS7QVJaEo2uHDRDk
        QERg09pxL7Mntk0m40hlF6cMfKRh/Vg+GgocJxA1icjbz/Vy9g==
X-Google-Smtp-Source: ABdhPJwt1y1ZpSzLC3eFat/GmkHji1q5G6LFnEcx8ONWvqUG56tiSZD8J1yXKo7UpSxwEbzmrOyArcpO7WAfHaxceHo=
X-Received: by 2002:a67:e902:: with SMTP id c2mr1456865vso.42.1618837189916;
 Mon, 19 Apr 2021 05:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210419122943.68234-1-ulf.hansson@linaro.org> <DM6PR04MB65755248E394D37512288DACFC499@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65755248E394D37512288DACFC499@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 19 Apr 2021 14:59:13 +0200
Message-ID: <CAPDyKFqqrqhwk6XPgmnfyj7Hh_8aRN3kHSHR7b4E+RVGVYDKhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Move eMMC cache flushing to a new bus_ops callback
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 19 Apr 2021 at 14:46, Avri Altman <Avri.Altman@wdc.com> wrote:
>
>
> > To prepare to add internal cache management for SD cards, let's start by
> > moving the eMMC specific code into a new ->flush_cache() bus_ops callback.
> >
> > In this way, it becomes more straight-forward to add the SD specific parts,
> > as subsequent changes are about to show.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks! Patch applied for next.

Kind regards
Uffe
