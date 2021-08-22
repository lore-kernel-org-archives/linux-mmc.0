Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1D6C432BE
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Aug 2021 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8116102A
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Aug 2021 10:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbhHVKc6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbhHVKc5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 06:32:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B27C061575;
        Sun, 22 Aug 2021 03:32:16 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so16750381pjb.3;
        Sun, 22 Aug 2021 03:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hQj5hxFiqLom8YIi6YlB58FDTgWBUik0cwCE54AMCVw=;
        b=R8C8lTWTUW+KgqVpcRCRbQGT3c4g3H2PFiCko36yeUJ8jSx8PM+DssNQqPPVLfsrfw
         Nsc1nKBH0iaPcM2kF0Lgnz7X0uYq5D/ZyAb6HxtI89IC+PPKE9fyvug7VIRDeTtTmfuS
         5pOldl+e7SalRpNeBYO+6qb/5yYfIbIs7eA4gSj17gWkR4PcnonGbe1iF68eTPcI08an
         gjOWIrLiWgTUr59D5a9yjTmACIREyx9eDQKIam3f0rI38oZrwbwF1RZnC4R7B0yQQlIV
         vPZx14Cn645FmhHp5mI1LRo6qQ7e/bDKvmU6pfWpMEafUoo4rXdRPRNnTgD9q+J09dv0
         wJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hQj5hxFiqLom8YIi6YlB58FDTgWBUik0cwCE54AMCVw=;
        b=tzDdmpfjJExyz9K2kWHw/qIv7X3F7hT2/fUnuiiBhp3XuACC4rO7PhfQcjavyJ0cNL
         lunV14Jh27KMB8gUldiY0dxtEngZUfMHs0tChmIu3slxjiNY1vZiEid+wxvQ7r/MyqJI
         AlWbIwW0exRYRPjA7erRHAc9OVWb5ya+PzWdnhQEYFnPVW2R6hr1TTpAFVChgl/DMAa5
         OQl74ltUwh/P8DoFiCZ6gOPEP/HI84eGD58zhQZQeCGnZZYt3jlDo0hLP2v1wCAN1Itb
         6k69lgrW+p9ye9hrk2YI0dfeL83R+rQbRxtf1yqMTdUWRHuiYETMwE9Qyc3zLzKU5ElS
         Up+g==
X-Gm-Message-State: AOAM531o1QbtLbGq4S6cqy2BFD/WQ40CDuLu8dQwzK3spe+GZPCX6apI
        UER1lp9+x2casH7E4LM63Bc=
X-Google-Smtp-Source: ABdhPJzHwqbDwoJSEscKZMXLfyYCuP5AiKczhok2dYkcbu7dQU3jiHKKBGvc9NS2g6UnZrcctYS5iw==
X-Received: by 2002:a17:90a:3d4d:: with SMTP id o13mr14593378pjf.34.1629628336342;
        Sun, 22 Aug 2021 03:32:16 -0700 (PDT)
Received: from [192.168.1.22] (amarseille-551-1-7-65.w92-145.abo.wanadoo.fr. [92.145.152.65])
        by smtp.gmail.com with ESMTPSA id m18sm11376080pjq.32.2021.08.22.03.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 03:32:15 -0700 (PDT)
Subject: Re: [PATCH V2 00/10] ARM: dts: Add Raspberry Pi CM4 & CM4 IO Board
 support
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fb80f7a5-8fd4-73e3-4c64-77f120546cc4@gmail.com>
Date:   Sun, 22 Aug 2021 12:31:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 8/7/2021 1:06 PM, Stefan Wahren wrote:
> This series add support for the Raspberry Pi Compute Module 4 and its
> IO board.
> 
> Changes in V2:
> - drop emmc2bus patch as it affects userspace (thanks to Marc Zyngier)
> - tested with CM4 and integrate sdhci patches from Nicolas (just include kHz fixups)
> - add Rob's Acked-by
> - add HS200 property to emmc2 node for a slight performance gain
> - move antenna comment to the proper position

Nicolas, I am assuming you will be picking up these patches and submit a 
BCM283x pull request with them. Thanks!

> 
> Nicolas Saenz Julienne (2):
>    mmc: sdhci-iproc: Cap min clock frequency on BCM2711
>    mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711
> 
> Stefan Wahren (8):
>    ARM: dts: bcm2711: fix MDIO #address- and #size-cells
>    ARM: dts: bcm2711-rpi-4-b: fix sd_io_1v8_reg regulator states
>    dt-bindings: display: bcm2835: add optional property power-domains
>    ARM: dts: bcm283x-rpi: Move Wifi/BT into separate dtsi
>    dt-bindings: arm: bcm2835: Add Raspberry Pi Compute Module 4
>    ARM: dts: Add Raspberry Pi Compute Module 4
>    ARM: dts: Add Raspberry Pi Compute Module 4 IO Board
>    arm64: dts: broadcom: Add reference to RPi CM4 IO Board
> 
>   .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   1 +
>   .../bindings/display/brcm,bcm2835-dsi0.yaml        |   3 +
>   .../bindings/display/brcm,bcm2835-hdmi.yaml        |   3 +
>   .../bindings/display/brcm,bcm2835-v3d.yaml         |   3 +
>   .../bindings/display/brcm,bcm2835-vec.yaml         |   3 +
>   arch/arm/boot/dts/Makefile                         |   1 +
>   arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |  42 ++-----
>   arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts           | 138 +++++++++++++++++++++
>   arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi             | 113 +++++++++++++++++
>   arch/arm/boot/dts/bcm2711.dtsi                     |   4 +-
>   arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  31 ++---
>   arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         |  36 ++----
>   arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  36 ++----
>   arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  36 ++----
>   arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi         |  34 +++++
>   arch/arm64/boot/dts/broadcom/Makefile              |   1 +
>   .../arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts |   2 +
>   drivers/mmc/host/sdhci-iproc.c                     |  21 +++-
>   18 files changed, 366 insertions(+), 142 deletions(-)
>   create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts
>   create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
>   create mode 100644 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi
>   create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
> 

-- 
Florian
