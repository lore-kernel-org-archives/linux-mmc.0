Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC87C04A94
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjHGLRC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjHGLQt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 07:16:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B85E1BFF
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 04:15:24 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d5869d9651aso66891276.2
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2023 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691406867; x=1692011667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UAMG1nFrln+Q4yiSeff4brKLH/zSnPhRgbRTD/BX+Xg=;
        b=yJ+JD/Z1soOuWw7eN0P75jMn00Wb2SUjX2O263hGhsDM5gpQqdjdC2tlCDZBdZQS2d
         Fd/Jj5zCjAVLteeCCgmqJHGcJOxx/hW3s+U5krCx9CtRcdBA/xZ5XbGeTNVH9oVzHZVc
         VlFVQWXPZQzuJTp8cty/WGlAks4fkB/QQpi0iiwpi8aPhWIekKVNFdmRPq+G4UQpqUMk
         RoKHkJ2MHq3Dav5+cl+f3FWhNBpSb6umM6d50kgxth01nECRm1tVQPLUDZ5G/AlJ6LgP
         iJtk4B8Opi3brRPYlp7gVcVCB9LZ3hiNLqHV8jEPyVGNfVf9EszXC8w5d56hnJSU1UG8
         EyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406867; x=1692011667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAMG1nFrln+Q4yiSeff4brKLH/zSnPhRgbRTD/BX+Xg=;
        b=AMTILBA6vxSj4WepenY6dz0DiyWP29JqMvyW2LI6ktZeytJxz3qbz4OnE8dzZ0r6K6
         3aXZQDdvX3vNVn1F14P44xOl1SKrSTe4FcnkirUM/KrcrrBNlkxj+oizVOF5nUQ+olXL
         pK5gpLHo9GhfZKxaG93Z2bShNB8YrHP8fmfwQAJxjXfQsLfuCI2fMlG9n3pvGye0r1tI
         OV452XNYXpWqfjVBu3Fpa1BkzgNclCdDIBtOqohfB7Iy/nGo5u7hXG6fv+tIY13/63r8
         yvXe7kBJCyWhb0FIREkjxLttia5kLAoiUDPoLwVL5twXMv3CU4XPioBr18CYCiNhn8dG
         wG5g==
X-Gm-Message-State: AOJu0YxnjlTs8moLEuufJ3khc/KOzeVhK3qvkWPXInzk8TzlmLLjURW1
        5WRGs0PUK5CMnTpLu1wxNvs3ifNWpzTAp4/J9ozMpblQxstJEW7gPks=
X-Google-Smtp-Source: AGHT+IHv/3ULTFrRJ9pL2wJrWrF27FwC9KJrqiZuTtw5Jd0zaZkHxg82qI9JUMKlfuivimgO2cEwUFZZRdlMlgT8jow=
X-Received: by 2002:a5b:189:0:b0:d0b:ca14:5076 with SMTP id
 r9-20020a5b0189000000b00d0bca145076mr10119911ybl.14.1691406867009; Mon, 07
 Aug 2023 04:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230625103814.105-1-avri.altman@wdc.com>
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Aug 2023 13:13:50 +0200
Message-ID: <CAPDyKFqLkbhZAQycrtyidEOtebs7y93pPOvdYR9=J+VWjt-jbA@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc-utils: ffu: ffu of large images
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 25 Jun 2023 at 12:38, Avri Altman <avri.altman@wdc.com> wrote:
>
> ffu is done using a single multi-ioctl to carry the entire firmware
> image. This is limiting the fw image size to be at most 512KB, as the
> mmc driver restricts each single ioc data to be at most
> MMC_IOC_MAX_BYTES.
>
> The spec however, allows the fw image to be written using multiple write
> commands. So if the fw image is larger than 512KB, split it into a
> series of smaller chunks.
>
> Avri Altman (6):
>   mmc-utils: Add fill_switch_cmd handler
>   mmc-utils: Add arg argument to set_single_cmd
>   mmc-utils: ffu: Simplify ext_csd bytes parsing
>   mmc-utils: ffu: Add ffu multi-command set handler
>   mmc-utils: ffu: Allow ffu of large images
>   mmc-utils: ffu: Add optional chunk-size argument
>
>  mmc.c      |   6 +-
>  mmc_cmds.c | 161 +++++++++++++++++++++++++++--------------------------
>  2 files changed, 86 insertions(+), 81 deletions(-)
>

Apologies for the delay! Applied to
git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe
