Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7071C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Feb 2022 15:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352889AbiBHPM4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbiBHPM4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Feb 2022 10:12:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6F9C061576
        for <linux-mmc@vger.kernel.org>; Tue,  8 Feb 2022 07:12:55 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b9so33870397lfq.6
        for <linux-mmc@vger.kernel.org>; Tue, 08 Feb 2022 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2+GjzePMFpH5F944i8QOqtHOHuiYTriOX9rD5i+Mws=;
        b=CCldQERGrCvjQn5prWyMGA1XEKEW6SlWWAaXNhd7pkglCcsjtbVcmreyYaIM3JRU9j
         kzk2Vw2WL5thyTjoc3WD0CQqbGvg3PKeTzSv0YKVWdDaPFH+Cv/zdLacQ+656059qxEr
         02eooFkw1Fu+hgpYEBviCX6usGPrpmARJXS5MtCDlIzDstS/xHJx3T6Za6DFTU5xR58q
         Syqh3/QfMiLIdezUQQR2WQ5B2k8psty8U+PwTzVKYHreCXIGf8GTHEANiqHMaeOdUtuz
         weE7yf3pFibbTCQL55PMQLGuX6xHedTNwMa0iyzP5/HstY7f53Ar5jfluhPmsrEDpQ3l
         tU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2+GjzePMFpH5F944i8QOqtHOHuiYTriOX9rD5i+Mws=;
        b=G2mik5pW+nKh3BNEkwW2C6YqksAO5cub7Ds6qrBzL1N9FLKLWpf8XyOMne8Yf+oEfu
         NyLeAjpD+79LQrMXwBf3O2DDL4SFrh6QLztEzlKsICHHHuXii3QnYRu0sEFY5nzjVZXl
         4lTcu0laadQPG3o0OdGdS7fAMa4VDpvXB5GEoMZuU2lMRpJH8MxsroOr9kRt0/+m2vAp
         s1T1YGoxZkYZjSS0JunNnT44oWW942e59C9Md/5DUAHCtVBosTe8w2RS3BFBfu+X/j3m
         Z6r79h6VHEvhU0BPEmKGwdeIia2OSSytivZTiUP0SK2wq+dy7exb0aNoybZ/AxWF62I8
         HORw==
X-Gm-Message-State: AOAM531di+y157PMUvzWAOcbeL0SPQ91H5Mbk6eG4xjHd6zVb9TM3EIq
        3SIcISwTjZp9bQ4NAoFiGbaNm8MQIwTJF5sqvflOyQ==
X-Google-Smtp-Source: ABdhPJwhm+nC6e2kePHoIEaRqqooZpIwL78JW6X7AsmRxvU286v5l6BSxZS1fegs8BoD3N9IXlW/J6k8YKCiTPMT5kU=
X-Received: by 2002:ac2:5dcb:: with SMTP id x11mr3273145lfq.254.1644333173813;
 Tue, 08 Feb 2022 07:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20220202180648.1252154-1-huobean@gmail.com>
In-Reply-To: <20220202180648.1252154-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:12:17 +0100
Message-ID: <CAPDyKFqDk3Jik5tXoKNbQijZTd08nTcHgv_Z-D2DbV_TUM+76w@mail.gmail.com>
Subject: Re: [PATCH 0/5] Use of_device_get_match_data() helper
To:     Bean Huo <huobean@gmail.com>
Cc:     Eugen.Hristev@microchip.com, adrian.hunter@intel.com,
        nicolas.ferre@microchip.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Feb 2022 at 19:07, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> *** BLURB HERE ***
>
> Bean Huo (5):
>   mmc: wmt-sdmmc: Use of_device_get_match_data() helper
>   mmc: sdhci-tegra: Use of_device_get_match_data() helper
>   mmc: sdhci-omap: Use of_device_get_match_data() helper
>   mmc: sdhci-of-at91: Use of_device_get_match_data() helper
>   mmc: davinci: Use of_device_get_match_data() helper
>
>  drivers/mmc/host/davinci_mmc.c   | 6 ++----
>  drivers/mmc/host/sdhci-of-at91.c | 6 ++----
>  drivers/mmc/host/sdhci-omap.c    | 7 +------
>  drivers/mmc/host/sdhci-tegra.c   | 6 ++----
>  drivers/mmc/host/wmt-sdmmc.c     | 7 ++-----
>  5 files changed, 9 insertions(+), 23 deletions(-)
>

Series applied for next, except patch3 that seems to need some minor
adjustments, thanks!

Kind regards
Uffe
