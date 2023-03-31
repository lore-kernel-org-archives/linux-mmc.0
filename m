Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA56C77B6D
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 18:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjCaS3j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCaS3i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 14:29:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF231BF49
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 11:29:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id kc4so22057094plb.10
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680287376;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qD6ukNMqLh8xbe//OUXBkQeWDIWWTPMulfjrGa4ng0w=;
        b=a1QkDGheT3QBrNx3Yvty8V1ssg8DNrPBx3dYwUndKpW7HhbFMJgO0r5VaRrTn0nWpi
         5U3lyCwtXBy52UxklvBXq4btDufWfBNmlC+zIvBcke56G1Wb0Jp2F4JhJMjy6gWkgzXY
         jRrXbAUavMRWXfI1fxAOLBMhYe31hTcZPR/lLf1Tegn79Muzj57yYoGDEjUhE0/OjXJc
         0M61DLvGPppGGWNdq2cr54xrwZ4fkTyLk/0gw/dP3JvixY5R6KNY1kvDqAb4kamS7vi4
         WOnMuu0xtTmP3V1IxRKwa/fGDw0YIg6imHLpFP4pPWZJf2+llXO9IqXIFIP1DmMIHDNt
         Lg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680287376;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qD6ukNMqLh8xbe//OUXBkQeWDIWWTPMulfjrGa4ng0w=;
        b=ZYrUyS5BjXCks0U2ABDPX2N6tEyIIFOyYtSEXOXmPTfi1+2gtXq17mR07UGFcMCTWU
         6Yzd4qgRsTq50JLNXNCG2/TlCVjlKKCy5DOf7SEWECKIO8BKmRP3gfxONyM6sTsn13/O
         8LLAtkQh81+UMe13KaEACdHWx9Cpxv3n7U/JFNw3AbGW23vOE5qHPa6kDwHCjMVvUiMc
         b/NCr+3ULEgkeGl7vBAkID2IM/FqcnV1NhBcMK/va1s3J7r6M4ETCgaRs2p2wLMiwHsj
         r4MLzwmvJ0vQo8k6+HStRy8IDv2ci3rY8il3mZCSAQSZVF/sHX3+nJZDbgjEeNGt573p
         wqtw==
X-Gm-Message-State: AAQBX9eP3qIBSsnZCFaTunHAK6/a4PERUKAqjmbOu9X3yN8uQ/w7+9f6
        sNviorjRqdd5QhDcpCZmMIkYQA==
X-Google-Smtp-Source: AKy350YF3V9IxWphaTmJMfqBFHoz7qLNFdg6GAUKjgLhJVUjrrPAR5aJl3+woMpnhIhzBhL5GaEMbw==
X-Received: by 2002:a17:90b:4d89:b0:240:e532:d868 with SMTP id oj9-20020a17090b4d8900b00240e532d868mr2812574pjb.43.1680287376091;
        Fri, 31 Mar 2023 11:29:36 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id iw4-20020a170903044400b001943d58268csm1900704plb.55.2023.03.31.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:29:35 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?= 
        <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
In-Reply-To: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
Date:   Fri, 31 Mar 2023 11:29:35 -0700
Message-ID: <7hy1ncydtc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Alexandre Mergnat <amergnat@baylibre.com> writes:

> This commits are based on the Fabien Parent <fparent@baylibre.com> work.
>
> The purpose of this series is to add the following HWs / IPs support for
> the mt8365-evk board:
> - Watchdog
> - Power Management Integrated Circuit "PMIC" wrapper
>   - MT6357 PMIC
> - MultiMediaCard "MMC" & Secure Digital "SD" controller
> - USB controller
> - Ethernet MAC controller
>
> Add CPU Freq & IDLE support for this board.
>
> This series depends to anothers which add support for MT8365 EVK board
> [1] and the MT8365 I2C support [2]. Both are currently applied.
>
> The DTB check may failed/warn about pinctrl binding, but it should be
> fixed thanks to this serie [3]

It's not just the DTB check that that depends on the pinctrl binding
series.  Patch 2 of this series touches the pinctrl bindings, and does
not apply unless the pinctrl series is also applied.

IOW, I needed to apply [1], [2] and [3] to mainline in order to apply
this series.

After applying the dependencies, the kernel fails to build:

../arch/arm64/boot/dts/mediatek/mt8365-evk.dts:15:10: fatal error: mt6357.dtsi: No such file or directory
   15 | #include "mt6357.dtsi"
      |          ^~~~~~~~~~~~~
compilation terminated.                      

With lots of dependencies like this, it would be useful for you to push
a temporary branch on mainline where you've applied all the dependencies
so we can better see what the dependencies actually are.

Kevin
