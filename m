Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF47C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9719E6108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhEXOMc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhEXOMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:32 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AEBC061756
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:04 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id u188so14295929vsu.8
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nHMt5Ue9zcAFsiS+aG2J53afQMewVgUVGCQ3OcSmIaI=;
        b=Ryx3qKevd+k6W5Rnks8NZAaKFLqZKWhCzg3LO95PFdvL7plkQSxQSYI8QUCAZ/eV1D
         IrS5pjnLv0KwovhGAEXepNyntb5RkHFB9Cqha8kBuzeX4H7c9RwltcUTrT0cJtKIeEUJ
         2tX0gBs4+Wb5pMNe7dQJyCaNwdqmnBppftQe48v2y6/xAcfYGYtDxBWJm9TWi2gUaiN4
         t6waMXogKzFIhF+6+Q7HA7LdPD5IlAK1sA+I/0FwER/k3NNXAhMsCL1eReHOfQj7Lqxx
         BVYNlnOic2o+abxb9MdxL31D00gWF3lCgFQsS1B7jvAWcBkx9cw4HAkKtcev55AFaEBE
         UzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nHMt5Ue9zcAFsiS+aG2J53afQMewVgUVGCQ3OcSmIaI=;
        b=YiAq+cychlkvRbtWbw3vYA8KRbGD5HsBHmncOyMbM9X0jiL6S16biYifosR+I8f7Kx
         Dm9mSv59HYHF2hzXImZ/ulpo9M9eKqijCONxlnCVancPsTIa9uuuerT74IwhUl3wZo16
         lUxhaD51YFx8I7IWNLwRaODGNNw0PKP/WJdYVlzwFLc2qFY64m2cgHhXsauCNJC1K0Nh
         GeiTvfv0NhE84dCak8vTqziDgh5KYZpjM5+KGxCErum8z5rSkwMDg7WN7AOUr8HkYhls
         RPbHmsZAYiya6jVbYHuGw6FOwxpPHu5LzLjUivnVUDa61CPlvn7kqvE474JPnInlYDSJ
         n4Gg==
X-Gm-Message-State: AOAM532UP3J99ic5Wl9ZnE5lwIhw+CSPlZ5tiHJ4mN4SktZDGIgF8H6p
        ctlvgutNwvI6TYsBTZTvk5XYqViHn6zhqFY8Q5XFpQ==
X-Google-Smtp-Source: ABdhPJwZWT1murqq4tYSjwsKyhu/eVCjhOyZeUmeeUfmlUNfeNGcgWIUriES6cC+bDh+rWS1u7k+V+I7Cs/PFPRhcm8=
X-Received: by 2002:a05:6102:7d5:: with SMTP id y21mr21664208vsg.19.1621865463713;
 Mon, 24 May 2021 07:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210510190400.105162-1-l.stach@pengutronix.de> <20210510190400.105162-3-l.stach@pengutronix.de>
In-Reply-To: <20210510190400.105162-3-l.stach@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:23 +0200
Message-ID: <CAPDyKFpN2L+KxbPXA_mKQrFrB9Rx8keEbH-57NdA77L+qMTE3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: core: add support for disabling HS400 mode
 via DT
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 May 2021 at 21:04, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> From: Lucas Stach <dev@lynxeye.de>
>
> On some boards the data strobe line isn't wired up, rendering HS400
> support broken, even if both the controller and the eMMC claim to
> support it. Allow to disable HS400 mode via DT.
>
> Signed-off-by: Lucas Stach <dev@lynxeye.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
> - move to core
> - actually disable all HS400 modes
> ---
>  drivers/mmc/core/host.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 9b89a91b6b47..0e066c5f5243 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -351,6 +351,9 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_NO_SD;
>         if (device_property_read_bool(dev, "no-mmc"))
>                 host->caps2 |= MMC_CAP2_NO_MMC;
> +       if (device_property_read_bool(dev, "no-mmc-hs400"))
> +               host->caps2 &= ~(MMC_CAP2_HS400_1_8V | MMC_CAP2_HS400_1_2V |
> +                                MMC_CAP2_HS400_ES);
>
>         /* Must be after "non-removable" check */
>         if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
> --
> 2.31.1
>
