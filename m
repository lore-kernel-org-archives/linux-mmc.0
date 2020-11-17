Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC59C2D0E4
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44E87223C7
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8f74d8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgKQLuZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbgKQLuZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:50:25 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F615C0617A6
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:25 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id q4so6404638ual.8
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9J4/GjBm07AuCxWfryW2OeEMZBlaijfc8o7o8S/orE=;
        b=w8f74d8quFo9AMbC+ANuv1sP3E7E1iKdtWXp299Hic/8NtM9t27nfA49y+y7TXslwl
         4YS48sBJhA7ruEJe3zd5cihO2AtJL1cGyw7ap2sLXwyfZGCeT8Au2GWRLX2cjJ5p3VMP
         Am0AvN8UTKEEfpmkV525On73KAaEF4Ox3Aqd/zCgh84Po2KO1xbj4QBVEyTGIEMIm1iQ
         9k+7y8h0CJ9Jpv4lCZcyNzeD1CI0QJG27BkiE5GEup+1FBi1qMUrBpgNcFqOI467E+d7
         TKXv4lgfAqmM2nbhlpoOo+MYvGjfiKW62mLXUtqdFp1K2hJT43KPLNiL9FXz+gHowyuy
         jpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9J4/GjBm07AuCxWfryW2OeEMZBlaijfc8o7o8S/orE=;
        b=HtlzyFE+rw69tjNnJpnGej/TmFfAF8JyffIC/Nz+GQIA4sRaIkLKE2pqj8CFiMBgTw
         G5WNdpw2CmXbjFH8kFgkvydsFgycusMLshE5SEXjRDSh9KH1o7o+6g60s71GFsIzUyHM
         As+D2XjZ1crE3Y2uzwEkqpuvLd62rLkK5NSMQBjLXOpy5tsBdeedqz55qxaEzEQIthci
         q0LZHGcDomuwTpqP9F2YsKwdgKTF3DJr80swQ9MvnEN9HVm2f6T/BHePx9EVm8lbRAf9
         ZlGaXqU3gHlNK/rK5vUM0Lk1dignJavhbEjcLFrHd0cEIb/eIMwVy6YzhwZ0chgqMe6/
         rw5w==
X-Gm-Message-State: AOAM530MqN4y30PtOIFSAcwSLVtrbm+V5e0KxNn5WNZrtlM0DUCf2ZGF
        AOrHYxFco2RN7B4FhQJsBYKmlCqSl8uHfTOCYtzhgPz9Fy7+Lw==
X-Google-Smtp-Source: ABdhPJwXuzplmzqlRYUuSajGJjVIwsur+A23Qx6ULze/9JXh1Vk+RLwka9ndHiOtCpsAu8RI0dxRnq0QxFa5m/NIEy0=
X-Received: by 2002:ab0:7103:: with SMTP id x3mr10785157uan.100.1605613824404;
 Tue, 17 Nov 2020 03:50:24 -0800 (PST)
MIME-Version: 1.0
References: <1604888706-63429-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1604888706-63429-1-git-send-email-zou_wei@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:49:47 +0100
Message-ID: <CAPDyKFr84zM8fu5KjHNWSQr4KyBVojbgDq82x_g90-VrFQiYLw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: owl-mmc: use true and false for bool variables
To:     Zou Wei <zou_wei@huawei.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 9 Nov 2020 at 03:13, Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix coccicheck warnings:
>
> ./owl-mmc.c:524:2-18: WARNING: Assignment of 0/1 to bool variable
> ./owl-mmc.c:528:2-18: WARNING: Assignment of 0/1 to bool variable
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/owl-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 82d2bad..53b81582 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -521,11 +521,11 @@ static void owl_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         /* Enable DDR mode if requested */
>         if (ios->timing == MMC_TIMING_UHS_DDR50) {
> -               owl_host->ddr_50 = 1;
> +               owl_host->ddr_50 = true;
>                 owl_mmc_update_reg(owl_host->base + OWL_REG_SD_EN,
>                                OWL_SD_EN_DDREN, true);
>         } else {
> -               owl_host->ddr_50 = 0;
> +               owl_host->ddr_50 = false;
>         }
>  }
>
> --
> 2.6.2
>
