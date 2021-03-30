Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E8BC433C1
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 10:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7932C619AA
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 10:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhC3Kpq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhC3KpS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 06:45:18 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE238C061574
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 03:45:17 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id b5so7869616vsl.9
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrP51yULiHG27SeEXJDFbTG58PKXRH+WhzM+ZrVVbzw=;
        b=XBn46g9AsX4KNUkiKNMCAHxQKzR3/PDY/ubXJQov8rSYHbVI+zQh8cT11T22S2Rwn0
         HhMLUvF6bmJ5J8VbV4QQUZiu3E4A21/5NDrBY4+eAamDR3UlL/cstlYOpG56CzkI7D9g
         1aoz4SNAW5Ze9gMKyhyBiE9aLGISNIKCCsVkf9dYgGBxelrs26nYyd7qlZYmQ1TLfLhA
         0TTrE3jpIPTDJtc6q8FQCXi+p3nQjZwQ7HwFtETf9Pl+7n0x07bJRlDjQqlj/Z/gB+53
         Yf63W9o/LgpbmAFt4jM3odJ1jjh5W7DUSGikWb4l3pL8e/pikTHjE1FdSKtobHI500Ut
         7zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrP51yULiHG27SeEXJDFbTG58PKXRH+WhzM+ZrVVbzw=;
        b=swSchb0E3Z298OsacH16C8tQF1cxYVvjSLZASiEMExmHWxlxLu+lycnPC8BxD0BxwW
         rKWw56Ty1BqgFpuIqQUqVF24BInkJ9Q8JWn37q+QNrlBYE1TQpFdZ9Ja+1ooC0OhM+k7
         xj4rC13qleJNtx5bysSonSKvlMKU+NYDppQwNd25pRs/4GmCeWYoYVoRnbxf8Q7QXjlJ
         O440u+5fPcuVLiSxVO0cchVEMqXPM1ssNr3CxFhXcnl3o8Jtjdi7QHJM1cOHOCPe4BFJ
         G6T3unYmkNw/bhfEXlpuB4UsLcLn2A2F3DAcmhdoSWTmag/pj5/RGW1RYPzpuvSm68yO
         dAPw==
X-Gm-Message-State: AOAM533F2+sQBwYWx+ZVJcQ40r6TWsN7WI13KYhQpVFbmhzkp2wMzJsf
        gi8Q4knAVDHRJzgDEAHTkRBEMNRTgeH5mn0BRwhDzQ==
X-Google-Smtp-Source: ABdhPJyU/ZLT8FCbPEzLuXWbGCHBJ/uI6+dgGhldthovHGOf5d1xr2PmlFG8gkEsO0GDTPPt6bc/waT2mzHA3lRDsug=
X-Received: by 2002:a67:77c1:: with SMTP id s184mr16252854vsc.55.1617101117087;
 Tue, 30 Mar 2021 03:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210326110214.28416-1-shawnguo@kernel.org>
In-Reply-To: <20210326110214.28416-1-shawnguo@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Mar 2021 12:44:41 +0200
Message-ID: <CAPDyKFq2dQ3zpwgxeekHoBQyeKOOAr8aAM_7dRxasWt2fVgC5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: separate 100/200 MHz pinctrl states check
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawn.guo@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 Mar 2021 at 12:02, Shawn Guo <shawnguo@kernel.org> wrote:
>
> From: Shawn Guo <shawn.guo@linaro.org>
>
> As indicated by function esdhc_change_pinstate(), SDR50 and DDR50
> require pins_100mhz, while SDR104 and HS400 require pins_200mhz.  Some
> system design may support SDR50 and DDR50 with 100mhz pin state only
> (without 200mhz one).  Currently the combined 100/200 MHz pinctrl state
> check prevents such system from running SDR50 and DDR50.  Separate the
> check to support such system design.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a20459744d21..aa45901325b9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -434,10 +434,10 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>                          * Do not advertise faster UHS modes if there are no
>                          * pinctrl states for 100MHz/200MHz.
>                          */
> -                       if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
> -                           IS_ERR_OR_NULL(imx_data->pins_200mhz))
> -                               val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
> -                                        | SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
> +                       if (IS_ERR_OR_NULL(imx_data->pins_100mhz))
> +                               val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
> +                       if (IS_ERR_OR_NULL(imx_data->pins_200mhz))
> +                               val &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
>                 }
>         }
>
> --
> 2.17.1
>
