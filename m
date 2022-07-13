Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCD8C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 10:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiGMKzx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jul 2022 06:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbiGMKzr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2022 06:55:47 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B44FF59B
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:55:47 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v185so10438633ioe.11
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7c3W4ZAQzN6j3AXvAGov1+EqMB4OBgBD/jHVot9laM=;
        b=dHLFjINRfWGxr9sKXGB6LSumog9+1BZUBYZQy8lRdEVV3oBKeC4IRquTfxMceVV4hS
         PIzDGVANGVPzSsm7XiQDS34Tpk9MHZvo96shQ2EDUKBJvqvQ13TwYHPjJ8aLhSRRWtoL
         uChsHOpwT65hqFw1CR7zHtBxEgThO49vpZFg1vDZAYqbK1PCf3DPmvFJJMPPGFkEKtuW
         W4o71uaouGqzicDCHvjTsMnOsugSzMPjHvYnvISqcFvmwc0KPliLzzNBmbIVE75bVt5K
         xNhTztOI4feyo9OVlRvj8NBGtnx44/2T/xXSrmxIn4OuJkfTHUwkGkhdNVBqSBTjvdGk
         Hr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7c3W4ZAQzN6j3AXvAGov1+EqMB4OBgBD/jHVot9laM=;
        b=Z9pvDu2uTwC+uigxjxEcnWQlOdDJ8px00CBSMLOvhbt747ZhvtAoYEtQRvUYeAgiWj
         S0zEr9bpiA/GL1D4tYEW0YUE7uIyuueNg+LwDZ12E+V/hS/QRVDxMCsaI48opqBKHZiR
         8O1Q61dBm3MGl7qgnrm+ENjA24EnYvvsrKyNdF81L+8JFHiBuMcHVYE118K9xTj2CD61
         jJOu3z9mUtLRHX8wlf60Ed7lZShZxeVzwJJ7y066EmTRQR97QD2T/0rp99dWknSCA6/C
         CzWG+FJjdJoMQS+QPUzC35yVr4OF9dA5NPGC+5XKlkwyqOAjpni++Qf4jLQZSAedwjRO
         8L8A==
X-Gm-Message-State: AJIora8zI6aMRN1CpmQucD1pT9v8lWDQgdjA2OzSzOH61imwrp5ruki9
        qo8DFBO4CnPVQb8a7GSO0fsIkm4xwjBVBlPQGYhn4CQzG74=
X-Google-Smtp-Source: AGRyM1s659o60bAf7u3CN2NB64tDMsOqTqNtsA/5JV51esmAp48Y2tnsxTdYa49386HVkJI2ckUsa5cLwSbuYB6HGRI=
X-Received: by 2002:a05:6638:2410:b0:33f:8518:659b with SMTP id
 z16-20020a056638241000b0033f8518659bmr932342jat.253.1657709746746; Wed, 13
 Jul 2022 03:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220713030417epcas1p4645d69539b295df914057b57d1c09c86@epcas1p4.samsung.com>
 <20220713033635.28432-1-sh043.lee@samsung.com>
In-Reply-To: <20220713033635.28432-1-sh043.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 12:55:10 +0200
Message-ID: <CAPDyKFrMb6AubiRrZEUXMQea8QCK5C4b0iH967ZuvJ=e_QchSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: use mmc_card_* macro and add it for sd_combo
To:     Seunghui Lee <sh043.lee@samsung.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Jul 2022 at 05:04, Seunghui Lee <sh043.lee@samsung.com> wrote:
>
> add mmc_card_sd_combo() macro for sd combo type card and
> use mmc_card_* macro to simplify instead of comparing card->type
>
> Changes compared to v1:
> - Reviewed v1 by Uffe.
> - Split into two. One for the core and one for the mxcmmc driver.
>
> * previous discussion
> https://patchwork.kernel.org/project/linux-mmc/patch/20220705015729.14455-1-sh043.lee@samsung.com/
>
> Seunghui Lee (2):
>   mmc: core: use mmc_card_* macro and add it for sd_combo
>   mmc: host: use mmc_card_sdio macro
>
>  drivers/mmc/core/block.c  |  4 ++--
>  drivers/mmc/core/bus.c    |  4 ++--
>  drivers/mmc/core/sd.c     |  2 +-
>  drivers/mmc/core/sdio.c   | 16 ++++++++--------
>  drivers/mmc/host/mxcmmc.c |  2 +-
>  include/linux/mmc/card.h  |  1 +
>  6 files changed, 15 insertions(+), 14 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe
