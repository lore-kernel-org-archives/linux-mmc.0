Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CBC433E9
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 13:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC42564F52
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 13:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbhCDNwT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 08:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241628AbhCDNvx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 08:51:53 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A49C061762
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 05:51:03 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id t23so14603197vsk.2
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 05:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJXZ2arE5/PeGIfJbk/myFW93wYw4LD+WoYIfQWesRM=;
        b=GQuY4jur5/xYVSlYy1G04K6z6YgIA2BN1h9VDBQrjz+ac4Al6iMMA1nwKuH3XSNrRt
         LwBWlGaZTo4VC6L230yhhcpqUNQtqSVLHGeky7BIHsPHI8K0++EzcaMBJj+33Y+6NKzF
         IG9sLfu/WrDdETxemzrzQ1WVXhX36L81iUpzR1+jYSRt0Nee8F54bbg03aLO3WTLNcZE
         xVz9Z6Ls68ysXOI3VldRl4Wp3JpB0fwhfdBtx481XY5+8rSzYlHwQfS4QoY5VQeT6vYU
         LCSSPkqneN4zVVPXYT2K9uwGNQ5wgvWq4fdTRjkVrLKhsWsQ5cmHcwcKmJ8Y4YJhDYd0
         pAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJXZ2arE5/PeGIfJbk/myFW93wYw4LD+WoYIfQWesRM=;
        b=Fsxv+h1k0X/7QJg1HmDfpsy60eVqQzbMnSTwA/KeUcVVx9u1z3IwmGDBuDMqeFU0dc
         BN80eo2WPztwcfYPe2X2ZGy71QqDWV5JiYmIPdxHZlHWwHOnLHV54OOpAhYKdiOzGE/E
         a2SyJ25rlKOVyCVfAS8U0Y4z4YNyDYYDXGKkBMDzXls7NV745bK58FkFj16ZgY0gBKTz
         Kpjs3asUmbXhuAfWAJ3YQCsP9SCxRjBgvKAQtlYRhQJK7C7yXRPnDRdSw6R1ciUAamIq
         h/BiyrJcTXswpwWg9FqqIefWusjAl1eL2MjYcC8ASV90CnStsbNI9CcvH7Yh62K1zlPA
         2o+Q==
X-Gm-Message-State: AOAM532dmowJ8irbYwvYhaCnhK6qZNdkHMQMRTzRuTGpnbenAVEl3gIE
        +9/2y0eIEOrtZg+yHsXMT3PDVP14s4ghNNf5NqDJsQ==
X-Google-Smtp-Source: ABdhPJwi4U3IpXVIyGV8sqDM7hqKMsvS/ksjvSZjh04fUsPdmav/34FszNNwCupM2djXb0evWO/VjFWntpYc70cFgxg=
X-Received: by 2002:a67:f98a:: with SMTP id b10mr2225109vsq.19.1614865862858;
 Thu, 04 Mar 2021 05:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20200122142747.5690-1-ulf.hansson@linaro.org> <20200122142747.5690-4-ulf.hansson@linaro.org>
 <20210222162406.GA17142@home.paul.comp> <20210222201245.GW2059@home.paul.comp>
 <CAPDyKFpXceh0qWZMxnOnLmrnwyt==qWWaxHCYzb6UxGRcvgksA@mail.gmail.com>
 <20210223093247.GA2059@home.paul.comp> <3c8007d5-4040-2a43-59a5-08579824ddff@intel.com>
 <20210223111926.GC2059@home.paul.comp> <CAPDyKFp=XhnoD0re3kwM-yt4URK4vc7UnJE_+oKnqierMuKJ5g@mail.gmail.com>
 <c9adeaa3-8833-fe2b-cea8-50b645db0a9d@intel.com> <CAPDyKFrWOs7xO1f+miz4cQznHcYQL+sunpzOW3Jg6P0rFOSS1g@mail.gmail.com>
 <168bbfd6-0c5b-5ace-ab41-402e7937c46e@intel.com>
In-Reply-To: <168bbfd6-0c5b-5ace-ab41-402e7937c46e@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 14:50:26 +0100
Message-ID: <CAPDyKFqM9oiF5ng3EJfkHTyb14iOyb+OFFzNq-EFZimjkbLz8Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix partition switch time
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Paul Fertser <fercerpav@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 3 Mar 2021 at 10:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Avoid the following warning by always defining partition switch time:
>
>  [    3.209874] mmc1: unspecified timeout for CMD6 - use generic
>  [    3.222780] ------------[ cut here ]------------
>  [    3.233363] WARNING: CPU: 1 PID: 111 at drivers/mmc/core/mmc_ops.c:575 __mmc_switch+0x200/0x204
>
> Reported-by: Paul Fertser <fercerpav@gmail.com>
> Fixes: 1c447116d017 ("mmc: mmc: Fix partition switch timeout for some eMMCs")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0d80b72ddde8..8741271d3971 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -423,10 +423,6 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>
>                 /* EXT_CSD value is in units of 10ms, but we store in ms */
>                 card->ext_csd.part_time = 10 * ext_csd[EXT_CSD_PART_SWITCH_TIME];
> -               /* Some eMMC set the value too low so set a minimum */
> -               if (card->ext_csd.part_time &&
> -                   card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> -                       card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
>
>                 /* Sleep / awake timeout in 100ns units */
>                 if (sa_shift > 0 && sa_shift <= 0x17)
> @@ -616,6 +612,17 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                 card->ext_csd.data_sector_size = 512;
>         }
>
> +       /*
> +        * GENERIC_CMD6_TIME is to be used "unless a specific timeout is defined
> +        * when accessing a specific field", so use it here if there is no
> +        * PARTITION_SWITCH_TIME.
> +        */
> +       if (!card->ext_csd.part_time)
> +               card->ext_csd.part_time = card->ext_csd.generic_cmd6_time;
> +       /* Some eMMC set the value too low so set a minimum */
> +       if (card->ext_csd.part_time < MMC_MIN_PART_SWITCH_TIME)
> +               card->ext_csd.part_time = MMC_MIN_PART_SWITCH_TIME;
> +
>         /* eMMC v5 or later */
>         if (card->ext_csd.rev >= 7) {
>                 memcpy(card->ext_csd.fwrev, &ext_csd[EXT_CSD_FIRMWARE_VERSION],
> --
> 2.17.1
>
>
