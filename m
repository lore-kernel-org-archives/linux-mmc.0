Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B6C48BDF
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 12:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA21B61209
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 12:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFXMX6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 08:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMX6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 08:23:58 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00FC061756
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 05:21:38 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id c8so208422vkm.7
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isLCL8z1tmap8GWbdidUDZTyoK/UcjEM+jtMkwPkO5c=;
        b=V8Z2rYP9OJTVNtXXqvE7v3Mf+0pfw7pZxjd2hjFHYBAGlPZI7b0WBqSos3Ef0BsgOP
         en20p0dI5cuZ/PwM7pfgADeiNsApZAuDaJ6htITpk30b2NDSSEdt9MCuXdBYi0zVWifv
         lXwPNcUEWKeu/U0rwA8JhX7MCTQrtQzM1N/YSt/5CxdrNpiTLj1J7xOJaOnIy5+OvqGs
         oMJJLbE9TRGtS+hh3EMEnTA5dXw9jZ0YZ/OXnTzhbUW4Fw0cbRz5xnba39l3mm1ZoKWR
         oBMNoXJiyRJRpoQ/9/OF3w3E3YPUkx/S4WbC0O/j1zMlMs7UT/HS3PXaGgd7bdEgb7y2
         6rVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isLCL8z1tmap8GWbdidUDZTyoK/UcjEM+jtMkwPkO5c=;
        b=FlGnUzLhzrq21L+W2uaUDRCPwDrppHsTluo/ShRj4LPmDkCO8xiSYJvp+YXUHq6Msk
         bS19QhG6+Fy0E6xymlz0Bk3dkEAyy3NQWmN5d4GKDCAM/Ru17GMq6JAZRdea+V2Le/zY
         izORxzNE3CSysRCHXoOEmyE1XukHt0m7yQnDe1GzPjeGSHrsBttr9WyvI0d5txZAe2Jm
         00BDql90QrubwZ9VRnVLOF59ajywPYuYTgTQkH+2TlMPpxIgq9O6MYL0ngYU8CbnDjLb
         ThUdiumVIXzMOTTd5JFAQZo90sa+WJXXn3wpnOj4cIYWhMKrtqZ9fEbHjlbxVZT/2FQs
         cEuQ==
X-Gm-Message-State: AOAM531o0o4E7c4gaygB4LvqkMcSZWxep7uPg8jwE9LDCwyG4I1k7iLJ
        rOHxlVSPV8UafrlLUa0MJht2zlHGgzqYp9tUUVWAbIoWoPpXXQ==
X-Google-Smtp-Source: ABdhPJz7GQQuIfdJYhmoRqROf007FYGiLEEBVLQ+2Zqf46YjLV1k6z7Zz8FTtSZ0eNS3xHebY9DAST1qB6OIyWnCIGc=
X-Received: by 2002:a1f:9505:: with SMTP id x5mr2209916vkd.6.1624537297559;
 Thu, 24 Jun 2021 05:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210624061418.30361-1-tykwon@m2i.co.kr>
In-Reply-To: <20210624061418.30361-1-tykwon@m2i.co.kr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Jun 2021 14:21:00 +0200
Message-ID: <CAPDyKFrh9azyXNwFHxoe1svDQKRWbr5FpWz3V_JOD+Zv0cHcug@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Added support for LED trigger only when SD
 card is connected
To:     Kwon Tae-young <tykwon@m2i.co.kr>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Jun 2021 at 08:14, Kwon Tae-young <tykwon@m2i.co.kr> wrote:
>
> led_trigger_event() is always called.
> In this case, if the LED trigger is set to the SD Card, the trigger
> will occur even when the SD card is not connected and the LED will blink.
>
> In case of SD Card, it is judged based on Card Detection information and
> changes to generate LED trigger only when SD Card is connected.
>
> Board tested: NXP i.MX 8M board
>
> Signed-off-by: Kwon Tae-young <tykwon@m2i.co.kr>
> ---
>  drivers/mmc/core/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f194940c5974..b3156f6c5cfa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -352,7 +352,11 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>         if (err)
>                 return err;
>
> -       led_trigger_event(host->led, LED_FULL);
> +       if (host->ops->get_cd)

No, this is not the right thing to do. Invoking the ->get_cd()
callback, for every request is suboptimal and would likely have
effects on performance.

Moreover, I wonder how big an issue it is to use the led here. If the
card is being removed, the request will fail anyway, so the led should
soon stop flashing anyway, right?

> +               host->ops->get_cd(host) ? led_trigger_event(host->led, LED_FULL) : NULL;
> +       else
> +               led_trigger_event(host->led, LED_FULL);
> +
>         __mmc_start_request(host, mrq);
>
>         return 0;
> --
> 2.17.1
>

Kind regards
Uffe
