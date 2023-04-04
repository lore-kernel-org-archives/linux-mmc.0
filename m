Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4230C77B62
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 20:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDDUbk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjDDUbi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 16:31:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C934C25
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 13:31:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id ja10so32464264plb.5
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680640295;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOVeDn8sGMiyUFHnj/niym7+yJLePku8ZuvCvpjBjFA=;
        b=d2PfSMqYfgsZroD2KnzQMRj0RMGsWfZOj8Pbma82DQC/fdoAL7fp4u3QRYiYy0KsxD
         7J2e/+s31Z1QQnI/qyqshLlDgu+gpXILHPK0Jdtbp3wfz5cn4ytd1IDNsyWG6Zs1qD9b
         WATap2+gj3/N62oIZ6s5sB34NSYCjItBlYteXFqgR861/Fh/7zmJzj7RjnwFpMvGYD+s
         TwK/P/yR8kLl7NVvE9VrRC860srGxgFh4X0TVV1Q2pUt3Ikfyq1u1wpY/jIXj2TyS7JN
         gNzlm+DEd4jK9eCkoSfSMTV0tHcgHYjdqxZik2z7GkUwOBDBEZeyDropDBoOwbivkXiD
         tIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640295;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOVeDn8sGMiyUFHnj/niym7+yJLePku8ZuvCvpjBjFA=;
        b=fRaLeOxEaNNGHoEisdZ5EsaG695ILcNNAVWkBkSyFnRd/2Bw8LPFGgR7ID17LsqrAO
         Ti4PiX5DZRadVxtGVIiUkQpTN1dYUyuZQWHh16xBbq1UJ+K+vbCz3NSO9oL8Rdj8hUnh
         neHAuQnAKs/mg8VhkbctBFxEp5Wr5fRb/U7lqenAEU14RCK/yD0G7KCwwrCeAijNlcH7
         +Rw07qvtbbJFDB2FqOHSbjkr43bDwuPt7VDTvBCWVVDa7ctYH/hxyaHrCrHRJUwqQi5S
         F2Yta1O07qF3Jc+TpNE1EQ5lCTMeYvTtCWyo5ZwehvRTwAQPp6fSYLekBT9zyiAERNBn
         uByA==
X-Gm-Message-State: AAQBX9foyDDok6uKqPlrbWp1X/mevOmkIPRXQ0teNRDQDqQkmvYYMuxz
        dKzYlIyxqOQHU0kNPkL7kiLFmw==
X-Google-Smtp-Source: AKy350YCpPag6hyvNnZwcBiqsXWIy1NnNsjRyvNEOMoKbr9kgeRuFVAQ98Nq/oUQ25+hXB9CQPoU3Q==
X-Received: by 2002:a17:90b:3ece:b0:22c:6d7c:c521 with SMTP id rm14-20020a17090b3ece00b0022c6d7cc521mr4045682pjb.45.1680640294866;
        Tue, 04 Apr 2023 13:31:34 -0700 (PDT)
Received: from localhost (63-228-113-140.tukw.qwest.net. [63.228.113.140])
        by smtp.gmail.com with ESMTPSA id jm21-20020a17090304d500b001a1fe42a141sm8706184plb.115.2023.04.04.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:31:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>
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
        Bernhard =?utf-8?Q?Rosenkr=C3=A4n?= =?utf-8?Q?zer?= 
        <bero@baylibre.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
In-Reply-To: <CAFGrd9qLzcDJO_Fk_-B6XYuuxQzQoYLXmdp0Qj1Tszr0-sqNgw@mail.gmail.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
 <7hy1ncydtc.fsf@baylibre.com>
 <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
 <CAFGrd9qLzcDJO_Fk_-B6XYuuxQzQoYLXmdp0Qj1Tszr0-sqNgw@mail.gmail.com>
Date:   Tue, 04 Apr 2023 13:31:33 -0700
Message-ID: <7hr0szwfru.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Alexandre Mergnat <amergnat@baylibre.com> writes:

> Here a build-able & working branch with dependencies:
> https://gitlab.baylibre.com/baylibre/mediatek/bsp/linux/-/commits/amergnat/i350-evk-board-support

Thanks for a branch with all the dependencies.

This branch builds & boots, but crashes because in the upstream default
defconfig, the CPUfreq driver is built-in and the regulator that it
depends on is not enabled.

Changing CPUfreq to be modular with CONFIG_ARM_MEDIATEK_CPUFREQ=m
allowed me to boot to a shell on mt8365-evk.

This suggests that this series needs some defconfig patches to enable
the new features, preferably as modules.

It's probably OK that the defconfig patch(es) come as a separate series,
but not sure what Matthias' preferences are here.

Kevin

