Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960EC433EF
	for <linux-mmc@archiver.kernel.org>; Sat, 18 Dec 2021 23:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhLRXWB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 18 Dec 2021 18:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhLRXWB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Dec 2021 18:22:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019FDC061574
        for <linux-mmc@vger.kernel.org>; Sat, 18 Dec 2021 15:22:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j21so18137569edt.9
        for <linux-mmc@vger.kernel.org>; Sat, 18 Dec 2021 15:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jy0Ga3DpjlJg+/LuCD6N3Bii634vakq81RRGU8kR/lo=;
        b=GXaYs/dYmFjCL9Hqi/k90Nn+qo8+Hm4uwztzbrnvz9onhQmw8FTTWvdc00sWatsuhK
         cjVG2KCOOcw/tgJcPBYRpuBop4582yKmBYlDkGwHIG+6B6TuaPT7iq09g2imQHw/e39R
         aQc6Lm1DHWFhnL9EYnSLDVTd9NUKBAWw7nupAuyrwQVxLvEq3cNFLMB42I5Hl5+smyTB
         teLuwkg3eqrHdhAM7KOneTOrkfoOgzUwBWwutaIMRaYXgTOA+rRbEvk+lPzFEMXVs4Xu
         y5rj4wV0BiXyQ663os0Nb5Hil1isgTnLGt3iyN0r9Fz0rHnMbaODtxvUuOcFRHyyWN7x
         JrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy0Ga3DpjlJg+/LuCD6N3Bii634vakq81RRGU8kR/lo=;
        b=2qOt4HmlybN100AyJUY3JidejjT9aHrRMbSrRHUHj+MyHAyat7PueEkuG4s1lIBm3k
         tKlHwoRA9zUxWwhCtW5IZL+hYXcPvEl3FgyedfbltZ+I/wT0oifrMv7MlUitCi9nh0n8
         EV/ogETToOqH3m2NoL5bICoVNBUJMY8icGZvm0J/kx1eA/NwhC7eJsKZs0RVvwLbtBNN
         +lMPm1pzmiIj2kYzDtr+IALmgRNrwV80w3sFWFzIEmt0aaOKllnNzlEjiOVR5nQ28GuB
         G0HnQQC6UdDCWuAnkEJZbwopqTSCVi1IMTq8OHi8CLUgkcV3qJwxu+kuGnE8XjermIaH
         eMog==
X-Gm-Message-State: AOAM532PJPeg+llcjzGt/lvPkGZcrFMSDzYSD1htbB4hucpwVYCz+EGg
        VEM7wjZkg2W0ZLoz2WQm4+Gc2ieltPdHRAQLtskvjPaqM0k=
X-Google-Smtp-Source: ABdhPJx/41M8w6QBX2nmKkkxnJ3pPd76IxUAUOmOiFQNl7SjjagIfd78bF2mSnVEepR76ZLv/E14js2hM6hUuPCyLrk=
X-Received: by 2002:a17:906:341a:: with SMTP id c26mr7617881ejb.302.1639869719365;
 Sat, 18 Dec 2021 15:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20211217202717.10041-1-s.shtylyov@omp.ru> <20211217202717.10041-3-s.shtylyov@omp.ru>
In-Reply-To: <20211217202717.10041-3-s.shtylyov@omp.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 19 Dec 2021 00:21:48 +0100
Message-ID: <CAFBinCCKokhAK=mK0WqVbNYqjB3iHDM1nm9QLEWtmUCFMfjK+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: meson-mx-sdio: add IRQ check
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
> Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoC")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you for catching this and for submitting a fix!
