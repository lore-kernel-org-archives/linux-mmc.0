Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22352C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jun 2022 12:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiFWMa7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiFWMa7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2022 08:30:59 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF329419B6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 05:30:57 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id n24-20020a4ae758000000b0041b82638b42so4010644oov.9
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jun 2022 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVRculqp+8YlE8R1a3c/ayoMskwxPMfVf3UlLMhmDhU=;
        b=RlevhDgG85c21yWvbAvjWXGG4oq+QSxPI4MzhJ2M5njYt7JbpUuvuggLqmUe9je3U/
         XN4SX4JgkNMW1PyyiSmMa3tS1migQVbHQOUC0FmEN5iZ1igS003VX+TuLxWSdw/VTF0j
         xr673leE2DphsOfujUk25TWi5VY8FpQUxTZxERM+YXIs9WXNOGPyHvrQPqRoi102DPTH
         iL/6p42GqkUF7C8ebPbVGQdGNSBycxZ2mNPnpQnOLNJ5V5+3UmDVWY8xOUE459viyIYK
         8hut325I50KHduZZfCdoPcvlQE3VPxXMBbj4woNOKzSwz6BPQ0ZncSTSGJA7DDLC9KKp
         Zefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVRculqp+8YlE8R1a3c/ayoMskwxPMfVf3UlLMhmDhU=;
        b=5iAVc5TRPb8vvPesxbEUm+MlhSSyrgPSi4hRpYaP8olDybgL7Yr6ubvkKjN6OnQDgP
         NZSmjUc8bEQreuoMpbvulVoO0Hhx6HHajPJR6hSMh/XbLvcjh+SHeTlzBvh+Fkx9w8dC
         QRUMZMm1B4qNWRwb4XgCnR38Dh+x35xgpDMottXZaG/vxja7FpeAASS2zS49bluXNMit
         GPOYVwCgArgEUhzUn8QGGaXtUpWNdtQmGAqaPhcWTRiDnKA2D/Tkp/1kCAG4RCdPWHAl
         58cz25e2P+VAGBci3i0PtpgPd7i/2b+YM4tc+FfPUkMFhraXIT8cpDB+7FLmFw7RM6s8
         XLHg==
X-Gm-Message-State: AJIora9vEciWlRo/GiYjHmxKeNYuAHJ28w0jkL9cWkKu1zPd1QBoLiNR
        Afa53OTpFvB6CGm436YE8XVs8UurWSdNaa42l76t/E7VzAY=
X-Google-Smtp-Source: AGRyM1vuVf7rC6lm4jrnpHo2nLtmUEuUP8h6EK6raDzX/y8U9qlprmYuclmVvQx9xKqnxcgIrD8Ym/grYKDl5RlImmg=
X-Received: by 2002:a4a:978d:0:b0:425:78aa:f546 with SMTP id
 w13-20020a4a978d000000b0042578aaf546mr48715ooi.1.1655987457148; Thu, 23 Jun
 2022 05:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220621094146.77216-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621094146.77216-1-jiangjian@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Jun 2022 14:30:21 +0200
Message-ID: <CAPDyKFqFLGeLGk6mupPwNdKSbGk5=F9TzCukq-a2hYuF1LYFtw@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw_mmc: remove unexpected word "the"
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     jh80.chung@samsung.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jun 2022 at 11:42, Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> there is an unexpected word "the" in the comments that need to be removed
>
>  * command hasn't already completed (indicating the the irq

I am fine with picking up patches for these kinds of trivial
spelling/wording mistakes. However, in this case, it seems silly to
have one patch per single line of change. Would you mind walking
through the entire drivers/mmc/host/* directory and make one patch for
all the mmc host drivers instead?

Then if you want to continue with the mmc core files, that could be
another separate patch.

Kind regards
Uffe

>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 581614196a84..7f00d7d7e35e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1363,7 +1363,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>                  * is just about to roll over.
>                  *
>                  * We do this whole thing under spinlock and only if the
> -                * command hasn't already completed (indicating the the irq
> +                * command hasn't already completed (indicating the irq
>                  * already ran so we don't want the timeout).
>                  */
>                 spin_lock_irqsave(&host->irq_lock, irqflags);
> --
> 2.17.1
>
>
