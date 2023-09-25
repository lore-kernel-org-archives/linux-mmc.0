Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ECECE7A96
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Sep 2023 14:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjIYOHT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Sep 2023 10:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjIYOHS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Sep 2023 10:07:18 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43421109
        for <linux-mmc@vger.kernel.org>; Mon, 25 Sep 2023 07:07:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d862533ea85so5613272276.0
        for <linux-mmc@vger.kernel.org>; Mon, 25 Sep 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695650830; x=1696255630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pbeInWKlUN3Z2QQBrR4UtpzNoToZLCsYpJRewAj23h8=;
        b=u6KT1EOy4DnS7okQTzXwROIFx2P8jddoRYL+AKF9JeJKCFdlFeZ1mz8ZmqzNoLjtKA
         1ux1WoOTPuvTMB1EZXr982mOOOxj89bC+SNRrFWtB6IMGJwqLENeWovlgeyBmFmLK5Kl
         GzP9/9gPBmw3qe50jgBsnCdJg93PAeo1LkNWWoCoZwsfW/YBQKL6nG8xgTgC9N0Yvgrf
         Mcb/Xn4/3CZlxmfxiFXkTA5rCT4l6YY5lLu92g5buyRh0nSGfFdFdKu7aeR65y04P0YM
         aS7BAVKv+jRpsxdkT9SRanDPGkqXjNIYAVkKMWI72p9C2PCNq1cUtjir5+H0mLLdK53n
         q/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650830; x=1696255630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pbeInWKlUN3Z2QQBrR4UtpzNoToZLCsYpJRewAj23h8=;
        b=QkZdEP0+3fvsBQSIO8X7iRZt1ujAN67oEXaeHMUrz9J+VQYPrRWv8gMbQeE21/+Va3
         p0sRkVs8xCQnrW4kppQyz54gDX3Hc5mh+1eQJT6o9r/CkFKWmDss7g3OzsHiOTiQzyaO
         TcOC3z6JTDq9WCTRtrMuOjCAPhMKUPnNVy9qjV3VwIxllAHL/DcrqAl4PxjvUjIfcaq3
         XBdCsaIKydvpofDfPpMFG6nEepub71Ftc4FKS7AoQ7rsobedY5DgmMnanVYVcrHszwWh
         16oE37bkj45gR2IOJgyHmpxfoLDrzTFvhDS5wqT4mjpmv55an8RuLVWNpIB/+lbEh6z1
         jaDA==
X-Gm-Message-State: AOJu0YxgcwebibC20tztcsbgMNxF+i8i33PzOQYgxJQMryc0ZiQ7ZJJq
        6DRT92xyZsGQTAV5GdEtFsvIOe1YBRVPvxIBcwvY1Q==
X-Google-Smtp-Source: AGHT+IGybh6b+QMCWVSNtS3PoG9odUy0INJ8lN7t0nCkj2GqRCzX4hr4FBHQ6scP86ZT8zt2NFX8jVlVz6abd2tcvGs=
X-Received: by 2002:a25:ce4c:0:b0:d80:9ef:928e with SMTP id
 x73-20020a25ce4c000000b00d8009ef928emr5922448ybe.33.1695650830416; Mon, 25
 Sep 2023 07:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230921203426.638262-1-beanhuo@iokpp.de>
In-Reply-To: <20230921203426.638262-1-beanhuo@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 Sep 2023 16:06:34 +0200
Message-ID: <CAPDyKFqN9xASjqJWmjtkTGdYEG0AauMzCVkR7VJ10Va0oF-B4w@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 21 Sept 2023 at 22:35, Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Micron MTFC4GACAJCN eMMC supports cache but requires that flush cache
> operation be allowed only after a write has occurred. Otherwise, the
> cache flush command or subsequent commands will time out.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Co-developed-by: Rafael Beims <rafael.beims@toradex.com>
> Cc: stable@vger.kernel.org
> ---
> Changelog:
>
> v2--v3:
>     1. Set card->written_flag in mmc_blk_mq_issue_rq().
> v1--v2:
>     1. Add Rafael's test-tag, and Co-developed-by.
>     2. Check host->card whether NULL or not in __mmc_start_request() before asserting host->card->->quirks
> ---
>  drivers/mmc/core/block.c  | 4 ++++
>  drivers/mmc/core/mmc.c    | 5 +++++
>  drivers/mmc/core/quirks.h | 7 ++++---
>  include/linux/mmc/card.h  | 2 ++
>  4 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 3a8f27c3e310..14d0dc7942de 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2387,6 +2387,10 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>                                 ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>                         else
>                                 ret = mmc_blk_mq_issue_rw_rq(mq, req);
> +
> +                       if (host->card->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH &&

Please add an inline helper function for this in
drivers/mmc/core/card.h, along with the others.

[...]

Kind regards
Uffe
