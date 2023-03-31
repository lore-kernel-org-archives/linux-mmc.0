Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC48AC76196
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 18:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjCaSqM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjCaSqL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 14:46:11 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244491DFA5
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 11:46:05 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5419d4c340aso431404847b3.11
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680288364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb6xLZTQTQfDOfnoLhLa6/IVI8QnMb1cauJ4IIp9pzk=;
        b=T8YJTdeMYbb5+drzr4PfwSAPqM0g2ur1tDsqj0l9TLQw8+V2H3RKsATUpFv8ILGFeF
         jRgBFoslWA5UWvvGMuGLLKHXjoEfsJxZm/z12TEe2Ri8mBh0nVkcqjnIuPrmYW2OVUyR
         SGb72wCQFq79qxru/phdmgHFLqNKp0YzEvHeOUu+3ej1ML+s4JtnpHUal4G1GDqGMk65
         yFegAuuOH8/q7xvzzcfwcOXRA32jXAxxKYjnX3GRrS/h//SZb5nyl+gqSulMDW+8RMYl
         P2hdl1o9gO5QKMKl9toztNs0lmlfUhD3IU6Y+rJlz3r0Mm1SGP57kPMihEtIJIH/JT1o
         MrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zb6xLZTQTQfDOfnoLhLa6/IVI8QnMb1cauJ4IIp9pzk=;
        b=q6IQ2kM28k+vJYEeLtzktLXzhyqLInH6fzra0jRiqM54TlmoFPUdfKn7qqUwInddst
         ZX87Sra/Coe0TrvnhYHW4DkCovwikopOhDQukJ19K8O6veFbnfdqthQokQmI3hvVcZga
         iIohekSgTM57jC/K1JInE+x/LOMQk/Qqdn44+z0SKbyxEIVot6hB++50xXPywQsCxw/b
         kU+A9fHxlGK+lLidwVfOF466/0/WqjQ/5HTkMmocZyu+GK2N32+3vEhgtxdRlVecEmNg
         aBM/0Uk9218hnxYFs6gZIykgx5tv9EgqY0p1hco02+L8COhU4fqt+zi/BlJzRa6HMiwO
         G/uw==
X-Gm-Message-State: AAQBX9cnZqdZBx2JGdNHsTMTav3LtVQG6gJuQkrtLspFBhzZUpMZpW2M
        fAcom7x96zjmA45SJIxlaN2wb0aiJURRILgQ7oY7fA==
X-Google-Smtp-Source: AKy350bgwepPnwHMRW0YSZuNpQ8dtHQVLT8+IDDu10nrt86RgYns1z2FMH6EnSP3ABnDRvDAIqVyiIAEzbdJAM+G6zI=
X-Received: by 2002:a81:ac55:0:b0:546:1e9e:aa01 with SMTP id
 z21-20020a81ac55000000b005461e9eaa01mr6163297ywj.3.1680288364273; Fri, 31 Mar
 2023 11:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com> <7hy1ncydtc.fsf@baylibre.com>
In-Reply-To: <7hy1ncydtc.fsf@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 20:45:53 +0200
Message-ID: <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

You forgot to apply the patches merged by Matthias:

Changes in v4:
- Remove v3 applied patch from the serie:
  - arm64: dts: mediatek: add ethernet support for mt8365 SoC
  - arm64: dts: mediatek: add mmc support for mt8365 SoC
  - arm64: dts: mediatek: add mt6357 device-tree
  - arm64: dts: mediatek: add pwrap support to mt8365 SoC
  - arm64: dts: mediatek: Increase the size BL31 reserved memory

...

Changes in v3:
- Remove v2 applied patch from the serie:
  - dt-bindings: mmc: mediatek,mtk-sd: add mt8365

Regards,
Alex
