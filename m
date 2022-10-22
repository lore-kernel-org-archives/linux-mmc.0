Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8ACAFA3742
	for <linux-mmc@archiver.kernel.org>; Sat, 22 Oct 2022 14:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiJVOCn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Oct 2022 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJVOCm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2022 10:02:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1217D87F
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 07:02:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t18so184299edt.2
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LNVXeM54MuUTzkxW4S+h/avYMDRiH1JNQoeYcnCHBhM=;
        b=GjMO9bieaHDBelf7XPvp7Mm6+ECuPSqx2R6/8PrakF0zbhlcSTaFXUaHjvuZ2PA8oC
         6WcjMZS86zeqIwyvNpGwuo6uT7FBWc0z/XIKRCqsdCIqfvsYU5jrdGwZO3AN/Ut8O2PU
         dVwNs+ZCerEYbOg45w7UYYLixBM2CbHkBDvT80VOQZCglZoEQDqqFHhmGHexg7wLDjKH
         dwidHE+9u/Qqc/ZjBKywjSP+b7eto8KN5KoUI5cL/eSVRiUi9+a4YNFvdbLp0UHLJ6sl
         gO3VAnOCQ8U/s+ZJg38eYK/md92XTywwgTsnnIKU+jdNd8yLoqJqnpyW7AhFA1JN3Ctq
         CMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNVXeM54MuUTzkxW4S+h/avYMDRiH1JNQoeYcnCHBhM=;
        b=TSx7/zAOG01B46eEQSrZXmZfCqYsn9kYUhZvFKRd4ViGhHSlWZx76Zk+fL4XfEeg3F
         Q3gO1U5dtIcTPMDtDLQJEEXRhKN0UKTdcrVTjRfc50Bxn+XZTmKsZCbOsia1n+Z6ks0D
         fNISn397HCwkXt79L7xPNksy/yEgGHZ3xUPAR4Bgtcs2YtzAGd03QTJPE/8U0Rc+nERn
         +DRQEb5D33YreRHDwMiawg3FSBBfviWwUD6TYr++egbx8NoyZLE6cF2w/05jjGfd7Cx+
         HCVxVOAhckIXAvGgDsE4D1B5HvzjCvMQ3XTBxFu4UNB7tFjzOuiJcMRV1E6VvWi4gmsr
         JscA==
X-Gm-Message-State: ACrzQf3FgRcX9QM24eDjC4F/lhoyVZxW/F207BAyutFO/Tjp7Ubxohw1
        YI1OqwxlbMkSjY6D+HGzsLFuLIpLoQa/h8CtGGpEtQ==
X-Google-Smtp-Source: AMsMyM7E0Zchl09puiKKoBotMVhULOKYzE0S/e35EOJ4h3CGvH2Wc0rTF+zAD6m+BsOpLEKYent2ulN8cXV4ms8GFBg=
X-Received: by 2002:a05:6402:1d55:b0:45f:c87f:c753 with SMTP id
 dz21-20020a0564021d5500b0045fc87fc753mr14243568edb.32.1666447356997; Sat, 22
 Oct 2022 07:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221021202254.4142411-1-arnd@kernel.org> <20221021203329.4143397-2-arnd@kernel.org>
In-Reply-To: <20221021203329.4143397-2-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 22 Oct 2022 16:02:25 +0200
Message-ID: <CACRpkdacViTuL_gmhWULNm7HCHQeGBXwkonDxQjubSM0=v8vgw@mail.gmail.com>
Subject: Re: [PATCH 02/21] ARM: s3c: remove s3c24xx specific hacks
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 21, 2022 at 10:37 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> A number of device drivers reference CONFIG_ARM_S3C24XX_CPUFREQ or
> similar symbols that are no longer available with the platform gone,
> though the drivers themselves are still used on newer platforms,
> so remove these hacks.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
