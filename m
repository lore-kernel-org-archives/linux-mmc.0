Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vw4UvRuc"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6331734
	for <linux-mmc@vger.kernel.org>; Thu,  7 Dec 2023 06:17:19 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d40c728fc4so5612527b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Dec 2023 06:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701958638; x=1702563438; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M60Jgfh6iu6z8nYVF4PYMb9c5IiQooWLUZtkA7L/n1Y=;
        b=vw4UvRucLn8DLHozaNOns+nIvOqtskgyfKn9vefIVrEkKzcbblitcxoV6QPNQzlo84
         F5/YIvqgxRdbpLza5fEmbqGpTntrx54FNBMdwPtLWYgXK/QrTOJ6OOcC+YFyECXwiBBv
         LoFuKXHCP7U8Gxw4a8ZT6Kld1NZKAT5+KH9WA73Z+0olOkpl3pkDHr438IQ4qdiEK4zd
         z4f+PM5BpkauuOjTyjSQDGIcmHrHILD6yIJ56X2sx6lq4Mb61W4V8Zg9TgShy6mkKc1t
         oGc3mnAvGxkjfwC7JB4VBXnWPOPWBs1lFGB1Srm35IhBqWwgrK9zUu1JVzbD1wSXISDE
         sxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958638; x=1702563438;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M60Jgfh6iu6z8nYVF4PYMb9c5IiQooWLUZtkA7L/n1Y=;
        b=slbOHYq4Ip8Rh3MHRtSMho+KGbFRInJb1q8JLyVCSZ/Al7Ph99E/0vo/orR4WbTjoJ
         GO8tBWQ1VC/M18ygLRw2AuX0M8rQ+WRPV1O7aBRrtn7BZxFaRXDLHHz8P4fbwb1tusDU
         3D7VJbvVVev1xXkNnpSJ/5BAEQhq/K4PBKA5vqSq/6uOMhvheSXwdifmyJd03qX/hnPK
         /qsrfnORx5PT9KFIOllRvPBg3nlPTJFk40AUZqSnjsk17emEtMIU/3mB3YJvzL5tIETK
         Nd24ETH9buIXaeEMQS2XdGikP5tWN3JcZPG0C5acCxJLhbnXSz3uvMepJcAsIUW9vNlb
         YnBg==
X-Gm-Message-State: AOJu0YwCf9pdSw65iIgC6lWNszHlSZJi0Gi2l2T4XKAMl2eQKG2f5A9Q
	IlHCdVZqsPmA/Am7KWcd7rM2w3cFaKhCK9f1o+WhJw==
X-Google-Smtp-Source: AGHT+IEJGe7l15a+9BqxmN89FyS7HOqKVFKB5un980cU1GLW108tgLGrnl+y2KomHMfyrWQKOt4HmdV1dNngzFGLsVA=
X-Received: by 2002:a81:430a:0:b0:5d7:1940:3efc with SMTP id
 q10-20020a81430a000000b005d719403efcmr1641052ywa.45.1701958638280; Thu, 07
 Dec 2023 06:17:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206055855.21092-1-rdunlap@infradead.org>
In-Reply-To: <20231206055855.21092-1-rdunlap@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Dec 2023 15:16:42 +0100
Message-ID: <CAPDyKFqrgnyQyY1u47j7VSdJE7GVvHBQ1RKG+=ZNx9a-eEbu+Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-omap: don't misuse kernel-doc marker
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 06:58, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Use "/*" instead of "/**" for common C comments to prevent warnings
> from scripts/kernel-doc.
>
> sdhci-omap.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> sdhci-omap.c:3: warning: missing initial short description on line:
>  * SDHCI Controller driver for TI's OMAP SoCs
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202311201117.lFxgJTK6-lkp@intel.com/
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
> This does not Close the report since there are also some warnings for
> missing-prototypes.
>
>  drivers/mmc/host/sdhci-omap.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * SDHCI Controller driver for TI's OMAP SoCs
>   *
>   * Copyright (C) 2017 Texas Instruments
