Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB53C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996206120F
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Oct 2021 03:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhJFD57 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhJFD4n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2021 23:56:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E5C0617BA
        for <linux-mmc@vger.kernel.org>; Tue,  5 Oct 2021 20:54:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so4497014lfa.9
        for <linux-mmc@vger.kernel.org>; Tue, 05 Oct 2021 20:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fc0GoKyWHbaDUKZRwzSCHWvKPWvkUL1O7EIfFaZFJjw=;
        b=ek+UBm52N/dNF84c5mtTjMTJvJ5oGZ0lbXTAAjAyV1XvQDUOFH0l/tTMhfVzJAVy1s
         5A9IIqqQjiddD6Xxi2TTAaGdSgVqpk0Rmqtk98pIDkXppBKhslgFJvZPuN4VYjg8Kh/k
         NvN7a6TOOxfaYoA9A7SJwXWmEtuPXBVt4gb8badGbZhlGOA620Gyxh4R+YbZd6q49MOv
         2Qi1wfxZ+XCc8YcurEshmk0YU/rcgY4765nt9Wx5F406K53k2YpQJYrDUJTkWqNBikGf
         xKtKknzKdnRkKPLuVnIzXFOf+W03r/taVjHXCFr1DlAWSxc5MKil96Ym1SLsZZZJqpo+
         ufLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fc0GoKyWHbaDUKZRwzSCHWvKPWvkUL1O7EIfFaZFJjw=;
        b=HO7hPj8/txiOOwkfl5c/bA3oHF1W5uN4kHsvW6zkGoHoGY+nbRb2SJdGS9M5NB+a7z
         +5iPD7wFarb9coWmTZlHGyqWO6sSBhQIlBESnBXxsdtPnbuiwRmaINHaxnoItgy5fGqx
         EzDb6RfbvDw4luqgJnuz5iyt4/QcFOuoWxbTErZSXa6puUfGF6OCrJxu74YS4XO63Abo
         I57t4cI5tTrafnG0g1Cz9KgN/FCr/bhisBEUvKPG0YBwqbGsVron4Rh9GzKNY9SOtaEg
         OEMDRpdGh6hEpgLc+9qzuqbfbRkZuYOuRdhZeWrAMcLHM2EKBUi2eyMzdKfYkWwM6nlT
         8GKQ==
X-Gm-Message-State: AOAM531bNIq/gFrjS2tL7LPgvACrACsiTS2fLgtg8Bxol9RIsW3k+wOH
        yEW3CSvw4j2WZMITpc/ovzTwoA==
X-Google-Smtp-Source: ABdhPJwsKWl3H1d1iLra8+QrQS59nd54fvK9Etapf6nvAyz9n7l6E+sLHM/FZUi8R5GtNZVbuy881Q==
X-Received: by 2002:a2e:9893:: with SMTP id b19mr26949222ljj.112.1633492462601;
        Tue, 05 Oct 2021 20:54:22 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4sm2142967lfd.103.2021.10.05.20.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:54:22 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v1 12/15] arm64: dts: qcom: qrb5165-rb5: add bluetooth support
Date:   Wed,  6 Oct 2021 06:54:04 +0300
Message-Id: <20211006035407.1147909-13-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add support for the bluetooth part of the QCA6391 BT+WiFi chip present
on the RB5 board. WiFi is not supported yet, as it requires separate
handling of the PCIe device power.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 8ac96f8e79d4..326330f528fc 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -19,6 +19,7 @@ / {
 
 	aliases {
 		serial0 = &uart12;
+		serial1 = &uart6;
 		sdhc2 = &sdhc_2;
 	};
 
@@ -98,6 +99,25 @@ lt9611_3v3: lt9611-3v3 {
 		regulator-always-on;
 	};
 
+	qca_pwrseq: qca-pwrseq {
+		compatible = "qcom,qca6390-pwrseq";
+
+		#pwrseq-cells = <1>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s2f_0p95>;
+		vddrfa1-supply = <&vreg_s2f_0p95>;
+		vddrfa2-supply = <&vreg_s8c_1p3>;
+		vddrfa3-supply = <&vreg_s5a_1p9>;
+		vddpcie1-supply = <&vreg_s8c_1p3>;
+		vddpcie2-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+		wifi-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 124 GPIO_ACTIVE_HIGH>;
+	};
+
 	thermal-zones {
 		conn-thermal {
 			polling-delay-passive = <0>;
@@ -804,6 +824,26 @@ lt9611_rst_pin: lt9611-rst-pin {
 	};
 };
 
+&qup_uart6_default {
+	ctsrx {
+		pins = "gpio16", "gpio19";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rts {
+		pins = "gpio17";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tx {
+		pins = "gpio18";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -1193,6 +1233,16 @@ sdc2_card_det_n: sd-card-det-n {
 	};
 };
 
+&uart6 {
+	status = "okay";
+	bluetooth {
+		compatible = "qcom,qca6390-bt";
+		clocks = <&sleep_clk>;
+
+		bt-pwrseq = <&qca_pwrseq 1>;
+	};
+};
+
 &uart12 {
 	status = "okay";
 };
-- 
2.33.0

