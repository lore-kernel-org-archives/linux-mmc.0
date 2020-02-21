Return-Path: <SRS0=+wZv=4J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC502C35659
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37C124653
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 14:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUMUWH+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgBUOeM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:34:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33403 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgBUOeM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2020 09:34:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so2442216lji.0
        for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2020 06:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qE1ZprvNAQZEaedKCgeg3ifr2lhMX5FFSbIkCacp4Kw=;
        b=DUMUWH+o5xdEn4HR/SntOIZf6pWK2WCRJo9GDytRJlf/wRrfthg3iixysSl789z7QV
         cWt75Jm8nDTe+v9ctDDtSdF0l5ln3hu7YnDUgIww04Q1jOLT3LlEJY5Np7xnnDm12q22
         zMtcwL6aW4EdhmjVpuhoKoluw2mZk8ZlFiPs7NXZpmM1yCzC0wVB0BH1b3EG4rqRqa9C
         pYVGdEP1BZ1xifOB1yzVdKi9iSVyJh2LWc8OsI88wTr7ivb3LyFWFFC5WkJlQ9bnDKOI
         Tv60UO/1LRXTVVXr8nBzNDWO6d8+PQniSdcEiO/19AcFYSeICRQ7COilyc6YYMi1QnPa
         y2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qE1ZprvNAQZEaedKCgeg3ifr2lhMX5FFSbIkCacp4Kw=;
        b=b+eyElg4+rFnbzYEciffl5TcHV7mpAP6QsreX+ok0DFeGQDAsrUuIxcV+hiUiJjR8G
         V24ear/YOkzSVKZSfDthUtVtjtmO3gGYCO49r1vtzvZZVwucwH6LCJ7ugK95qYe+ulHD
         hLHXevjQgtyGKOUtQj7Vs61JBB5HI87YC/0qsOQw4SpVM+pmfaJXbnhitGiU3tYKUfdM
         60r7X1wYEpYz+5P1wm+69mgu163broSALC9int9u1i6CRyX72AMYh0ZtgMxuQ4T1B9kW
         G8oyq4z6KOijOeoDz2uRsKmcgKV7L2c+jcVMp1je+bwqzB9dang71hYtU1JGvDz36M99
         hY3g==
X-Gm-Message-State: APjAAAVH7aQT++Fd9kWWopdgTdzXpE1S7DGf0bvwCD12Z7PdIoafcfB6
        DFVq8aWYghgTDYvSsXPQ1JdtvXZwBH7qVH5SxoRflQ==
X-Google-Smtp-Source: APXvYqw4oSVVlShPCelo7IGnTIlbPgsMGxvB5xli1PlMp8bLrG3RvR3Haq1OJ5idjUHugDKxC+iAjv/NG+M/2+LLAR0=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr21749572ljg.168.1582295649418;
 Fri, 21 Feb 2020 06:34:09 -0800 (PST)
MIME-Version: 1.0
References: <1581921111-24172-1-git-send-email-chun-hung.wu@mediatek.com> <1581921111-24172-2-git-send-email-chun-hung.wu@mediatek.com>
In-Reply-To: <1581921111-24172-2-git-send-email-chun-hung.wu@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 15:33:58 +0100
Message-ID: <CACRpkdauCe-zAcsO5q_79+Ux_a2=bktA5UqKjWs4XdBJZ3wWeg@mail.gmail.com>
Subject: Re: [PATCH 1/4] [1/4] mmc: core: expose MMC_CAP2_CQE* to dt
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
        kernel-team@android.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, wsd_upstream@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Feb 17, 2020 at 7:32 AM Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:

> Expose MMC_CAP2_CQE and MMC_CAP2_CQE_DCMD
> to host->caps2 if
> 1. "supports-cqe" is defined in dt and
> 2. "disable-cqe-dcmd" is not defined in dt.
>
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

I don't understand why this is even a DT property as it should
be clear from the hosts compatible whether it supports CQE or
not. But it's too late to do anything about that I suppose, and
I just assume there is something I don't understand here.

> +       /* Must be after "supports-cqe" check */
> +       if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
> +               if (host->caps2 & MMC_CAP2_CQE)
> +                       host->caps2 |= MMC_CAP2_CQE_DCMD;
> +       }

This is the right place to do this I suppose. Disabling CQE
selectively is something you might wanna do for debugging.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I see that some drivers are already parsing this DT property
on their own, should we follow up with patches so that these:

$ git grep 'supports-cqe'
drivers/mmc/host/sdhci-brcmstb.c:       if
(device_property_read_bool(&pdev->dev, "supports-cqe")) {
drivers/mmc/host/sdhci-msm.c:   if (of_property_read_bool(node, "supports-cqe"))
drivers/mmc/host/sdhci-tegra.c: if
(device_property_read_bool(host->mmc->parent, "supports-cqe"))

Make use of the central parsing instead?

Yours,
Linus Walleij
