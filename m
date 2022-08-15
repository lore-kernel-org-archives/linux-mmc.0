Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95235C3F6B0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 10:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbiHOKWn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiHOKWn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 06:22:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34079DF4E
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 03:22:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d14so10017793lfl.13
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GYPvjChMzihllF6NfylcKZILuIvORrCrmYPLKfqT66Y=;
        b=ZJUkVZk00qiLqlltF3e13FEMFL6jQ4rjBe5u+0Cq8QogsebiFsttF1uFP0a3Fzcxu3
         WU4C3HF8pltxTojHnR2ipOjMWWZKP/1if81a7tF3ZHFiBrIh8RQZRGGQoYT1evgLXHZr
         /r1qd5uiX4A4TI3DMuvz4YVfvdneXM9UHEacGmn81S/cMlg+uYC8w9WQEuYdyYTyKNhU
         CbZ8W6TDYGQnjqhRoRKqACVyCQMm9Cr4UJfTNQT2YHF9QhaThyAdxYmq09ftfRw+hBOf
         IXORo02R23c5UQCLckfeS3m3zLMMp/WGDyytEKlutJFz2KRYNsSzar+P6yTFsdZzI0Mo
         xRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GYPvjChMzihllF6NfylcKZILuIvORrCrmYPLKfqT66Y=;
        b=x6k21TOcvRmJJpWIefqmkWzd/3XTExnRju6IOGri8rUty10zKu8+wY5Du07QUEMcMI
         gDRotUNZoSUFxSqzZViib9RKbf0fbyGQERvzF5obIhw+9qkwzVwTGBP0Qou56LXjE/9f
         +7gElIBVAQNJFHuaRQf96zqeL9wS3uAwKFN8ZPS1bDGOzovrisSbubChUpyt93Ew5mkq
         4PtbJ8bz/HRLPFWI3UrjzC/gPqxzTITvCc/njes1HvlrPGMWHGcCulxHKWFReBO7MP9V
         6Q3r88RcZnIhErRghVlPy2FmhYwKby78RaFwzGzxWLa5I7CLa/uq6wfxbPKCzZ5WxK+C
         4gfA==
X-Gm-Message-State: ACgBeo2IHuFzBld8rQtkAxV+zKHKd4eDAJcEKRPS8tdj2fpFVhyPRBqI
        c51i42WgwdhpdAbiewqLdfBwTbIa5CAfQgLDG/1XVA==
X-Google-Smtp-Source: AA6agR7kv2rp1ww6/+Efl2vXjiGE20Moxf0J/RImS706rUjnl6INvnrEc5kn9YujRWIO7Qmat79PMOCrfUV2aCAdfOI=
X-Received: by 2002:ac2:5324:0:b0:48b:9643:3838 with SMTP id
 f4-20020ac25324000000b0048b96433838mr5553561lfh.373.1660558959554; Mon, 15
 Aug 2022 03:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <bd442556c0094be2c240f070d15ce2061b376c09.1659288898.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <bd442556c0094be2c240f070d15ce2061b376c09.1659288898.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 12:22:02 +0200
Message-ID: <CAPDyKFo24z-n5g5w4SwugySAQGVLAp4j5TGX-SBRLbBNgxBnRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Fix the dw_mci_rockchip_remove() function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 31 Jul 2022 at 19:35, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Having a something_get() function call in a remove function is unusual.
> A something_put() is more likely.
>
> More over the remove() function does not match the error handling of the
> probe().
>
> Fix the remove() function to match the error handling path of the probe.
>
> Fixes: f90142683f04 ("mmc: dw_mmc-rockchip: add runtime PM support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> /!\   SPECULATIVE   /!\
>
> I have a limited knowledge of the pm_ API.
> However, as said, the error handling path of the probe looks more logical
> to me.
>
> Moreover, some more or less similar code can be found in
> drivers/mmc/host/dw_mmc-exynos.c. This patch also align this rockchip
> driver to the exynos's one.
>
> So review with care.
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 2a99f15f527f..b5893c738b4a 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -373,8 +373,8 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>
>  static int dw_mci_rockchip_remove(struct platform_device *pdev)
>  {
> -       pm_runtime_get_sync(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
>         dw_mci_pltfm_remove(pdev);

dw_mci_pltfm_remove() needs to be called with an active/powered host
device. That's why the call to pm_runtime_get_sync() is done, so I
don't think there is anything wrong with the existing code.

Kind regards
Uffe
