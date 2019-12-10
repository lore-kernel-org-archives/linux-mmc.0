Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE21FC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FEB20663
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dj4UkYHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLJX0A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:26:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43043 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLJX0A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 18:26:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so21820434ljm.10
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+NAFHOECjOm+Of8S34hcanAlNHlaaf7f+qO55JvC8E=;
        b=dj4UkYHwPC6f6tJS86iMrxRFAEo7gzf5kG+EbTA8q3vlRjVNOJzeDa1Iy4p6aXcpMM
         XMfHSUSQXe3U39THlz6cD8C7c36jHBUxsKSogdTkkc1lGW7X3pBJX0mizwm77jnZk3Ur
         S0jxbByHy/mPwzO2tRlJJteYENVYL8zCQEUy/hGEalNIgIzrdN6E+dpWo3N0Mq29Ntf0
         ytaVGryKG/bwsQdZYZBHI4vwWr+1ZxpuJGUfSNxjEtxraaxG02O2lqoqCPtgRfLBQEl6
         xPJOUEBAxPFjZ7cGLiPjUqForYHFL55XrzzUAzkXxC4YjOzwhHHMka8096M/a8Rvt1fT
         a5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+NAFHOECjOm+Of8S34hcanAlNHlaaf7f+qO55JvC8E=;
        b=MG/UCTK4RPGrHsA1sIChwFiRTFWglh192NW+H1o4Xjec5uPof8DTVf+k5syKaGR0nO
         0s06ik4TcInJu3pFvq9buXH6/2U6+pJRwWsOJH7ngROH7/6uRjfzqUbDLKFPKtKlAoXQ
         Bbl5/PRbXoiCt74mjYlqtHMtqv3upIbxL2APvECysxkgC2aUQxsDV5JKazedTus6guPk
         6efokW6LkPM5dYjR3OnCsR8JPUfk1WEHU2DRVtx1i818cDm6WfsKxEOjhZH1cGpOPvF9
         1rEj6sN+Gf6yE6rx/3YjR3/QprcVscMLIYh0IABBo21/Grzpr7+PyBDVMMMzZ1KM3VE5
         e6Ag==
X-Gm-Message-State: APjAAAWHVpS5ncA2sw1wz40ZJwqro5B6FJvjzw6/41dpBwkwy40p7H4k
        lELRYruwwNaDAUWxjMbiJxKIVcwyol1/xYDh+AVHRg==
X-Google-Smtp-Source: APXvYqw+XB24h/jKt0LN4UAyUEz5C8VQC2M455Sn4P/xnPPSA99WQqQEPjRZulWyWNRjxOMFfBi7AI3Ma68A1nTSwX0=
X-Received: by 2002:a2e:9ec4:: with SMTP id h4mr22396271ljk.77.1576020357623;
 Tue, 10 Dec 2019 15:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20191203130120.11511-1-haibo.chen@nxp.com> <20191203130120.11511-3-haibo.chen@nxp.com>
In-Reply-To: <20191203130120.11511-3-haibo.chen@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 00:25:46 +0100
Message-ID: <CACRpkdawz5TedRTwSXgcNyD+uZ3znqxRm54_J9Jfn4T9mNJ8uw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] mmc: sdhci-esdhc-imx: no fail when no pinctrl available
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 3, 2019 at 1:54 PM BOUGH CHEN <haibo.chen@nxp.com> wrote:

> When using jailhouse to support two Linux on i.MX8MQ EVK, we use the
> 1st Linux to configure pinctrl for the 2nd Linux. Then the 2nd Linux
> could use the mmc without pinctrl driver.
>
> So give a warning message when no pinctrl available, but no fail probe.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Wow what an exotic thing.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
