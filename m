Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B00EC10F1B
	for <linux-mmc@archiver.kernel.org>; Sat, 10 Dec 2022 22:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLJWHc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 10 Dec 2022 17:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiLJWHW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Dec 2022 17:07:22 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F212083;
        Sat, 10 Dec 2022 14:07:20 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 754C61C0002;
        Sat, 10 Dec 2022 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670710038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ueh8h8K5la+rt80fMQ8vcYLiSzG6Mqr+N8q3yCay810=;
        b=Zv8t/FhTd1Zc2QlXoRmxmacKAZv75Rfx3VVjjTJns95L95S8o352asFO7BYWrY0IIsdnl8
        lHxeqg2CWb6BSAQzY7ZeV6YBsa4zQD88dIX3uDi459AKB0ZVgTdZukGZe+eM02YXuSH9Rx
        J7TNQLGd29uFin7i6PDyyAdPhQVV929JwWWbk5mX6owi7CHB4wXcsE3ilKaAFaBwNBrtDU
        UZXWRd5dvg5KlxiDvDkAO0VB0vLCf9tlZZjN0K/iSInx7RiGuHboPdNgBzNNosDnGmVzbR
        R+snAOpDsaRqivcL9kcaNdpu2Mm+SMX9Nvw0WHqqllaPmrJ0+qtmj3uCavQWoA==
Date:   Sat, 10 Dec 2022 23:07:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Russell King <linux@armlinux.org.uk>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org
Subject: Re: (subset) [PATCH 06/12] dt-bindings: rtc: convert rtc-meson.txt
 to dt-schema
Message-ID: <167070996827.280754.10880226731567626980.b4-ty@bootlin.com>
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
 <20221117-b4-amlogic-bindings-convert-v1-6-3f025599b968@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-6-3f025599b968@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Nov 2022 15:33:32 +0100, Neil Armstrong wrote:
> Convert the Amlogic Meson6 RTC bindings to dt-schema.
> 
> 

Applied, thanks!

[06/12] dt-bindings: rtc: convert rtc-meson.txt to dt-schema
        commit: 800b55b4dc62c4348fbc1f7570a8ac8be3f0eb66

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
