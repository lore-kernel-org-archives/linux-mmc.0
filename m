Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF37C3F2CD
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC68624658
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vt/MiXy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgCDPe4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:34:56 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35350 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCDPe4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:34:56 -0500
Received: by mail-vs1-f67.google.com with SMTP id u26so1416207vsg.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ze9tBstTyboHLILVj0OaEOg6WM5JvwNlZS+aed+FMxU=;
        b=Vt/MiXy1WS2l7JOd9r23uzW+E/m0UMP1u+FKXAXiQSfRyPU5It8gnLlWCNwXsH+0/k
         xFOg7JpMGYLdKfT/CNMAson0IVYutggTQI6JjiF+T7tKuGxZ2fBpVI9zcRVX/uWy0cKz
         kVnA5iLzhMSSX+GKipzmuMLdFysL5ZvhSRLk0srB3X256g9whxGjoGkThZtSYgfyLnhs
         MWZ1XPQlIAEfRw8U40oAt0i+FptPqLy9683Sv6g1KtC1B3tvGSK26iUHww853dclWslD
         rnipnBrKA5a/TIcNuYJ/CuNqRtCe+9EQXtxkprJZc9XERe/NFhMu774eANtx/GnpYSDH
         aHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ze9tBstTyboHLILVj0OaEOg6WM5JvwNlZS+aed+FMxU=;
        b=r/B3VOZ22m5vJz+ZXk5EGAsjNijyea0GS9wIowWa7aKNAiEubjY2DIYHB3HD2r22fp
         KK4zaXluhgSHyYzqYqWaYif5XeTFNScEgG3JeBnS1pzGg4Bkx3j7sInPw6gv4SGFQPwL
         09dF6sbOLKslIFvIFQsgsxdNhTY437ko3RoL36c5BxHHhyJ5J5G90+HpcNxig7o5kewK
         kCwEJrfuv64g6RvP11RenUX4kOTCk/Nw3B4/d5dlIixNfshc+PEsVyph/4pD0jpaKvoj
         LVCNZU86A0Yf4b+rlJbcn/FsrKcGHktu2v8lufe9zCPg8vpQAvejs6KOo838HbnI4Woz
         dIkw==
X-Gm-Message-State: ANhLgQ0PG7qXVWGCOPZJtguDILPS/bCMwfTRo547oXdJP4k4mjInUedm
        vdWTwNuY1zEH5Zp2+5GgmV4S/0tNGzrr8U/4XKGK8g==
X-Google-Smtp-Source: ADFU+vveTLbzpBGaFxPaPpdNfRATyqSltJ2WqjJSE3ZT/DWlLKiwenOYVWEh3hn5fMMe/kzlckQD+lH3I4/pCa6DE2s=
X-Received: by 2002:a67:f4cf:: with SMTP id s15mr2023430vsn.165.1583336093713;
 Wed, 04 Mar 2020 07:34:53 -0800 (PST)
MIME-Version: 1.0
References: <1582100563-20555-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1582100563-20555-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:17 +0100
Message-ID: <CAPDyKFrqWT-zbSviwKYHt_5ek_ge0DP1cfKhf5K8WwxnSEV6EQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] few fix for sdhci-esdhc-imx
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Feb 2020 at 09:30, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> ---
> Changes for v4:
> Add Adrian's ack for patch 9~12
> for patch 13, change to add the check for pinctrl error
> for patch 14, change to judge the dev->dma_parms first, if it not exist, then alloc it.

Series applied for next, but waiting with patch14 for a while, thanks!

Kind regards
Uffe


>
> Changes for v3:
> Add Linus Walleij's ack for patch 2
> for patch 9, drop the use of 'sdhci,auto-cmd23-broken' from dts, change to add flag ESDHC_FLAG_BROKEN_AUTO_CMD23 in the related esdhc_soc_data.
> for patch 10, add a new esdhc_soc_data for i.MX8MM
>
> Changes for v2:
> Add Adrian's ack for patch 1~8
> Patch 9~10, change to use 'sdhci,auto-cmd23-broken' instead of 'fsl,auto-cmd23-broken'
> Patch 11, clear cqhci irq status and halt cqhci, move this change to sdhci_esdhc_imx_hwinit()
> and add some comment to explain the reason.
> Patch 12, add error return check for pinctrl_pm_select_sleep_state()
> Patch 13, clear the DMA_SEL in sdhci-esdhc-imx.c instead of sdhci.c
> Patch 14, add the dev->dma_parms in core/queue.c, instead of host/sdhci.c.
>
>
> Haibo Chen (14):
>   mmc: sdhci: do not enable card detect interrupt for gpio cd type
>   mmc: sdhci-esdhc-imx: no fail when no pinctrl available
>   mmc: sdhci-esdhci-imx: retune needed for Mega/Mix enabled SoCs
>   mmc: sdhci-esdhc-imx: restore the per_clk rate in PM_RUNTIME
>   doc: dt: fsl-imx-esdhc: add strobe-dll-delay-target binding
>   mmc: sdhci-esdhc-imx: add strobe-dll-delay-target support
>   mmc: sdhci-esdhc-imx: optimize the clock setting
>   mmc: sdhci-esdhc-imx: optimize the strobe dll setting
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_BROKEN_AUTO_CMD23
>   mmc: sdhci-esdhc-imx: Add an new esdhc_soc_data for i.MX8MM
>   mmc: sdhci-esdhc-imx: clear pending interrupt and halt cqhci
>   mmc: sdhci-esdhc-imx: clear DMA_SEL when disable DMA mode
>   mmc: sdhci-esdhc-imx: restore pin state when resume back
>   mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
>
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt |   5 +
>  drivers/mmc/core/queue.c                      |  11 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c            | 167 +++++++++++++++---
>  drivers/mmc/host/sdhci-esdhc.h                |   1 +
>  drivers/mmc/host/sdhci.c                      |   2 +-
>  include/linux/platform_data/mmc-esdhc-imx.h   |   1 +
>  6 files changed, 161 insertions(+), 26 deletions(-)
>
> --
> 2.17.1
>
