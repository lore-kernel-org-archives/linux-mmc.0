Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A047C43334
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jul 2022 18:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiGYSJf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jul 2022 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbiGYSJe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2022 14:09:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992021EED9
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jul 2022 11:09:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c13so4428744pla.6
        for <linux-mmc@vger.kernel.org>; Mon, 25 Jul 2022 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXHUeursV/DnjA3vkdaJ9YQ6tDdJ4lD2AcKBqo+/DmM=;
        b=pU+PspT7bMrdPFrmwH5v7iD+m9BosZvMDVMaMlBSdp2Yh8KrPvuVldL1USRhBCv8Pk
         KpnX5yU3diW7ZhoNYURhrbXdGGR9Z3yYQ9vdsGklAn8txZyAgWOWyxNtAWG6y9iwBnTw
         yRUUT0PJrxHczV/PWHAEnb1PVQbzOtYOWKtgYShEzF8kCBPuPcCCOWyW+mw8Bx5gQ8F+
         hN/uqE01TP2o6xChI3TUQZb3U0Adl1iwExG5Ycti+ayXcMEaepTJ2Oz56TqKuc51FUP4
         +suUot1DegNzhmDIJuXLuViLToZzEKtZ4ZjL4RHwdcNG6UCHqnQ+mMWF92/9LHhaXook
         vK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXHUeursV/DnjA3vkdaJ9YQ6tDdJ4lD2AcKBqo+/DmM=;
        b=6symkNUWAtcFFN0EsBKzev6Qh0/3fyyF23g2wtMHkbwfV7F+I6m4vR4X/Ti+NcMyzC
         PSFERrB6PmWxO9zIJucwouqVgROiLpUqJts1/FmV33rec9QOzzVuJV6K5tswrBfGqjms
         SD9jD4bzLOJ3wuS4inVBEfr8PTBu+xxv8/gGbjkMOk4PcQg7KMi3uPTDkPRz+CE7FYoH
         4NI8PIvT0twkMz18LQQrj7yL0DG09YNkDbQIsijXSlEl7WacOuUk7tyIjFisGvsx5oGa
         ZcjrZdIlfy+Lin8lXq9P1sdX7t5PrVyRglG2QLR71d9V6sOHcjYXZYNrnqMzpmEMXnIL
         eXSA==
X-Gm-Message-State: AJIora+SYmgGNr+u1UAV1nJj6YghJ9iX9HW/J6/zJuwAQAzMNtB3Y4ao
        PQ0XpgVQqzvcOfaaF4SYkWrhla3Pc/bO/w==
X-Google-Smtp-Source: AGRyM1sJFjjTAQKKaSs8M50XszsAs8p2m3lvgVY9YJiOr1lX5bLoCrA+vhgLYYf4q/AvaxN8bKPlqw==
X-Received: by 2002:a17:90b:38c3:b0:1f2:e229:41fd with SMTP id nn3-20020a17090b38c300b001f2e22941fdmr1481399pjb.201.1658772572680;
        Mon, 25 Jul 2022 11:09:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a64c800b001ec92575e83sm9219735pjm.4.2022.07.25.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:09:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: [PATCH] dt-bindings: mmc: Set maximum documented operating frequency as 384MHz
Date:   Mon, 25 Jul 2022 23:39:16 +0530
Message-Id: <20220725180916.2850228-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As Ulf noted in [1], the maximum operating frequency
documented in the mmc-controller device-tree bindings
should be updated to the maximum frequency supported
by the mmc controller(s).

Without this fix in place, the 'make dtbs_check' reports
issues with 'max-frequency' value for ipq8074 sdhci node:

  arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
   max-frequency:0:0: 384000000 is greater than the maximum of 200000000

[1]. https://www.spinics.net/lists/kernel/msg4442049.html

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- Rebased on linux-next/master

 .../devicetree/bindings/mmc/mmc-controller.yaml          | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index ff5ce89e5111..c49f3060c24a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -87,12 +87,19 @@ properties:
     enum: [1, 4, 8]
     default: 1
 
+  # Maximum operating frequency:
+  # - for eMMC, the maximum supported frequency is 200MHz,
+  # - for SD/SDIO cards the SDR104 mode has a max supported
+  #   frequency of 208MHz,
+  # - some mmc host controllers do support a max frequency
+  #   upto 384MHz,
+  # so lets keep the maximum supported value here.
   max-frequency:
     description:
       Maximum operating frequency of the bus.
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 400000
-    maximum: 200000000
+    maximum: 384000000
 
   disable-wp:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.35.3

