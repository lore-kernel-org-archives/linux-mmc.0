Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D0CC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 12:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351812AbiFAMrX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353041AbiFAMrX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 08:47:23 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC1DEC0
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 05:47:21 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id be31so2536584lfb.10
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8u9RNTYeHxY9YWObp6yzipkkBA/vWj6mJ4FlGRiqkoo=;
        b=LSFLfGwhPD/CksaBMNE5p6uAZAjr81Pcy6QlBdg4n9aaxH6qFvzkLnf3cry1y+PPng
         qwiBGBYDww9j2fUKH94eQ31VGab56HaeLSLB4c+f8Fud9gFCf/n8Uwa1oQD3L8ccEhCI
         A4GZ6aDe+kirtSQ7ACTbkAuBDUTooSOAAiwB/qx8hq6BB1h4wlCw9QQYxHW5Stp2u+ev
         wVMuEWgFxwPsFWIbJbtWdrfTfR23467UmyKtLz5GE3/lEMgoxqtjMhSr6GE3mxVPzNn+
         50eKsqD5J9gHvXUokp60cHt5R6XaNJ9GyxiMua3HuT7tV0m5PTwW3B9GTj8wMCk15z61
         YhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8u9RNTYeHxY9YWObp6yzipkkBA/vWj6mJ4FlGRiqkoo=;
        b=0III0PlSpQ0dGuXb5HMMA2C6ha3brA8BOy+5pQtsT23lFVyTjz9k3fSymnHYz0ttu1
         ETjU5li5O20xtm98JhcnEkttMYLsg0N672xrHWiUKyfYgaZYCiCiSiWp3GjqaTNDJRtS
         UfFj/kenqI94QV2Q9QGACGQjss6dVBrJT2hpFxdKCrymUh20p0RlRGPo7CSunfCJ+P0S
         HQ9+sgkvkkBdOT1NTo2S6f4QOhALNkAwwrvTpRA+2G+/gZCIKWoPc1xLYXKAGuKX0ld3
         OOAOJ2gsCDAiwtaqE9sjJjl+hI4VzlBUq3o/ZqfT9vSZle/4iVEQm+fC62DRGXw16og2
         5MJA==
X-Gm-Message-State: AOAM532xs/OemxDJ/N/bWHWKyVCI2NsPXAdiI/qvMH3v00VhRtmC+Y1P
        KL66I2Yv9J28TXuuLYiATLJuBgOlRSIAQJu0mGFboNi6C2k=
X-Google-Smtp-Source: ABdhPJxDCyWdqBE+ghyIruLdQyvQRKTjhJZ078rEdkP6A6ndEjTtRRBlbO53WBZNtfW9TLaKeVcGSWKH51sPIW5nJIU=
X-Received: by 2002:a19:ac42:0:b0:478:593c:e6fe with SMTP id
 r2-20020a19ac42000000b00478593ce6femr40749300lfc.254.1654087640129; Wed, 01
 Jun 2022 05:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220531171922.76080-1-adrian.hunter@intel.com>
In-Reply-To: <20220531171922.76080-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:42 +0200
Message-ID: <CAPDyKFpjNj4QP5UvYL6z2ApGz9Cg=_8c9m8QaY_BtUdh6n3_zA@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: Fix CQE recovery reset success
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 May 2022 at 19:19, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> The intention of the use of mmc_blk_reset_success() in
> mmc_blk_cqe_recovery() was to prevent repeated resets when retrying and
> getting the same error. However, that may not be the case - any amount
> of time and I/O may pass before another recovery is needed, in which
> case there would be no reason to deny it the opportunity to recover via
> a reset if necessary. CQE recovery is expected seldom and failure to
> recover (if the clear tasks command fails), even more seldom, so it is
> better to allow the reset always, which can be done by calling
> mmc_blk_reset_success() always.

Thanks for the explanation, this certainly makes sense to me too!

>
> Fixes: 1e8e55b67030c6 ("mmc: block: Add CQE support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1259ca22d625..f4a1281658db 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1499,8 +1499,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
>         err = mmc_cqe_recovery(host);
>         if (err)
>                 mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
> -       else
> -               mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
> +       mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
>
>         pr_debug("%s: CQE recovery done\n", mmc_hostname(host));
>  }
> --
> 2.25.1
>
