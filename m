Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB9EC433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4120061356
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhDLHvS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbhDLHvS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:51:18 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855DC06138C
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:51:00 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id o17so2665682vko.8
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bwXeF6DPNCUNrDpkgt9DFKvZdBX7LfKFuuDUCZIcIw=;
        b=NWjaNJ4sKzmsXTFfXMIoboYg4yCXg346ZnHIuFbXlJB5dHFk3M1Ww97JRXLhu888T4
         R8+zjK7tTykf3LcP4oRMa8MN18/sNPWJIdBRJdCQtE4U+WYolAW2/918YHpZO1m2TiYq
         xB74kHPGjDnTw3ctivsAjVMIAGos7rgTvQ78l+akCS5Ua2NcxG4mZnJkgXnuzToAlwzp
         /kIUCUxfIVQzZiBklUqcaNZ8wsmU1QPVUpUsyyJYzNeMuHohpPh7MH5q6uGcq2Rrvr7s
         TIlJdYwHZOAwhzZL+zey/cs8e82dwvK4hUiJSiQ6Tw/5r8mIoqfU6UfmIehHlZ8wJnjr
         KpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bwXeF6DPNCUNrDpkgt9DFKvZdBX7LfKFuuDUCZIcIw=;
        b=rwOdIFCJCS2oB5C5sB6R2i0wIhzeBGAtnBjS5Frh6m2XCNRruxpnGa6VIrk1nvYhNW
         HLMXmjfj6zMM+j9Hbo5PlM0RjWZY8dmQHWtb2RfymMa/+JvauoY1PMM0s1FC5oLEH/4g
         lmcbK69HuTYAfhARJeehuTmdXRBLCSvrtvvRM2BZt3XEd9puoGT3+7wQ9Tm5Wm839SvR
         bXWqMfElatUiHbK/wzg860O6+aUFlhjYcBRqjtgJeos/WNgZcTpJoeC/gg0R5uYFBwcD
         xeR/JUTvdRbv9uVoUM/5i9v+wacTtWk8molKGbHr5sEXouSoM3xl2iC8SgzpBi74r2Be
         l2Xg==
X-Gm-Message-State: AOAM531E1DKVg9SjSYwMN71iHFmvmYaVFI15xkKDsP+dRJOlH6l47MVi
        2nRZcWyJyJSlUxpDa/yrDH6OWSlWQgA5B0+U59lx9A==
X-Google-Smtp-Source: ABdhPJy3gSf1u5aHEM+c4Vjkj50BZURW2s9YkL8uFokqZdDKN51Q0Ihpy2lsV68v6DqmIdcb/6ZsOfvK3AfsQiSrkmk=
X-Received: by 2002:a1f:2a95:: with SMTP id q143mr18758937vkq.8.1618213859970;
 Mon, 12 Apr 2021 00:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210402092432.25069-1-huobean@gmail.com> <20210402092432.25069-3-huobean@gmail.com>
In-Reply-To: <20210402092432.25069-3-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:50:23 +0200
Message-ID: <CAPDyKFoT4YoG1wwHYXMMpXmq-ybLMh_qipzr5yKkWUY8Yt5q0A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: core: Let sanitize not retry in case of timeout/failure
To:     Bean Huo <huobean@gmail.com>
Cc:     "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Apr 2021 at 11:24, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Not any commands need to retry in case of timeout/failure.
> Currently, the sanitize command is issued by the IOCTL interface,
> and once its timeouts, the user normally decides to retry or not .
> Just blindly retry three times sanitize in the driver, it doesn't
> help sanitize retry succeed in the end, on the contrary, it only
> makes the user feel sanitize timeouts after 12 minutes.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/block.c   | 13 +++++++----
>  drivers/mmc/core/mmc.c     | 47 ++++++++++++++++++++++----------------
>  drivers/mmc/core/mmc_ops.c | 19 +++++++--------
>  drivers/mmc/core/mmc_ops.h |  4 ++--
>  4 files changed, 47 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8bfd4d95b386..9778093d7006 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -836,7 +836,7 @@ static inline int mmc_blk_part_switch(struct mmc_card *card,
>
>                 ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                  EXT_CSD_PART_CONFIG, part_config,
> -                                card->ext_csd.part_time);
> +                                card->ext_csd.part_time, MMC_CMD_RETRIES);

I would rather not change the mmc_switch() function definition, but
only __mmc_switch(). Just let mmc_switch() pass another in-parameter
(MMC_CMD_RETRIES) to __mmc_switch(), which means all callers of
mmc_switch() doesn't need to get changed, but only callers of
__mmc_switch().

[...]

Kind regards
Uffe
