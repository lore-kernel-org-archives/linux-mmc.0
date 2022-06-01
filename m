Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E62C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jun 2022 12:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353081AbiFAMrH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353103AbiFAMrD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2022 08:47:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AB35F47
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jun 2022 05:47:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s13so1873110ljd.4
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2022 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqDKJWJn3KR6F/t8EuCHiF1PKuDwpntQP0fkdEdQKws=;
        b=Fh6mGwxvUqrYxnGeAf6gRK0flNakrFnVg9b2xz1C0/zw54bfM+TF+jUKVOFwQNYRp+
         Fcvt5S3hwHMsigKcVt7+uHOLwQRDUSmE9mE/ZU+/wrEkc/M0SuU861PbAuNH8qb+T9E2
         MV7wlVsmnB6J5j3mAoKwYwuuDeOctq+f/Z0ws6OvbJIfDoWe56zcXxWcWFhs/9QMc9q8
         701JG9yzRYGhH3j5OoSroN5LU4zBLGWA2KYRMEMa0lnaKRhMDy9UOoZqpSOUDkeV4fI0
         Qb9Z5HA8xEgqxYfnH9kZ1b2VN2cJ2gTe00YFR07+KpDBiywxJo5UiXprOq+U/Q3Qt2ND
         v1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqDKJWJn3KR6F/t8EuCHiF1PKuDwpntQP0fkdEdQKws=;
        b=K0vH71kiPvF3IFPDB6bzZXJLdNMAr+kKz07lfBjcuOcqBt+UAZOlBdV50iQyNI8tmA
         lYA6MQiP5sNYZOCWhx4p4DyWAHHiJ5wQWQCxf8p0sLfgXuwhWANmQFyzx1USpczf08Up
         GxJMoSI9m6f90mDAsDZvCpcct/RvG95bDGuX8xBngdOuXeTXWkxjOFwR/FfZNYRR77g7
         kEwCeB0mnqcKjwiFVz892/Ajr5DMpco0qiq5llyb2Tw9wUcFbD9XxHdFv0tpQ63qEEQP
         ADdP1nFMXo4fOnIjv4KFSVLuXCzeN4L7iYMzjVjB7M+kLzmNtmgisz4/YRJJp4oeEtSe
         U75w==
X-Gm-Message-State: AOAM5314Nd506CIQxC/pKBTu4vtOICvjik3kVYgcLzeuYSB6DDGZNQ7K
        AtB9uS4qxc1mN96hY9iGbG9qPPvxhvaK4hh3dKaWU6lNLDI=
X-Google-Smtp-Source: ABdhPJxJIs39WEUtGpVqKIIbRC1ZzEuJkg8hkJUTVxGDs/YlupuKseOHBIm/4fxNJmL142hY/6+4H6ajgpj9hkeXWnY=
X-Received: by 2002:a2e:a273:0:b0:253:e0e7:7948 with SMTP id
 k19-20020a2ea273000000b00253e0e77948mr33626186ljm.463.1654087621703; Wed, 01
 Jun 2022 05:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220530123857.692076-1-fparent@baylibre.com>
In-Reply-To: <20220530123857.692076-1-fparent@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Jun 2022 14:46:25 +0200
Message-ID: <CAPDyKFqNegBhdqc0URv27OLKMupXEMEU5c7-e4YasWsKGA0OQg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: fix typo
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 30 May 2022 at 14:39, Fabien Parent <fparent@baylibre.com> wrote:
>
> Fix a typo: Fianl -> Final.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Queued for v5.20 on the devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 195dc897188b..c7d196f805ec 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2318,7 +2318,7 @@ static int msdc_execute_hs400_tuning(struct mmc_host *mmc, struct mmc_card *card
>         else
>                 val = readl(host->base + PAD_DS_TUNE);
>
> -       dev_info(host->dev, "Fianl PAD_DS_TUNE: 0x%x\n", val);
> +       dev_info(host->dev, "Final PAD_DS_TUNE: 0x%x\n", val);
>
>         return 0;
>
> --
> 2.36.1
>
