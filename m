Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DFCC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B132074F
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpOet+5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgG0NKL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0NKL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2020 09:10:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754FC061794;
        Mon, 27 Jul 2020 06:10:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so17157461ljc.5;
        Mon, 27 Jul 2020 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8aJgTeOOMNvC3X35ZPNyQ7MJmZxrJEivSO6dpNlY0w=;
        b=YpOet+5OohAKeocqhV4KRLZsIftxN6qyrcm78/wxaBs4d531oO5QKTKrZAavKghZL1
         pCvTUMj6CTUQ7v/+BuleaUG+AhkLfMHR3pY4oYBx5YzOCRaa/7hEJ2fd3CUvYiZIHVsJ
         YhVqVLUXSKvLjP2D3TReIOkhipMEb03uXaymu+V+PtUQ4Mj/bMQ5pnv2WGm1toyTWaFy
         TVznEBSh19VXP+D2rafhgJJLiuV1/YzcVhg7LbMTkvVkKtaioOBnzibXP9GPx3C85zqq
         Q1V6b2Yrfk2meVn+ZJe9/8si9mV1w3U2qX92U8RK+Ih6CAN0M8VfxziWYQ8JgrrTWrj6
         xPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8aJgTeOOMNvC3X35ZPNyQ7MJmZxrJEivSO6dpNlY0w=;
        b=RAYuWxAddQxooYjf7nVcS6fyNBErfL5tsUFzqmYworOA9hLbR/CoBBsU00v2n6choj
         AYZkn7ZEJ9uuzqQZISiWsyMBdfhK9ZpM8sJ9K4mNXV0dI/4uP/Rwyo8sF08amc3vOyCm
         BEwPAISwshsDZ8+rrgPvfMPvYm8efBMXPwrjFjVwqjdV4NjqHvpc/h2xxgjhpghVSkqI
         gAs+332hD5rpiZGuRdpaucWXzuflBKRxnBtHBqMnfvjJ9kPBjKPgLsijNTaOYfBdMJY8
         oM15SiSJYDCuZLpOUL1qigVBG6/Dz2Gb39rNlDw/WKWDiE2JX9QSay+DOEkaxZstzyET
         WILw==
X-Gm-Message-State: AOAM532rWUhSAxAiRn/q0kc6wU1CcbxVLM/m9djy2F5n6u21aI59a0Vh
        wYAiiQ2t8hYGEIM8YseL4bEufgmB
X-Google-Smtp-Source: ABdhPJwnoGvwlTb4Q7yMAGl31ThQ1KF8qea01jP6Ay2SV7pxHkffrZcL4Kvcg7FIL4wXQC4qb+FkRQ==
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr9415769ljm.343.1595855409032;
        Mon, 27 Jul 2020 06:10:09 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-12-16.pppoe.mtu-net.ru. [91.76.12.16])
        by smtp.googlemail.com with ESMTPSA id l19sm2348443ljb.15.2020.07.27.06.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 06:10:08 -0700 (PDT)
Subject: Re: [PATCH] mmc: tegra: Add Runtime PM callbacks
To:     Aniruddha Rao <anrao@nvidia.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1595854036-15434-1-git-send-email-anrao@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ea1a68b6-2399-f7ae-a336-bd1e14793b52@gmail.com>
Date:   Mon, 27 Jul 2020 16:10:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595854036-15434-1-git-send-email-anrao@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

27.07.2020 15:47, Aniruddha Rao пишет:
> Add runtime suspend/resume callbacks to save power
> when the bus is not in use.
> In runtime suspend
> - Turn off the SDMMC host CAR clock.
> - Turn off the trimmer/DLL circuit(BG) power supply(VREG).
> - Turn off the SDMMC host internal clocks.
> 
> Re-enable all the disabled clocks/regulators in runtime resume.
> 
> Signed-off-by: Aniruddha Rao <anrao@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 149 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 140 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 0a3f9d0..1b4b245 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -23,6 +23,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ktime.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -36,6 +37,7 @@
>  #define SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE		BIT(5)
>  #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
>  #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
> +#define SDHCI_CLOCK_CTRL_SDMMC_CLK			BIT(0)
>  
>  #define SDHCI_TEGRA_VENDOR_SYS_SW_CTRL			0x104
>  #define SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE		BIT(31)
> @@ -51,6 +53,9 @@
>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
>  #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
>  
> +#define SDHCI_TEGRA_VENDOR_IO_TRIM_CTRL_0		0x1AC
> +#define SDHCI_TEGRA_IO_TRIM_CTRL_0_SEL_VREG_MASK	0x4

Hello Aniruddha,

Does this register exist on older Tegra SoCs?
