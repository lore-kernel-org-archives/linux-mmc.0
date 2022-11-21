Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0841C4332F
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Nov 2022 20:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiKUUaQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Nov 2022 15:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKUUaP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2022 15:30:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CEED9074
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 12:30:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b29so12357252pfp.13
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2022 12:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9+M2W0CzPt/3Idrh2stcScSTO3IN/Wj2t7AJg/nEkVA=;
        b=YxHUTbGH3q2bQTBCEF8BcGPhzX9RTjklZuyP9KKihuNg2GbfTKSVzcjnXV0FCFZlzF
         AET+H8UWx8bvKRO09bmjuThzAk3lUftqshCEJ4T8BfwBLj15mTvtUBYUL+8r3G0hsUvm
         2442Nd26UU41Z4HjxqQ1sOSFUtpMXf0V4sOH80XRToQ1LDAeKn7y5OdbFAZpg86Cqrwx
         kY7LHSxdUZiIX12PIAMXiIbpqaC/mvKF7JdHytu8uOmBUSIo5pT3Kg3V1BiRJI9rW1Xx
         e+IVs/Vue9dMfaKGGdzu3noGQ1ZolYyDujzwG1c0ynELIbdSSATK1bejPOuJhJBV1/5l
         zI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+M2W0CzPt/3Idrh2stcScSTO3IN/Wj2t7AJg/nEkVA=;
        b=BCrFw6tjcpEaLX/KDsmQGDo5hHNfppIPx4mH1L0g5KJQzcPiUZ9D3xwC3eTusWtqUT
         nz2YoacwWljEQ/mhdOJHVWS9hnnmsn6fv6KYkI7zEovyRMstrSs2wPgqJ07LdXRSg3kL
         Tgi55dHEyKgowq7JOGjFHdgA90NFd2ig9HzxGwaRiIAbtMVe95LtoNtE5MJMhV4xcDGs
         Y9+4jnglTLWqtXspeWNOSjsZSK7AJOEJow4BkqAnAKe51/c3bk2Z4CudJV8bOtuFcTCQ
         f4RBw4MlSZz3f8VIO0a4Gr69BrfqNUAkGriPE+upw5fbqcXYjK63EJl5T9qY3EEcCrQq
         mL9A==
X-Gm-Message-State: ANoB5plKJ1vjBHC4tSEMp+SbfvCqN2K8/XQz7+o0Gw33+ZGYxegpuwHX
        PKVy8ZxGdnn41iEO6NMiYB03HhbggYYwvUs23KVT9Q==
X-Google-Smtp-Source: AA0mqf6P/4cgoOqms4Hg/SBSbh8OfDCW696Vy5GWvdjLuZqZQe1MJF6oDeEej9/G1ihbNGyvj9oxLBpQL4B4kaUnjEw=
X-Received: by 2002:a62:e80b:0:b0:56e:ad31:b98b with SMTP id
 c11-20020a62e80b000000b0056ead31b98bmr4856818pfi.40.1669062614134; Mon, 21
 Nov 2022 12:30:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <cover.1669023361.git.tonyhuang.sunplus@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Nov 2022 21:29:37 +0100
Message-ID: <CAPDyKFp2uzqiVg1k8qxm+BGvDp_YPT7vonVR+Z7y6NBbYDrOrQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] Add mmc driver for Sunplus SP7021 SOC
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     lhjeff911@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 21 Nov 2022 at 11:07, Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> This is a patch series for mmc driver for Sunplus SP7021 SOC.
>
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
> etc.) into a single chip. It is designed for industrial control.
>
> Refer to:
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://tibbo.com/store/plus1.html
>
> Tony Huang (2):
>   dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
>   mmc: Add mmc driver for Sunplus SP7021
>
>  .../devicetree/bindings/mmc/sunplus,mmc.yaml       |   62 ++
>  MAINTAINERS                                        |    7 +
>  drivers/mmc/host/Kconfig                           |    9 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/sunplus-mmc.c                     | 1000 ++++++++++++++++++++
>  5 files changed, 1079 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
>  create mode 100644 drivers/mmc/host/sunplus-mmc.c
>

Applied for next, thanks!

Kind regards
Uffe
