Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318D9C433B4
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 17:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086E861357
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 17:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbhDLRrS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbhDLRrR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 13:47:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C30AC061574;
        Mon, 12 Apr 2021 10:46:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r9so21679471ejj.3;
        Mon, 12 Apr 2021 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kcD1QZqIuNz4WcBW32lQIKsKLiIqCZYBdkHqfOIUFEI=;
        b=mRUWSOq7blVHzvZOrWQQkCCxuMIcervNYvtLYmwJNxD9rVCaKIF/tkMAJyYhq+q/bD
         ESKaKgTS9+zv0fGFTqw2Zg3/cJere9z3Zq4lvCeArOZzltV66Zg6pppMq2dLjo0QLcTR
         1Jw8gIigW3nrx6oCxFTIe+FjJBJIO9/qvS+8/hstrv3rw1m2+Uu5SpWTV/Plm2FPmjYn
         AxpaGupni1BHY6hDX7bBd9b0pUJZ3S5oZmsvFxqsAYVOHs99s0gzQJzBR6EVuDbn/wpS
         I6CifUateCQPDjfOr+zCfgAFCOH11yBgK5fKTret/DUeiLqAu1jBSTnzbGxZr6IXX2ol
         K5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kcD1QZqIuNz4WcBW32lQIKsKLiIqCZYBdkHqfOIUFEI=;
        b=I8c0XE4mAODd923U9VCm5lfmdBdRqe0Lyr4c9Dzy5wP2lB6+4vUdQ5a/MzC+0JniD+
         Lp8x8a0Vwx18YBQV3h6PW34iIW/A1UkXRpuMzg70CGSs/dLbed1RjLOLlXPjEP24E6VD
         NXfsiDyR82WNFeM3gBOGw/uBXFospTVfgNgkqNpjgXp8ZAf2NrwKSLoT0Jg0Zxl1gxSE
         8CbrqdbfN3tu149gec4e3LNMBUhKIDGPmEkPnghbVt8Arg5JYZcLvUoHy9k2kYilRC2x
         n1adzot0edrZu2/P3qJeFNtIVSZeS87AGlcP5qVcVR7RG5KMNBFhVBE+9dKtznkdUb8X
         5ZcQ==
X-Gm-Message-State: AOAM533iMA70BtOrVrsEi+u8Ijqu7OjK1x4yeoFxEFShKwmNlwF1VBDQ
        0yKm6S2faWkhEOv1Xq7CB7o=
X-Google-Smtp-Source: ABdhPJzYDlf+JATE3dqIq7o4nGa320QTdQUSu2KGIN4+fYrjh49df2KFnqEwNvrhUSQQrltDnOH/qQ==
X-Received: by 2002:a17:906:3915:: with SMTP id f21mr7027865eje.256.1618249618090;
        Mon, 12 Apr 2021 10:46:58 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.googlemail.com with ESMTPSA id w25sm7308133edq.66.2021.04.12.10.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:46:57 -0700 (PDT)
Message-ID: <a70a17e3873f84681de379bde82d49ab96e70d21.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: core: Let sanitize not retry in case of
 timeout/failure
From:   Bean Huo <huobean@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Date:   Mon, 12 Apr 2021 19:46:56 +0200
In-Reply-To: <CAPDyKFoT4YoG1wwHYXMMpXmq-ybLMh_qipzr5yKkWUY8Yt5q0A@mail.gmail.com>
References: <20210402092432.25069-1-huobean@gmail.com>
         <20210402092432.25069-3-huobean@gmail.com>
         <CAPDyKFoT4YoG1wwHYXMMpXmq-ybLMh_qipzr5yKkWUY8Yt5q0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 2021-04-12 at 09:50 +0200, Ulf Hansson wrote:
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 8bfd4d95b386..9778093d7006 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -836,7 +836,7 @@ static inline int mmc_blk_part_switch(struct
> > mmc_card *card,
> >                  ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >                                   EXT_CSD_PART_CONFIG, part_config,
> > -                                card->ext_csd.part_time);
> > +                                card->ext_csd.part_time,
> > MMC_CMD_RETRIES);
> 
> 
> I would rather not change the mmc_switch() function definition, but
> 
> only __mmc_switch(). Just let mmc_switch() pass another in-parameter
> 
> (MMC_CMD_RETRIES) to __mmc_switch(), which means all callers of
> 
> mmc_switch() doesn't need to get changed, but only callers of
> 
> __mmc_switch().
> 
> 
> 
> [...]
> 
> 
> 
Hi Uffe,
Good point, I will change it in the next version of this patch.

thanks,
Bean

> Kind regards
> 
> Uffe

