Return-Path: <SRS0=C2IL=4Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0CBC3F2D1
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Feb 2020 06:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE5E2469C
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Feb 2020 06:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGFfkxsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgB1Gqj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:46:39 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45422 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgB1Gqj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2020 01:46:39 -0500
Received: by mail-ua1-f65.google.com with SMTP id k24so593209uaq.12
        for <linux-mmc@vger.kernel.org>; Thu, 27 Feb 2020 22:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPJ2OvRxOCmEPKIxeEp6m+UO5YYbHEl1NGnXOdz3GOc=;
        b=MGFfkxsit/DPkZmPZOjFO6NBpVO57ycjoKQUSv7jQj14fcYOkrwzJha//tF5sJe2SV
         rF6/JutXvVt2AOglHZVx9Ai2EwW+iLiXVM732Q9nhPogw+H9zadQ4AIx3HXzrnYnYyCG
         GeT5N73h22uMiC9bkUxDGXcYQ1cLePWqdGJLaP7LKHsyT7ze61fSD0SKDxuQhR8E4RnX
         /RSJFJS1e91CvXGgeZORmjefHV7XvbOV+8hdgirz7uSZ0s2nH9AVFE8iBNRaouL0bthe
         Y5bIxyTZbHjwwgE+Tc+hOireM9WHpfbKxx+oh9YKw6gQSUvlA2Pf7Ou/l2YSMIR0P8l/
         ZKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPJ2OvRxOCmEPKIxeEp6m+UO5YYbHEl1NGnXOdz3GOc=;
        b=ljO4M8DpwAk8FjvhSP5ADG2wqnYPlVfmWfmWksdE0KjO5Mpub3GtG85UfnGvCRWwWw
         Fw3otkWoifgCwK8VlB4GXDO6ESwesHyfV+LVVViV+arfj+KFP8BqzOinsEhU5NUA6vRt
         67X2WmMJ+slYVjgnw1dye31IFzZv0IDZBkK24GjIOYnIzyOpPtTslNzpIRuiD0jiSOh8
         3UxN/T9SJy7mcFojOsGaVhxoyEpwzDJJ4Xp8WfGJBiMeQ77964ggH9yA2qs9W+zlKNiI
         IjQGopvrriVjBLxZ6OywWviCJKjT4evll8qHHfYoIBPdd4vn+b4S/WFCgj/6u60JGoWh
         8a+A==
X-Gm-Message-State: ANhLgQ38Ku+EXdRnMEuBRQreWlik8mPs7IzA7NjwZCNHcpDItkupxzvF
        diDF+f28jpGeIuoig3Sy4k5/i9lv5KJzWMGZSD+CiQ==
X-Google-Smtp-Source: ADFU+vvpOsoBDpUk5r/gx8ycA0CjgosW3O8Yiua7BRgqnWzXr4ld+qyf42jXy3BVL1pBAmWF2tn0rIv6kueQhwavvmg=
X-Received: by 2002:a9f:3046:: with SMTP id i6mr1323024uab.15.1582872397671;
 Thu, 27 Feb 2020 22:46:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582839544.git.nguyenb@codeaurora.org> <b328b981a785525b8424b4ab2197dc1ec54417d1.1582839544.git.nguyenb@codeaurora.org>
In-Reply-To: <b328b981a785525b8424b4ab2197dc1ec54417d1.1582839544.git.nguyenb@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Feb 2020 07:46:01 +0100
Message-ID: <CAPDyKFrGmXj8HWNz2irUd7i8Cb77U8rLM=V91vcrWE+r7Pqeyg@mail.gmail.com>
Subject: Re: [<PATCH v1> 1/4] mmc: core: Add check for NULL pointer access
To:     "Bao D. Nguyen" <nguyenb@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>, cang@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 27 Feb 2020 at 23:06, Bao D. Nguyen <nguyenb@codeaurora.org> wrote:
>
> If the SD card is removed, the mmc_card pointer can be set to NULL
> by the mmc_sd_remove() function. Check mmc_card pointer to avoid NULL
> pointer access.
>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/mmc/core/bus.c  | 5 +++++
>  drivers/mmc/core/core.c | 3 +++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 74de3f2..4558f51 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -131,6 +131,11 @@ static void mmc_bus_shutdown(struct device *dev)
>         struct mmc_host *host = card->host;
>         int ret;

This obviously doesn't solve anything as we have already dereferenced
the card->host above. In other words we should hit a NULL pointer
dereference bug then.

More exactly, how do you trigger this problem?

>
> +       if (!card) {
> +               dev_dbg(dev, "%s: %s: card is NULL\n", dev_name(dev), __func__);
> +               return;
> +       }
> +
>         if (dev->driver && drv->shutdown)
>                 drv->shutdown(card);
>

[...]

Kind regards
Uffe
