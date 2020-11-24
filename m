Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E4C64E8A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4033E20888
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aeB8G8gS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388941AbgKXO0E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbgKXO0D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:26:03 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A00C0613D6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:03 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id w67so4784278vke.10
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V535LKPebOfjmdDDJc9j/Xpd7Zkc2zNFkTI8tr1mekU=;
        b=aeB8G8gSYDiqcddXjf+bJO2gfHQapF4V+qksw4C4BVIyGL0pyLClxbkKLh02/5t5Ij
         oVA/vysGuoetb0VxPUrgrCN1I8b9JE/KtU6QBoe4IjuXdvQEuvCWAoOWFkxfmmZaoN5s
         vSfOSVZOzeEs7lGZaPfl//8ukdsSJ+Vlh7rwh4HQ2ep4BAtYYhTVDzsX3j74fwUapJnS
         UQQepa7pny+PS5ntOk6paekdm5slPySeTjfgROn1cNhuIq2+DdLER2DTWf40uDfPIoBB
         O6+HOE6DSl1S/GpOvWJLRQWURiI8jjodXAlx/6BypopUJH6XyzUS2RBAvrOl+Kdvb8MQ
         b0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V535LKPebOfjmdDDJc9j/Xpd7Zkc2zNFkTI8tr1mekU=;
        b=h8QtfZpz3RAGOn0rnVsBlg7331tAhelG4uLxaynn44/ujHPQebdh+5Oa4D4f78ym6G
         yYk6fjgCJGcWBYg6XRxyKUADS/TmBPR5pd4HAhrY1exhu5IoeEn1D8jkE5GN00xMhrQg
         wOjhpVcqxaci04yWZeOxXG8+Ql061pBzuJdWTr3j87O+WZjbznWjzREb8aUyGtpfSYJZ
         t1MAzaUVDNHdJ+n+zAOjGlPGximNnbYGsKR+f8eUyqQWJ+Zt5V2l+w+cW6Z252MjXyx2
         AZ9cKWGGlz19BbYPyommJbZ5QJnFOJ70GIcP5yUlFEUnbKVD97bKVCZpF7VYzpH8JakZ
         jW0Q==
X-Gm-Message-State: AOAM530QfsqFGsbVxcBRJDnVxfYe0ku5r6+yJNfjblIch/1OhLPWBK5k
        kgHhWOprvhZAFuIOw2nqfnkzgy7aoYC5QmdqRM68Rw==
X-Google-Smtp-Source: ABdhPJxncBq4QuAAzYdQ/eP6RGjssC+Rf5A4aYYuP4SphD7S8VrYEzyMVPS7yB7/TJm6uE+PNx+C9iC8IvIHjz7gDsM=
X-Received: by 2002:a1f:2cd4:: with SMTP id s203mr4017312vks.6.1606227962418;
 Tue, 24 Nov 2020 06:26:02 -0800 (PST)
MIME-Version: 1.0
References: <20201122120056.100045-1-krzk@kernel.org>
In-Reply-To: <20201122120056.100045-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:25 +0100
Message-ID: <CAPDyKFpTCtJx7Uab+072fz-8Mr00r5DuHLwj9sFbbnN3k-f0pQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: depend on COMMON_CLK to fix compile tests
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 22 Nov 2020 at 13:01, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The MFD_OMAP_USB_HOST uses Common Clock Framework thus it cannot be
> built on platforms without it (e.g. compile test on MIPS with LANTIQ):
>
>     mips-linux-ld: drivers/mmc/host/mtk-sd.o: in function `msdc_ops_set_ios':
>     mtk-sd.c:(.text+0x2bbc): undefined reference to `clk_get_parent'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 310e546e5898..bfe912ec8955 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1023,6 +1023,7 @@ config MMC_BCM2835
>  config MMC_MTK
>         tristate "MediaTek SD/MMC Card Interface support"
>         depends on HAS_DMA
> +       depends on COMMON_CLK
>         select REGULATOR
>         select MMC_CQHCI
>         help
> --
> 2.25.1
>
