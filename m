Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE92C636D6
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Feb 2023 15:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjBBPXL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjBBPW6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2023 10:22:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F56EDF4
        for <linux-mmc@vger.kernel.org>; Thu,  2 Feb 2023 07:22:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id e10so1537401pgc.9
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2023 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGfX55LDKwIhxgBD6Pv/9qAlZ3kdQLWrx019H3iLqUE=;
        b=ONA1iCVjl6ZCooezOTJ98NRlsioy+aiVMj5YJWlPqGzjMDIi5qv7wZqy24ONbuk09z
         Iw+5Jj0L+rY2oGlYQV0kyJgG7gvGo84Dk2U7A02eGT9NEPH0xBjjExQqyO2EkyCU53DP
         GBOqWdZxe7/lCbaIoyd69etDe3Yg7/DGIFEpyKkouCxc+oJlZPwOrDFHWjrue3zwt0TU
         1Cz9mHeITH4l5XvYH+7gkPswY7/DrvBwP3DJylQcizgRTv8bsnCFwSVBUj93N+ixaAbd
         oM3g/AvNvLNUClbsuqpHb2hP4Mo3UMAq/idqYCBafXXzQQQoisPwYj9bPUGj2udz6OBP
         2kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGfX55LDKwIhxgBD6Pv/9qAlZ3kdQLWrx019H3iLqUE=;
        b=5wQtsySUeP6iiHaNKw9tAt2dZRSZbKVAtb4I1LrWgtFTXtcF7HpaXwfWCtpWvgmA2t
         /ZBnB9KFIj0BrZtWgRrOmEGg6ghxNEI0/Jb05myzjjrRcr4Qd113pExDlCCXVCufRL/2
         l4j7SfbRC1wj2FawztnB0CLyebLAU9UB6ieWisLUrKxSUMIzSpmzJDcnGvE868Kju3UG
         f0iTizPJURMlZDUYPn2r1TTklsl43Vv49qx2B7+KbfoWTaZCuyGnptEr/mxrhQtArcDC
         6+j8PEP8kAQnqf9boc0zM3LP1xkGQujtMDC8J1mH0TQrNKS4Zwq2xiYuwMV4iUPPTtzg
         40EQ==
X-Gm-Message-State: AO0yUKVtfo12qNu0n8HZb37Ps7wcPMOM9NmgxjPMfmtkMzsKwqpFS7ac
        QC7oiM/cmtcdV9vtv6QrE6kWzuGXfLSmUbuUIbDNVP5Im2JT5A==
X-Google-Smtp-Source: AK7set9VTZrVkIkP+oXz1cIB38TwGV2QakBKlVcyQMqSQScI/aUsUDrbvgbFafGagD4V5IxkNsy0q5FuD/dlWZBacRA=
X-Received: by 2002:aa7:96ab:0:b0:592:5ac8:156f with SMTP id
 g11-20020aa796ab000000b005925ac8156fmr1599752pfk.39.1675351375537; Thu, 02
 Feb 2023 07:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20230131085220.1038241-1-linus.walleij@linaro.org>
In-Reply-To: <20230131085220.1038241-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Feb 2023 16:22:19 +0100
Message-ID: <CAPDyKFqCMZLOte6Fd6oJgTMXaMYMTiRsZKSJu-YJE+nWYTpQ6g@mail.gmail.com>
Subject: Re: [PATCH] memstick: core: Imply IOSCHED_BFQ
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Jan 2023 at 09:52, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> If we enable the memory stick block layer, use Kconfig to imply
> the BFQ I/O scheduler.
>
> As all memstick devices are single-queue, this is the scheduler that
> users want so let's be helpful and make sure it gets
> default-selected into a manual kernel configuration. It will still
> need to be enabled at runtime (usually with udev scripts).
>
> Cc: linux-block@vger.kernel.org
> Cc: Paolo Valente <paolo.valente@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

For the similar reasons to why I applied the MMC patch, applied for
next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/core/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
> index 08192fd70eb4..50fa0711da9d 100644
> --- a/drivers/memstick/core/Kconfig
> +++ b/drivers/memstick/core/Kconfig
> @@ -20,6 +20,7 @@ config MEMSTICK_UNSAFE_RESUME
>  config MSPRO_BLOCK
>         tristate "MemoryStick Pro block device driver"
>         depends on BLOCK
> +       imply IOSCHED_BFQ
>         help
>           Say Y here to enable the MemoryStick Pro block device driver
>           support. This provides a block device driver, which you can use
> @@ -29,6 +30,7 @@ config MSPRO_BLOCK
>  config MS_BLOCK
>         tristate "MemoryStick Standard device driver"
>         depends on BLOCK
> +       imply IOSCHED_BFQ
>         help
>           Say Y here to enable the MemoryStick Standard device driver
>           support. This provides a block device driver, which you can use
> --
> 2.34.1
>
