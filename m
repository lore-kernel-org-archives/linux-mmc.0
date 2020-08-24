Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D6FC433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E06207D3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUoDj3Xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgHXJvw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgHXJvt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 05:51:49 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14856C061755
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:49 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b26so4091666vsa.13
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6IUrmPgUfQ6Qh2dE+GqJ4MoV6eg6EsbHN0PK195SwY=;
        b=XUoDj3XoqQF/8HVWNEAVIRQQBuzE3esbdKnX7Tv6OYmOtw/Xf4CC/ZKb4uJ14gTrq5
         eAZVYIS0QwNx/DHc5TMZXO1HQtC9hEqRoC7sKnG0JQagitTFgyZKi3XuZtOZA1tuN4l1
         nCza6t/TBAZMs8PilIAnZ8s4JbhaaDuGlJQHdXLY4HM+A/F9vFSGM7Z73Hnk28QvFI4L
         MpoIiXxYlU9rI0053Qhk0pigh/WrDoWrF7RBm+QijNPc3yCfRmikzkhCwjn7zYP78JsI
         wgY8DY7aa8ZK3jhIIKnyGuHjr55IbTUH2+uYvk8v/67rdLeJN+hP0vq/S+wvr+NOYKkh
         MKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6IUrmPgUfQ6Qh2dE+GqJ4MoV6eg6EsbHN0PK195SwY=;
        b=ata58T+8imNE9J13Wcw0V8q5cAgSH8HmfZ+O2Ugx/Mfl5SFnVlakkGU4m6A4Rf6Fm/
         u/4djJSPa/6yPaoCcNvfOIt1cLcmtptxogerIgfq1hOUtOrpAEUIaNR1jcJnSlyhgUQL
         ZlG+rb4Q7POtB7zql0XT9T5/SWnwIEctFtqbG/NUGT1HccUXFTdZJtvRktDjYIx4GkKl
         55nd15vJHC2VikS3lTlY3iBo+1eM04sqNG/eNQ02m9fDCIwzi38dxCEYzHHVjd8smlzN
         PEb/nKY9Hofvxjrjh8g9/F7pTao2VOIKiW46xMBQFEdjLWr7qLv3SZ+pTflvtRxTw1wp
         5itQ==
X-Gm-Message-State: AOAM530XHiPyfERx58LsuAORfM1eVaOmIM+ozzgPCltzUFFok9mSc9nb
        /UgMbwTyBdUDvLOYHat7YFnH8dsssVKPv3qwvjlnCA==
X-Google-Smtp-Source: ABdhPJyP+LtrFHIJTf3Sht0hrrBHK7GyA4d0BHVOWtJzqrvCtaOf8+s0y5mgW29W4/wc3GAmB9caJ98O6OPkaUaW9Tw=
X-Received: by 2002:a67:e45:: with SMTP id 66mr1972191vso.191.1598262708304;
 Mon, 24 Aug 2020 02:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200821063533.3771-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200821063533.3771-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:51:12 +0200
Message-ID: <CAPDyKFqc0u47JHgXyTh1qa98d3g=D6H_G+CD=3b+OnV6KpfKnQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: improve documentation of HW_RESET
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 Aug 2020 at 08:35, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> HW_RESET means resetting the remote device, not the controller. Two
> drivers got it wrong, so make it more clear.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, with a few amendments, thanks!

Kind regards
Uffe


> ---
>
> I sent a series to fix the TMIO/SDHI driver. The other one is bcm2835,
> but I want to get this patch approved, before I notify the maintainers.
>
>  include/linux/mmc/host.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index c5b6e97cb21a..cf04793ab4ea 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -163,6 +163,7 @@ struct mmc_host_ops {
>         int     (*select_drive_strength)(struct mmc_card *card,
>                                          unsigned int max_dtr, int host_drv,
>                                          int card_drv, int *drv_type);
> +       /* Reset remote device via RST_n */
>         void    (*hw_reset)(struct mmc_host *host);
>         void    (*card_event)(struct mmc_host *host);
>
> @@ -346,7 +347,7 @@ struct mmc_host {
>  #define MMC_CAP_CD_WAKE                (1 << 28)       /* Enable card detect wake */
>  #define MMC_CAP_CMD_DURING_TFR (1 << 29)       /* Commands during data transfer */
>  #define MMC_CAP_CMD23          (1 << 30)       /* CMD23 supported. */
> -#define MMC_CAP_HW_RESET       (1 << 31)       /* Hardware reset */
> +#define MMC_CAP_HW_RESET       (1 << 31)       /* supports device reset via RST_n */
>
>         u32                     caps2;          /* More host capabilities */
>
> --
> 2.20.1
>
