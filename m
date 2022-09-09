Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8915C6FA82
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Sep 2022 22:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIIWCp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Sep 2022 18:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiIIWCI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2022 18:02:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8651451D8;
        Fri,  9 Sep 2022 15:02:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m1so4492255edb.7;
        Fri, 09 Sep 2022 15:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=C3qADeaLVD5Wq/Bi8b6dEyFRSiEgo2NkstG7crvWOAk=;
        b=C+5bCGSupcduQheii5Mu+8UBVGi+s97RyVpipzZT0paGye3t6W8S0T55FMowLqLrus
         z9fNAD0K5pUYe6zsdLyQY7GnA8j631W82+SauxDaz/yWzoy0DEV+9itWF5zOZhzXQ+yu
         H9pp84M41DWilCxPTMpu4pJ07lE/sA+SWEsbC8bSpqUAzOci662UbHLYFyppRmiDxTzq
         /BRjVtupv/gfI4s5KPaRZNxruCQQMW1FZOQpr8C094XmHc7cSFMeiLgJcb1kTPEOBvgl
         RANJB/mvzHM5AZS937EAnjg4yjrZyCVlJc7M/LHYf8X9Gb/TzeRkmrofY8Te2bWsiNZz
         D+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C3qADeaLVD5Wq/Bi8b6dEyFRSiEgo2NkstG7crvWOAk=;
        b=FkEGDU8TS+QgDZcr1zbpoU9MWgiHfsOeB0RPzMesURX5fJSxkSyDVoe0GreqLkzQwX
         p0ZW8ZVHh+Pdt/oyhnXfmf1//tQgYumQVAoLX40uz23gMBpuW4U1foxUg24MOQfdn8dh
         ccs9NgLwabBBaw2vIQU+UsPvmesLjGDJL9e/CnQdW2MFHYYGFcsD3V+okZK1hlsYp5yO
         BdvHJNrcU7AsIq+VfAIwyvffwKea7TxGVk1fUNr9I3tc/PSSmT4G5iCWJ4tmtJW9z/pE
         qtFgNHSbPRhJfglSllWWqDYCX1Kv84BQdiewZ8yZeYnpqRedowmGB65VB99FRnd3tmqP
         gO9Q==
X-Gm-Message-State: ACgBeo0l2qr36BN86mpjqfmiteavX5PtnRFLqVtkPh1kxOC+s8nKCRad
        zYP4Y7CuNiI1lTTgeDRlmbw=
X-Google-Smtp-Source: AA6agR7EeHoURQWCtPEXQq45h383TFHKi6B0OznbjQfOnLVUiwu64bS7CKwZHxn593dBTjdmnvEnTA==
X-Received: by 2002:a05:6402:1013:b0:448:dc53:752e with SMTP id c19-20020a056402101300b00448dc53752emr13119868edu.30.1662760923862;
        Fri, 09 Sep 2022 15:02:03 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i22-20020aa7c716000000b0043d1eff72b3sm1002426edq.74.2022.09.09.15.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 15:02:03 -0700 (PDT)
Message-ID: <dfb657ab-85e5-ac47-810d-133c7e8dd823@gmail.com>
Date:   Sat, 10 Sep 2022 00:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 06/11] dt-bindings: usb: dwc2: rockchip: add
 rockchip,rk3128-usb
To:     kever.yang@rock-chips.com
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
Content-Language: en-US
In-Reply-To: <20220909212543.17428-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add rockchip,rk3128-usb compatible string.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 1bfbc6ef1..dc4988c00 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -32,6 +32,7 @@ properties:
           - enum:
               - rockchip,px30-usb
               - rockchip,rk3036-usb
+              - rockchip,rk3128-usb
               - rockchip,rk3188-usb
               - rockchip,rk3228-usb
               - rockchip,rk3288-usb
-- 
2.20.1

