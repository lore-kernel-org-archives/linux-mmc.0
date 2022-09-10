Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B0C6FA8B
	for <linux-mmc@archiver.kernel.org>; Sat, 10 Sep 2022 07:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiIJHq3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 10 Sep 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIJHq1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Sep 2022 03:46:27 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F916FA28
        for <linux-mmc@vger.kernel.org>; Sat, 10 Sep 2022 00:46:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so6516536lfr.2
        for <linux-mmc@vger.kernel.org>; Sat, 10 Sep 2022 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Xc325GZc+vxzGRAdvA0vChIvJkypnglJvofgNCbWMR4=;
        b=CPmvcoQIYyMAF4zt3FXqNSoDD7DiPiOGlYdVcymhCh+IKdlIs7rTLSuAVlx/fnmLcu
         96NZnumm1CF84Z+2pYGPbjiWAkif5ly3iN0Kwrq0KeWNsLda90xz+GV8V1yK9ItJ4vG2
         B1EJuY2n5/0kLF9US3rV3/w1AZwY4XPQxshrXFoNm8pI/hSdNgeek9/L11NVXvSYTWgU
         2fK6mTHrRrlrabBghWT0dudUvkei0lR0po0ax3jU4MditiLLlY72FydbDtgkVbMNSil7
         27Nm3kr9NLe4oefhueLn2QCXYfMY0dphxyDHblNj7RHUwh5Jd3gLvlwaOrkHot8uTUZQ
         Yt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Xc325GZc+vxzGRAdvA0vChIvJkypnglJvofgNCbWMR4=;
        b=41hpje8w1iHHK45Kx+Yq7rqMkgi8TM6p5KEvzUF1lwTP0zso9xWzLgfpMNgYrHhQ0n
         jCL+0/V//aBuHsdbgqSC9MFWNuK/FdS8mCiVmX6NTKlbkkfavR8NC0uHkAk8FEEgbCSX
         wYcN3C3WU4CKApENZw0Hs2nENjCFIrxhjttXIGL/lIJmcuYTRdK88EPGS6m3Ex//LVxk
         ng7kHwRvMOOY42LiY3n/kZiEHbAh6ADJ2BALs1gCy8oFhQ1DQLifE9A1ivvwBNfxgyX3
         AM9IzXgv7v2HZFeaypTrubRxkRlbcKsQ+fIfjJ0R6hBZEBiRTi7lNHb/CaWAsf8xtjmX
         30rQ==
X-Gm-Message-State: ACgBeo1ieCF9+LmZG+DxL35Cy6ObiJ8ICiwnb86kUwf6Rwq/Do5ZFZ7F
        K1JMvveGKv6xA7X0FBsp5tUOag==
X-Google-Smtp-Source: AA6agR75ZEPrL/yKL8ezMsVKnuKBIXSz81lwLCFZHWoLKO6Bsf7yB53ADVYs4VBVxujyrIqJgj0K/g==
X-Received: by 2002:ac2:4f03:0:b0:496:272:625d with SMTP id k3-20020ac24f03000000b004960272625dmr5369172lfr.303.1662795983686;
        Sat, 10 Sep 2022 00:46:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h12-20020a05651c124c00b0026bda31c10fsm201998ljh.61.2022.09.10.00.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 00:46:23 -0700 (PDT)
Message-ID: <e8b33710-db07-bde4-e1d1-d42c05b87d6b@linaro.org>
Date:   Sat, 10 Sep 2022 09:46:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 11/11] dt-bindings: mtd: rockchip: add
 rockchip,rk3128-nfc
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, kishon@ti.com, vkoul@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        zhangqing@rock-chips.com, jamie@jamieiles.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20220909212543.17428-1-jbx6244@gmail.com>
 <f09665c1-9938-38c1-9a31-f196a3ef9cf0@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f09665c1-9938-38c1-9a31-f196a3ef9cf0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/09/2022 00:01, Johan Jonker wrote:
> Add rockchip,rk3128-nfc compatible string.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
