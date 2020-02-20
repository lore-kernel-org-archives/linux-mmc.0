Return-Path: <SRS0=5xTW=4I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D6CC11D00
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 08:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D070424672
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 08:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMxSsnCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgBTIZ0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:25:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39407 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgBTIZ0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 03:25:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id o15so3264259ljg.6
        for <linux-mmc@vger.kernel.org>; Thu, 20 Feb 2020 00:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tW5HxOwN772Tkfp0QgE1JQ8OvzEXP4upbTi2MYtJoUI=;
        b=fMxSsnCn71aFU7h3HzMp0QrwO3SDmXFY3My+n8cBUP6Qj1562mZ1VUyesNxaq+z0U9
         R0/fVkXjmppUN5Ue8o2GUeuFvnFfov18O5sT2x5GhF2cOBCIF23daV928xZY2TJh1UVK
         YSqdFQ1tNHWVbgnFzC2SyCCAhJPzOlXxHt1BRw6TMOeIdaxJHnP4iN6qGbvhQsDcEDa3
         kTg9e++AdEGguQ0lRrrQBMqbQcMtrJpHYRRMXF9lO1/8I2d9kfCgc2QDupERFaWVlueO
         2kMvYnlxKXGddt/w7mXPvxWH4BslWBVOFH6qj6/PYqXnJVF2zpwcH/PCe8f5LgTKUzPu
         acYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tW5HxOwN772Tkfp0QgE1JQ8OvzEXP4upbTi2MYtJoUI=;
        b=oPhp4A8IjI/kaN4RUEKcb5rXSfrLEAB+fFDbTlnq/kAyEA1rojMBnHQB45FILd+Uyy
         gIoTIjWwG6dqeXMCyfvX1sWw+Op0DGjAPCZokqKXLrYMswPu4M4oLHPhNAZzl7Sx6Zw7
         wqekG3wxwOTCCzODSL0yVws9Fa+gK+3P/03rv6trLmuRRFWv0IPUeNZ/i9O18nikt5q+
         wj2+cA+9qzi7JqbBZoLFXUatR+7lkMCtvqxC12M5Y/LaRKuQkSsSyb8g/uhsG8Ff4oB0
         /KccSKPfsVHDaj+xbV2ShHsim5eVgLFpMUN8bgU8S3fIyKxgXHYdrvaTYiuynqgPmBey
         z3zA==
X-Gm-Message-State: APjAAAX0oFF1N/XH/7viZjuquNqp3mefmj513fpIakRg8s4IGXxAfOFI
        oYKXDV6MtLsy+JWU7xEvj+KFviTrLKu9qE19qh35CA==
X-Google-Smtp-Source: APXvYqyZYfoPEuR0zLtVy2GKzhlKvWhompK7c9Vl198fJZZPzMto6qnbPr62IGWpMUeHcbLsAVVspnLiOBTlLO9cV6M=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr17550251ljq.258.1582187124354;
 Thu, 20 Feb 2020 00:25:24 -0800 (PST)
MIME-Version: 1.0
References: <1581324434-30903-1-git-send-email-haibo.chen@nxp.com> <1581324434-30903-2-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1581324434-30903-2-git-send-email-haibo.chen@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 09:25:13 +0100
Message-ID: <CACRpkdbOHJu9FUOuSjGH79QCXfJ+YDJmT57gxFpVFx-Nh_t0Ug@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] mmc: sdhci: do not enable card detect interrupt
 for gpio cd type
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Feb 10, 2020 at 9:52 AM <haibo.chen@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
>
> Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
> we also do not need to handle controller native card detect interrupt
> for gpio cd type.
> If we wrong enabled the card detect interrupt for gpio case, it will
> cause a lot of unexpected card detect interrupts during data transfer
> which should not happen.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
