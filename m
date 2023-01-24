Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BB7C54EAA
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Jan 2023 10:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAXKr0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 05:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjAXKr0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 05:47:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399E13A859
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 02:46:38 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so58350pjb.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 02:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EwYsnKm1wuuHwoknofZDyXm1lKsn+VLmuOiZFMPmJr8=;
        b=LcdtX8SMvVIGxfKCh6w7FI3Qfg28xzH3kvCfc9/DEjQa1Ew9TVUn/z0QKqK7YwCmPp
         bN9Lu6GNBwOdxKKwf97NStJGopS0aGw/wphnyA6o9w86s8WvJvSbNWbcBxH+pdAH2WvN
         VeP3wMBvEh7qXU9nBljfGFm/rvfW0tcV1QGVQ+P+xkUv+zOXjvWrdPZPhBQ4s/GByGcH
         6kXkBRoztlR3aCk7niOSIy0y2NG9LiU5cT2goOzReIc1k/DoLNbQW8yFFW0RDD3kD2y4
         FYwq6pzQQIEv9d/5Lh4ezadxs8Hded+jrShRIFzsRLgBAXWjtf6zQqxb//rqsr9s7gIy
         lbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwYsnKm1wuuHwoknofZDyXm1lKsn+VLmuOiZFMPmJr8=;
        b=awLDpo9Ydg7PZAb7qf0+0EemX0/A+skocGqbaS4SeVECiQUfKxzhQN7WpvmYoVPi1y
         nm3TWurQpxe1pVPI77OLm6tVKxgggSJNpYyoN8ky6ddTNQg6b2ZY8Qj8N/14BD7OVEIT
         Z6LcGZLElbzjgo1mE/EjHstF2Y4WecNgUa2NeGCeDs1WAAZIbSdjDYTuv8RNBuUn7hGJ
         1UjlcSsnhm4bPYenl22BBkiePv+VbnzpC4SVgNp43gA02sr89XOZW0R2/TwtQeFDFVuU
         Apk6LaNy3CerPEB0gKsZMQFAILHG2Nmd2oeuizLjpxqsWEzXz3RHoy5zFr5NUK/3uE+7
         UZTw==
X-Gm-Message-State: AFqh2krPQuOTBkfBP5Dey8y7iz1w466VT5Gys8o+Zm8CUmaGHP6P8WY4
        5MyX2LyR2yeSQnPNyGASp/5gTtLEBBJSP3io7dmQNA==
X-Google-Smtp-Source: AMrXdXuhaAkHjqf7wVL9LKFqRXHeOAo5mSB8U+1DMxKodtCvkWljszswAog6tkypto9FMffKtU7XuESss/m+QPGX1NE=
X-Received: by 2002:a17:90a:1d07:b0:228:f08f:a9b3 with SMTP id
 c7-20020a17090a1d0700b00228f08fa9b3mr3562268pjd.202.1674557189474; Tue, 24
 Jan 2023 02:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20221230194315.809903-1-t.schramm@manjaro.org> <20221230194315.809903-2-t.schramm@manjaro.org>
In-Reply-To: <20221230194315.809903-2-t.schramm@manjaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Jan 2023 11:45:53 +0100
Message-ID: <CAPDyKFo-LCrS=pVB+9+ob4txcRbBgCD-W8KEBwDZdvZR4f=_zg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: atmel-mci: fix race between stop command and
 start of next command
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Dec 2022 at 20:43, Tobias Schramm <t.schramm@manjaro.org> wrote:
>
> This commit fixes a race between completion of stop command and start of a
> new command.
> Previously the command ready interrupt was enabled before stop command
> was written to the command register. This caused the command ready
> interrupt to fire immediately since the CMDRDY flag is asserted constantly
> while there is no command in progress.
> Consequently the command state machine will immediately advance to the
> next state when the tasklet function is executed again, no matter
> actual completion state of the stop command.
> Thus a new command can then be dispatched immediately, interrupting and
> corrupting the stop command on the CMD line.
> Fix that by dropping the command ready interrupt enable before calling
> atmci_send_stop_cmd. atmci_send_stop_cmd does already enable the
> command ready interrupt, no further writes to ATMCI_IER are necessary.
>
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

This looks reasonable to me. I assume we should tag this for stable kernels too?

Moreover, I would like to get an ack from Ludovic before applying.

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index bb9bbf1c927b..dd18440a90c5 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1817,7 +1817,6 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
>                                 atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
>                                 state = STATE_WAITING_NOTBUSY;
>                         } else if (host->mrq->stop) {
> -                               atmci_writel(host, ATMCI_IER, ATMCI_CMDRDY);
>                                 atmci_send_stop_cmd(host, data);
>                                 state = STATE_SENDING_STOP;
>                         } else {
> @@ -1850,8 +1849,6 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
>                                  * command to send.
>                                  */
>                                 if (host->mrq->stop) {
> -                                       atmci_writel(host, ATMCI_IER,
> -                                                    ATMCI_CMDRDY);
>                                         atmci_send_stop_cmd(host, data);
>                                         state = STATE_SENDING_STOP;
>                                 } else {
> --
> 2.30.2
>
