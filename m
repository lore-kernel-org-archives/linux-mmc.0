Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94F7C05027
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Feb 2023 15:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjBBPXC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjBBPWy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2023 10:22:54 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8247315573
        for <linux-mmc@vger.kernel.org>; Thu,  2 Feb 2023 07:22:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso2132640pjb.4
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2023 07:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDprxbolKOWdwwbIHMkRMigRdw+EGw2x6+hQir7JvSA=;
        b=doQlECiin+IZHhqzYYBAGmG7ruHwjSzhZrT63tI0qaxrLqoCRt1F6MC0t09QD/nDRT
         qSuJ5JdN672y3v5s81n3vaM1ZsRwnMcZ77rgWkAEuzW/FFQ//L6IRTdP8L1DkTKQYw64
         o/NgLjAIM5f21e1RK6cv79FOSjj0PDlhytOWysU/jnj5OkZFhWEwAEeGRDvHWDpw3Fhc
         2FOlPRmv8n7Asfb0qMnTDsgUmCmzjU4gQMdCas6sPEjWyfJvzEmlZ6pn/WENmrL8Snmz
         OCR4N94EGcLG/ieyVTtMfy2YLdWlh/2sDOk0PkviZWyQjk2Bmigt+1bFBjANliUXJC5n
         0fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDprxbolKOWdwwbIHMkRMigRdw+EGw2x6+hQir7JvSA=;
        b=e/YosyB0AKRitjUQDuCDr3eu3eT7r5meqoIpmsBjZWclE8KrFemiTSwD+Hb6CFiMrK
         0j0Q3LWsseTRjycpa5gV5HbmfAcQt2otpcM+0fqRVHuwYHC1QNdDYBWONM4iucGxzhQU
         t5AxM49C+YPebjUSen7LECOgWc9oK9ECTljLDswv/ZtKOI1jFT8YDFZ/uRM4gTLM9Lyc
         myabO3Bl5Ntfxu6V2e/5VqTUNV2QCmLaqR57UsIETrOyEe/EPPteRHaq+yB+3q0V3MIi
         uwQLMd8z7FIRMT5+gv2Zh2Rc5wI26fzlsxo1FmTReBHj7fdbIsJDxkI3YFQ2z6LFSXB6
         7hBg==
X-Gm-Message-State: AO0yUKVZV1vh8+lNFqVSHRThV0Yt4xJGshbhkV+m3Y0VwA35OYFIzDw1
        //vdYSSOShTF9cTOWLNG4XE/kFTehNugEdRbn3TfeIl7lnAu2A==
X-Google-Smtp-Source: AK7set98New9iXm3ve35FJg7oNZjOErzLseWUSRPRNXVwcE7LzG/FJWndHiXjjUOs11lfhzwYHgb+c0FtlQ/B3QsQgc=
X-Received: by 2002:a17:903:11c7:b0:196:1462:3279 with SMTP id
 q7-20020a17090311c700b0019614623279mr1676619plh.17.1675351372019; Thu, 02 Feb
 2023 07:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
In-Reply-To: <20230131084742.1038135-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Feb 2023 16:22:15 +0100
Message-ID: <CAPDyKFrLetcCcFueJzZeWa-SVbsJcspwZ+nXWUDCGRXawxNhdg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Jan 2023 at 09:47, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we enable the MMC/SD block layer, use Kconfig to imply the BFQ
> I/O scheduler.
>
> As all MMC/SD devices are single-queue, this is the scheduler that
> users want so let's be helpful and make sure it gets
> default-selected into a manual kernel configuration. It will still
> need to be enabled at runtime (usually with udev scripts).
>
> Cc: linux-block@vger.kernel.org
> Cc: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I have taken the various arguments (for and against), but I think
$subject patch makes sense to me. In the end, this is about moving
towards a more sensible default kernel configuration and the "imply"
approach works fine for me.

More importantly, $subject patch doesn't really hurt anything, as it's
still perfectly fine to build MMC without I/O schedulers and BFQ, for
those configurations that need this.

That said, applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index 6f25c34e4fec..52fe9d7c21cc 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -37,6 +37,7 @@ config PWRSEQ_SIMPLE
>  config MMC_BLOCK
>         tristate "MMC block device driver"
>         depends on BLOCK
> +       imply IOSCHED_BFQ
>         default y
>         help
>           Say Y here to enable the MMC block device driver support.
> --
> 2.34.1
>
