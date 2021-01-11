Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A24EC4332D
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E080622CB3
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jan 2021 18:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbhAKSHc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390107AbhAKSHb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2021 13:07:31 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A157C061786
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:49 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a31so116891uae.11
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2021 10:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ceLUFE0xEYsyzIqgA0y0vAyTYpccrGoaC3NMKTv7ZM=;
        b=aaQtCTIJrOMGeByW9fyp87whoUutWwkp1LIX2+WpLuWMO1X32PJf/oR7ZM31rx696q
         53iLC8f7Gu1XUDzvB/FWcuTJEJGTZWEa+LQPn3Rre5m9cjdhIlcuHu0tBj2bRRwmwhli
         XjLbtDPmExf/ezMfJU2bgsgB+Bg72SvU6BJ2nnKebJq+IuP1uHySQkl9hDmrMHMZEti6
         da9eApkw18w/RRlozBpAhEnw3o5Rl6q7UMvuhPNkhDUaKnE7NfuNfQ4DUUjj/aRCCzod
         zk7q9Wd0qNYI1XrSFAsSKFLpGrfrh9GaISajnl1PV5QgoZnLoc8Vbs5kf2EN65qaGZa0
         D1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ceLUFE0xEYsyzIqgA0y0vAyTYpccrGoaC3NMKTv7ZM=;
        b=R5iN/e9kgrv7sOFKrjHDqHWp2BhohAL2Q6POJzcTuGqMdZ1lUl2zrEzJ62ZdzELr1I
         yYAhxCiZGR9jHW6lK199e8SRES/3ya7boEqyp508SfHtfcvDyD9g+DfWJv6Q7PqAeJLP
         +SZRpLNf/5zbKrLrU1AWwCnXS+4o5gEIOTwC2VLiWnGhX9qrr0JQdfQUyJ0DeN+Y0g5L
         WRO/vWNFCRYaqK2m+UedAzGOxdJajjQwU+dcQzZX5a06bdKNVWbdl7bOjsQ39z8uqi+P
         amAkf+RbAJfLRw21s/+n+e72/ev5Tqt5HVN4dkHVqFpmEu06IOOlkjrbThg5Y25qJku7
         4Elw==
X-Gm-Message-State: AOAM532rszSl+1TXj4yGFO2aLtZoXcQ/VBWuDODdDEK8lbBndDCt4h3N
        a3r2F3WNxfBOmOmPUZI1IeNu3ncXNyCL4kx6ERiZjQ==
X-Google-Smtp-Source: ABdhPJwlJ/IQ+m0K7SGd2Bs6vVItjRMIJWrTqC0VF25endRRivF7KO62s7TsSEBjHpe3QFAa8ctUWKXl9J25CaeqZb0=
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr718845uaa.104.1610388408471;
 Mon, 11 Jan 2021 10:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20201210165510.76b917e5@xhacker.debian>
In-Reply-To: <20201210165510.76b917e5@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:05:58 +0100
Message-ID: <CAPDyKFri-WMWeE7HOQRFipsyGiqttRmM2agNP5-_VNk5W0k75Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Dec 2020 at 09:55, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> The SDHCI_PRESET_FOR_* registers are not set(all read as zeros), so
> set the quirk.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4b673792b5a4..500040253de2 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -87,6 +87,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>         .ops = &sdhci_dwcmshc_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
>  static int dwcmshc_probe(struct platform_device *pdev)
> --
> 2.29.2
>
