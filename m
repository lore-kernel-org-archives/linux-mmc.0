Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515DDC433E5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 09:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE220714
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 09:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vita4HiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXJkx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXJkx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2020 05:40:53 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150C6C0619D3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 02:40:53 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x205so4561831vsc.11
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPs3Kpl9gUxerrpH+PKf/MQttt7ODK3F6c++6G9cS0o=;
        b=Vita4HiW9be8xgOd6mYZD7HSrlvQhjqS9kVNdJ+/RLLbDNCwz2L5abnEfQC14IQFLi
         TOn9fbNZ/iFUej/om6UzGsFfh8WM0u8QpyG7aLH3xk/+6DEnlGbcAtj6A0mR20+cUlQ4
         Z06v2f0RDmcaI84tVpg7gNpjpweAuGjT+CjyZ7dC2tDrh98AKtyJhJ30A4dEBx0oWxfg
         Ani8/9IZnyJ3quWb4+793KXkPV63m6h/24VCZcypSC0+Mhm+VcJsvGTbIcKfDrr9oTDA
         88wTeK6/XWbl0W9I+ufrj/K9JNqVg8/iKE/nS7rZU/8rBbHS7oYixV7H1chAZ1wALw1U
         h6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPs3Kpl9gUxerrpH+PKf/MQttt7ODK3F6c++6G9cS0o=;
        b=Qffx7ol/bwkW4IM/GgOor2oUZfxXAvvadJyt6WaVQ5aC9xcCYsZE+SbCOq+12HUU7/
         bkaWsvuu87AYNF0f79mBXMMqOUyvEvx/bAxchHDEyyQaQ0uaEB49ErD0ru8yNS0MCcHe
         14GXFgVXKkvwcYYQQ9fRb8Ufent/1LUkaMT55pTlXn+uFwvxvgnolVU5hHJpUahzzLW3
         7BgpzkASYwz+favjSNEg9s3WQdiFHaFUw/fKt4ZTeDGkWv3fWRpTrPHQxxQESOH+HXz8
         kbSmKNw3+qdZ14dR1REr5paqe7wHYz37vcGqznZwFDvx5912BVdX3K3cHbUfu6wu8RGw
         6bFQ==
X-Gm-Message-State: AOAM5319Ug/YfO4iZFBZZOB8c7vGC4vHxpFI82PSUIx0z8RWZ0A2f44h
        7KhoE+52A46I5/fE+Hp16ALjSXbJv8+HidTpfJre/Q==
X-Google-Smtp-Source: ABdhPJz+ssJ9jfqPfiNHbj1PYiRmPAvAhHyfgqAVopt6PG8bSTO4fkaSkeRagOC1eMMhAFbfpPtr8dDM831CF0UT0Ow=
X-Received: by 2002:a67:f888:: with SMTP id h8mr6889837vso.165.1595583652321;
 Fri, 24 Jul 2020 02:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200709085331.8145-1-ludovic.desroches@microchip.com>
In-Reply-To: <20200709085331.8145-1-ludovic.desroches@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 11:40:15 +0200
Message-ID: <CAPDyKFq5gCA1f=XVVepi93wotn4uR8JHcRh4JoFt-Preg4ATjg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mmc: sdhci-of-at91: handover maintenance to
 Eugen Hristev
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 9 Jul 2020 at 11:03, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> As Eugen handles the software for bootloaders and new products, handover
> the maintenance to him.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

I am okay with this, but am waiting to apply until I receive an ack from Eugen.

Kind regards
Uffe

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c87b94e6b2f6..dafcfa626c76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15376,7 +15376,7 @@ F:      drivers/mmc/host/sdhci*
>  F:     include/linux/mmc/sdhci*
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
> -M:     Ludovic Desroches <ludovic.desroches@microchip.com>
> +M:     Eugen Hristev <eugen.hristev@microchip.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Supported
>  F:     drivers/mmc/host/sdhci-of-at91.c
> --
> 2.24.0
>
