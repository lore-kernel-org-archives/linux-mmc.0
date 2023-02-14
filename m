Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C80CC64EC7
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 21:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBNVoV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjBNVoU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 16:44:20 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2032942D;
        Tue, 14 Feb 2023 13:44:17 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gn39so5175134ejc.8;
        Tue, 14 Feb 2023 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbHCaVpympgD+rZ3HviBrecm2Nox2/uMHYu24H65DxI=;
        b=UWDRUL4uC/fLxhAO2XHD/9ZST4q+AwrnyiErvFgyKNTV2alU7YC82XKLePKM1LG565
         aznqOd355jQ0Z4/3Ho9S3fdo2Pz78sNR9HZRQWUPgS3yXfezP+BEvzONzJ8WJ8E88El6
         n+oZFBE8wDcoqoKEiJlGmiOwkH6wGscgcFnQj7cssLX313YweR5qBWUfr7omY5IwGVMp
         iS3o+gYGZgd7+x083fHdgl/PkzSd+FxWMeWNN5ZJbs/8bYQjDTNd3g12mO/pXJFmgseV
         /qnoT0LPbVX3tyPwaWWEwv03yILFXd7eWjTxE6PbDDHbX9B2N6uZn5ahax59gdB11u8M
         Ydcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbHCaVpympgD+rZ3HviBrecm2Nox2/uMHYu24H65DxI=;
        b=L4QQhERg2tdxu6vPeV5ZJYSZPD74PMz0BdFYMRFsrvTOMSWk2oatNhYY117h31bBTc
         bu9xMISDLmmHmscvEQn9oSxGI26Lqp8rAHSQInKtn/RTCtHXC0gTbGeZjMXRFRoF7ij9
         DqPOz7qh+c98rNmtAdyckojdywnOdcvUIIUqtc61SJ4FcLxoTe8NLsLkEBsS+DANuWy3
         v0yD3Dcb5RN5HaCesfH8y3dM9lFLoA3VIfQjBkpRqkoTvo66VLhVr9Tzc/+CaC5imgC4
         M9EYphNZJA4XLk9SADODVWruSQO14yuyDkL3H7WfEqpdQTyljt6Bf2J4ri3EiUbGtqAj
         nK/w==
X-Gm-Message-State: AO0yUKU1QQMYD9O5PIMnTHz6gC2IpnPQGXgrWPb6XwZ37qe6DkKOAP/3
        COZwnPOa1A2KyLs06LfU1c8=
X-Google-Smtp-Source: AK7set/r5p4+TIUHGxGEziaM2ujswam5/RjYE31PKNOauB2KjuV5YXikWQOIKF15RK44rueEFZGcRw==
X-Received: by 2002:a17:907:10d4:b0:844:79b1:ab36 with SMTP id rv20-20020a17090710d400b0084479b1ab36mr410828ejb.25.1676411055609;
        Tue, 14 Feb 2023 13:44:15 -0800 (PST)
Received: from ?IPV6:2a01:c22:7234:f800:b56b:f43d:948c:eede? (dynamic-2a01-0c22-7234-f800-b56b-f43d-948c-eede.c22.pool.telefonica.de. [2a01:c22:7234:f800:b56b:f43d:948c:eede])
        by smtp.googlemail.com with ESMTPSA id bl4-20020a170906c24400b00880dbd4b6d4sm8749475ejb.136.2023.02.14.13.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 13:44:15 -0800 (PST)
Message-ID: <1c5996a5-491f-39d6-b120-bbef86473729@gmail.com>
Date:   Tue, 14 Feb 2023 22:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH v2 2/3] dt-bindings: mmc: meson-gx: support specifying cd
 interrupt
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
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
References: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
In-Reply-To: <15df9ef0-9b73-ca5a-d3cf-0585cd135bc5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Support passing a second interrupt as card detect interrupt.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
index 46e235bf2..c8c30300d 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
@@ -28,7 +28,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    maxItems: 2
 
   clocks:
     maxItems: 3
-- 
2.39.1


