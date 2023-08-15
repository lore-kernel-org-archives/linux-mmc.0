Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BE0C001B0
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Aug 2023 11:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbjHOLla (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Aug 2023 07:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbjHOLlZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2023 07:41:25 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FDB1984
        for <linux-mmc@vger.kernel.org>; Tue, 15 Aug 2023 04:41:22 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d64f0c2bc95so4452590276.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Aug 2023 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692099682; x=1692704482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J4N1vFKm98r9vL5Jh5sxV8586i7eO9cMGxgErXba+/4=;
        b=gstOxz0CoTIqJau6woT1ch73JnX4xfIaWwxe094kc1tw5F/w4tdmTWGr75VboyLWcM
         MXS5br/0cckaekWTsnLlA3ww6+ouYP8k8rdVDEw0iiKY0tLlhRx7Y/lTGWNYENoBsnKK
         T3ZRCiocQHmLtbTGD48rWlJ/0pxi+MyWc+wgTP+tYKT7EVk2y8l9q4IMNRh4rsOj5zc/
         qj+eZWUcGV6kdR7Dv5VGOAWp6nzpoc6FfvEnfIoAYOhu9VsbUmJJDumqO3ao1O2QZlkq
         aWa2N4ULCkSEQbi1m3dwK2xhenQ79BU+L82M6EYOEn0iQpQbI/1ar7zGvRF3YdU5k0PJ
         Gsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099682; x=1692704482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4N1vFKm98r9vL5Jh5sxV8586i7eO9cMGxgErXba+/4=;
        b=jAlWqy/qlhuZc+Srb2cbW9myZiLXQ2zxLszuHQAPzGCXx+5SDg+ILMZZno6mtTS3PV
         T06uOMad6WhZhyFLw42S9Pybxg+IBsNbYWMfrtnRh0Dvkx9RbZM4nhurixFtzYBXKvuw
         GsXjLtq1s/8pTTdic+jXa1r/y7Cqot/6ZjH4OYdq3vX6TR6uD2TOaJkbns9f3YlRoFdm
         QXpSi6lr5u1VtijV9XGWNUTH9XjbNZF1M+lkk5CX+n5oNahea1KBfeZN96PHkERW1Db1
         RYNH0HnEVp+fi1DwiK9Ai26/RkAgeIJ2LeK+yT2zjzpmuJTaJQmGsDNRZvSsIF6pAlxE
         /EpQ==
X-Gm-Message-State: AOJu0YyumZ11gZyNjFoWvIi4WCL+J6o+vC7EMuPm86pWJZ0DzNv/MOM4
        i57quuDaf0pWyIpjUjFCAJaxRGnV/sapaNLhVGhH6w==
X-Google-Smtp-Source: AGHT+IEIAsC6RK376JyprtRFIyknlP7H7j8/Aqc8TKJ/xLDgxozFxS+HxDwj0bExgLR8ZiRgeyS/eLLAaNDqLn3YRww=
X-Received: by 2002:a05:6902:18ca:b0:d5c:fb65:7e72 with SMTP id
 ck10-20020a05690218ca00b00d5cfb657e72mr16923086ybb.65.1692099681618; Tue, 15
 Aug 2023 04:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230811130351.7038-1-adrian.hunter@intel.com>
In-Reply-To: <20230811130351.7038-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Aug 2023 13:40:45 +0200
Message-ID: <CAPDyKFrevs3TVcn_2b7RKR8ZxKUHQgxj3sA-FcXt0L3euujKMw@mail.gmail.com>
Subject: Re: [PATCH 00/16] mmc: sdhci-pltfm: Minor clean up
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Michal Simek <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Brian Norris <briannorris@chromium.org>,
        Ye Xingchen <ye.xingchen@zte.com.cn>,
        Brad Larson <blarson@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Swati Agarwal <swati.agarwal@amd.com>,
        Andy Tang <andy.tang@nxp.com>,
        Georgii Kruglov <georgy.kruglov@yandex.ru>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Doug Brown <doug@schmorgal.com>,
        Li Zetao <lizetao1@huawei.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Aug 2023 at 15:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> sdhci_pltfm_unregister() does:
>
>         clk_disable_unprepare(pltfm_host->clk)
>
> which prevents drivers from using devm_clk_get_enabled() or similar.
>
> Move it out, and where drivers are doing devm_clk_get*() immediately
> followed by clk_prepare_enable(), combine them into devm_clk_get_*enabled().
>
> sdhci_pltfm_register() and sdhci_pltfm_unregister() are not paired functions.
> That are just helpers and effectively get renamed:
>
>         sdhci_pltfm_register() -> sdhci_pltfm_init_and_add_host()
>         sdhci_pltfm_unregister() -> sdhci_pltfm_remove()
>
> Please note, the patches are based on top of some
> "Convert to platform remove callback returning void"
> patches by Yangtao Li, which were posted here:
>
>         https://lore.kernel.org/linux-mmc/20230727070051.17778-1-frank.li@vivo.com/
>
> Patches can also be found here:
>
>         https://github.com/ahunter6/linux/commits/sdhci-pltfm-cleanup-1
>
>
> Adrian Hunter (16):
>       mmc: sdhci-pltfm: Add sdhci_pltfm_remove()
>       mmc: sdhci-bcm-kona: Use sdhci_pltfm_remove()
>       mmc: sdhci-brcmstb: Use sdhci_pltfm_remove()
>       mmc: sdhci-cadence: Use sdhci_pltfm_remove()
>       mmc: sdhci-dove: Use sdhci_pltfm_remove()
>       mmc: sdhci_f_sdh30: Use sdhci_pltfm_remove()
>       mmc: sdhci-iproc: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-arasan: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-at91: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-esdhc: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-hlwd: Use sdhci_pltfm_remove()
>       mmc: sdhci-of-sparx5: Use sdhci_pltfm_remove()
>       mmc: sdhci-pxav2: Use sdhci_pltfm_remove()
>       mmc: sdhci-st: Use sdhci_pltfm_remove()
>       mmc: sdhci-pltfm: Remove sdhci_pltfm_unregister()
>       mmc: sdhci-pltfm: Rename sdhci_pltfm_register()
>
>  drivers/mmc/host/sdhci-bcm-kona.c  | 12 +++++++++++-
>  drivers/mmc/host/sdhci-brcmstb.c   | 18 +++++-------------
>  drivers/mmc/host/sdhci-cadence.c   | 17 ++++-------------
>  drivers/mmc/host/sdhci-dove.c      |  8 ++------
>  drivers/mmc/host/sdhci-iproc.c     | 14 +++-----------
>  drivers/mmc/host/sdhci-of-arasan.c |  4 +++-
>  drivers/mmc/host/sdhci-of-at91.c   |  2 +-
>  drivers/mmc/host/sdhci-of-esdhc.c  |  2 +-
>  drivers/mmc/host/sdhci-of-hlwd.c   |  4 ++--
>  drivers/mmc/host/sdhci-of-sparx5.c | 17 ++++++-----------
>  drivers/mmc/host/sdhci-pltfm.c     | 14 ++++++--------
>  drivers/mmc/host/sdhci-pltfm.h     |  8 ++++----
>  drivers/mmc/host/sdhci-pxav2.c     | 19 ++++++-------------
>  drivers/mmc/host/sdhci-st.c        |  4 +++-
>  drivers/mmc/host/sdhci_f_sdh30.c   |  2 +-
>  15 files changed, 58 insertions(+), 87 deletions(-)
>
>

Applied for next, thanks!

Kind regards
Uffe
