Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68445C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 11:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiGLLKO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGLLKA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 07:10:00 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A1B187C
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bp17so5499049lfb.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7xvUr3acBmNT91OYSg7vp9pOqhndSc1vMzk+QzXWQc=;
        b=MsS3VimdgaefeQl8U7UML7XFrz4h3us6DsTYAxw/f+gilnXnutIc9hFnzyeuDCXkFs
         GWLR1RqguJ/KZwxkYmL/apAdLtVxLn0ymPmDPsTjyQPmja0ERhz5YxR87kz97RLLcSYQ
         TGvZjErInvOflZirsmeBcxfByn2CXN+CXWnbfNwzxX//L3EdX4JNi5VdqXJH0oqmCRG1
         J1H9f4J3SooNyTGyQL67TPFHlEKDcVx0o6/g2UrIrug4xvA0QujLEHzNUYXBsPDIzBju
         7VTPMImE+2PPkFKLccGmnjhL3LT3M8c+x6CAA5j4ftK+y+JJXLiwEhyEdRKKrghacCrd
         XWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7xvUr3acBmNT91OYSg7vp9pOqhndSc1vMzk+QzXWQc=;
        b=H2LY3I2clg4WF5PJPT3p9o+C/shPneTs8HsuCygKbwqBRUTiP/hIRcvK3NgkrH/7gQ
         bJVZkVxrFvvcM2YYz/5csiP0erqS07LpOG/1sWsDKjx2Yv0iUx9q8dSfIJQOWXpye7yg
         0PJgF6m6jYyuG+lS1jWT3KjyJiNu9oIoFibACy227lKDLb1nq0lxzPwbTDVhZDkOKS0U
         haxJPgP3vm8DgTYd8C2mHo4Di3Y4Hl1gGZovH2E9C/zqCd+ecCE5n/OPJt4k8n5WjyGG
         8SfsjqfovKj3y/c6zCNrxQNKujdPyb6pXfSrbkZrLSUWfRVDihckPZI5eDu+z4wydylO
         QoZg==
X-Gm-Message-State: AJIora9mHckendv6gTykRXNeUtMRVs/eTZsdg6dZQ9dxFtJq0hMxV/Rg
        kXN1RVMSYq7RqVgX11QkDpQoWNf/Z5sWypHl8wBn/g==
X-Google-Smtp-Source: AGRyM1uUlmjFxrOoOlM4FZGvF50cT4juYxnY7SNb70UjezAVCvgHGjctbLvLBFJkJ4dMA3i2QyxScecw5MdgqMp+OE0=
X-Received: by 2002:a05:6512:32c5:b0:481:1822:c41f with SMTP id
 f5-20020a05651232c500b004811822c41fmr15259311lfg.373.1657624197888; Tue, 12
 Jul 2022 04:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220706005238epcas1p110ad467f1406cb9270e449de998090a9@epcas1p1.samsung.com>
 <20220706004840.24812-1-cw9316.lee@samsung.com>
In-Reply-To: <20220706004840.24812-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:21 +0200
Message-ID: <CAPDyKFoP4c8_oiHOxHm0VBRZq53ENSKRnb8DeKpGFv=b3AcPaQ@mail.gmail.com>
Subject: Re: [PATCH] Replace with already defined values for readability
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     s.shtylyov@omp.ru, huijin.park@samsung.com,
        andrej.skvortzov@gmail.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 Jul 2022 at 02:52, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> SD_ROCR_S18A is already defined
> and is used to check the rocr value as shown below.
>
> So, replace with already defined values for readability.
>
> --------------------------------------------------
> /sd.h
> .#define SD_OCR_S18R    (1 << 24)    /* 1.8V switching request */
> .#define SD_ROCR_S18A   SD_OCR_S18R  /* 1.8V switching accepted by card */
>
> /sd.c
> static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>         struct mmc_card *oldcard)
> {
> ...
>         if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
>                 err = mmc_sd_init_uhs_card(card);
> }
> -------------------------------------------------
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Next time, please use a proper patch prefix ("mmc: core:" in this case).

Kind regards
Uffe


> ---
>  drivers/mmc/core/sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c5f1df6ce4c0..d2023837dd72 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -870,7 +870,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>          * the CCS bit is set as well. We deliberately deviate from the spec in
>          * regards to this, which allows UHS-I to be supported for SDSC cards.
>          */
> -       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
> +       if (!mmc_host_is_spi(host) && rocr && (*rocr & SD_ROCR_S18A)) {
>                 err = mmc_set_uhs_voltage(host, pocr);
>                 if (err == -EAGAIN) {
>                         retries--;
> --
> 2.29.0
>
