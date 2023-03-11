Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90DDC61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 13:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCKNYX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 08:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjCKNYW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 08:24:22 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB709CBFB
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 05:24:19 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t14so8166541ljd.5
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 05:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678541058;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=e5miCUH9+j2RdGcKV56QfgK4Y8Fx4f7muc7Gy2p23T+E13twYC+EGfDZZI+jdR2mKn
         Pt64eXV1TU9Pk0EXV3Bwh6cLdfEjd1LKYuTyUilLGAM2+uDpz/PiySXVOjp6dzuw82so
         tes6SVWi3xyWMgCPFxhaAryY+9sxgoeYClzp1h/+vVheDEYXqOzcl7AAl0UWvzyii6Cb
         gaW6aZejDN7k9tPZsS4uRMG71+jghbvc3t9lcgOw7Qwf6pE1fPczEWUpnbUey7JLC8dB
         wRDfWzrbUyJ+4N4+84MwbQhT/UH8Mqd60hlix4mPSsvTSMGz/Zbu/6lETHioc+3Oop75
         RpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678541058;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=cuoGb3/oDHD9NVM/xfHl2W3TO0O7PD1DnCqPjuoT0PCdSYsLovjat93WfM6B+/b94z
         kOAIrUMZSazJ1y9JTPqB/rL40bybWwGLqHVeRkboFEAmnt1P/P2jZQQeukNdX8zztqfV
         Vrybf0w7U15V708G+KhINvnNPfTekoYTYFSdsnsvMP0aCvsXNhLc40FHSkpU249HEd4b
         eDAH66c6sLJjxaUaY+OajJGQLdYCDc5rOhWUOM3y/7SgH27rnH6aPzC2+UkIknAzeTEl
         gozW8RMhWFZiIlJNNTDbzxZUwlxC7cUILuH4Cx/nJxl41l5CZ2dnNOghZTPIooC8fTpB
         Pdeg==
X-Gm-Message-State: AO0yUKU/XYuWr5J5uNdsw5+YEdq8MtlkuG3nMDtTj9pRSsbFxPjVz+iD
        O68RslwLuP0fF3WxRw2QkTSZuM3qFw1ZiykBEwQ=
X-Google-Smtp-Source: AK7set8QohH10oEHA3taUXF2fj7DDkbGqFbR6iCxRlodGa1QGJXOTl0pjBt/2XCn5XakkNgv7orHww==
X-Received: by 2002:a2e:5311:0:b0:295:945d:d483 with SMTP id h17-20020a2e5311000000b00295945dd483mr8076677ljb.44.1678541058002;
        Sat, 11 Mar 2023 05:24:18 -0800 (PST)
Received: from 0001-devicetree-synopsys-dw-mshc-common-add-fifo-access-3.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id z6-20020a2e7e06000000b002946f95b359sm312840ljc.105.2023.03.11.05.24.17
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:24:17 -0800 (PST)
Message-ID: <640c8101.2e0a0220.aa0c5.0bd4@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 15:54:22 +0300
Subject: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add
 "fifo-access-32bit" property
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

---
 .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
index 8dfad89c7..2bc5ac528 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
@@ -57,6 +57,12 @@ properties:
       force fifo watermark setting accordingly.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  fifo-access-32bit:
+    description:
+      Specifies that this device requires accesses to its 64-bit registers
+      to be done as pairs of 32-bit accesses, even on architectures where
+      readq is available.
+
   dmas:
     maxItems: 1
 
-- 
2.38.3


