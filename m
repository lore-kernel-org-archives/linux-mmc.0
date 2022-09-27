Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80420C07E9D
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiI0MOk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiI0MO2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:14:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97089B14FE
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v28so1862149wrd.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JEiHz/34anv+sw3YKePZRjvV+9euJIIIAjKXG/xyX1c=;
        b=t/+7n69a4OmAhKy+ZWE+4OQ2hMUftmYmgtIOEk57+qqwu7JzJRaIUREi2L/JQ1n/9S
         eyky4GOl6B2rnoZizxF4MKwqzMG6xe5aFTDTpPislQe3Gx9iVHcKxAlYJ5HMNJTVphlE
         ZIBhYwxeJWARxeNBjVFt4SE3GomnHqbJ42peP0Iaohmk0b7UPb2VsbfKAbi/Ds17WnJV
         Le0JoDm0L9loO6d83+AB1yIlqETsZVeqc3Fpztiac1aDbQ4kcYpPJm7ybECGTtwvKQ8H
         V9V8+OFSfOqxZ94RB8Oc7e2GuZdekCldDWtFIecz+Ot8SVW86Id31SEXQs9MBBN4y/0A
         A85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JEiHz/34anv+sw3YKePZRjvV+9euJIIIAjKXG/xyX1c=;
        b=wE903y43xjOd4RFZ98XzcoOgL+YWATS+go/abYBDCv/QrUbltEKEYQ7O0EDYmlhkgD
         4qIEKLtCRXcEaW0QM50JuQcU6ugwEU4ULmSB4GchAC2qFqzkhFKQB3KP7o+7xz726BcV
         TTcO2jhGa4XxGg4nn+26/hblAgAAWPVwb3pNs/p7kc7iRv/qUPM6t4QiIL2AR1RwUkx9
         k/ig3Rue+jLbnKwLHyj/ImDAJSsGhf8iRUxBhEu/+JBP/1ePWY7mIPDcGJSfwBfOc+TY
         n/WZBfn8+pUO6bnjjB4J7DlL9SQVIN7v0fR/PexZy0IJAeZknrqZ4p4q5kWHHIlP4UOk
         FuNw==
X-Gm-Message-State: ACrzQf0wyf7KM4sjHXnDrPODHYAvL3/7YUiguHr1tMAJuTg9MGuRmKC+
        KaQM6M5fxO/xZYoVmhSNx31DINjl+BpewraT5aAIgQ==
X-Google-Smtp-Source: AMsMyM79n3MIxjAoajTxuCPqGzixd4TjlcvHFd3QhhkoLQkaGt20dlcjC/18m/goKhSip4RrtZLqjN+0za+VfNrY78M=
X-Received: by 2002:a5d:6d8e:0:b0:22a:4831:e0e with SMTP id
 l14-20020a5d6d8e000000b0022a48310e0emr15723503wrs.442.1664280864867; Tue, 27
 Sep 2022 05:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220923065005.20062-1-kishon@ti.com>
In-Reply-To: <20220923065005.20062-1-kishon@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:13:48 +0200
Message-ID: <CAPDyKFqxAaoC0+PQFdWN_ovgsn-ti2HkWH+2g056EVVwm7gJ-g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Vignesh as maintainer of TI SDHCI OMAP DRIVER
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 23 Sept 2022 at 08:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Add Vignesh Raghavendra as maintainer of TI SDHCI OMAP DRIVER.
>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Kishon, thanks for your contributions during the years! Vignesh,
thanks for stepping in and helping out!

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c368f5aa7429..ffad3f1dfe9c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18302,7 +18302,7 @@ S:      Maintained
>  F:     drivers/mmc/host/sdhci-spear.c
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) TI OMAP DRIVER
> -M:     Kishon Vijay Abraham I <kishon@ti.com>
> +M:     Vignesh Raghavendra <vigneshr@ti.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci-omap.c
> --
> 2.17.1
>
