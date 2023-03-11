Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158CAC61DA4
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 15:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCKP1Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 10:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCKP1Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 10:27:24 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB05E34BE
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:27:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id t11so10440286lfr.1
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 07:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678548441;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=MEa12rVPjYPwGegsBex7DEE2GTvzcKovW85MsQBjXRUUI/txji76ySL1XOfSxXq7CM
         rrN9/IPr9JVLYp5Sp6Xsywl2zlHS6BiOXTrHxg0X/vrFV0rh0ELoaryNw7plryIEBY34
         sgtpGi6KZqG4Rh6ve+kmHF7Gz/eLLELnatiYaIRKYui6XW8yDNfRwlJSdBlMjSqDA7Ka
         MjsUDqNbAtZ7himCKyg7G6KQudPjnFwNH5HXg3JfbYSgciUkFbIIF/6M1EJZ3MUeU2rM
         YlzTJeOQ4FPlPsBAY1oeeUd7QnRqTH3Bxwby63HrjNwjrXJEl06Lt2BuScfg+DGrsAVA
         W1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678548441;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s9gnIYUH4a7DISj2GFil2OdRXxeDO2P0HDbRjCc19c=;
        b=YUZc5bGLnXwyGRneiL1SLq20/2VcMIR/NrMhntJ6XRtYWKSZbUzba4q9FbyRbt/V9N
         H+Kh67RgPYjpjKBDAVsoqc2axYWOnWa8jbNje6fC/c9uAKlCMzr7cI+a4WQgo6NtUPYJ
         5eicRSjlTvcUYznFHjEtNstz6u4kVdYf8uFwACwi3qAdHBDnLX1SOwxvaaMkUGqaQNk9
         TOsJtonDqICI2SnMdK5+m1D1SxN3OjmnE68TLLkkwLlwErqQ7KhVXKvWrDO5/ge3y+1q
         eTEruQQFHgfx/ZsM/20D1owKSxXAobTzrN3NIOWVFDAPXTrMmw3Lu7CVvyxPhMy9C7Pb
         D3vA==
X-Gm-Message-State: AO0yUKU0HER6zYxJkBTa7k3m50Ftq4wHjYKFcJlzAJ8IZ23GQSl3EH79
        uCJ1fNrTLp/Et7z5AZIKUHFaYyicGpaA84YpzA8=
X-Google-Smtp-Source: AK7set923o6l6Me9oiqeqLP6Z4OmKcHISanG/nrAdfd5AMCxlVFaeSqk1e4Fmr2CI86ynxtqQiOrbA==
X-Received: by 2002:ac2:51a8:0:b0:4cc:7308:8f40 with SMTP id f8-20020ac251a8000000b004cc73088f40mr9220260lfk.40.1678548441233;
        Sat, 11 Mar 2023 07:27:21 -0800 (PST)
Received: from 0001-devicetree-synopsys-dw-mshc-common-add-fifo-access-3.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id c18-20020ac25312000000b0048b365176d9sm344618lfh.286.2023.03.11.07.27.20
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 07:27:21 -0800 (PST)
Message-Id: <1678548256.0817535-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678548256.0817535-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sat, 11 Mar 2023 18:22:41 +0300
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


