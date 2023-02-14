Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E70C64EC7
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjBNVjP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBNVjO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 16:39:14 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A237F2914E;
        Tue, 14 Feb 2023 13:39:13 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mc25so6095418ejb.13;
        Tue, 14 Feb 2023 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEXEnkugIFdL0Ne4cj0ASOooSzM+NebkL2xQfGimV1I=;
        b=LOGQQmlrrtyslhxCZq7FxaENf1OLt7gXmBHDXGo2rOO++aHdPrlQs8Zb4MaQZHCggG
         cGlLOghXahi6skESYI3e9yInWsHBjzSk4h3KPI4tKb3ov0UWbRwy56iSX49jO55ambs4
         Zo4NOWnoxHZW//xdFQiNYHdCibsGaJdXQhp6sVsSuNSMBb85PXIS/V/TRjN25sQiCtuH
         bTFfOSkMJKL7JvEZvQVLy1EhrS1vjvBUbHcN6qQRTv6QSYaNK0Px38hWS/15+C91Zutk
         Aov/JJwRXUXeK8EzenMt5RYDvNsLeAqGxggll+5cQYF/ePpAISZG7IoK/UniflPiRtwS
         utEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tEXEnkugIFdL0Ne4cj0ASOooSzM+NebkL2xQfGimV1I=;
        b=kn/nEyjPU53JFUAOhuOPbR8nY4rbzVk5zqh6UeKFWJgWw9VXIjGOUNI0/nYnhOzkLN
         Yn57VnGQRmlrwENUVIRE2kpAAKo2Pqezzk7oPqGqTlV34SVb+VgzBhflv+pWpBRhmhq0
         TBPtXqqJMBOox1kSqunO0qtoOClD6Hc7O9DsEL8e5a7QEcgeIv4V0p8PtrnsKuuZbWxi
         MgSyMGt4WIe+jXcTYNhdAa2SSoQQgjQ10M3vqy1QjDDp/Susx+xHOOwmXFGD9dBVuTbK
         kUmaDxxM/U2/JE2Wc0QJ/iVFcZ9tkEqkuM6D973csSqwMBYvIDBAsnFZIe0NWgVN7nTF
         Z7Sg==
X-Gm-Message-State: AO0yUKUvT8hz8TqNiaqjMUAGj6Y9NLEymK3myA+yIh7QoRmqxgaQFvg5
        SBGYNwg6vnLv3cISZ275hHY=
X-Google-Smtp-Source: AK7set/mSD5r81hS62kdH25mU5YugY0DJUWnsLzPYW7DbBkWHEPacBx+dzCRnQ/WPf9ol8uI4vqYfw==
X-Received: by 2002:a17:906:3c17:b0:8b1:3d04:7b9a with SMTP id h23-20020a1709063c1700b008b13d047b9amr319027ejg.38.1676410751985;
        Tue, 14 Feb 2023 13:39:11 -0800 (PST)
Received: from ?IPV6:2a01:c22:7234:f800:b56b:f43d:948c:eede? (dynamic-2a01-0c22-7234-f800-b56b-f43d-948c-eede.c22.pool.telefonica.de. [2a01:c22:7234:f800:b56b:f43d:948c:eede])
        by smtp.googlemail.com with ESMTPSA id gl11-20020a170906e0cb00b0084d381d0528sm8678168ejb.180.2023.02.14.13.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 13:39:11 -0800 (PST)
Message-ID: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
Date:   Tue, 14 Feb 2023 22:39:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/3] mmc: support setting card detect interrupt from
 drivers and use it in meson-gx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
due to the design of gpio / interrupt controller. Therefore provide an
option for drivers to pass the card detect interrupt number
(retrieved e.g. from device tree) to mmc core.

v2:
- use another mechanism for passing and storing the cd interrupt
- add patch 2

Heiner Kallweit (3):
  mmc: core: support setting card detect interrupt from drivers
  dt-bindings: mmc: meson-gx: support specifying cd interrupt
  mmc: meson-gx: support platform interrupt as card detect interrupt

 .../bindings/mmc/amlogic,meson-gx-mmc.yaml      |  2 +-
 drivers/mmc/core/slot-gpio.c                    | 17 ++++++++++++++++-
 drivers/mmc/host/meson-gx-mmc.c                 |  5 ++++-
 include/linux/mmc/slot-gpio.h                   |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.39.1


