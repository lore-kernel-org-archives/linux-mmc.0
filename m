Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3050C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 08:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD586103B
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 08:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhINIPo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Sep 2021 04:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhINIPn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2021 04:15:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F88BC061574
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 01:14:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y28so2768097lfb.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNAG6sGwDoGBymW4v3k2eOOtXFLNm8P1dLCL1GXtjWw=;
        b=dNM9vb+VveLvd2V/oVpPSsK+h62LKqMHmFHU963BBbU4Lb9pm4ysOpfp5YnrysH+MJ
         OUCVwq2PJIun9j6Ic/UtB+2eLZMl2AoehNGV4dSfUWT1LfrIQHNkD0wcBv7c/LXw0heO
         FYNbd4K08VsPgRqWLKtWMmOhLpZOqwCtosnZbU1sRl704aoQiBsWew6hUdOLTY8WSieA
         B6ZWLIFQJkh1iAahWrEBnjAj5mER4S6PBGGDgA+AmB/om+Y/r3t/sblBeUfhE0jD4d1b
         IlilLuFbPSVd4HK0n1btBB5WB6mbnp0Sx/z7uLwZYp85/9QDAe55EavHS0ZEelactzRF
         B8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNAG6sGwDoGBymW4v3k2eOOtXFLNm8P1dLCL1GXtjWw=;
        b=IVjoP7xdjZMYo9wXjpwPN5t+lIXqGh5BzcpGcLarm7Mflib4WSvoypp0SBhvwaMoez
         RNdp3H2hiiHrDfkpeF8fgIRG1jVvo9yo/HfQtAGLGi2vl+fe1t45xjp4Ez8MqWNpPhcG
         F2aiLSYwwG7hEey/ZTFxJRndU81krXwUi0m+lvDqR172Ql6lpCLCbXbtrT+hObglIqfD
         8ofTyeIMv9+cXt6mZY9H8GD6Ba3cuijw7XpWUOEsmW1cr6bFbB+xZLoHh+q1mN/sfmGd
         6FzNH9jvGBwNYXdMnVQKUWpZ53Hsm049W28G8sAQ+OKexhr2dX1VEijn3r0QdujbZY9V
         ZevQ==
X-Gm-Message-State: AOAM530plLlXEHP4iw7pWydGPcTwdCF9gPYRuE8jlkFcIGl5ac/v6VIG
        a/vA4W5WES/M7wY585XwT9I08VDiPzxcbJ6RtVmc084/EeLcWQ==
X-Google-Smtp-Source: ABdhPJz/39ZOyxqmVezb9i3SjizQHorwf0mpUOqdFpYqSbdtNny2LPuz9a6DaVUyBR31t7Q+Hk5gL+fzBvq2PVpCJ0o=
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr8992193lfl.373.1631607264938;
 Tue, 14 Sep 2021 01:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210907151204.118861-1-huobean@gmail.com> <20210907151204.118861-3-huobean@gmail.com>
In-Reply-To: <20210907151204.118861-3-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 10:13:48 +0200
Message-ID: <CAPDyKFpC6iei96n-UcRTNrxTaHeejzfQX+rka7GSwSZjXN7-4g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: No need to calculate the timeout value
 for CQE data transmission
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 7 Sept 2021 at 17:12, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> In case CQE is enabled, the timeout value of data transmission is always
> set to be maximum in sdhci_cqe_enable(), so, calculating its timeout value
> is obviously superfluous. Change to return directly, which can save some CPU
> cycle time.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 240c5af793dc..0b571a3bc988 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -649,6 +649,7 @@ EXPORT_SYMBOL(mmc_wait_for_cmd);
>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  {
>         unsigned int mult;
> +       struct mmc_host *host = card->host;
>
>         /*
>          * SDIO cards only define an upper 1 s limit on access.
> @@ -659,6 +660,13 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>                 return;
>         }
>
> +       /*
> +        * In case CQE is enabled, the timeout will be set a maximum timeout in
> +        * sdhci_cqe_enable(), so, no need to go through the below algorithm.
> +        */
> +       if (host->cqe_enabled)

 I don't think this is a good idea. For example, host->cqe_enabled is
set for the hsq case well.

> +               return;
> +
>         /*
>          * SD cards use a 100 multiplier rather than 10
>          */

Kind regards
Uffe
