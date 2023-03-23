Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E58C7619A
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCWMNV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCWMNU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:13:20 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E612F38
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:19 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5416b0ab0ecso391102917b3.6
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B16rkBzYZJZIfz4nN7+PWbHREgEhvwGKHJmdyTrsREI=;
        b=k2ifNPIw6jZmT+vxBj0rBix73jWXTZN0h3AfOkyQHtFhSj3Jj7elh66U0cUmGaHAVn
         t5hitmZqnDNjc4UPFgGDaeFRJZD/9XDdqVT+DR2641WqEwrs6DIIwJGLZpDJBB1qQQEL
         0NRVIxt2nJaZypantK+ZzS+7GC4oCxKKp8jv12uGWNRsziJaCicZbicbbFRPb11z0JDu
         mua2IKj+YxkIZw199HF3xCKfkprYAynziguTCiPuBYgEKwRoca1NFU98pbijFpelDj3E
         XdqpNIx9rpwBamToMFg/YQB5WLidhcaVs8GvvUWK/KLWs7O2Wu3vo6noUzL0Udo/xe9X
         hFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B16rkBzYZJZIfz4nN7+PWbHREgEhvwGKHJmdyTrsREI=;
        b=OKfV0q/7lvdchViUAdQfDVnwmiPRfEKkldV6o8rVUndpVGHwvxzJsox9U9DHIIhs/Y
         AxbaNIaxbptowakvH9MyeNADcyjTZeK+8TCSt3Tz9G1WkJtXspCoE5aeYZZk99CUkBJQ
         kX52fijBwKs2qK9wml4aj2dRAX3TdscDa57D5kpSCnyPP9gBTfHe01YF3Gad8YnkE50O
         2vh/vUXH4IBHM5Dwfszf2/uYMW7ykGA7wNeszqVcUBF/zqTJr9LUGBVRdDfm4NSy1NWf
         8w8z/2BaAbm4i9g4sw5+klrx7+GJx0WBmuVZWm8lA2++FnjZjDGlg2rzzgQ3AWSxpfAS
         pAmA==
X-Gm-Message-State: AAQBX9cqiGocEAtOFX1lNAzypdjsNXFjyzFw+TuJYcLMpOXOWMIE9/kR
        QU2KAkWQgiMoy26ikc21myKLlPSJe0QUJ1D0U5V/Kg==
X-Google-Smtp-Source: AKy350aFlkEwble08xseD9G21q1vBGsScCuffbA9Q9Buw614fzfZsHTiZNLse3rFreSeUsVuVKHGGdKSlsaz6Pn4+oA=
X-Received: by 2002:a81:b344:0:b0:536:4194:e6eb with SMTP id
 r65-20020a81b344000000b005364194e6ebmr1735646ywh.0.1679573598613; Thu, 23 Mar
 2023 05:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com>
In-Reply-To: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:12:42 +0100
Message-ID: <CAPDyKFq_P_7gzuH3c3TGhRcWfujFqP2KiEnbwevZYp9fW0nVtw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: add and use helpers mmc_regulator_enable/disable_vqmmc
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 11 Mar 2023 at 23:38, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> There's a number of drivers (e.g. dw_mmc, meson-gx, mmci, sunxi) using
> the same mechanism and a private flag vqmmc_enabled to deal with
> enabling/disabling the vqmmc regulator.
>
> Move this to the core and create new helpers mmc_regulator_enable_vqmmc
> and mmc_regulator_disable_vqmmc. Make meson-gx the first user of the
> new helpers.
>
> Heiner Kallweit (2):
>   mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
>   mmc: meson-gx: use new helpers mmc_regulator_enable/disable_vqmmc
>
>  drivers/mmc/core/regulator.c    | 41 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/meson-gx-mmc.c | 18 ++-------------
>  include/linux/mmc/host.h        |  3 +++
>  3 files changed, 46 insertions(+), 16 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
