Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A63FC77B6C
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Apr 2023 09:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbjDFJbu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Apr 2023 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbjDFJbm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Apr 2023 05:31:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D8B7EE7
        for <linux-mmc@vger.kernel.org>; Thu,  6 Apr 2023 02:31:28 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p203so45450526ybb.13
        for <linux-mmc@vger.kernel.org>; Thu, 06 Apr 2023 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680773487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nrbKJN6tNn5SoaDKodx2sPMgtPGrY3/0d4LglRnRjWw=;
        b=C3ZUWp5jv2p5k+fiz5+fnVwJBalRBkyRYyQSvDrPKCU/5iyYhOVyo/nvX9tTpcqlyE
         J9Mv7oygbSYXwW0fcQbO170abhdYtmzHNW/aB/1RlUSVxUQV6A/8FygoLBVJxCeKAwN4
         Q180JaJhTQaG+GLX2+dMq4VYtaEgx4eyPcY1HfWqYy272CSwvMsvfPV0L4gAAYTI1r7z
         bFyYTNS/ab4WKxxE1e87yxajVCh0GDXtgW+olE0nqWkPvS9E16mt7top8QvvEaMKK448
         sPjXjkeebQ9UG2qJqaAfsEQhNcTrNETtjhrtyZyv+CyTPZaiJ1IT3SZO7LxW+HufpjDs
         QYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680773487;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nrbKJN6tNn5SoaDKodx2sPMgtPGrY3/0d4LglRnRjWw=;
        b=PTh03qmjOmxFJATbWHsUQamesLyjWQ90xWQMSne9cHISW5FErSu9d+ZMv/AVPXrhLA
         oY4XIaJ6QWs0m2qdDo/amWAv+MIXWPY4/917KIBUqA0uDSUQPBGRoavrzYtXImHaS+gD
         /9AR0E9OwYujYsa6meA84P7fwDPAgYyNHO/r2U5NqZdfKg6+R3wKInTv7MgxkP/W7HZc
         fe1IKkxioQ4VaUE++zgcrBRHh8pCge7mLewOzrib5I4oMrEV0R5BZmWcWF9N1EXnThGw
         sv6nu41bFv6c+Pp3882nKl/1EFjGKZpyX+9luXOkOi95wuerri6rAnAxog2P7cM7Tomw
         gmVA==
X-Gm-Message-State: AAQBX9ffBEX0H6uGuHyvA/OYz/PUJtkanBJA5igMj8Wuld40UZdSmqgs
        VzubYSMT1tgjTiVpNjScRMCCgN83T9PRIxp3G2MbUA==
X-Google-Smtp-Source: AKy350bGsQPdLchFWKf2g9la+14ELRiC01S4GZX480KVbABfXHVsgyLauNQM0/TQCGMeGEvUf98TjPYIaK3P6Qtic9c=
X-Received: by 2002:a25:d0c2:0:b0:b6e:361a:c86 with SMTP id
 h185-20020a25d0c2000000b00b6e361a0c86mr1385830ybg.3.1680773487671; Thu, 06
 Apr 2023 02:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org> <20230405-pl180-busydetect-fix-v1-1-28ac19a74e5e@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v1-1-28ac19a74e5e@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Apr 2023 11:30:51 +0200
Message-ID: <CAPDyKFp1KDV+q9ApKfq7C4PoiJnMOsACKJvbEiZLhv06GJGB_w@mail.gmail.com>
Subject: Re: [PATCH 01/13] mmc: mmci: Only call busy_complete if callback defined
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 5 Apr 2023 at 08:50, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The code unconditionally calls host->ops->busy_complete()
> if we get a busy response and the variant supports busy
> detection (variant->busy_detect = true).
>
> However there are several STM32 variants that define
> variant->busy_detect to true but do not define any
> busy_complete() callback. This looks like a recepie for
> a NULL pointer exception.

This isn't correct, as things would have exploded by now. :-)

>
> Check that the callback is valid before calling it.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b9e5dfe74e5c..bc150c0d5eed 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1381,7 +1381,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>                 return;
>
>         /* Handle busy detection on DAT0 if the variant supports it. */
> -       if (busy_resp && host->variant->busy_detect)
> +       if (busy_resp && host->variant->busy_detect && host->ops->busy_complete)
>                 if (!host->ops->busy_complete(host, status, err_msk))
>                         return;

All variants that have the .busy_detect flags set, need to assign the
->busy_complete() callback too.

To me it seems a bit silly, to check for a mandatory callback,
although if you prefer it, then I suggest we do it during ->probe()
instead.

Kind regards
Uffe
