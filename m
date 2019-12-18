Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF3CC3F68F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 02:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416AA24680
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 02:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576636043;
	bh=XXM1qIhv6mp83mUAwPbmy0ZfgUh12/5MVM64g+j5teY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ymJbJrFk3Sk6LfjzNnAjKSdn3Vzz10CthWZ7pH96b3A4iX43PxjCHT7kNaUvjnuqo
	 29SR4Xt+bR4UwqP8k7L9MZ8BBRDvspZSHXAHj8z3FpXIj/I1nLnNug5MM1TClNjIgD
	 E6S0+HVN60HvjWllT1+PtbeqNq3b/P1oxB5XpKu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfLRC1W (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 21:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfLRC1W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 21:27:22 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8399124676;
        Wed, 18 Dec 2019 02:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576636041;
        bh=XXM1qIhv6mp83mUAwPbmy0ZfgUh12/5MVM64g+j5teY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCi55Za6H6EHQPAD6URE8PGJGj3b8jufgHzcpYxUrTf1oOUk0J+qMQUm0sPJCtc7r
         6hqTkdqqH/VSIYUPWgFk0SWRXd5zDliUXY7JRQjWGD8UVI/Jkk3JvuQlCMV4fucBh3
         b39jAE0qN9Y0vhBvTYjp72lV3E2ydN0Rtg9KqVu8=
Received: by mail-wr1-f53.google.com with SMTP id w15so579920wru.4;
        Tue, 17 Dec 2019 18:27:21 -0800 (PST)
X-Gm-Message-State: APjAAAVY9VQiY9A3whG4YN9VxAkoWfER8wNrJX57xF5lQLYy4iXs3NUi
        yS3/10cRL52kx+UdDtPrKgVfqsHKO0qVeDAME14=
X-Google-Smtp-Source: APXvYqx5UqcfQ1FFJHQCZKd5vBjgfL46TLBnUHJQVj6I1P5C7P5qttyGdV5lMniGCCRpoGO06aEnPCSAImq8qwlk310=
X-Received: by 2002:adf:81e3:: with SMTP id 90mr1054120wra.23.1576636040002;
 Tue, 17 Dec 2019 18:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20191215175120.3290-1-tiny.windzz@gmail.com>
In-Reply-To: <20191215175120.3290-1-tiny.windzz@gmail.com>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 18 Dec 2019 10:27:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v64uQr6JKCbhY+iMd___bLedvSOMTffg=JDX-pOZHY+sbw@mail.gmail.com>
Message-ID: <CAGb2v64uQr6JKCbhY+iMd___bLedvSOMTffg=JDX-pOZHY+sbw@mail.gmail.com>
Subject: Re: [PATCH 01/13] mmc: sunxi-mmc: convert to devm_platform_ioremap_resource
To:     Yangtao Li <tiny.windzz@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     manuel.lauss@gmail.com, Kevin Hilman <khilman@baylibre.com>,
        chaotian.jing@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>, nico@fluxnic.net,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ben-linux@fluff.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        wsa+renesas@sang-engineering.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>, allison@lohutok.net,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 16, 2019 at 1:51 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Use devm_platform_ioremap_resource() to simplify code.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Acked-by: Chen-Yu Tsai <wens@csie.org>

>  drivers/mmc/host/sunxi-mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index d577a6b0ceae..f87d7967457f 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1273,8 +1273,7 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>         if (ret)
>                 return ret;
>
> -       host->reg_base = devm_ioremap_resource(&pdev->dev,
> -                             platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +       host->reg_base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(host->reg_base))
>                 return PTR_ERR(host->reg_base);
>
> --
> 2.17.1
>
