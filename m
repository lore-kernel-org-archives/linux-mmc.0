Return-Path: <SRS0=vSIZ=ZY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484BAC432C0
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C13820833
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 14:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vd7wNQxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLBOl1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:41:27 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42364 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBOl1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2019 09:41:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id i5so10160515pgj.9
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2019 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ynHcIuOVTswBCOhsCj7rfF7reyKlOrh1x0LK0XaYbgU=;
        b=Vd7wNQxLC70prHxTvnC6Kr+ZmcwgZkxRteFJKyH29YSmNlW9y0xzd09zWelHW0xX2Z
         zO6mHnKhU6J3aZUgchesn/GRUKfZG5QHCmdyj/Jj1uOoDk1v2wJTv6kmpySFFT7FtPQK
         T5QTz9xmOPGlkrBmiSt6FwHFln8bQpa7z3G41oXpa7GwesNR+BomXNeSl4MHu3arunrC
         Y+8ojLmHJVwwbk5Gu+uYwp39EjaJ5p1xY7fzyOsCzyWjapN8ZTQ6/EfvO+uN7yJFuN/S
         KHkWBmBaNIwplMLBYBNuUiLvpM/bIeeqL6EbHQB+wZTnPPX5HImtQ3atr+NOwR9BiLak
         w12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ynHcIuOVTswBCOhsCj7rfF7reyKlOrh1x0LK0XaYbgU=;
        b=sJ4v9AgfMKKLgWzz0z3JS/hKIAPbWZ7sz1fOEqhB2OV6ns72HhFIvWQHxmu2am/DjA
         ZTCRXr58ziyX75zMyH4cUDkiMD+LA9imNywk6N+uaT7g7tAIvl/k7ngi05SluXPfzZg0
         /FBgZlLgBV6MnC5GJwEBzzMLm4vQXZvdC/iirZOm7wb9mJk4//ArJj6xd+tsZNILeWCc
         +/914nODBXI5Ycf/e4WmBNsjaqVyw3g8z6IsYYDGE2I2dO7LDb1w213hSdrNEd9QdEMI
         ziXxLRiijCMUhjCS0IKA3xy1/3xSJCTraX4mYk/sKKFSpy94evN0P8yUICpq1KFKag8S
         xl0Q==
X-Gm-Message-State: APjAAAX4jrG3+Ips8T9LDcgkgfChFs6awbS1qK3fu4GvDbbuy9doYscG
        p/i3t/XxLkNWe8Ms2raKnaQ6jg==
X-Google-Smtp-Source: APXvYqyk+VIxjHsImpz7nqyjaZEmXbHiLmq4wAU1mqJMKNB+OT9pHjZLrrYW973O/FfxD/ct+oXvUQ==
X-Received: by 2002:a62:1a97:: with SMTP id a145mr5768870pfa.244.1575297686889;
        Mon, 02 Dec 2019 06:41:26 -0800 (PST)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id f30sm33985090pga.20.2019.12.02.06.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 06:41:26 -0800 (PST)
From:   Jun Nie <jun.nie@linaro.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] mmc: sdhci: dt: Add DMA boundary and HS400 properties
Date:   Mon,  2 Dec 2019 22:41:02 +0800
Message-Id: <20191202144104.5069-3-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202144104.5069-1-jun.nie@linaro.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DMA memory cannot cross specific boundary on some controller, such as 128MB
on SDHCI Designware. Add sdhci-dma-mem-boundary property to split DMA
operation in such case.

sdhci-ctrl-hs400 specify the HS400 mode setting for register
SDHCI_HOST_CONTROL2(offset 0x3E:bit[2:0]). Because this value is not
defined in SDHC Standard specification.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci.txt b/Documentation/devicetree/bindings/mmc/sdhci.txt
index 0e9923a64024..e6d7feb9a741 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci.txt
@@ -11,3 +11,11 @@ Optional properties:
 - sdhci-caps: The sdhci capabilities register is incorrect. This 64bit
   property corresponds to the bits in the sdhci capability register. If the
   bit is on in the property then the bit should be turned on.
+- sdhci-dma-mem-boundary: The sdhci controller DMA memory space boundary.
+  If the controller's DMA cannot cross a specific memory space boundary,
+  such as 128MB, set this value in dt and driver will split the DMA
+  operation when crossing such boundary.
+- sdhci-ctrl-hs400: The HS400 is not defined in SDHC Standard specification
+  for SDHCI_HOST_CONTROL2(offset 0x3E:bit[2:0]). Different controllers have
+  have different value for HS400 mode. If 0x5 is not the HS400 mode value
+  for your controller, you should specify the value with this property.
-- 
2.17.1

