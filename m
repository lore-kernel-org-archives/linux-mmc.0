Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A8C54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 12:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjAPMRZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjAPMRJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 07:17:09 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7CB1CF5B
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:09 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so30132008plw.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hqj8FFYrjtIpvkQxu1b+PnmFF96AZFCUCFVxl3Uf1EI=;
        b=LZVi3fLl4kPcioH/mGOdgZeRyGD2VbkXrHMRGmqGN/7BL9pFaq6oSyowQNFyFWiWNF
         TCr3/kG4V80L9PSNMUPtbqIuRdead8PrcVxx2hk8rLlHPscotnGCc3dGTyW7woulCeAD
         f+ITiuJqxsWlZdFj11XObNBW1jzhEJcTsPpwm/JxOaW39JLbaXOUt36YEV4BqAqMA2rD
         lYAnXxqow/6iLpaXi4MM2VC6HZ+zWBUjyoxKwfwvv5Ddq8OJreZlt5GUp8fh+IJ0lVHQ
         PHtDPl6HdQtNVzG2ogYCTTZGlwImu1N4vBfnvml+r4aOVoysPfkfnhEJo0e6kOippJfG
         GmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqj8FFYrjtIpvkQxu1b+PnmFF96AZFCUCFVxl3Uf1EI=;
        b=WmWM4FQzvgMRlR+O7fkdamnGeU+z1ZBRI7seMZ8FJDDO5c/9mOTi6avdin13Rm0qqi
         Ek8Dl6/dR1/1sDgujXnoSuHEunGT0d9Fao0NuX3+iFxFL+eV53yRY9ReHlbhO1FWo5BM
         Iubtol2iZ43g6b+0mMADnEchCmttyxgwdkFCxFrqOqPEmT2mfcMDOLoPKBp9cP2720yq
         TT5eNXvB1eZyiTb7v7VFg9dsqmEJ41YEzdKQJOdST5pPjalAUSFGTmn9LI3V43sliajM
         +f6eBHpYPfxWd/BJnoyyQXfr2Y0uZbHddTr6zRhFaUjeU/AajnwyIArqO3J2y77EgMTu
         I1bA==
X-Gm-Message-State: AFqh2krgnzRuR8we4vBPjW55zmFto3yc4hV7qV0igKcuqPuIp94Zv6yk
        INv8aF4eyZkmA9todAQThdZFdr47015U8elUAL98Aw==
X-Google-Smtp-Source: AMrXdXuRSeUw1bY1yGoAr0Zqk6dD3aTOOuZ7TQVZ+MpFYgqTk4mAykG+iWOCZnOZzuFI68EK9tiV9fr/LCWInrI48Ao=
X-Received: by 2002:a17:902:760d:b0:194:6253:d685 with SMTP id
 k13-20020a170902760d00b001946253d685mr722618pll.3.1673871428712; Mon, 16 Jan
 2023 04:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20230113110011.129835-1-adrian.hunter@intel.com>
In-Reply-To: <20230113110011.129835-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:32 +0100
Message-ID: <CAPDyKFqc2WGWZXTMBv3vfUJgWxpMqiZtT-+Vx13nmvRDHLcJEw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: sdhci: Remove SDHCI_QUIRK_MISSING_CAPS
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 13 Jan 2023 at 12:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> This patch set is to remove SDHCI_QUIRK_MISSING_CAPS.
>
> SDHCI_QUIRK_MISSING_CAPS is not needed because __sdhci_read_caps() can be
> called instead.
>
> __sdhci_read_caps() is also called from sdhci_setup_host() via
> sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
> anything because after that host->read_caps has been set to true.
>
> Note, __sdhci_read_caps() does more than just set host->caps, such as do a
> reset, so calling __sdhci_read_caps() earlier could have unforeseen
> side-effects. However code flow has been reviewed with that in mind.
>
>
> Adrian Hunter (6):
>       mmc: sdhci-pci: Replace SDHCI_QUIRK_MISSING_CAPS for Ricoh controller
>       mmc: sdhci-brcmstb: Replace SDHCI_QUIRK_MISSING_CAPS
>       mmc: sdhci-sprd: Replace SDHCI_QUIRK_MISSING_CAPS
>       mmc: sdhci-pxav3: Replace SDHCI_QUIRK_MISSING_CAPS
>       mmc: sdhci-iproc: Replace SDHCI_QUIRK_MISSING_CAPS
>       mmc: sdhci: Remove SDHCI_QUIRK_MISSING_CAPS
>
>  drivers/mmc/host/sdhci-brcmstb.c  |  4 +---
>  drivers/mmc/host/sdhci-iproc.c    | 14 ++++++++------
>  drivers/mmc/host/sdhci-pci-core.c |  8 +++++---
>  drivers/mmc/host/sdhci-pxav3.c    |  4 +---
>  drivers/mmc/host/sdhci-sprd.c     |  6 ++----
>  drivers/mmc/host/sdhci.c          |  3 ---
>  drivers/mmc/host/sdhci.h          |  2 --
>  7 files changed, 17 insertions(+), 24 deletions(-)
>
>
> Regards
> Adrian

Applied for next, thanks!

Kind regards
Uffe
