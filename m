Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC203C3F2D1
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FC620870
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 13:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kz3ZoEts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388094AbgCDNFc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 08:05:32 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40882 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgCDNFc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 08:05:32 -0500
Received: by mail-vs1-f67.google.com with SMTP id c18so1058503vsq.7
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 05:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6V/ThFMEUQVv4pGKZWOlNFwrQHTHd/Cjm8+feJdCcI=;
        b=Kz3ZoEtsx/w9PtpTfMWI8BfIvHJpdI9eqfduNdgSwzkFoNOvf5mynamxJMQ38s1scq
         UG5FlR10x0pBG5V1AFPAdPmP0MOEpxBmXzWx7P7RmWNYCu4XmNn6TTtWxhX7VSYioDlK
         wEcFWuz1KtLJRddXeMmM++EC+8fDJOiJlgk+zDB8nWuDmYPwY4OX5/qowiZ948/V+kxU
         9IUoYDeOARIZkvwXc5m99BVtXs8ZzFhifpP2vb1byNKWfJ9JZBThXmMUnc6lTfQjIsKu
         167dPumst3rTtZBc9uDOXmDzBFJItYEmLl1hwTjdK/BEIWqYTDx9KTbELZK9I7NV8XN+
         RenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6V/ThFMEUQVv4pGKZWOlNFwrQHTHd/Cjm8+feJdCcI=;
        b=V0tbNk2o8ofZPvgFGVj6/LsA4dVjMIZ1g2wVEYP2HVToVP/HvGjpWN6le1JrapUQKd
         ly3Sb3wINIPMKmU3MagUVbs7b/qUCZtrb+5Uz9eSNMWWspeDIskZccysdnmx3zad99pB
         ella4fVOGNn/5WCNpjzsxNUvVM2yD6V1+1+cePTGMhI6j5Mf5DqbSSznJcgzmJ99Gesp
         BeCWy01RgMgFMEiP4jOOPJT9CaWHGW0c506VO0+tECyudFpSu5Twn/UHIFlKlq80+yAl
         PH1osNoPyjfs8E3ujRTGTAiTA+Y2WgonNxKA2RMlasamhPMc7D09/hApDkvBMoeXhEEI
         G9oA==
X-Gm-Message-State: ANhLgQ3g+lEwkBI1jx3Eo+x8l9nDI8/Skw+MJXcUF92FJwCTPEKURcws
        CL8jMODgsdvdSv6bWsZ+Rg3US43P71jS5HYG75ySNQ==
X-Google-Smtp-Source: ADFU+vutcotJyTUK5tPrXTH7n8AgfiQgisISlV0zrVV7kZWnuc9rR3DZfocZpWM1AQk8GeUV02RcRhWp4SBgvRUJOTA=
X-Received: by 2002:a67:800e:: with SMTP id b14mr1606080vsd.191.1583327129997;
 Wed, 04 Mar 2020 05:05:29 -0800 (PST)
MIME-Version: 1.0
References: <1581922564-24914-1-git-send-email-chun-hung.wu@mediatek.com> <1581922564-24914-2-git-send-email-chun-hung.wu@mediatek.com>
In-Reply-To: <1581922564-24914-2-git-send-email-chun-hung.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 14:04:53 +0100
Message-ID: <CAPDyKFpyah+oA-GtXNmdkrhwnGN_syU1JqRHn-9gk=HK0fV8EQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mmc: core: expose MMC_CAP2_CQE* to dt
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 Feb 2020 at 07:56, Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
>
> Expose MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD
> to host->caps2 if
> 1. "supports-cqe" is defined in dt and
> 2. "disable-cqe-dcmd" is not defined in dt.

Both of these DT properties are defined as common mmc DT properties,
so the above isn't really correct. Please clarify this.

Moreover, I suggest to update commit message header into "mmc: core:
Extend mmc_of_parse() to parse CQE bindings", as I think it better
describes the change.

>
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  drivers/mmc/core/host.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 105b7a7..efb0dbe 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -319,6 +319,14 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_NO_SD;
>         if (device_property_read_bool(dev, "no-mmc"))
>                 host->caps2 |= MMC_CAP2_NO_MMC;
> +       if (device_property_read_bool(dev, "supports-cqe"))
> +               host->caps2 |= MMC_CAP2_CQE;
> +
> +       /* Must be after "supports-cqe" check */
> +       if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
> +               if (host->caps2 & MMC_CAP2_CQE)

Does it really doesn't matter if we set this cap, even if MMC_CAP2_CQE
isn't set? You can probably skip the check above.

> +                       host->caps2 |= MMC_CAP2_CQE_DCMD;
> +       }
>
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
> --
> 1.9.1

Kind regards
Uffe
