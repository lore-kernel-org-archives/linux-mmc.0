Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA425C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 09:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A94233A2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 09:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhAMJ7u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbhAMJ7u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 04:59:50 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B135EC061575
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 01:59:09 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id y21so508854uag.2
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 01:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGmIWyDuVO9oVyVosfnUvrEJ+6uYqwH01U/ypuWqHzA=;
        b=rAVBu9fP9XMsjekcFFXd3MklM6sDjTnuBcnUT3SkjMDZACexowwQ8bokG0BDKTF+IC
         pt7dEBYZyKlGi6rSPS6SRoZNbpWJ/juFWbPbDZ3cOWaEYlKBwkBYHaG/un97KO8s/yIO
         njGDDLntKSuNuo2QBT6GB6dQ4hw3N1X/dEcOeV1vvjr7AkPOq48/EX5aL+/VBV08Voyk
         PAWGdmVOdc33/Nfjz8yCcV+DUQJERa9vQyV4iUYjtMVGbmkQxl6l1LJ4vtBZ3tUa9yiC
         Q7Qpe87FFbA9GmlLBII2C2/lys3mZbdbeh3NJPA5XkNf//1rPro1WkLeECKEq1a2q468
         zc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGmIWyDuVO9oVyVosfnUvrEJ+6uYqwH01U/ypuWqHzA=;
        b=WXu5QMFPEPhn/AWhDfdo1hokjTZRzeDAOaQjQ2ON/77zEVPK/snHo58g/kxDnDCKeD
         Cs/vrKkAYTdRZeAFCsHE1YuDSfRMe6UGu0XRUFc9eKBxJ7muOFRORqUT+IlktBEx8aMS
         RObIyanDuHmIxgVWIjXZatwkUUVCTAHVIXhb4zHJnRtvISon+qgXW7S9LAOVM3htEFhN
         AdiCjW+/go8LPcOHh1IFi11ygpp9oLqm4MWMrmj5ugS7SOxrLVkFWU1Gbh9Q7TJt50nq
         5Xlqe4MWTl1Ds3DEe5udwuDLhbl+dy84SO00aHJ+scjLLRbETuAaGQBJA2KZxasXqoqA
         qrCg==
X-Gm-Message-State: AOAM532bRmP9O+akCfbtWimSzO7utMalyMQO2KXFuNy5zpSReHnd3+me
        ofbbwyqDiXtVqaH7wpo/MStYIJ+gyPHXjelXwX6Qfg==
X-Google-Smtp-Source: ABdhPJyehSOINnOwLOeycoelO1Uthul2BxKY6eSZuKxRhJqBQQA9zzEyRMEUKrKeL9PokE/81DV7LBIuLaXTquH+Zik=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr1089390uad.15.1610531948901;
 Wed, 13 Jan 2021 01:59:08 -0800 (PST)
MIME-Version: 1.0
References: <20201230090401.12627-1-ricky_wu@realtek.com>
In-Reply-To: <20201230090401.12627-1-ricky_wu@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 10:58:32 +0100
Message-ID: <CAPDyKFro-dWCOVx=a1BhEJ=J=Hj_+nU+FmTUZjkeAkCqtML=kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: rtsx: add delay before power on
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Dec 2020 at 10:04, <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> Make sure voltage below 0.5V before power on
> when do power cycle
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index e6f5bbce5685..d21b99962b36 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -906,6 +906,8 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (host->power_state == SDMMC_POWER_ON)
>                 return 0;
>
> +       mdelay(100);
> +

Why exactly 100 ms? Can you at least add a comment about why in the code?

Moreover, I think you should convert to use msleep() rather than mdelay.

>         rtsx_pci_init_cmd(pcr);
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SHARE_MODE,
> --
> 2.17.1
>

Kind regards
Uffe
