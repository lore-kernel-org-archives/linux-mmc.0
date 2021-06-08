Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EF8C4743E
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805C161249
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhFHNTv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:19:51 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:34639 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhFHNTu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:19:50 -0400
Received: by mail-ua1-f44.google.com with SMTP id c17so11576488uao.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O/G9l7SZvoUdCJxEXjuBblAs730rAEGTbJM8qPA6QnU=;
        b=VgUbGyWA5w4WVmAe9n8s36mYEbTWqRLHWDBYfnzcrwv7u8Q13KXHzmh8sVX93mWvIB
         pDw3LNkobVwjNadgKKbR9ciXt9GJdirirQT3tKqeg3SGMlx74RbbrKY8/gvILsY83QoF
         WIsfKE8y2EWlPIYIYolXxZE4LapDijyU3xDhsE0WwDYN0M8H1W1DeRF3GDgANY6jO1eJ
         emwiO0I8sSUoqmLQdL1sd8aXa1Xw0XxpARyWm1EdzGk+XsIspjT1QnYdE+ob2ulc+tRn
         McoKCBRtA7C2v4JRCnYjPZtOpOhKe/KUm1Zf8k4pL71gd2zYxqYue5fs+LYVSqc2h7Hl
         uXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O/G9l7SZvoUdCJxEXjuBblAs730rAEGTbJM8qPA6QnU=;
        b=Me9399qpmsbC1sFQ0VfqipZM4BGwFDmwlqjlBe3X/LPdLE0Tkk4B8CDUM4mHNVg29Q
         yNDmEWYxgyShV6BI3r59cBUdPyHJs68HMN6Gld3wTZW2SBvMT+82uIVR3mSXjGoY4xim
         Q3fxNRGsX6F1nDbg6KNZ6FgsJTzALO0BKFjmS9z5niyC3HRCgEKTTicIwWMU0TDlCdta
         1wIFg4pUDGXF+FI8oRFXO4Y8In+FPOSkidejZ71im8bptZSujatyNTrUG6/QVOTmCC+1
         fz129ApY32HdpOPIqnXYLzoQNOBiG6PWUSUy656Hrd1LwjWyLiz6nPJ2uxEMNh5FMaUr
         PDPQ==
X-Gm-Message-State: AOAM531wQ2p5fSvSqS/Wa4W+YQHTBy2qo7lJeASpAEi9fEgtn0+Ps2PM
        b0nkFbv2/W69NoVh7KIkKGCQDoyfhgQ86/6I3hd2vw==
X-Google-Smtp-Source: ABdhPJw6Z7tEwu1v/VB/4p+MORZ0ZMJRvQwsN15C2gwVElhiBFHlbN9EVF81SFiKHxUf9+L9SMq/DikLEI/mGwTxoBc=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr3218881uad.100.1623158216958;
 Tue, 08 Jun 2021 06:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210604104459.7574-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210604104459.7574-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:20 +0200
Message-ID: <CAPDyKFpX+n1R4fuiS-sVjXyiA392roRjL0th_fpvv3sGGF7h9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: debugfs: add description for module parameter
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 4 Jun 2021 at 12:45, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Make it obvious what this is for.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 9ec84c86c46a..3fdbc801e64a 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -26,6 +26,7 @@
>  static DECLARE_FAULT_ATTR(fail_default_attr);
>  static char *fail_request;
>  module_param(fail_request, charp, 0);
> +MODULE_PARM_DESC(fail_request, "default fault injection attributes");
>
>  #endif /* CONFIG_FAIL_MMC_REQUEST */
>
> --
> 2.30.2
>
