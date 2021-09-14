Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE17C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 09:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF4961155
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Sep 2021 09:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhINJGL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhINJGL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Sep 2021 05:06:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F4BC061766
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 02:04:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id k4so27278061lfj.7
        for <linux-mmc@vger.kernel.org>; Tue, 14 Sep 2021 02:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TxkMbPDfFbLZj7gS8lbkBILCw0qzdwhInbM9Rl7jN2Y=;
        b=Reh4KSfhO4uWMDSUTeWXW3VcT5h3uBKRpQjg39H5GecQ5wxeW84U8vrpTqv+0SzJOP
         rYR4PiJlpe36Aw8Onae3lV1jz9Ajq9FO5Ym1FsY3kPIH7N37aLQgkzqtkoBEl1i+pFoD
         A43CJBDWEziyptxLKRpLl4HBhXj4VLn+9NiHO/lZlf/gFEm2iugTaDrhocDCvIeXbvr6
         ftJS5MnNsLuOuEX4rG23UStaF85BlqADOEnDgwESly0liQVNGebWl9eHQnU9aytoXRmv
         sDjktJt8SWlhr/FsBtujNrthw4UtCozMk35BL5Q4246goHs+quUMXXm8E4nHFZOWYY3u
         KjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TxkMbPDfFbLZj7gS8lbkBILCw0qzdwhInbM9Rl7jN2Y=;
        b=vXTRf9w9Uyih6YFWY9X00dw/a+wPvYIKgy/W/Gtee0nNkFMb2GPahznDEy6r1p/Ud6
         ccU7sqSwkHqR10gLWKQ5zsTxIl0t1ZX+19FHkyAB/ca5EY1MWtHn9x2yU1kRGvRt/9A9
         QKV43pik0rpbBavFA3etZLm/gsbkI2XoRLtLNcw5bLn/nzRbxF5l0UrHm/L1ywTQS7TQ
         YuBrh8QJIgQsWpF25x49O0UQk4dRsLx0cHoPQJZIEh3hXsWFzoTIdsUjD/fOZEYSkz67
         4cynL+bfMtzXy0Q3TSLQqkf/O4LHvKWXr2zZIzacyF6YBSCWoQ2cXrLTUe1l68XqjZ5m
         euEw==
X-Gm-Message-State: AOAM531LZNEpjpz+UBMSzfBSEVp2scOp8XMekk5T+uCvn/vJILZC33YD
        JDH+ORVowmG/Wlpi0e57GqbPR8weUSoIUcvXFck66g==
X-Google-Smtp-Source: ABdhPJxmtEn3tJSHkFDVGWx0SpxzVkHAAASInKwE013atEj5O0Z9owxq78OkTQeJkvm7QK88xVAWDaZ3LFcJNo3racU=
X-Received: by 2002:a05:6512:3ca5:: with SMTP id h37mr12218278lfv.254.1631610292303;
 Tue, 14 Sep 2021 02:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210913013135.102404-1-ebiggers@kernel.org> <20210913013135.102404-4-ebiggers@kernel.org>
In-Reply-To: <20210913013135.102404-4-ebiggers@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 11:04:16 +0200
Message-ID: <CAPDyKFqEmhwT0v8ZWM9ByOSoVPYM62mi4zjDTG9J1bD40_Zfyg@mail.gmail.com>
Subject: Re: [PATCH 3/5] blk-crypto: rename keyslot-manager files to blk-crypto-profile
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>, dm-devel@redhat.com,
        Satya Tangirala <satyaprateek2357@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Sept 2021 at 03:35, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> In preparation for renaming struct blk_keyslot_manager to struct
> blk_crypto_profile, rename the keyslot-manager.h and keyslot-manager.c
> source files.  Renaming these files separately before making a lot of
> changes to their contents makes it easier for git to understand that
> they were renamed.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/Makefile                                            | 2 +-
>  block/blk-crypto-fallback.c                               | 2 +-
>  block/{keyslot-manager.c => blk-crypto-profile.c}         | 2 +-
>  block/blk-crypto.c                                        | 2 +-
>  drivers/md/dm-core.h                                      | 2 +-
>  drivers/md/dm.c                                           | 2 +-
>  drivers/mmc/host/cqhci-crypto.c                           | 2 +-
>  drivers/scsi/ufs/ufshcd.h                                 | 2 +-
>  include/linux/{keyslot-manager.h => blk-crypto-profile.h} | 0
>  include/linux/mmc/host.h                                  | 2 +-
>  10 files changed, 9 insertions(+), 9 deletions(-)
>  rename block/{keyslot-manager.c => blk-crypto-profile.c} (99%)
>  rename include/linux/{keyslot-manager.h => blk-crypto-profile.h} (100%)

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

[...]

Kind regards
Uffe
