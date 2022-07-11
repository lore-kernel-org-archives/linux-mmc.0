Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2553EC43334
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 08:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiGKI1Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiGKI1Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 04:27:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696931EC59
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:27:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a39so5307259ljq.11
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rYTa3JGM6IeieDSa7LDtG3vHNWLhIAb8Q7HiOVEvC8=;
        b=zinFVnq9fQpbCQuwb8BHCAEowVRjH36LHQTHxp5OnTlr8AXGzG+c4lQBsUvi6dPqVP
         p+m3H9SksCgQr5AHTzo9OMgGCiP9QJMiffClQ8E1wkLAMyvXguBdqo+wP4AGSHFwY+NA
         7ee2xPiK/4naKDcwxtsKeiRoiAd2IrE7zQrz0UiAmsICBc+W1ZDj0WkXtp2rW6JGvTau
         VjiZP1GwjwgiAdNoH1K63Tcp0GYIFlazw041c8HEVOuPOkwNm6P4QTYOjzRbvpGk5moO
         5x4tq7mb+YJeuGETn92KXLWJvsBjk9g14aPJdGMDHSXQQPqtqqH3w0bdtPOagwpOWhSP
         ucAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rYTa3JGM6IeieDSa7LDtG3vHNWLhIAb8Q7HiOVEvC8=;
        b=tN4+z/6+xjw3WbU25ZGREVa/YoVNFON0Xjt/j6POGyPgDC70cbRFd8j/QO+MZq1Pi2
         DnKTfPY8vIHxE+wXVLQpyDPPg6wpu3ZSDhIajgFHNTjyMxuAn/VvxKmPeKrf2HPkmkfb
         gkTeBnz3ZZIAGPZ2XKUIIGT70bOt19i0mrVOdR9F3HhgF+vcRhaSZxqixiSiHYi2K796
         172s7JSUZWq6s6xYPaM3cynwL6Zw1jlGKbeh38xxyeku5jsGaJHQlJ5sfag78NR4pr4I
         7p9158gdHipzfWAvyyMk1IEoM8BQRg6EDVu8Yo0Xayuc0opmoL25W3IZKnvcFEL8dVIN
         cXPQ==
X-Gm-Message-State: AJIora/wPG5KdPNunx0uDYW3ww/GnYHhG99WajURNQbBV6OUl2457VOc
        gKG7OIpvj1FBSjxPdoK+k4IqOg==
X-Google-Smtp-Source: AGRyM1stMqKlh8JH5aONT4GAIuHzSJe0Ju8dVYUNNWTNDrM2QWxZpOJRQVYJo/uTieqlDxsE/6ILFg==
X-Received: by 2002:a05:651c:1061:b0:25d:6302:68a2 with SMTP id y1-20020a05651c106100b0025d630268a2mr5368868ljm.212.1657528040761;
        Mon, 11 Jul 2022 01:27:20 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id c30-20020a05651200de00b00473c87152bcsm1408994lfp.127.2022.07.11.01.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:27:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
Date:   Mon, 11 Jul 2022 10:27:09 +0200
Message-Id: <20220711082709.39102-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
References: <20220711082709.39102-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add a MSM8998-specific SDCC compatible, because using only a generic
qcom,sdhci-msm-v4 fallback is deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 91153a0234f5..c98f36f95f3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2076,7 +2076,7 @@ qusb2phy: phy@c012000 {
 		};
 
 		sdhc2: mmc@c0a4900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,msm8998-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x0c0a4900 0x314>, <0x0c0a4000 0x800>;
 			reg-names = "hc", "core";
 
-- 
2.34.1

