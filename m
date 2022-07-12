Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B8CCCA47C
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 11:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiGLLJm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiGLLJh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 07:09:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE979B0F86
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e28so9754081lfj.4
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtKSUMpZJw+fu84zLRlJO6MjozPPrekM/BZueYyrvAA=;
        b=dpZmTVwz9BJjjbK9ykVFWxFIFj9/BTKakkDrE83e5iJIE1YPwgbp2t0bQyUxpNXQdE
         y5E2Ni9PYJqcOpmdia8fyiQ8nTQ1naeygnbab02L87Ah4DKn806hy+2DHg/lvEofMf/b
         KI+2bkzkHTMDAulyq4c0+wCEmYjTDa1PjXD7EhokPDzK8p60HDxW9zzjS62NcepZ37yH
         CrC7OXrI/nH7FzOPfu/ow15GGCS0IyfwPYhmxvb2+sz2mait+aXBST0ay4K/Xxy+cdJE
         lwchfRKC0mcRc0+m3LvfdCZBGlTYmXNJeFuNAHJtGcxPsV5fKY98VT5okNRpavfYZ/Bt
         QjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtKSUMpZJw+fu84zLRlJO6MjozPPrekM/BZueYyrvAA=;
        b=Olu2cYBhO6P9jXGXxJOy50c7TtP32scGl1cuaL0jlZ4szH0HvXE781qKhjTQs9veaR
         ug8zpTJM5fTc1XTYe1ozJLz/Maa2tM0ECPyLQenSJmNbCEFfVhc4s1YOF1GunsmdeRbY
         MdLbJ+LIpTb9OPQk2BlvMB7T5q/gveje23807n0U/FqFNhltdVSM1b4eF3c55MzLFzjd
         SMyPmJtYQfU4YmgPtRx89aIMSK78cEIiXEyCeqN9y1UtOJIgwisf9XCwDueoOsrtB739
         sjzhVY1pRVzFwzBi20nRMa1f1WfeVikrqQlnN45S03W/XYxd5Ijnwk6CpfmuWPKMByWa
         InoQ==
X-Gm-Message-State: AJIora8EtMxUnnSggujf/vXDj3/Rw7Av5ydnsHY4x1RFvBjZ/cNEAFhF
        qsP/p09HZJ9HFpFb8+YqeaCAH5O3SuhYEPHPxh45IA==
X-Google-Smtp-Source: AGRyM1sdgovgZIpqFjv05+JJMOy7PP/DsLxQvjdR86ykqJS8oJpjV4Z8e08ny5YY7PKmxYSaf5Oova9atuFb2+AHaTM=
X-Received: by 2002:a05:6512:c0a:b0:489:cf39:d750 with SMTP id
 z10-20020a0565120c0a00b00489cf39d750mr10733405lfu.233.1657624175220; Tue, 12
 Jul 2022 04:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656155715.git.christophe.jaillet@wanadoo.fr> <b216df8798f765ab14bce65739c220643320f376.1656155715.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <b216df8798f765ab14bce65739c220643320f376.1656155715.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:08:57 +0200
Message-ID: <CAPDyKFoKxY6EyBpyE+ZhMBBkFo6uEcs9E6-wMCPYHZ4uh6iNjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] memstick/ms_block: Use the bitmap API when applicable
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 25 Jun 2022 at 14:56, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Use bitmap_equal() instead of hand writing it. It improves semantic and
> avoids some explicit computation to convert a number of bits to a number of
> bytes.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/ms_block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
> index f8fdf88fb240..c05edfc1c841 100644
> --- a/drivers/memstick/core/ms_block.c
> +++ b/drivers/memstick/core/ms_block.c
> @@ -2245,8 +2245,8 @@ static int msb_resume(struct memstick_dev *card)
>                 goto out;
>
>         if (msb->block_count != new_msb->block_count ||
> -               memcmp(msb->used_blocks_bitmap, new_msb->used_blocks_bitmap,
> -                                                       msb->block_count / 8))
> +           !bitmap_equal(msb->used_blocks_bitmap, new_msb->used_blocks_bitmap,
> +                                                       msb->block_count))
>                 goto out;
>
>         card_dead = false;
> --
> 2.34.1
>
