Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4123C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A699610A1
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 08:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhJVIo4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVIo4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 04:44:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7CC061764;
        Fri, 22 Oct 2021 01:42:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e19so215106edy.0;
        Fri, 22 Oct 2021 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rMHji8kgf+m1porXcns682MpUeRt4z96dt4L6ZyjLc=;
        b=oXEuAQPtB1gYaPl9YoqjUDxFnNnue1Mr3NiQMDM7grJKT0/tF180plb6gb1WyBHxDb
         eiboqeXZlG2jjZLA1uRzymppl5uzcDeocO1kbQFgnevlYOdAjpolhZxBjKXw8eEAaxwN
         +tOYj7uTOd7CPFAHC/aj+q7QZ8XGXFDH25C3+AEyMQWC0Wz7KbMZtTHi5hBNjL6VqK2v
         xS83oYpecRXh4RuSuezcBJMQJJx7OZmCJUUJe8bTQli7cI2ia+wqAqSOMF+qN/dUyGh+
         Y+BjnHXyY09Pj40X2AUFZpoqer1Fyeczj8PuvKAdt2Lxs0jEdTkayBu1GH4A4pFRq1zy
         4E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rMHji8kgf+m1porXcns682MpUeRt4z96dt4L6ZyjLc=;
        b=bvqWIIqeDtnPSPAhpeEs0jOiDof29A8JJ9TbqWUVg0QUt3tY92abSFfGrdBmXqlUYB
         CQhGP3UNswI9Rk2Y8xNbnv0xdZahOk/+cL1Hpwu4arsXEp+nmeQ8/W4qR8TRGx/kyzbl
         41fZ3LR3nY0/Fi2tNeD89u0JKnlhiu9kpjlsuaMfyen1JuyKZgqx3fAltPIaJAaBwfWG
         0C75rHerELXBHpo2aAQd/qSwVyGdhHnyIs9eVUB+iBSRmpY9Ll1tF7vZDB32BbPA3uwk
         52YneTFy2FAq7KDw0ocl0yqtoryI+JwBmKK3/jQvRLwNzYriDk/yN523Quc0JdjX8uz0
         CQZg==
X-Gm-Message-State: AOAM530lgqBv196LSqIwCp4IUojj0yjFDYccNrOvUeHKrAL5aafeBGnw
        SCMB5WM1i7XNQ9fy9v9gYitHpjTvtWRZfTj/Ny8=
X-Google-Smtp-Source: ABdhPJy0bWXnnvLSXyQCDfQotX5wHGejlFHaw6dDhsx3Z37fh+OyTdfcnQxhJw4p0N10FFgFATsYPm8TPGkzd/PRtUI=
X-Received: by 2002:a50:e188:: with SMTP id k8mr15802135edl.119.1634892157363;
 Fri, 22 Oct 2021 01:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211022054740.25222-1-lukas.bulwahn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 Oct 2021 11:41:41 +0300
Message-ID: <CAHp75VePmGx-24XWocV9eUwh+uFw4seY83SyA7zG-pa-6T18_Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop obsolete file pattern in SDHCI DRIVER section
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 22, 2021 at 8:49 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 5c67aa59bd8f ("mmc: sdhci-pci: Remove dead code (struct
> sdhci_pci_data et al)") removes ./include/linux/mmc/sdhci-pci-data.h;
> so, there is no further file that matches 'include/linux/mmc/sdhci*'.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
>
>   warning: no file matches    F:    include/linux/mmc/sdhci*
>
> Drop this obsolete file pattern in SECURE DIGITAL HOST CONTROLLER
> INTERFACE (SDHCI) DRIVER.

Thanks! I grepped by name but definitely haven't thought about wildcards.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20211021
>
> Ulf, please pick this minor non-urgent cleanup patch on top of the
> commit above.
>
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44c590b762d1..c47ac3e938b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17024,7 +17024,6 @@ M:      Adrian Hunter <adrian.hunter@intel.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci*
> -F:     include/linux/mmc/sdhci*
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
>  M:     Eugen Hristev <eugen.hristev@microchip.com>
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
