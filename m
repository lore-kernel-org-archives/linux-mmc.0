Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B64C76188
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Apr 2023 20:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDCUGo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Apr 2023 16:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjDCUGO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 16:06:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006C35A9
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 13:05:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso20584054wmb.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Apr 2023 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680552347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w63VFmiH16vEozVIfZE6H9nBGMybmPlflk/SwWYJdEs=;
        b=ppnPwRSMi6a1hCFhUQXBVflFookWwsw9uTun/lpkSAcq6yLR/Fb2hvwh8x/GIq9qBL
         17vol2Dz/nicpTPjY+sdd3nIFHterpRb2a7Q5fMPnmTvZGn+Tkv6EBthAlzegwvheSy/
         FL9INnwMzqwpHYcVHj3YUX9WDlfcaETfKUPhnYfJA6sGAY8WoyH5eZf22JI6qRFY3M82
         HKM2kqSM63vVhLTcB56NfZx3WFybrWaMZg8asc79hkfg0AKALFocn9yEYiym5gwuMGfT
         rokW46x6mOGHjnQSh5OBZ7J8LXIhpmKFAoIDJtRcw70xaLej5NdKFQRN6n41WZ+UfJoX
         tFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680552347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w63VFmiH16vEozVIfZE6H9nBGMybmPlflk/SwWYJdEs=;
        b=F6/KlURkP5ervk3UverPerC+g1f7Zjmbg+MeN1iVi2JJXDQvaWrnd/1OkzhQLZ9SyX
         ErrsbAZYSAFWSZUgNAncyT0rnhmwgC4VjJcMkq21aG8kMIT1jA5Fwk4C4pnmsXua3cvZ
         JI5c+sjI6YMPxaeP/USvIrMSgo8H/oyIWQLW5Ny5bOomQAQRb0EVjo+gPT2/0kgXcfKt
         3ttkj0ZkkLd9/rep516Gm50cHAjoiYIJT4RqquiBrQoDix4J0r1LRTqPkd4/20AJYDpA
         Pj244deK5UCF5JTA0mzZuo5nvoerXYsvzZrSCSdrVfEnaPkWmfOYmo6lu+5qPt2Q0TRR
         S+Ug==
X-Gm-Message-State: AAQBX9fvO7sIS1Mtkq/a3Z7UnMwiLNKSefTWTJ3elw2jUoEi0b57YTK6
        V7S04qt1PPFnVpMO9pVeT9bsbA==
X-Google-Smtp-Source: AKy350YX1qUZV5PNkMcHPes5bv/LBKFgFxiLlw1bxdFmas+muyBCDQI5VLAThWKSecWRbxT/ec3Bxg==
X-Received: by 2002:a1c:e916:0:b0:3e2:2467:d3f5 with SMTP id q22-20020a1ce916000000b003e22467d3f5mr403869wmc.25.1680552347094;
        Mon, 03 Apr 2023 13:05:47 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm20798037wmb.40.2023.04.03.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:05:46 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH v5 6/6] arm64: dts: qcom: sm8550: Add the Inline Crypto Engine node
Date:   Mon,  3 Apr 2023 23:05:30 +0300
Message-Id: <20230403200530.2103099-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403200530.2103099-1-abel.vesa@linaro.org>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for UFS ICE by adding the qcom,ice property and the
ICE dedicated devicetree node. While at it, add the reg-name property
to the UFS HC node to be in line with older platforms.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v4 is here:
https://lore.kernel.org/all/20230327134734.3256974-8-abel.vesa@linaro.org/

Changes since v4:
 * none

Changes since v3:
 * none

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index c6613654942a..dcfbbf33663a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1889,6 +1889,7 @@ ufs_mem_hc: ufs@1d84000 {
 			compatible = "qcom,sm8550-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
 			reg = <0x0 0x01d84000 0x0 0x3000>;
+			reg-names = "std";
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
 			phys = <&ufs_mem_phy>;
 			phy-names = "ufsphy";
@@ -1932,9 +1933,18 @@ ufs_mem_hc: ufs@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>;
+			qcom,ice = <&ice>;
+
 			status = "disabled";
 		};
 
+		ice: crypto@1d88000 {
+			compatible = "qcom,sm8550-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0 0x01d88000 0 0x8000>;
+			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0 0x01f40000 0 0x20000>;
-- 
2.34.1

