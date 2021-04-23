Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB3C433ED
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 08:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161EA6128A
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 08:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhDWIPn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 04:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbhDWIPn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 04:15:43 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D58C06174A
        for <linux-mmc@vger.kernel.org>; Fri, 23 Apr 2021 01:15:05 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id j8so12539208uak.2
        for <linux-mmc@vger.kernel.org>; Fri, 23 Apr 2021 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/1p4bVB/IMzYSh3lEXsuQcO/JfPdUjhh9i2ce6TwNU=;
        b=pEkwBSLRqGzDhcLG5eFakZTdU2Qg37RO9RtA1nyKpKLxUtzL6N3lKsjIle8kMyNult
         MnwHkVfFBhZe3+KFRCwWOT+K5F8OrL14o3z35nnJxtbUOe3X3E4SRYBEFQY0QOjXq8Pz
         MsPc1OwJzrAGeOHTyci8Ww913e8iA24UKi87IxbxyglVm3DKQE1tfoxe7ugjhHetfuWp
         buaM/oerD0Q3pdOjZ0+PbbKjMSORq0V3e0VqY1l9adMHXIyQjLpZ32giAoXLHKpuQPf/
         Xk6+sYBIljN3SNElCjxSWkYZmuJYhfWmWl+TPBnUeaU0mLHwnGWVKnNJQVaCOFui2Nwm
         0w6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/1p4bVB/IMzYSh3lEXsuQcO/JfPdUjhh9i2ce6TwNU=;
        b=fEK8yJhDSmr5D/npAPg3clFJlO1rgLiJwZiYqHALw1cCpJFHLWbuzSOoUbuI7X5XzL
         RWm1ckbne6KNEmMlGicMY8xDUhfhAz9f09qsuj1/FqHFjsRNJywwXWTzqLyb8Hw3oI3n
         67i6H3aTueNquWLcK/2o+Ji5T+1xngF1XP2oSf9rQPwrMDMObCBHpkaP3Ce9CVXKEdIh
         S6pOMyKhs5lR5Rnc5dXLdJypQ2MOb/8POOtqPzG66FiCquW/orYcRU0KtpKciPN24ncX
         BUNGH4ggXaObuN4D5I61SNlK98kaEhbxZJcJAYbRCoyZRqQMnkE6WIAeb7Bb9v8CDJUf
         v6oQ==
X-Gm-Message-State: AOAM5339Yh23RelnhUN4N1Xo74emQgDpE1lnbvFzgWbslC7/MLUCQZjV
        ILZVcnvMGvMFzWAtpwSTZwLsfSIOPwokEreZeKy2Ag==
X-Google-Smtp-Source: ABdhPJwZMkVNq7pr6fRHMhYlBhNxD2i5z/5FXnT8VelaqnN/k0lCcJoLeWzWnzh7gBGPY0mYiHl7F8Ep5vzhDz2U27E=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr1906916uak.19.1619165705016;
 Fri, 23 Apr 2021 01:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210420134641.57343-1-avri.altman@wdc.com> <20210420134641.57343-3-avri.altman@wdc.com>
In-Reply-To: <20210420134641.57343-3-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 23 Apr 2021 10:14:28 +0200
Message-ID: <CAPDyKFr95yFAbYyRGZMg6UpsUXYxm4c8J0ZRqw2ASdf+bF1edg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: block: Update ext_csd.cache_ctrl if it was written
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 20 Apr 2021 at 15:46, Avri Altman <avri.altman@wdc.com> wrote:
>
> The cache function can be turned ON and OFF by writing to the CACHE_CTRL
> byte (EXT_CSD byte [33]).  However,  card->ext_csd.cache_ctrl is only
> set on init if cache size > 0.
>
> Fix that by explicitly setting ext_csd.cache_ctrl on ext-csd write.
>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

This can go separate from patch 1, so I have applied this for next and
by adding a stable tag to it.

Thanks and kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 24e1ecbdd510..7e70f11e85e2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -572,6 +572,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                 main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
>         }
>
> +       /*
> +        * Make sure to update CACHE_CTRL in case it was changed. The cache
> +        * will get turned back on if the card is re-initialized, e.g.
> +        * suspend/resume or hw reset in recovery.
> +        */
> +       if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
> +           (cmd.opcode == MMC_SWITCH)) {
> +               u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1;
> +
> +               card->ext_csd.cache_ctrl = value;
> +       }
> +
>         /*
>          * According to the SD specs, some commands require a delay after
>          * issuing the command.
> --
> 2.25.1
>
