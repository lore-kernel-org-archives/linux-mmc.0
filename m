Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF42CFA373F
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiJXSgi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 14:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiJXSgQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 14:36:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68908564F6
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:18:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so9012176pls.4
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2022 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wQlo3EGPItBuzHrQYdhs7siuCNxgTb6N4tdeGMEYPmg=;
        b=r6BcM5bPHTx+CZ/xITZDNypxRIKxZAhLLtBF9eGUnGF1EEXcMJBiAEppYxIg5nU974
         ufMdIzQaInTisbMym8yR1/G79VLjdpTZXN3uqdinOCCypznM3Z3dQz4u9AN2Ckm8o4tS
         Zb6aXTkzjHnydvU7PL8D6+mUAHNTzOSClsD/kNwrLV6XSFXct/rStsHywYRK0xFhLVPI
         ACj6e7nZS3MpTO2liPnN7jGztHYLJoY6XmlD3XCwVCDwptwxa0ulyTP6b8PbOPVhzaLv
         FuPhNbLwOf5alEo2FJ4n2LvpduSHZpqLJeGWohSjzV0KQu+cQg4UP2FZPa7EN55D1k75
         Xyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQlo3EGPItBuzHrQYdhs7siuCNxgTb6N4tdeGMEYPmg=;
        b=3hA3zCRsc8o3QmbDBoGHDIH3F/vkBMeQac0ipP1olfjoGAVUpmeebn1HcuUZ205HTG
         c4SNFV9JkKwAJ7xvqxo3Il8ogOnE2QgFt65+TWwU4TEmM5PmWkjOapYGq1b+PgS5Sg+7
         Ll6NKxurDdpBO/cDgKpFnrmOeuaCUVwil9JsbsH60IUZbRfKOGEKBlRrzJnaO5+sU6DR
         g75/u88gOpq25jy2XkQBNXIRzMTlOkkASUPuM7lLrMgJvQnVUPkqtd1PzeIMzYb+Plrs
         unvKy8qUXjd6fJxbs8hPd5hZJAEfPYPgST0BxGr9WhCOO/NPgs5+4XAZWpzJrf/zYZJU
         CGww==
X-Gm-Message-State: ACrzQf1j0QDGgoA+IGktqqOr1saNkS64nM9zCnv9feRqixsNM4FNrRzN
        ojhsgUw/EIY7WF2n6yfwcZZgm8XRj6jU6TEluIH+1w==
X-Google-Smtp-Source: AMsMyM5WBBFAAfIn9WtDfPDuABCV54WS+zJkcHcW88tzTpF+YchV1WG7oz2KmjlVBqKiRg5LDZYniE/BxUHJidZRrJc=
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id
 mw7-20020a17090b4d0700b001ef521cf051mr77094132pjb.164.1666631783789; Mon, 24
 Oct 2022 10:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130123.4033218-1-vincent.whitchurch@axis.com>
In-Reply-To: <20221020130123.4033218-1-vincent.whitchurch@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Oct 2022 19:15:46 +0200
Message-ID: <CAPDyKFrMHA-AgHbAoFTiGru=JPbWYeggCJFnOCyzRLLg-19Fng@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix WRITE_ZEROES CQE handling
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, Jon Hunter <jonathanh@nvidia.com>,
        Avri Altman <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 20 Oct 2022 at 15:01, Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> WRITE_ZEROES requests use TRIM, so mark them as needing to be issued
> synchronously even when a CQE is being used.  Without this,
> mmc_blk_mq_issue_rq() triggers a WARN_ON_ONCE() and fails the request
> since we don't have any handling for issuing this asynchronously.
>
> Fixes: f7b6fc327327 ("mmc: core: Support zeroout using TRIM for eMMC")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/queue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index fefaa901b50f..3661ba0bbc87 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -48,6 +48,7 @@ static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
>         case REQ_OP_DRV_OUT:
>         case REQ_OP_DISCARD:
>         case REQ_OP_SECURE_ERASE:
> +       case REQ_OP_WRITE_ZEROES:
>                 return MMC_ISSUE_SYNC;
>         case REQ_OP_FLUSH:
>                 return mmc_cqe_can_dcmd(host) ? MMC_ISSUE_DCMD : MMC_ISSUE_SYNC;
> --
> 2.28.0
>
