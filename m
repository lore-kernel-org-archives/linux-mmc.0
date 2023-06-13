Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E2C7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 12:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbjFMMIi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFMMIh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 08:08:37 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEF5E56
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:36 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-56cf6f4211aso35602607b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686658115; x=1689250115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPJzuW0ixM9ZYI29kAN8WxQgl/GV1/FsHCF7gaVnK78=;
        b=r8T7q0eWqU+jx8bkFiitMspo6hRJX+2Y3SinRe2ydRHu8y3+aXBVewA6Rgj4i+F07O
         3dQexa539cgwhkOtEevmfMo5O/4dLZnqOGI9c3mF9IIvzqCv9edD/r7+ZMudcRqWYGEe
         hKRzS6KjDWJR8TaA0QLprELgc1ZIYBbUCz52Ma12gqq6kbfm7zA6CD+Dh2pQG//TGPJo
         +TnPCH9t6OtpHC5cjVy17hE40wLZtEOZ1d2r2HhzI/TDGWPzWFMZ9uRtiS3qkgPt/S/+
         YWy4uuu1ymnnuLzn+TV4PTT/DyCwSibeNrjWOfTHIS3md7dj3HSQH5xFwU62HAALEh2P
         +SvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658115; x=1689250115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPJzuW0ixM9ZYI29kAN8WxQgl/GV1/FsHCF7gaVnK78=;
        b=NanCtJSipe/IVR26BrYkT5W77LRmIkVAayulwrcykC6F8+wUAUgHL7J6uQhW4ltC/G
         8y1p+jW40n+l13zTl4RK3HB+8zLlw/dHKiaYT5ZkkzQvBBY8WycxkrY8ldzr0q+IaGn2
         x7nJOrk5b6Lh+PbylJ+yQfKR3jPnY0sFjkRcnxRHRPQ1bv++uUC0PP4Ig0Z5XC55cZ6V
         SaX+EAQ4pux68R8cIME7knOTeel3sCFalCj89XyET8rbsOz/PJTiVTI0k58s8jfKBdm8
         M5mJs0rCCJ4Q9teUB/hW9LRkRcpd4y0bLWzgzgydvrggUzrZ+3btx9tbYAmpiZLNNdxn
         poKQ==
X-Gm-Message-State: AC+VfDxSheqZr+cXkrtWDojfHvgLzKg/w3JxtkAoxgFt8cWAVt75qdjf
        y1wtRxBOQkvwLh4dteBelLsfesAMnjBuc01NwhGOGA==
X-Google-Smtp-Source: ACHHUZ6bgansim4ozu5bUy2SkFCG4cPQlj+TA60nsFrF7CF14y/MUSUJ3z8OP1rqhakkO9yReUk76ztVjDLIGqhpno4=
X-Received: by 2002:a25:8e92:0:b0:ba7:9c6f:e2de with SMTP id
 q18-20020a258e92000000b00ba79c6fe2demr1352064ybl.27.1686658115562; Tue, 13
 Jun 2023 05:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org> <20230405-pl180-busydetect-fix-v3-1-cd3d5925ae64@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v3-1-cd3d5925ae64@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 14:07:59 +0200
Message-ID: <CAPDyKFoWnt+MO1yoXqxjDGKvUL6Cfu7GkggTPjv+WeKQrts6fA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mmc: mmci: Clear busy_status when starting command
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 11 Jun 2023 at 21:41, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we are starting a command which can generate a busy
> response, then clear the variable host->busy_status
> if the variant is using a ->busy_complete callback.
>
> We are lucky that the member is zero by default and
> hopefully always gets cleared in the ->busy_complete
> callback even on errors, but it's just fragile so
> make sure it is always initialized to zero.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Clear host->busy_status no matter if the MMC_RSP_BUSY flag
>   is set or not.
> - Now we have an if inside an if left, so combine these into
>   one singel conditional.
> - Resulting re-flow the if-clause.
> ChangeLog v1->v2:
> - Unconditionally clear host->busy_status if we get a
>   busy response.
> ---
>  drivers/mmc/host/mmci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f2b2e8b0574e..14d639872952 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1238,7 +1238,8 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>                         c |= host->variant->cmdreg_srsp;
>         }
>
> -       if (host->variant->busy_timeout && cmd->flags & MMC_RSP_BUSY) {
> +       host->busy_status = 0;
> +       if ((cmd->flags & MMC_RSP_BUSY) && (host->variant->busy_timeout)) {

Why are you changing this line? There is no need to add the extra
parentheses, right?

>                 if (!cmd->busy_timeout)
>                         cmd->busy_timeout = 10 * MSEC_PER_SEC;
>
>

Kind regards
Uffe
