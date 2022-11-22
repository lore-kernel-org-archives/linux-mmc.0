Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D25DC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Nov 2022 15:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiKVPpP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Nov 2022 10:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbiKVPpJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2022 10:45:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B108871F2F
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 07:45:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so6257038pjo.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Nov 2022 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2iiSRNNiKtY+MeAoNJIbN/6h4BHQ29xnmUotWKbD50o=;
        b=f+iXcz9V0X4xeTaaoduLXQv78WX/hrcuhiaC+tIdpRAoJBpaqp5gOYB02mIvNnC2lC
         Llh5eChyJy97HVPFDN+x0Orx/9qXTyxiHFuTm6JQ4jpdvgWTw+ii3leZgXyA14YRd44j
         8KCd+ivwUgszjcnNkyRRwjZ3F0+WSu2BZM6sVZzkRLxSKrH1gKP/0MrvPTXpGN528wg6
         XpGVg9sQN1mk4Lt6uxORJwA0GHpGOcklSE4gpB1xyhLMCjtgnVswlpL/bnoADs/nsMH1
         q84Z+nZeBM7DT0jkQrL4UrjxuU7HsbNgI54ZlLCG2y6grR0HhX+0bVrFfv89Pkf4DHoA
         hUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iiSRNNiKtY+MeAoNJIbN/6h4BHQ29xnmUotWKbD50o=;
        b=hSxr8VvF9clvpHeZ3dXQl8i3h6GoQy2oMq0w/TEDOP7RwWBPy+c+Dcd8NUHjgCw2E0
         S7R1JPXSw+UKIg0OiiSrB5MovBvQy+iOvYmcwXKTwt0/I2UT5Z2XVpruyZPiBm+RW/3O
         HknNPylA3phCLF05lLLpgHotvwF5VqKjCZNnGlMSMMhrb0kwzAAs8PKlnffhyXER/hNT
         VxbWq6KAy80YG43b28LXFRcBfg1bnutddE6dJVXTiobHClLsOirgqitAPmvbvdkZE5E4
         sQIU5NI30ThfrlCuDJhtkjsWRoNy4lFCUBwxt93o6XpetuLs6wIgbUs1TjbQiER+Wknd
         dv5w==
X-Gm-Message-State: ANoB5pnSgubWR1UjsGfgH+q7ep7TobGISoATTWqTyfAtj9FSRR5mrVaT
        CJZ8zrxls8cYiSLRpg8/uTlsQbDole+QCsuJJepSew==
X-Google-Smtp-Source: AA0mqf52g8c1et2hYL2aMvkmrDbsTTbh0QzWoetXHWk4ssA6Po+Dfx8zSFV49xyrzO/M09rjNiPeaKnDro+TrpnEClA=
X-Received: by 2002:a17:902:b283:b0:186:be05:798e with SMTP id
 u3-20020a170902b28300b00186be05798emr4416045plr.37.1669131906759; Tue, 22 Nov
 2022 07:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20221122080554.4468-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221122080554.4468-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Nov 2022 16:44:30 +0100
Message-ID: <CAPDyKFpPg5WGG7vLxUJ9uXOmr54XONEHXzpBhHHuep+z8fHGLA@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: use plain numbers for end_flags
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Nov 2022 at 09:06, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Linux *_bit accessors take plain bit numbers, no need for BIT().
>
> Fixes: 8d901e2ba566 ("mmc: renesas_sdhi: take DMA end interrupts into account")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index ea2a85174a09..68da3da9e2e5 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -57,8 +57,8 @@ struct renesas_sdhi_of_data_with_quirks {
>  };
>
>  /* We want both end_flags to be set before we mark DMA as finished */
> -#define SDHI_DMA_END_FLAG_DMA          BIT(0)
> -#define SDHI_DMA_END_FLAG_ACCESS       BIT(1)
> +#define SDHI_DMA_END_FLAG_DMA          0
> +#define SDHI_DMA_END_FLAG_ACCESS       1
>
>  struct renesas_sdhi_dma {
>         unsigned long end_flags;
> --
> 2.30.2
>
