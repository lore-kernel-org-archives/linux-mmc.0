Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B979C71155
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 10:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C0C221FB
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 10:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgLBKzA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 05:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgLBKzA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 05:55:00 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE85DC0613D6
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 02:54:19 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id x4so329218uac.11
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 02:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3AO6wTcW0VKva/E9cCl1XzsWI4FnSxYu14wq7bMOwrs=;
        b=jJzyK8qKF4PqraOHQbgbbSS4ZFk8uVvJeG5z1cqZDE5GUF0veD5IetBtJhYZUITTpv
         NLGjgmD5JKWmaMzyt+yJoaTs2dQiWmRfw3n3Dk/Uojm2ZSG4zI5FInZBsgRDdZsa3zu9
         ziPdnTm1/KMenBSqIJ7UJb8xpAikYNe1wdNeCG55Ckh7rCyGVpEv2vbtCjBr5un34tko
         2HDceWNZIadaa6WNn+ly8ET//zneEGG7xdWjxzyVOZol9gpEYJ4qd5fkUK2M8WqAQG1k
         mk99YaNaLGsry7ODmkDqI1kU6RMI5EYTSriQLDgv360SSWARZCQ0OTyWkQaYOY6LOU1y
         WSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AO6wTcW0VKva/E9cCl1XzsWI4FnSxYu14wq7bMOwrs=;
        b=HQWyhlxwPiRcAxrUrGUSFXblbfaH3fEr9wmRi2lCMyqPMm9GwNmAd8L2NRbHeLJRF8
         7Hl13IsARyW7mcB+NuwGviq8Smwe5LabiKO+J+MgC5O+lqBIhEr95SMD+9QBsIgBGyST
         QPXZv6BweSHQqfsKkQ7zGsve0j/CNVxFTUH8TXGZ8oN8lxiEgP0had0vXMli8ipMAS96
         QewrZmOrYdXdBB+nIQ792HN2TXaWc+OzteZ7xTXEqd3MZZeyX+mlSvfK8lmYmjBlhF1K
         b4CGX0FcsgPIXx5EfliuDs4wDglTiDrrYomq3is0k4rQ92AK2myTxzRNRXMhCO5M1wc+
         Evdg==
X-Gm-Message-State: AOAM533KjLlyPvMebWHb+d6rxsP/7JPIc9LOXHnYBsg+mHyoRLjsQJPV
        hGAS6fzqV/Pzotep7TkXRvEApOVctWlmRQrHdcKCEw==
X-Google-Smtp-Source: ABdhPJyfka2hDgmvrtlvdOv2ihNfujrV30WPtKeHP+7dTYNTjAsDAqGZF/E5PvPLLwSEMo6Cgs1d2ZnlYTB+Ge09Jfs=
X-Received: by 2002:ab0:60b1:: with SMTP id f17mr940652uam.104.1606906458917;
 Wed, 02 Dec 2020 02:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Dec 2020 11:53:42 +0100
Message-ID: <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        mgross@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Dec 2020 at 08:02, <muhammad.husaini.zulkifli@intel.com> wrote:
>
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Hello
>
> This patch series adds UHS-1 Support for Keem Bay SOC.
>
> Patch 1 : Add struct device *dev in probe func(),so that dev pointer can be widely use in probe to make code more readable.
> Patch 2 : Export function to be use by device driver to configure voltage rail output.
> Patch 3 : Defined the DT binding to support the UHS-1 operation.
> Patch 4 : Gives an overview of how voltage operations happen to support UHS-1 mode for Keem Bay SOC.
>
> All of these patches was tested with Keem Bay evaluation module board.
>
> Kindly help to review this patch set.

This version looks a lot better to me, but I am still requesting you
to model the pinctrl correctly. I don't see a reason not to, but I may
have overlooked some things.

Would you mind to re-submit to include the gpio/pinctlr list and the
maintainers, to get their opinion.

Kind regards
Uffe

>
> Thank you.
>
> Changes since v5:
> - Restructured voltage operation for io bus line in one function and added comments in sdhci-of-arasan.c.
> - Use gpio regulator modelling for expander pins.
> - Add DT Bindings for phys, vmmc and vqmmc supplies.
> - Renamed func name and added comments for firmware header files.
> - Update commit message for each patchs to describe what goes on.
>
> Changes since v4:
> - Fixed comment by Andy and Sudeep on first patch.
> - Add Acked-by tag.
> - Fixed comment by Michal and Andy on the third patch to replace current users of &pdev->dev.
>
> Changes since v3:
> - Add Dt bindings for uhs gpio.
> - Fixed comment by Michal and Sudeep on header file for the macro and error code.
> - Fixed comment by Andy and created 1 new patch to separate the struc dev pointer in probe func.
> - Fixed comment by Michal in arasan controller code.
>
> Changes since v2:
> - Removed Document DT Bindings for Keembay Firmware.
> - Removed Firmware Driver to handle ATF Service call.
> - Add header file to handle API function for device driver to communicate with Arm Trusted Firmware.
>
> Changes since v1:
> - Add Document DT Bindings for Keembay Firmware.
> - Created Firmware Driver to handle ATF Service call.
> - Provide API for arasan driver for sd card voltage changes.
>
>
> Muhammad Husaini Zulkifli (4):
>   mmc: sdhci-of-arasan: Add structure device pointer in probe func
>   firmware: keembay: Add support for Trusted Firmware Service call
>   dt-bindings: mmc: Add phys, vmmc and vqmmc supplies for Keem Bay SOC
>   mmc: sdhci-of-arasan: Enable UHS-1 support for Keem Bay SOC
>
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |   6 +-
>  drivers/mmc/host/sdhci-of-arasan.c            | 282 ++++++++++++++++--
>  include/linux/firmware/intel/keembay.h        |  54 ++++
>  3 files changed, 322 insertions(+), 20 deletions(-)
>  create mode 100644 include/linux/firmware/intel/keembay.h
>
> --
> 2.17.1
>
