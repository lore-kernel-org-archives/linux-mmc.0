Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4149ECAAD8
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Sep 2022 12:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiIUMvL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiIUMup (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 08:50:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4C98CBA
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:49:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso3690331wms.5
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lEb4/vNRwZCzTxI/+P3qnCbawhg15sfGPXUaXIOqYpI=;
        b=PoHyJCavEEfGvzK5zXf9rbMdn7G6Upl1QJOu7Zm5YdjfK763Nm3aSmlNChHxB4ZJzv
         2dgQnb/ZNZThkfQNTXl3cIsti7gm0Q9eLUrRhlu5OBi06LbUGd8q0rocOYzn/A1Jnixy
         KyA7KT9j9oNQGs3Vt6HVR6q0U86dqPBKwjXCrKbCUVvBmPQ3ttxCspFJIl+GXj+9JJ2n
         dWPE+7gSrIa7otYJiWekHk9vWPGSW49dyeGZxn4GaJZ+MFcKlMc6Wwm4WnkWC/qcBacr
         h9l0mfGXGgPB+gcfMSzBd4sOwQYnDFlr9imeQBdGW6h1H0xnpZ2UCeq0KA2gQy+w8mMR
         gcaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lEb4/vNRwZCzTxI/+P3qnCbawhg15sfGPXUaXIOqYpI=;
        b=0PdSK1ximcy6VLoSJDW0+Jwk8ZtnI0imeNEcKnPVbwGAfC2eiCJDEdXxJWSqKoE6wJ
         h5DQ64eF5wdyjR3AvZqSHPnD9gqbWGDSGpSFJQ7CBRknfVYLEdXV+1QGJNqa7Bc4FuM3
         LD7SDeEtkEwVke3XVDSspl5JIA/E0YLga6LjrRFjwvZS6hiKgcSl8plo+6Yvv7bX4g0D
         6SzaDhevH+o9fWQtUuKATnSu6c02Q3/G7KLNkTn97IKLP5/10w9+/RcLvcgiqarNFHGM
         wT5n/Ql7zBW5uu1/u9tI7iUC9S4DY/QPdaeZP0d9tQ5H5T+w0VilWty0JNpeZvHYJV51
         0p7w==
X-Gm-Message-State: ACrzQf0VfkaaXIW/H8LSHUYCjBZG3grvnZ2Aao1ACBK4Is5Hx1Frd8e1
        KTwE8Jnj2IknBTfVTWnVjhyrCwrIBHHQ1a4Yl6Uf7A==
X-Google-Smtp-Source: AMsMyM7RicGBmKbhHlBZWqTSEaQjpWc7j9DhvdwmmAme+poXKTCBPcEBxEu/631ZA5y8bw4T04rLJ0cER2Icgi83Pmc=
X-Received: by 2002:a05:600c:524d:b0:3b4:91ee:933c with SMTP id
 fc13-20020a05600c524d00b003b491ee933cmr5562117wmb.100.1663764543062; Wed, 21
 Sep 2022 05:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220914063702.20283-1-wenchao.chen666@gmail.com>
In-Reply-To: <20220914063702.20283-1-wenchao.chen666@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:48:26 +0200
Message-ID: <CAPDyKFptoSosJG-LGk6QFbU43f-NUnLHafMyXG7CfoWO-D5zLA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sprd: Fix the limitation of div
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Sept 2022 at 08:37, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> From: Wenchao Chen <wenchao.chen@unisoc.com>
>
> Because the bit field size of the divider coefficient register is 1023, it is
> limited before returning the value.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index f33e9349e4e6..46c55ab4884c 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -205,14 +205,14 @@ static inline u32 sdhci_sprd_calc_div(u32 base_clk, u32 clk)
>         if ((base_clk / div) > (clk * 2))
>                 div++;
>
> -       if (div > SDHCI_SPRD_CLK_MAX_DIV)
> -               div = SDHCI_SPRD_CLK_MAX_DIV;
> -
>         if (div % 2)
>                 div = (div + 1) / 2;
>         else
>                 div = div / 2;
>
> +       if (div > SDHCI_SPRD_CLK_MAX_DIV)
> +               div = SDHCI_SPRD_CLK_MAX_DIV;
> +
>         return div;
>  }
>
> --
> 2.17.1
>
