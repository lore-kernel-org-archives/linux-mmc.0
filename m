Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184762063FD
	for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752394091; cv=none; b=bOhcfXAveZlFeFC5ZMgaxo2pCFEnL/Xcs1a+dglwwOavo7frDGvKE7PGYhGN61mxaRs3ka36ejhOJIgayomKwz6erralO/ebdRFySw2Ogs3IIaJ2fbZJOldva9GWSDnsXdN7Zb7ie3DybWiEcrlkBIBi2BWro2An/n/eJK3cObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752394091; c=relaxed/simple;
	bh=TDGLdncjHrRfwJLeRJx0srg3hwRbkzZPPtbM9rMrBJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOZU20YaySx8Y/wx8IlB610cY4XRYrkq4t9/Kc9hOHtKZ3WNTegnDcGoe7f+nBAHycz38ridaLaxo+dUMd3HT8X+jaBDqJJUiwcPYMONxXsYm7zhB0ctA2jJFNxa8oj/x9+Y4dew5T/b1isu7DaBrFdTK/KQVbI7hJZH0vTL0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=sMgAMuon; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="sMgAMuon"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a51481a598so1774838f8f.3
        for <linux-mmc@vger.kernel.org>; Sun, 13 Jul 2025 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752394087; x=1752998887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+6gXYwyTRWuBa8Md4EiJFqvKmQqpIFr/3pDxL4GvdQ=;
        b=sMgAMuonw8basfApNDTKqifBh9wAd7YrabsdArmen2YtJClm6aFU06A6Ruifjna74F
         zTILoBtEBgvkrKk4GUhN4XLyMxkj17cA+u+vOq+yb5qQlOGnKjzN0m9SYWl3f2AOnYbZ
         Y8ZpVyc5NgvG6YLQn8YZTl/iX08n40QWnw/+vgb7PRf7HJlQAIqF4hcA6PWiHcYJMzMw
         6lP/zHqK9gr/W64ZcNrpWJ7OwuIABitZKZw512I7JkJf7Q2CtVc8PIVGq4WprUR4oNkT
         WCuCjfrXW2SI14xgbLxdpKL62pZn/ZUFdBMLmDsR7m70GbzvaUlORdkzaa26g2VuX2Jp
         +6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752394087; x=1752998887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+6gXYwyTRWuBa8Md4EiJFqvKmQqpIFr/3pDxL4GvdQ=;
        b=hV3aYK4gt54YX2HanrtvL6CIomfhqY9sSeSQdXjEyOxPCqeqH+V6r1+yVRgqfpNhiW
         zk+9me46H1cvGDz1JHam8+CYZqSh+zF9FfGM8ge/nbuYmzlfT8gtja1G2WIR90mI7qOe
         uv9FFkjczLssjJ+IN9/QiCuxgRUd8OdMkz1k525IyiZmfzImFGW0ED/uB7Awgc74X1/t
         d2mZA8DuGPzeFuWF2ce+mZUVt8NziHhBvKbF5cgGwnDl1YCCcbGNM1HtZuyTWUbzUPpQ
         bbu6k1Yi6b6hE1k/YhY34PUcBbrcKfO9bwXJoELdL4JQc+6smAkVNBCy3cLVQJtCvRHR
         Qqkw==
X-Forwarded-Encrypted: i=1; AJvYcCWbxpcSlK0iOW9VFahWabjree0rG2MaRsdia0U2csHT7Hlp4UK/pZIqfNoD7CXkbve2c3YXq+PByfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54wH1kP9e4Uqx9J9cMv1meYe5fHlgsbSN6vM6YQEHGblAvAnw
	Bh6OE7aHTcbP6O/JMBhKNh+9yiZQnrOz8wonPW7qzUZxejATrC29ItWAtlrca8FdVYw=
X-Gm-Gg: ASbGnct8dPPZuG2wNd0J7T5YI5INGg5TLX8VebFvxHr58yZlu05Y/4KoqKvKL8Ml/3V
	ScshTXv5v2QS0EfpQcj7JoTxuMNSdms0tglhS4RkgjY9vQII3LZZaGSwbKMx1ls1MsxLfx36kev
	EySAPmT1ooTQFv+3KLG8Jm7NQTNgHDNlfUAD0rfXqJN57XHRZyu+LFIi47mOyeYpB6O9ZZfCB5r
	WHU3l65ZyvxM+13Pn6UQRXddrjc+oJP7BwVmRPo1iFoqDlEqb0LHHLq/DgKO8E+0r6N4NJpURp8
	tWZ3bG7bih9MBmuw1hEhGbdMec9fJbrdQ675L4NhDPl4PR9ehfoN0IJi2myHzSOzRKEazsxAtwF
	8dRKIOkIHYbQ9uRxacCFgn1mQHbiz11B7b1/C
X-Google-Smtp-Source: AGHT+IHlbVBRzVBx+TB+ru8FP2l2jobEeZXcX09t3vF/BFXG1VnybV1VXvA6fI2r0VYJILh3gQH2vA==
X-Received: by 2002:a05:6000:4012:b0:3a4:c8c1:aed8 with SMTP id ffacd0b85a97d-3b5f2e229a9mr6323377f8f.39.1752394087188;
        Sun, 13 Jul 2025 01:08:07 -0700 (PDT)
Received: from [192.168.224.50] ([213.208.155.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm9386608f8f.34.2025.07.13.01.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 01:08:06 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Sun, 13 Jul 2025 10:05:35 +0200
Subject: [PATCH v2 13/15] arm64: dts: qcom: pm8550vs: Disable different
 PMIC SIDs by default
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-sm7635-fp6-initial-v2-13-e8f9a789505b@fairphone.com>
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Das Srinagesh <quic_gurus@quicinc.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752393945; l=8108;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=TDGLdncjHrRfwJLeRJx0srg3hwRbkzZPPtbM9rMrBJ0=;
 b=7/Ta1AVjfApt3ZZgioiKcM9HcANPYIqXuA2LD86TP3WHJJEb5D6A6bd7fmkfxJZCxeY/WKqID
 y4uY7T/4HGWCJqYS2e5Ga+XlN8dfeKNnzax7x/f1PVibKRdXAhFmgrx
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Keep the different PMIC definitions in pm8550vs.dtsi disabled by
default, and only enable them in boards explicitly.

This allows to support boards better which only have pm8550vs_c, like
the Milos/SM7635-based Fairphone (Gen. 6).

Note: I assume that at least some of these devices with PM8550VS also
don't have _c, _d, _e and _g, but this patch is keeping the resulting
devicetree the same as before this change, disabling them on boards that
don't actually have those is out of scope for this patch.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi                   |  8 ++++++++
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi             | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts          | 16 ++++++++++++++++
 .../boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts     | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts                  | 16 ++++++++++++++++
 10 files changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
index 6426b431616bde2d960780be2bed4c623af246c2..7b5898c263ad8a687e8c914fbb0072c58799b6b2 100644
--- a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
@@ -98,6 +98,8 @@ pm8550vs_c: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_c_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -122,6 +124,8 @@ pm8550vs_d: pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_d_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -146,6 +150,8 @@ pm8550vs_e: pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_e_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -170,6 +176,8 @@ pm8550vs_g: pmic@6 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_g_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
index e6ac529e6b7216ac4b9e10900c5ddc9a06c9011c..e6ebb643203b62ba0050d11930576023207a2e35 100644
--- a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
@@ -366,6 +366,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 9dfb248f9ab52b354453cf42c09d93bbee99214f..ae90b59172d845be9778901f979d579750511dcc 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1111,6 +1111,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index fdcecd41297d6ebc81c5088472e4731ca0782fcb..7e0ff2f1c7cd56754e6df6f36634070b19ecf953 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -793,6 +793,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 49438a7e77ceaab9506158855b6262206bca94ec..594178ec9d3372ec657e08713a0ab2b620fc2b48 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -961,6 +961,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
index 7d29a57a2b540708fa88fb59e821406f400a3174..af963f506269c954e3ab629d8092341a9e44f86a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
@@ -533,6 +533,22 @@ volume_up_n: volume-up-n-state {
 	};
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index d90dc7b37c4a74cbfb03c929646fda3381413084..0e6ed6fce614706590ab37eb96c1077622d0d532 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -661,6 +661,22 @@ focus_n: focus-n-state {
 	};
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pm8550vs_g_gpios {
 	cam_pwr_a_cs: cam-pwr-a-cs-state {
 		pins = "gpio4";
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index d0912735b54e5090f9f213c2c9341e03effbbbff..19284298d64dfb39bab5355fd98f64b03931c998 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -1046,6 +1046,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pmk8550_rtc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 76ef43c10f77d8329ccf0a05c9d590a46372315f..ebc9b4b7bd881f8d9098d1a8b3ac281e9c94313b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -688,6 +688,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 71033fba21b56bc63620dca3e453c14191739675..97e29b8039d508e343c3136e61b237c7e9111aec 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -1002,6 +1002,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pmk8550_rtc {
 	status = "okay";
 };

-- 
2.50.1

