Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B744C433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Sep 2021 20:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5C161052
	for <linux-mmc@archiver.kernel.org>; Sun, 19 Sep 2021 20:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhISUFn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 19 Sep 2021 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhISUFn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Sep 2021 16:05:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E690C061574;
        Sun, 19 Sep 2021 13:04:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t6so52399260edi.9;
        Sun, 19 Sep 2021 13:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6dcfeSU/NOsGSKbPe3yVGjy+BHxzeNlCvBUbxrUC+I=;
        b=eIEUGJFpKqwaqe/BM2ipxcvnehHrJDzjyAepeocNa9a/QbsroK3efi7YIiCyEGTRZf
         JrqYvugCXMPfdCMBpi9t5NJlq8DIO0SQSKhEsv2i7upHyblhsEhfE4lIpLTkzVM5am59
         36cZWoLGQn6wkEzu4V2W4y6ZqDGKOK8xVmY++3TgAaoQeTVEVbKzWvEMv/6r1/IYKaIS
         J9qVEC7P6etYjyeAQ6v2LB0ENIK2Ymy2abnCx7fqoYFvqJ8XmIDMhfm+N4WGDj7/Kjkv
         /wp+Ea0sY38dBMYHWDFWbo6P0X6DFz8sZ5KdSWvCqs64nosGKDh9DGxFzyplY/W8DEwq
         Hvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6dcfeSU/NOsGSKbPe3yVGjy+BHxzeNlCvBUbxrUC+I=;
        b=Akrp2AtWNmKPlfu2EeWB8er5lg4t+yoBtX3hzopycAj+1YFx4JicjqcClFc5O+sM3K
         NkhuaNRmQA7ZoAd7AZHBKa6wBFhGj3+cPFy+7qpXUFpwzIS2aPVmgM0TUsC7E7fodgBM
         WzJbV6E0R9ruBeWNRLgaTmlLPxjGm9xm3J2XJeet2DfWGHYHrztGKoUsyAsFbz0EbMY1
         SEBhwNEj5E8Q94wDw4OWiqmX0r0lR+072uhBD8uWhgqqg8qGd0I5uM6npNrjM8dwhOZT
         s4YX2USwqxuALwOP/l+fZiTyUyuaN8m1imUlEBMcVHiF3hB5WDxXzCTOoHMn9LLxESeR
         aK2w==
X-Gm-Message-State: AOAM532YXG5sWayRFA/GtpMEhhhvnOFzPYQs0jZzI4EicFjHEBzKaY8V
        4J+V/WCWsJs/2/278AL+TT9QMaE6yImBVWNuSK6XfOrwYwc=
X-Google-Smtp-Source: ABdhPJzZSSqwoRRH6yf/ElrPT7c/a1ILbXHOxkd8n5v3y1fDg0NwwQK4OJUrZKHLvrxDjZ6AhRLPnIn3fFBxaKR+Sng=
X-Received: by 2002:a17:906:e105:: with SMTP id gj5mr24161655ejb.408.1632081855922;
 Sun, 19 Sep 2021 13:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210913080504.832521-1-narmstrong@baylibre.com>
In-Reply-To: <20210913080504.832521-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 19 Sep 2021 22:04:05 +0200
Message-ID: <CAFBinCDbxTo9B5nfP=etv+DBwwf3_L7PaRr2Fck2pELwwLQnLg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: do not use memcpy_to/fromio for dram-access-quirk
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 13, 2021 at 10:05 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The memory at the end of the controller only accepts 32bit read/write
> accesses, but the arm64 memcpy_to/fromio implementation only uses 64bit
> (which will be split into two 32bit access) and 8bit leading to incomplete
> copies to/from this memory when the buffer is not multiple of 8bytes.
>
> Add a local copy using writel/readl accesses to make sure we use the right
> memory access width.
>
> The switch to memcpy_to/fromio was done because of 285133040e6c
> ("arm64: Import latest memcpy()/memmove() implementation"), but using memcpy
> worked before since it mainly used 32bit memory acceses.
>
> Fixes: 103a5348c22c ("mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk")
> Reported-by: Christian Hewitt <christianshewitt@gmail.com>
> Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
