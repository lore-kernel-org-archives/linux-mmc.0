Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22B6C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Nov 2022 12:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKIMfK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 07:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIMfK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 07:35:10 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37C175B8
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 04:35:09 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so16088300pgl.11
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2022 04:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qd8Y9+ZvQyujV+c7kNOqn/pafwGmFA/g0z8fT+IZK8s=;
        b=b7o3RUhr2TEWV78A8yoYn1p14+bpKqHwU1yslXxsOm4zRr+sVyfpGIIeQvLCDLWmkk
         Y+cORhnlTwtHjT28PauHn2Q+FWg7az4bbeRzlRVDVKlZPvMXhyAjIy5KZGBzl1j8Jkf6
         JtVGynIB80ZAvpORtcFOJw3vMetc5He7LwkkwZatVqShEuWtH7hi8cD9978EF4SYM6R5
         liZrTdHbgVIC0HbiMNvbKBwvJn9HPPWoBA2wI97MxKZ12hX75QKppyQQIIg//nh91TUn
         sC3Ab0Ysu8FnY2UfubSyJ4XGhZ5j9RQ5YoYQNncE48QpbZMkKdTLFm4IliitpkwlXSTo
         mNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd8Y9+ZvQyujV+c7kNOqn/pafwGmFA/g0z8fT+IZK8s=;
        b=D38SVc68blKoyHmN586hSrFLrWBrBfL2AIkhRIKgTW5uZ/NWDxSVYnxOFiet1wsJUk
         k57XD6VzUpdDIubRJU/uUn/VLdR7HIlx4Dfb1MGzH75hOetmyUJXmTyle2RYXMmNqiD3
         DtOAUgIheTdxU24QVR8epmL+U8lbmhD9iv17PNFQzpbQsI/NPgVcF1nNPIbEuVol5Y3f
         xU6ZoPBN+IkXG+J1AbmRnGk6d8cowp0ieo9iqgUOZ/5wQOt/uK9RdPJfaVI8VpsRQ6q0
         fSUsgwuuNxYGy4faEpZlVwsT6FbWqZsYwEGlrLIUR3h2iNqo8wlAVV1w3LcoCm413JZK
         7RBw==
X-Gm-Message-State: ACrzQf0lRiwk9WmJ7AIitQosBDF0BHlbhCNiPRqGvMcO0mmM72ELsYfw
        jcsqndKpVIxyBtJCx+p2DxcjGXb9rt1B5d4PYHDCrGMAlrw=
X-Google-Smtp-Source: AMsMyM7waVcPBRz6YwhGHKZ26QmVdDVR2JqrNRb4MBY+ymRVNTpRlX5qu6PUM8LOdDP+3a6JK3hyoPSUTopxZzcmMT0=
X-Received: by 2002:aa7:8895:0:b0:56b:e1d8:e7a1 with SMTP id
 z21-20020aa78895000000b0056be1d8e7a1mr1186186pfe.28.1667997308844; Wed, 09
 Nov 2022 04:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20221108122819.429975-1-yangyingliang@huawei.com>
In-Reply-To: <20221108122819.429975-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Nov 2022 13:34:31 +0100
Message-ID: <CAPDyKFpATHJuKa+jYyNtxk88nQy4aAa-H3fm-48era3Y5k=0AQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix return value check of mmc_add_host()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 13:29, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> mmc_add_host() may return error, if we ignore its return value,
> it will lead two issues:
> 1. The memory that allocated in mmc_alloc_host() is leaked.
> 2. In the remove() path, mmc_remove_host() will be called to
>    delete device, but it's not added yet, it will lead a kernel
>    crash because of null-ptr-deref in device_del().
>
> So fix this by checking the return value and calling mmc_free_host()
> in the error path.
>
> Fixes: 7d2be0749a59 ("atmel-mci: Driver for Atmel on-chip MMC controllers")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/atmel-mci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 91d52ba7a39f..bb9bbf1c927b 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2222,6 +2222,7 @@ static int atmci_init_slot(struct atmel_mci *host,
>  {
>         struct mmc_host                 *mmc;
>         struct atmel_mci_slot           *slot;
> +       int ret;
>
>         mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), &host->pdev->dev);
>         if (!mmc)
> @@ -2305,11 +2306,13 @@ static int atmci_init_slot(struct atmel_mci *host,
>
>         host->slot[id] = slot;
>         mmc_regulator_get_supply(mmc);
> -       mmc_add_host(mmc);
> +       ret = mmc_add_host(mmc);
> +       if (ret) {
> +               mmc_free_host(mmc);
> +               return ret;
> +       }
>
>         if (gpio_is_valid(slot->detect_pin)) {
> -               int ret;
> -
>                 timer_setup(&slot->detect_timer, atmci_detect_change, 0);
>
>                 ret = request_irq(gpio_to_irq(slot->detect_pin),
> --
> 2.25.1
>
