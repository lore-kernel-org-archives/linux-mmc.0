Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA1C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 12:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAB461493
	for <linux-mmc@archiver.kernel.org>; Fri, 12 Feb 2021 12:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhBLMXt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 12 Feb 2021 07:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhBLMVp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Feb 2021 07:21:45 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A91DC061797
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 04:21:04 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id 67so2824896uao.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Feb 2021 04:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=viAPb33YtxSHxnpQVLe7jGQrv3iGhRJXuNsfTkuOok4=;
        b=eQCt8zOTdhHceYYUr4pdxt55xg7uHrwEhjuLbuv1gEgBXmOBrEk+i+QU0LXWE47yv7
         AjkWka0zENo1Q5A54c8VuKkhAORf6CptzHCMdRDYdDWxZFfzJMKdub/BtJQ97JnbVzB2
         4Tnck1h/iTFz5CsjEPKXIGR4IkfEtkKniFkdN4s74DKaHszmOZOsZaq3+Aa/uuh6CYGC
         gXyATcIKk+lNLn3mtx1GfABknDJjIJxwrJ2vWQut3U8g9CO/4e6GDqcpajqsT3pqGSJi
         mYQY810kXQX2fFsHcjoeMCh4r1b7QUImbk55XGNFZw9Z27rp3TwbAyQ8IgIbdfC69GIY
         i5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viAPb33YtxSHxnpQVLe7jGQrv3iGhRJXuNsfTkuOok4=;
        b=nSS5Ani7hh1EEoVHKooVDmZKvetPGA2Cta4+M6IvC2zoohjDoGGwB0RX5Fy0xHr/oF
         uv17O/cmeIEwrYbGDlTIU9/IXizz7QzgI13hLaw2LkbArSx30fRddRF84cDwrztkMSx8
         o3OhOtPlUWyAHvOu+rX//jHoPO69s/fRIdXZcYkvu199R5ehdwO+hUGRlgMXrpcvude2
         oKYPAzGFeaxBiyrrxrOXhgNaNcUeo0ndKnK2e6TwswbP6yvynehR6AYhgWIvNOXKpKP5
         Mx1LIra9oq3lJ8G5dMDay6NteUi/r+VchW2LFTcTl4qcv0SaKrYMLDbHq/qjqKFicmrR
         qfXQ==
X-Gm-Message-State: AOAM530QCmm8AuutBSxoKZZVka3RB9C+QHr1RWml87x3GtfeADzvXcz5
        oFlpLsK8GOyHMI7WA4LZWPBTpqvOi91CFWKdFzAh7Q==
X-Google-Smtp-Source: ABdhPJw7rG5WdVMVpFE3X+wUUa8hbj2ZxxnC4+2kK50KrfG5PcDIXOoi2DHzV3UN5xmALH4NXHHbZLhx82Ofs7gdvyQ=
X-Received: by 2002:a9f:3562:: with SMTP id o89mr1236079uao.129.1613132463567;
 Fri, 12 Feb 2021 04:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20210210181933.29263-1-Frank.Li@nxp.com>
In-Reply-To: <20210210181933.29263-1-Frank.Li@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 12 Feb 2021 13:20:27 +0100
Message-ID: <CAPDyKFpjvNmpjB67FGrxvsygtz6EG+8MfGeWocgCoqFboAPxQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: imx: fix kernel panic when remove module.
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lznuaa@gmail.com, Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 Feb 2021 at 19:19, Frank Li <Frank.Li@nxp.com> wrote:
>
> sdhci_esdhc_imx_remove access a register before pm_runtime_get_sync
> the clock may be closed by runtime pm when remove module.
>
> Access register should be after pm_runtime_get_sync.
>
> reduce pm_runtime_set_autosuspend_delay time can increase problem
> reproduce rate.
>
> [ 1811.323148] mmc1: card aaaa removed
> [ 1811.347483] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> [ 1811.354988] Modules linked in: sdhci_esdhc_imx(-) sdhci_pltfm sdhci cqhci mmc_block mmc_core [last unloaded: mmc_core]
> [ 1811.365726] CPU: 0 PID: 3464 Comm: rmmod Not tainted 5.10.1-sd-99871-g53835a2e8186 #5
> [ 1811.373559] Hardware name: Freescale i.MX8DXL EVK (DT)
> [ 1811.378705] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> [ 1811.384723] pc : sdhci_esdhc_imx_remove+0x28/0x15c [sdhci_esdhc_imx]
> [ 1811.391090] lr : platform_drv_remove+0x2c/0x50
> [ 1811.395536] sp : ffff800012c7bcb0
> [ 1811.398855] x29: ffff800012c7bcb0 x28: ffff00002c72b900
> [ 1811.404181] x27: 0000000000000000 x26: 0000000000000000
> [ 1811.409497] x25: 0000000000000000 x24: 0000000000000000
> [ 1811.414814] x23: ffff0000042b3890 x22: ffff800009127120
> [ 1811.420131] x21: ffff00002c4c9580 x20: ffff0000042d0810
> [ 1811.425456] x19: ffff0000042d0800 x18: 0000000000000020
> [ 1811.430773] x17: 0000000000000000 x16: 0000000000000000
> [ 1811.436089] x15: 0000000000000004 x14: ffff000004019c10
> [ 1811.441406] x13: 0000000000000000 x12: 0000000000000020
> [ 1811.446723] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
> [ 1811.452040] x9 : fefefeff6364626d x8 : 7f7f7f7f7f7f7f7f
> [ 1811.457356] x7 : 78725e6473607372 x6 : 0000000080808080
> [ 1811.462673] x5 : 0000000000000000 x4 : 0000000000000000
> [ 1811.467990] x3 : ffff800011ac1cb0 x2 : 0000000000000000
> [ 1811.473307] x1 : ffff8000091214d4 x0 : ffff8000133a0030
> [ 1811.478624] Call trace:
> [ 1811.481081]  sdhci_esdhc_imx_remove+0x28/0x15c [sdhci_esdhc_imx]
> [ 1811.487098]  platform_drv_remove+0x2c/0x50
> [ 1811.491198]  __device_release_driver+0x188/0x230
> [ 1811.495818]  driver_detach+0xc0/0x14c
> [ 1811.499487]  bus_remove_driver+0x5c/0xb0
> [ 1811.503413]  driver_unregister+0x30/0x60
> [ 1811.507341]  platform_driver_unregister+0x14/0x20
> [ 1811.512048]  sdhci_esdhc_imx_driver_exit+0x1c/0x3a8 [sdhci_esdhc_imx]
> [ 1811.518495]  __arm64_sys_delete_module+0x19c/0x230
> [ 1811.523291]  el0_svc_common.constprop.0+0x78/0x1a0
> [ 1811.528086]  do_el0_svc+0x24/0x90
> [ 1811.531405]  el0_svc+0x14/0x20
> [ 1811.534461]  el0_sync_handler+0x1a4/0x1b0
> [ 1811.538474]  el0_sync+0x174/0x180
> [ 1811.541801] Code: a9025bf5 f9403e95 f9400ea0 9100c000 (b9400000)
> [ 1811.547902] ---[ end trace 3fb1a3bd48ff7be5 ]---
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 16732759bfb0..4da4f4734641 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1791,9 +1791,10 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
>         struct sdhci_host *host = platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -       int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
> +       int dead;
>
>         pm_runtime_get_sync(&pdev->dev);
> +       dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
>         pm_runtime_disable(&pdev->dev);
>         pm_runtime_put_noidle(&pdev->dev);
>
> --
> 2.24.0.rc1
>
