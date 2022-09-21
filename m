Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40618ECAAD8
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Sep 2022 12:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiIUMvb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Sep 2022 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIUMu5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Sep 2022 08:50:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17FE98D1B
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:49:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x18so3693305wrm.7
        for <linux-mmc@vger.kernel.org>; Wed, 21 Sep 2022 05:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=F5Aj6UsKXonhXjaCbwszX18YbRfjkPa5U1IrmdLJ2uo=;
        b=kQLHGhz6TByVsMUoQtSqGzC9Gc6weBfXxZgUqnPeF6B+9iyhqtsMtlKJLp01S4SWjQ
         CpoLlS1cA1v9dVJPgWykPwFQz1rCczudnjTMoc+s9EJ0ztBwUv3a6xJhIUKUHKgbZQRQ
         17JnKX7bU0kICHqYMUYT18XiXr1cjdwvmXTeM8HicMtVhkcFh1mOLyQopKe97FYaNAgT
         KB4g+8RaGaw+76p1fD2+L9aNL6xbSUNNieZDO1+hdHowrtxnN38u5SlvA4HQQfMhulyl
         BbeQLNbCqDmgCBbF74WxUWWDccehDfsn1PGvwZOIvjTqjpri5eDxLHUspeUsG5Yg8yFP
         9EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F5Aj6UsKXonhXjaCbwszX18YbRfjkPa5U1IrmdLJ2uo=;
        b=lYIMxjJ1eAh4WRp6I662eQEFVnFKyossqs4IrMVjDJDtQqGfzoSBm1xwYojkOI+NvT
         xbgA7Yikr1giL/Xx/i+3NI10r4z40cqvpiYq+623QUxT9zh7rOW7i0L2JhIUwMT/4Yaa
         Q2lNEoeD1x7UjoKnhzYwJmqvsapK6/pnZS5VXSOfNNNDRlwR/6J5LdIJOrHWke3EowWr
         Pz6aOqVz5CQEDiWz569mERL22/ufmOsYh3zDGKggFwSAB5SeA9ffSKcLqO9kgTOhP9Ux
         3x/6pQTpSdp8W6a+WiNroVbGTozR3hbY61CvpmZsoKB25PkQB6yJKL1YqiucVHg7bdTk
         U+Jw==
X-Gm-Message-State: ACrzQf0/0wg99QclBl+x/9GPl5ah2o82SX3G4njmzln8Ww5SJn+ezkDB
        Bp0ZQnfrcc6d7FXT7+olSJHKy9CUSpjGrhO6ysmpCEanjps=
X-Google-Smtp-Source: AMsMyM5FKzTNmyylU3xPPxJYhH/SCtTxGMS0wL4PqMMujFXMXANNrm34bY1b+dRJoKk9gq76vmB+V1SFcep8mi+/4tI=
X-Received: by 2002:a5d:588f:0:b0:22b:5cc:e1d3 with SMTP id
 n15-20020a5d588f000000b0022b05cce1d3mr7784825wrf.142.1663764553759; Wed, 21
 Sep 2022 05:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220916115602.370003-1-pbrobinson@gmail.com>
In-Reply-To: <20220916115602.370003-1-pbrobinson@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:48:37 +0200
Message-ID: <CAPDyKFr8Y+ChTK2-AdioYr5zYuxx_d-gwUBppGJcR5X7M2+SSQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Add dependency on ARCH_ASPEED
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Sept 2022 at 13:56, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The MMC_SDHCI_OF_ASPEED is part of the Aspeed silicon so it makes
> sense to depend on ARCH_ASPEED and for compile testing.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e63608834411..f324daadaf70 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -157,6 +157,7 @@ config MMC_SDHCI_OF_ARASAN
>
>  config MMC_SDHCI_OF_ASPEED
>         tristate "SDHCI OF support for the ASPEED SDHCI controller"
> +       depends on ARCH_ASPEED || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         depends on OF && OF_ADDRESS
>         select MMC_SDHCI_IO_ACCESSORS
> --
> 2.37.3
>
