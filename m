Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF0C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 11:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BDF20758
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 11:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MMEL6u3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgERLYN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 07:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgERLYM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 07:24:12 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04DC061A0C
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 04:24:12 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w65so2656383vsw.11
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7CNGuSvmlN/mZ3+PC56eLzxn16Sb0bs4J/OSo5A77s=;
        b=MMEL6u3Oyr2eMmb5M8Ql70ZijNgMaij9WLERoRLPlGr0nV4BupQxdD5MCmVT1HkUDS
         NycCfUjWTfhY8gubwN9NkKiMWmADn67wlWxa3baz90E8QBEfhmRy7SmDN3/PAzI60+dN
         tUZXup6CbYHE2vW64HmNSjGbBCUYaX2Uzi3mfdMOhilOoo06gOyed77iLxy07Aq0Vhhk
         ln6Qpsfeb5dlmGQTKzImBwOqNHh8ma9fVXXcrFc0TnsZBFrSuMSXnBl0XApWlWjgRqa0
         GUXR1V/rJirsxiA011hxcE+o9SNJE/20oZvks3W0DA7uM5OqYo4xJoNfCG0hRrN6LCt/
         un7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7CNGuSvmlN/mZ3+PC56eLzxn16Sb0bs4J/OSo5A77s=;
        b=k9OMV+u3jrRPFQccR+zD91S4sU1MiyG6PlNBY6a9SbOKrFGz7RDS60k53O31aXeR+1
         7coHPOwv0JFNFZy+Y0StRM2P4JKpJvm916ZcMXSEQNfiZPh1xBnwiqAl9Eu+oxvUkEV2
         q/ZKWWIX+9fPbhXtV/3niiK2XJkX8r3yarBxF0GPDHC/KC0MBdXZxR/a6LqfgvFJgCrM
         5Sa0R97BCifLTxPqAfNQ7K/h8LoaW7ULPbkAVe02jrQhAQiBjD4Wm8N3fB//Jc8o/FFK
         vCFcfZ9kr4mIwZt2cc4hWPypqwS3sE5Vg5GggGo36pNL9vli79CglrCf5wh+P1f2+SJ/
         gQ5g==
X-Gm-Message-State: AOAM532Mvi9KzOPrv9PDAErf0Dyl9t3irGyYKHXXRX6TrymlPtsa8FL9
        VFZHS79SjzknMg7gCJnTsUalbYP5kbThWxfUuu54lg==
X-Google-Smtp-Source: ABdhPJyzC3tnGJgyZXvfGsSARscfaytWT/0yOaKkvSkAwSjHcB3KlbPsGKVK6Pedty8puv6PmgDF6f5xxea+4Iporrs=
X-Received: by 2002:a05:6102:5d6:: with SMTP id v22mr9047005vsf.191.1589801051465;
 Mon, 18 May 2020 04:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <1589527703-19108-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1589527703-19108-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 13:23:35 +0200
Message-ID: <CAPDyKFpSQS4bQ1todUD_rcECJS7+wiMmMkFW3b_PDy5m36Rwiw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: add HS400 support for i.MX6SLL
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 May 2020 at 09:38, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> i.MX6SLL support MMC up to V5.0, which means support HS400 mode.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 38cd83118082..d770cb0bf78b 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -215,6 +215,7 @@ static const struct esdhc_soc_data usdhc_imx6sl_data = {
>  static const struct esdhc_soc_data usdhc_imx6sll_data = {
>         .flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
>                         | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +                       | ESDHC_FLAG_HS400
>                         | ESDHC_FLAG_STATE_LOST_IN_LPMODE,
>  };
>
> --
> 2.17.1
>
