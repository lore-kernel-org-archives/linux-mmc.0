Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D95C38A2D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B078022242
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjESJIAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgDQJb3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgDQJb1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 05:31:27 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1B0C061A0F
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:26 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id c23so402902vkc.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wiAjeMfcURelxBHuZUMdahz3hslfuep2aSIiGdvB4+U=;
        b=MjESJIAGjhwM+OrbAF9iPGpZJ/vkK1eikxiMgw0yxaSOcuysZ9JVFY/FVkUul49Yb+
         ovf+VnarnjcO59QYSQd3TdLtK3EwPQLBRvbZrzEppGkSwL/E2vjW0Zi5wxDFNTnhFhjq
         Dw0Z7KvjigjoPpQ1Oi+ppIM/XAF+Q9U7X850eljiesC/vYF/04hRrI3MXW2XIiCKwnPW
         2OFZTk0iC/A+Ph+H6IANq/DNHJPd6d9W0yvIPsQ+f6mrvDJ3sqydF5DKb/Tuc50PdYso
         ZYFrcO4wneJmMqPZGqcZ64OwN1shzuLS7/LRqsHjnYoec4cZEAuRv8fEmOvMRhRwCyhd
         Atjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiAjeMfcURelxBHuZUMdahz3hslfuep2aSIiGdvB4+U=;
        b=qjkHtTd2DqPZu6t3oG0BnOaBjxp7uCZUoi3Nd3lbADTpNGlYf5a4BlbtXgD5DNUNRZ
         7ftn47LOWof4FVhYbkHBvhoOwebmAw+CX9f6To04UYzbaz+A3dqxPu2W4gvhn7CLAKR/
         yYg1mlWwLUKqBvN0ts8X2+G3d7xJqFT+A8sKnSWIZqZkzC+siboL9eKHoWIYxEAovQNL
         hPpSGRQ+ta9II4/OKApWJPoqYW1OUE+FrGcNEq8Y7m2HCAOEkbCChdW2XpKyGZSnXpII
         tZSTs72cpgUrbixxhXRa9ZazVVXun8it1o/EqdBGJFbjCqDHM2gQs2zQJICnfduAF4rI
         jBVg==
X-Gm-Message-State: AGi0PuZ9YOoK2Lin2lPoxh5KY5bzlAWQHpytU/+Bl9AiChHwOAb0zVaO
        mKe6MwPddaeMjlowRRSQ/HiS+JUorVxgl/NiDDxwew==
X-Google-Smtp-Source: APiQypIhgrTQ9F4wV2XftulBfc+nuqItiJK/bLZiDLrTiNf3ydl2NH2qIiRMIU9GYujl8QU/p2GD5YgyX4Hb2jNJNZg=
X-Received: by 2002:a1f:5003:: with SMTP id e3mr1648075vkb.59.1587115883938;
 Fri, 17 Apr 2020 02:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200416183513.993763-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200416183513.993763-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 11:30:48 +0200
Message-ID: <CAPDyKFrKs-NAYH7aCbEUCBw9wkwQEg-HmDun_cVw+L-EPSyZ_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] meson-mx-sdhc card busy detection fixes
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Apr 2020 at 20:37, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The following errors were observed with Linux 5.7-rc1 and an SD card
> hooked up to the meson-mx-sdio controller:
>   mmc1: Card stuck being busy! __mmc_poll_for_busy
>   blk_update_request: I/O error, dev mmcblk1, sector 17111080 op
>    0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
>
>
> At least patch #1 should go to a -fixes branch so it can make it
> into v5.7.

Applied for both patches for fixes, and adding stable tags, thanks!

Kind regards
Uffe


>
>
> Changes since v1 at [0]:
> - added correct Fixes tag for patch #1
> - added a patch which drops the ->card_busy() implementation from
>   the meson-mx-sdio driver because this is not working
> - special thanks to Ulf for taking the time to provide debug
>   patches, explaining things and answering my questions!
>
>
> [0] https://patchwork.kernel.org/patch/11483621/
>
>
> Martin Blumenstingl (2):
>   mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
>   mmc: meson-mx-sdio: remove the broken ->card_busy() op
>
>  drivers/mmc/host/meson-mx-sdio.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> --
> 2.26.1
>
