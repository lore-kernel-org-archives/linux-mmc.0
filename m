Return-Path: <SRS0=ACzm=CR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379A6C43461
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F366920936
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMZXE0EL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgIHRn5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731656AbgIHQOE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2020 12:14:04 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CBAC0619D0
        for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2020 06:53:58 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id q124so4066964vkb.8
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2020 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+RHY61MbwHUN+JTzO3lIufg7DScFPibKdsAs2vpPFs=;
        b=OMZXE0ELFn/5UeXE5Sdyi+rvYzQOT2CKk2y0rX/WgCjXlf2C20yNbQQVRIFfPLSDcM
         Pw94LjX2xcoFi+vqpTAYDBBXcDW16UAM+bj9pWPL9VKZeZeOo938fNgbVpK9cpSOmA4/
         5LehJqqiksA6xb7P1tZNMtiWsNskWYBd/7MeKhpF3qTyRpPteIq5LwsiIQ69qb6tFzo1
         yk3VS0JKYpPjBrPiSIlWhin6wJmffPTsrwehlOxvcBP1IvdH5unTOrZEgOcvBl4mq2NC
         VG0mPKMzsPillvGRZXhkpyjMZtpMpKawTuXnAIGDd4JuM/892WGzcHTL2mVwz7LrsXx1
         SFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+RHY61MbwHUN+JTzO3lIufg7DScFPibKdsAs2vpPFs=;
        b=NOUFzOhZxZeR7+4sx4PeTZa4soqtOKxwy20+h3Utj+apVKoetz4TkMT4nkkX/VR+DF
         z+LxQMlgEkjPcVDMyaOt++NlQyjv651cseq/LMreGGnxXoqdHkDL9JBN83cXMVfRHT7Q
         3JMy39YP88wBtJuFQOR3KUyvUUso6AuOt3+ELM64Pl1Ok6GrQGe49vO+4TQnbRzEeSLS
         BCpxwYLkZoNidLnuDdDpIWm0JXqKj55HPadx+0wB2h8PhhO/CEYVGJXdwU1Bq5MXuAKA
         tR13vEdf6kY8suZtN3WMDioqWmNHcB3yv1kgYoQ63OF2qy8LIH8ls8PNzFXm6Oz6rDQ7
         698A==
X-Gm-Message-State: AOAM533GskqrlpSV3pfpgG76CT54MNwZBCx8wJjdM+eyFwKhfn3upC0s
        dC8QkSBVjR986FIkLy8a4hJf+kX3obu8nwgZZDS28LXZPltzKojj
X-Google-Smtp-Source: ABdhPJznQRp0A+wqCEqrqZaEDdoP2cDcKRmw10gXIH0FlDFfEfIEzvFyZJnfs4mTgdX4ERfy6dNeuBEXVvmpgROoMdQ=
X-Received: by 2002:a1f:16d1:: with SMTP id 200mr15128572vkw.31.1599573237594;
 Tue, 08 Sep 2020 06:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200907105254.31097-1-krzk@kernel.org>
In-Reply-To: <20200907105254.31097-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Sep 2020 15:53:21 +0200
Message-ID: <CAPDyKFowS-psoJqVUChU35Xp92nrvH5r5eY=_8bMKU0SVBxLcw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: host: Enable compile testing of multiple drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Arnd

On Mon, 7 Sep 2020 at 12:53, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Multiple MMC host controller driver can be compile tested as they do not
> depend on architecture specific headers.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

It seems like this is causing build errors for my next branch when
running allmod config [1].

[...]

>
>  config MMC_S3C
>         tristate "Samsung S3C SD/MMC Card Interface support"
> -       depends on ARCH_S3C24XX
> +       depends on ARCH_S3C24XX || COMPILE_TEST
>         depends on S3C24XX_DMAC
>         help
>           This selects a driver for the MCI interface found in

[...]

The problem doesn't exist in linux-next, since it has the
corresponding cleanup/rework patches for MMC_S3C from Arnd.

To fix the problem, we should probably remove COMPILE_TEST for
MMC_S3C, for now. Then we can add it again and send it as a fix for
v5.10-rc1.

What do you think?

Kind regards
Uffe

[1]
https://kernelci.org/build/id/5f57413db10918c9bad353a5/logs/
