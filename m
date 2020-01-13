Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCB3C33CA9
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD27A24655
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utfA3alr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgAMVHv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:07:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45411 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMVHu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:07:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so4292305pls.12;
        Mon, 13 Jan 2020 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LyQkYDM/KZKONjplFnyoxpxnLT5IGwQv8MiMr7YPN3I=;
        b=utfA3alrv7tHpghnKdkmJ3E0IqLvR/zXbdnViKLkrLfW8ko7gw7GTfXLrgEkbIqSJe
         OmHci07hmtJ8jlSGaF8s1zDVjPIzQbipUsLUzcvg4+SmZNpGatNqyPmtr4yXj5HXue9w
         v+le4kOlRgwDbA7LBe4l6BQhXCP+r7kjMT7xUiEmxzx6IYN+SGFsaTbYx6zfeKDTOSE3
         QtJB3IIApfjxmV/26ONJgL9AMVrAS5+lJNBUc25L8k0i0m0dkVyHBKAeM9wZkok2+SRZ
         bp1R7RwtXcAXMCWfGMM4Ej4kts9WxU5aHmRNFNAidPjM9ZZjSZVaBdYTKjYI9xzrHzX4
         LKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LyQkYDM/KZKONjplFnyoxpxnLT5IGwQv8MiMr7YPN3I=;
        b=bmQelJIxYO49s4259czJBJ5LNRvwRe0S2x6fR5C4IpKWiBtfY8UM7lHZT1FdxCgXCz
         5+yqG1+FK8mfUpDgh4EqCr7IdfJqhzeVtnzTv3S72JWbCfdsn0vb19N88z+/K/0Vp5py
         GPM+0u6bhv7jhWvF5EueUG1srb74WBL0VB4aBs41Pjh4i/SoNNRbOdjMJbrr7kj8ocpo
         K8KyJHlQRDqV52sJl0PDGRn3OM/mW60/mRj9+00RKqxhlZgJbb/LNaNbxR7+5v1p2oOu
         SdrFpPE7F69p7+jTZemYpT7U4ZVks9wlcs3ei8MLjdFFxEPS5PGCoYnfGBV6U2dWHbFd
         JNiQ==
X-Gm-Message-State: APjAAAXDdQFvTBPSgFMFi4fXVq+E2nfNU+ELGfXBSdy/ZPTAp/t46vVF
        ct/RXtssMjmbRQeT1qwzHXjDeqml8il7og==
X-Google-Smtp-Source: APXvYqzliCyBk9qFpUk4+wdWthbVhifyZvXlrNnXV9vrs6fPOu67hIWB75V3MJEl+WkyzYcNilvw3g==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr24522340pjp.72.1578949669444;
        Mon, 13 Jan 2020 13:07:49 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id s1sm14195827pgv.87.2020.01.13.13.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:07:49 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH 1/6] dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 7216b0
Date:   Mon, 13 Jan 2020 16:07:01 -0500
Message-Id: <20200113210706.11972-2-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
References: <20200113210706.11972-1-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add 7216b0 with supports CQE, HS400, HS400-ES and SDR104.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../bindings/mmc/brcm,sdhci-brcmstb.txt       | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
index 733b64a4d8eb..ae2074184528 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
@@ -11,28 +11,43 @@ Required properties:
 - compatible: should be one of the following
   - "brcm,bcm7425-sdhci"
   - "brcm,bcm7445-sdhci"
+  - "brcm,bcm7216-sdhci"
 
 Refer to clocks/clock-bindings.txt for generic clock consumer properties.
 
 Example:
 
-	sdhci@f03e0100 {
-		compatible = "brcm,bcm7425-sdhci";
-		reg = <0xf03e0000 0x100>;
-		interrupts = <0x0 0x26 0x0>;
-		sdhci,auto-cmd12;
-		clocks = <&sw_sdio>;
+	sdhci@84b0000 {
 		sd-uhs-sdr50;
 		sd-uhs-ddr50;
+		sd-uhs-sdr104;
+		sdhci,auto-cmd12;
+		compatible = "brcm,bcm7216-sdhci",
+			   "brcm,bcm7445-sdhci",
+			   "brcm,sdhci-brcmstb";
+		reg = <0x84b0000 0x260 0x84b0300 0x200>;
+		reg-names = "host", "cfg";
+		interrupts = <0x0 0x26 0x4>;
+		interrupt-names = "sdio0_0";
+		clocks = <&scmi_clk 245>;
+		clock-names = "sw_sdio";
 	};
 
-	sdhci@f03e0300 {
+	sdhci@84b1000 {
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		mmc-hs400-1_8v;
+		mmc-hs400-enhanced-strobe;
+		supports-cqe;
 		non-removable;
 		bus-width = <0x8>;
-		compatible = "brcm,bcm7425-sdhci";
-		reg = <0xf03e0200 0x100>;
-		interrupts = <0x0 0x27 0x0>;
-		sdhci,auto-cmd12;
-		clocks = <sw_sdio>;
-		mmc-hs200-1_8v;
+		compatible = "brcm,bcm7216-sdhci",
+			   "brcm,bcm7445-sdhci",
+			   "brcm,sdhci-brcmstb";
+		reg = <0x84b1000 0x260 0x84b1300 0x200>;
+		reg-names = "host", "cfg";
+		interrupts = <0x0 0x27 0x4>;
+		interrupt-names = "sdio1_0";
+		clocks = <&scmi_clk 245>;
+		clock-names = "sw_sdio";
 	};
-- 
2.17.1

