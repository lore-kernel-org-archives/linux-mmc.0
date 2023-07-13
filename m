Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACC1EB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 11:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjGMLHQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjGMLHO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 07:07:14 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBE226AC
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:09 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-577637de4beso4902537b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689246428; x=1691838428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YynRJVjn4jFQingsAjZzW8BP9Z9BqPeKf0r1i2I/YtQ=;
        b=kBJmQS0O//8na3ZnG7csNH8foyEwvS1eUHZihWOJeQ8RbT02KneJXZhQGjG2wBgWrt
         98nnZ9ZCMfL/WHj0EyZjD39iSChuxpUqAAmJIFyfcx9+mWVQ7hLlpxTIxFd1cNdEPdaA
         OZcydG0jB9KmMdjHbf5OUI1RbWkz2vnhOaccp13k3Mj00CYQqbgKz+B/YcpFTalleATk
         4hJQrJtnSiwcmaeUOQTEF595ZMvrzfS6D36bAzhmEoutQC/7tKZjNLz5i/ZrUY738OLX
         Mwqy18rprlJWk/m7WAdXXi3R4SPNU83MVaRkRHVQ0SzzI0FUF7jZqnvtFnazfW0V6NC8
         KAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689246428; x=1691838428;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YynRJVjn4jFQingsAjZzW8BP9Z9BqPeKf0r1i2I/YtQ=;
        b=GQrzOaTmfsgpMi4YLmZwyu4MpTwPc6443endNS+PRtd2AAhI0kIK40YlF05aN8+yRB
         VVz6D02joiXNibYsKFVktVoxYi2Lc/XglP/5lZ9iHBsQgepB84bU8FxQN13xyoF34SA3
         6khYJmP/w5gZan16ikPaz81uvKE4gXFJsma6Gw9fYDO89VONl5N4QoJhAxC8JHx3OyZu
         bY95pb3KGv9azTdHmFxDSFln87GsRm2tAvx5W5Hcua8nJvBa+3JoxfqroE5a2TAaXlwy
         LdlKYibc5UDMKrg0lMInaUF2MTRnXG5KMNLdOcflz9qzwchJXGsab6MuI7z5IQM+J7X7
         5Xqw==
X-Gm-Message-State: ABy/qLaES27LlzGVs6wxL613pEYpApJhYeFWOWScCDluidgIli91qaJr
        6r4ox2bbsCer4iHc2jryNKNgsCr+A5eXG4waSKS17g==
X-Google-Smtp-Source: APBJJlFxHllpTe01vvfKlpEeTLNBybHL7UxZ/vIhTjEuOdd5yFgvs3rRv5RdMB/bLLg2FER0bI1YHxhjD6rIdSbK2bc=
X-Received: by 2002:a0d:d78b:0:b0:570:6667:1cfa with SMTP id
 z133-20020a0dd78b000000b0057066671cfamr1361428ywd.47.1689246428353; Thu, 13
 Jul 2023 04:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230712140011.18602-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230712140011.18602-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Jul 2023 13:06:32 +0200
Message-ID: <CAPDyKFrPzLJ+bXfU-GhA5J6ybNRgAx0j7awUxd7uNbLpHhgAsQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: renesas_sdhi: register irqs before registering controller
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Jul 2023 at 16:00, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> IRQs should be ready to serve when we call mmc_add_host() via
> tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
> before registering the handlers.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Biju Das <biju.das.jz@bp.renesas.com>

Applied for next and by adding a stable tag, thanks!


Kind regards
Uffe


> ---
>
> Additionally tested on a Renesas Ebisu board (R-Car E3).
>
> Changes since v1:
> * refactored setting sdcard_irq_mask_all (Thanks Geert!)
> * added tag
>
>  drivers/mmc/host/renesas_sdhi_core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 345934e4f59e..2d5ef9c37d76 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1006,6 +1006,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
>                 host->sdcard_irq_mask_all = TMIO_MASK_ALL_RCAR2;
>                 host->reset = renesas_sdhi_reset;
> +       } else {
> +               host->sdcard_irq_mask_all = TMIO_MASK_ALL;
>         }
>
>         /* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
> @@ -1100,9 +1102,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 host->ops.hs400_complete = renesas_sdhi_hs400_complete;
>         }
>
> -       ret = tmio_mmc_host_probe(host);
> -       if (ret < 0)
> -               goto edisclk;
> +       sd_ctrl_write32_as_16_and_16(host, CTL_IRQ_MASK, host->sdcard_irq_mask_all);
>
>         num_irqs = platform_irq_count(pdev);
>         if (num_irqs < 0) {
> @@ -1129,6 +1129,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                         goto eirq;
>         }
>
> +       ret = tmio_mmc_host_probe(host);
> +       if (ret < 0)
> +               goto edisclk;
> +
>         dev_info(&pdev->dev, "%s base at %pa, max clock rate %u MHz\n",
>                  mmc_hostname(host->mmc), &res->start, host->mmc->f_max / 1000000);
>
> --
> 2.30.2
>
