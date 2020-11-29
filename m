Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7E9C64E7C
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 20:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 652C620757
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 20:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbqU0XXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgK2UcN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Nov 2020 15:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgK2UcN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Nov 2020 15:32:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A68CC0613CF;
        Sun, 29 Nov 2020 12:31:33 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so12535563wrr.12;
        Sun, 29 Nov 2020 12:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkHx25BRkh2eHsRS0pNBw3Iop5cZozEWk2vbjEjWymQ=;
        b=BbqU0XXJNsMZFAN1ef4SZVZ+e+4ENsIh2R1PSjUC+N78D/EmGe4zYYNDY48LL/7lrs
         y9rK5ZmQ3vn+6OfETraOV9zpLtsvs3/kF4UWaqAGVPyCvb0fawk81YMnfXjey7W2sf+W
         ThWw3lZsD02VO6ajwobC/88QQGCDOcg21D+g4DuPfNfFyLI2+jhlZp46Q5fbT4GFUHR7
         CBRZ1dlzJNowKGxdi7hM6aXiecn9TW84o8XpXfILg//vUIjuoXWBXjJX9eBBBG+V8/TU
         RzxkwMI50HGvvVvmbYUXVCV6iY58XtapNXpqtpbHdvgpSPYpKbpNwIppURtAhyFv01KZ
         4ZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RkHx25BRkh2eHsRS0pNBw3Iop5cZozEWk2vbjEjWymQ=;
        b=kGlSAICBaazxfgsxYuWcdGCoKDmmKibB32dLMfP3TK79X5IGuvxF9WukgdvckvWu3l
         C3+qQ89mHRD5UDFDOWKuIS8D23wqpFrBx3I6kzwIXJK4L6dxJCnRcF3QzsiCtxcY/3CH
         BJJGRKGaNFKyr0OE9ZbzvidkCoMeF41UdwMOIqIECdjdVOkKlkaGnxsbClkfHqxVg9sr
         cf1SWhSEXhckgR/XFkYw9ZaCfQd+WO5TgeWDxM5kbyCyDqiLTQDNfka41C4G0pJvyUpK
         M2sRoBiBDdn7xw6y+qRpusGQQI2/eaxItr6iW1wKKxKtj1XomYyPmdSlj4P4diNxl8hi
         D64g==
X-Gm-Message-State: AOAM532H9+oXjgCuInt9/SQPGkk92Vovjp3ewLgVl7v1nTdCUuGovODm
        WyhiAbZp0w2bnMveQMj3MV1ANBdKwuHIjg==
X-Google-Smtp-Source: ABdhPJwn5HvBVBs+EIyxrcf3kYX/s3GC58gTrAEo6LxGP32NvDqno2Bc+AVFfvZwoCM9ucBa1geGhw==
X-Received: by 2002:adf:f349:: with SMTP id e9mr24158997wrp.110.1606681891874;
        Sun, 29 Nov 2020 12:31:31 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id a144sm22997876wmd.47.2020.11.29.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 12:31:31 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 1/2] dt-bindings: mmc: add an option to disable HS400 for fsl
Date:   Sun, 29 Nov 2020 21:31:15 +0100
Message-Id: <20201129203116.11987-1-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add an option to disable the hs400 support in the fsl esdhc
driver.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index e71d13c2d109..070b40ae8c44 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -101,6 +101,10 @@ properties:
       If not use this property, driver default set the delay target to value 7.
       Only eMMC HS400 mode need to take care of this property.
     default: 0
+  fsl,no-mmc-hs400:
+    description: |
+      boolean, if present, indicate to disable mmc-hs400 support.
+    type: boolean
 
 required:
   - compatible
-- 
2.20.1

