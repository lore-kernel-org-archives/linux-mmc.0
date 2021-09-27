Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF49C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5C6103B
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhI0Wec (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbhI0Web (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 18:34:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDBBC061740
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u8so82953410lff.9
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mylYr9AxO1lp/qjqY3iRM44WQJLHrj/GgtihC6w17dA=;
        b=uZdSs2h7nd01pW0t9cpgr5Cba8CT1umQcEJ2lHA0ntFmU4NeTExjMhagqDQgy/WbM8
         rDB64bTKZhlk48jrpydjYgSpiT8Vk+08AqHHT90Ke/+LOZ9KbAqBIy+JSeSdg2VMx9Ne
         tSOF58fk8b0uzBp5RIK8yA6sjl8YB8wUc3n5UsWfl4751/Nm/cEZnJpfA3D6rPIy0BdM
         8OaU72xx8ENuKjghJkOOZN68bMrXknjRABGAHTw+G3pMjbLaR1LWFHDwZ5pY6z7lY9Cf
         trV7YIXiUxtYoNSposH2DLu1/NGpk6V2A5mM3ZO5GUPRB02wLyTy1BeZZBQN87bkXUH+
         5rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mylYr9AxO1lp/qjqY3iRM44WQJLHrj/GgtihC6w17dA=;
        b=5jgwtO2NfsKsIn5Jr36wT082Pd9No9tMZSQN7xh+csL45vpq1xl2DdNapIcCZ5fx4t
         +c54vWDH27hAYMqT4e4KTnx4Yv9+uqyDoTFrU0o42II6XrxlPiDEgvmPyDeT45GxxEG/
         1kn9W1g6CiuF7HmakOMHp214L7SzEdcetF50aUS8lhQwRB9MdcX9MONPoBhLZ9QVn3gD
         s9GwZaqtr9r3VhWpaJ73SafUJN7VT3Y3FTuWX4QeMvzNi9qQQAg4u2359XBOUgn7IQT3
         1Uavo2oZt8FhvurDsEGMNBukL4hFb+kM+0Sk1JwBt5STthRpCQQHkWbCbO9XrxWQuuUC
         085Q==
X-Gm-Message-State: AOAM533ulvkM9aJXOphCEO9XQRITqOuZ8SJfkp3Kgq8m4eeNJhbCgGZy
        ruobQ6jjlAaTIYknG97Bfy9U3MoZa0JiRfgjkP9bZg==
X-Google-Smtp-Source: ABdhPJw/h1r/YFDP5Wc1Qi+JuEXjneeg18sMNnQ4fQ+Mw86L+IFScl+H99pJQIE4Z4Rsia9g2q6Cx6NELi5xjFZvs3w=
X-Received: by 2002:a2e:1548:: with SMTP id 8mr2296321ljv.229.1632781970877;
 Mon, 27 Sep 2021 15:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210926092835.146449-1-zhang.lyra@gmail.com>
In-Reply-To: <20210926092835.146449-1-zhang.lyra@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:32:14 +0200
Message-ID: <CAPDyKFrMEs-9fUHWPVofR0VG45ywXPLb4Hf5tg5kMjvOwR+KGA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-sprd: Wait until DLL locked after being configured
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 26 Sept 2021 at 11:28, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
>
> According to the specification, DLL status has to be locked before using it.
>
> Signed-off-by: Zhenxiong Lai <zhenxiong.lai@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> * Use read_poll_timeout() instead of while loop.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 11e375579cfb..f33e9349e4e6 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -8,6 +8,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/highmem.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -39,6 +40,9 @@
>  #define  SDHCI_SPRD_BIT_POSRD_DLY_INV          BIT(21)
>  #define  SDHCI_SPRD_BIT_NEGRD_DLY_INV          BIT(29)
>
> +#define SDHCI_SPRD_REG_32_DLL_STS0     0x210
> +#define SDHCI_SPRD_DLL_LOCKED          BIT(18)
> +
>  #define SDHCI_SPRD_REG_32_BUSY_POSI            0x250
>  #define  SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN       BIT(25)
>  #define  SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN       BIT(24)
> @@ -256,6 +260,15 @@ static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
>         sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
>         /* wait 1ms */
>         usleep_range(1000, 1250);
> +
> +       if (read_poll_timeout(sdhci_readl, tmp, (tmp & SDHCI_SPRD_DLL_LOCKED),
> +               2000, USEC_PER_SEC, false, host, SDHCI_SPRD_REG_32_DLL_STS0)) {
> +               pr_err("%s: DLL locked fail!\n", mmc_hostname(host->mmc));
> +               pr_info("%s: DLL_STS0 : 0x%x, DLL_CFG : 0x%x\n",
> +                        mmc_hostname(host->mmc),
> +                        sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_STS0),
> +                        sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG));
> +       }
>  }
>
>  static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
> --
> 2.25.1
>
