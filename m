Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B3C433F5
	for <linux-mmc@archiver.kernel.org>; Sat, 18 Dec 2021 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhLRXVl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 18 Dec 2021 18:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhLRXVl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Dec 2021 18:21:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E671C061574
        for <linux-mmc@vger.kernel.org>; Sat, 18 Dec 2021 15:21:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b7so22531097edd.6
        for <linux-mmc@vger.kernel.org>; Sat, 18 Dec 2021 15:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9G+7wKR/KNsA9zGuDF2Yl81AiE4LUMErpemWo7OkFk=;
        b=AHNkg4H4msQ4orc3K6D4Avgakh1S83HT7TZ9yF0AeohMPuj/SrWhyzNdt3GfRnhUXA
         HfNmBkScB4Tl4vdPNsc8BYxntdHfAGLoqThSFG8yPCj8qAJLO31nM1Hkd26iGapqP9MY
         54rRQxCPVqrqxf0XXWY1BV9Pv3193uqnLtUjsG33IyDif8UGq5wVLd8JRY7unCIBCakH
         GVizGaBINMJZ9a3hZiFNrHnMLpTHvfIY9WEux9EcwLLOW4YnsKROOUCbwmevjIlSqueI
         q5RbWWzsRo3q5rtNsHy6clepZRhnzVStjBVjYnLekbsmn7bAkevnrFwR3Z+lD2Veuavb
         /CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9G+7wKR/KNsA9zGuDF2Yl81AiE4LUMErpemWo7OkFk=;
        b=SxSRleD3dzCONyXjLabTHGUCW/FYwy+1By+rEGNwwWSNvSxopb83c6AP7ePqzuylnw
         f+dkMEzpk+s9f1corvTs3dg+49tHG39T/EbZbYNI48He2ZPpLReNPbTKAsJJJ2fQgPI+
         Hraqntww+H4AH8s72Z67mhX14F17kcVq3Ui+cm70/H1NPYmsN3mSeIrcMbixJV8rqd6H
         oqE+MO4xCNnwkzJ3e9WGZ9eBBLfWP/zYfR6cS8CDyY0JkWaRRKIkDx8K1dDufH4kLfG/
         PUSP9ktT7RIlPCqx3St0rdgQcXxbdACFmWG7SD8Be89Mke2nklkeGdSVMOVt0YxK6QuG
         fd6w==
X-Gm-Message-State: AOAM5308Dqp9D51VG5X+OD9094bEq1LjDEdLpU/DvgA+jsyiqQJDlfiD
        PjNfyC8AaX7qo+tSPGvlSNWMzsfz/UCVt//xYMQ=
X-Google-Smtp-Source: ABdhPJxSa0b2hUzZXFDIQ/DY84rRA9KupwxCFS/7c93jMS/DHOpA5gpCLoW9nuyPgkQkdnsaW+mO5ZYKlF2Lnc+TEUw=
X-Received: by 2002:a17:906:ff14:: with SMTP id zn20mr7775536ejb.649.1639869698818;
 Sat, 18 Dec 2021 15:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20211217202717.10041-1-s.shtylyov@omp.ru> <20211217202717.10041-2-s.shtylyov@omp.ru>
In-Reply-To: <20211217202717.10041-2-s.shtylyov@omp.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 19 Dec 2021 00:21:27 +0100
Message-ID: <CAFBinCCSopiPE2o=HXAzxth7o8iXaYqDK_mUcfcZrRbHKK001g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: meson-mx-sdhc: add IRQ check
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 17, 2021 at 9:27 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> The driver neglects to check the result of platform_get_irq()'s call and
> blithely passes the negative error codes to devm_request_threaded_irq()
> (which takes *unsigned* IRQ #), causing it to fail with -EINVAL, overriding
> an original error code. Stop calling devm_request_threaded_irq() with the
> invalid IRQ #s.
>
> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you for catching this and for submitting a fix!
