Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96364C4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Nov 2022 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiKOR2v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Nov 2022 12:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiKOR2m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2022 12:28:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885517AA3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2022 09:28:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so25456496lfb.13
        for <linux-mmc@vger.kernel.org>; Tue, 15 Nov 2022 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnzzFvDnrUNiU88yEZt6sQdtp0kEECaqorraO0GqvxU=;
        b=gTqXfTfz1AawXgaddIVtPqg4+pkukv3DqH6QpxMlqCBS05LIvP+2dQ4b6OMEevO4kA
         FHj86IBdobrG3d5IdXt/+3TCHAqqGWj7BmXM4FluMRmhulHmbEe5m0nXfF6h4N6N0+3n
         znqac4WQsqsJdf44MkWe6m4u5H+yNPTs63KaTASt2BnjxAZq/98zjcYD8Al4EFI54bEU
         QqtUy4uUBwj4NKrABJcJqUAW+u4RH3y95bTU2KY9/wJr8NkScoBaNXb7FrgeRbGujFTf
         mtDvGyealO5gkDiuH5wrlXwrTfAJbO+wzBFX9fYvNonCrOQYraxjuRY14Zkz3nz+ld+n
         lMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnzzFvDnrUNiU88yEZt6sQdtp0kEECaqorraO0GqvxU=;
        b=yXqGS2fQeru5rCrY75EG1hY0G4dVlytbpIUJEnQjvQ4pwVxD2M1ahMiNQV1UCxdzTl
         f1DlRUUYWJ96kc5aiJ7drjLQFlIh9f9fMKxD7lXpiZlneq5q+ahiwvfistzxMbABQ/Vo
         8BgnOChn6r7XLsNJdzoTEZ25r7GUTK2qmSVhQ9yARbEKwy1UGzK6AdsnwEYJCRxsVrNu
         LATzR3ReT4n+06UpJXReEpu7RCKIpMpQIubVLo5vpz+WiRz3ue5xMBcz7bwUGSbEmnud
         w45n5Fx48SGzt58BjoA66Uy5OvJARutqOg/JzzxwPw78Ce2BKy/rch1E66h/IrfR367L
         x7HQ==
X-Gm-Message-State: ANoB5plg9CPvvWgsFlKWB8OqQtYadqH9lepNgK9TYwdgsdbbrlBZ1h1E
        46SPJTtEmlobyb8/8c1n5/7lhA==
X-Google-Smtp-Source: AA0mqf5iYiSCCg41VSN3+mgDERmio+BS0NImVtdSFTzVWSNilw7sO0zafZj5BDmVrN1pC8TF7RC4kA==
X-Received: by 2002:a05:6512:3c8e:b0:4a0:5393:3749 with SMTP id h14-20020a0565123c8e00b004a053933749mr6050082lfv.494.1668533319861;
        Tue, 15 Nov 2022 09:28:39 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id b42-20020a0565120baa00b00496d3e6b131sm2261511lfv.234.2022.11.15.09.28.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 09:28:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 4/4] arm64: dts: qcom: sm8350-sagami: Wire up SDHCI2
Date:   Tue, 15 Nov 2022 18:28:28 +0100
Message-Id: <20221115172828.14372-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115172828.14372-1-konrad.dybcio@linaro.org>
References: <20221115172828.14372-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adjust regulators, add required pin setup and finally enable SDHCI2
to get the SD Card slot going on Sagami Xperias.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index a428ce31ab4e..fdf95b763cf4 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -312,7 +312,8 @@ pm8350c_l8: ldo8 {
 		pm8350c_l9: ldo9 {
 			regulator-name = "pm8350c_l9";
 			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <3008000>;
+			/* Originally max = 3008000 but SDHCI expects 2960000 */
+			regulator-max-microvolt = <2960000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
@@ -558,6 +559,19 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 92 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_active>;
+	pinctrl-1 = <&sdc2_sleep_state &sdc2_card_det_sleep>;
+	vmmc-supply = <&pm8350c_l9>;
+	vqmmc-supply = <&pm8350c_l6>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
+
 &slpi {
 	status = "okay";
 	firmware-name = "qcom/sm8350/Sony/sagami/slpi.mbn";
@@ -782,6 +796,20 @@ ts_int_default: ts-int-default-state {
 		bias-disable;
 		input-enable;
 	};
+
+	sdc2_card_det_active: sd-card-det-active-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	sdc2_card_det_sleep: sd-card-det-sleep-state {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
 };
 
 /* BIG WARNING! DO NOT TOUCH UFS, YOUR DEVICE WILL DIE! */
-- 
2.38.1

