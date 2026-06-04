Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551823603D9
	for <linux-mmc@vger.kernel.org>; Thu,  4 Jun 2026 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575674; cv=none; b=BUoQSv85JL/flAoySFXwHRKyr//htbsBrs+Sxdk0g9rwYMUk1QBYv/b8mkg+IKQhPRrwG9JMkQ8HzlSjHT5Ip4qldVTvCQQ8d8z1E3ks4lx39Eqf5rWKOrlgjKyvT2ke0jCBya8ccePoAa3YiIL6wcYLBIa0mo2zrR9Hm+Yg3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575674; c=relaxed/simple;
	bh=DRvh8QxawSDwpvKoFkz2PnI7K/Ntuiei1ZywQHsnXW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1sO83hXFcU4Aa30yt9vvTeKFPL8pHdSKtgEQXypRmalDoQ2T6sUCznAc3j9snXJ7ppfhZm+G4m0fdG8rRlnnBf817tq7/MBXK/zd6AePi1cCTqYT2vVXianAf1GKImkn29aU5xPR3uhvjxNMecBvtFX7A3VMIj0ihnaUnehxWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lbh1XYPw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XFcgi+18; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lbh1XYPw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XFcgi+18"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654CCXh43221123
	for <linux-mmc@vger.kernel.org>; Thu, 4 Jun 2026 12:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=N1a0zVA1H38
	h2GIyEe6nGYiHzDUyiFxiJj0Sqb5Bfp0=; b=Lbh1XYPwVSYg75VxrUvuGfeqknq
	dMh5Y9CNj/bKSlu0fGl/B+jnyz4PjhG0PoU9nEvlXzmUzLWkSOZDUD6jmchfhVnO
	rPCA2TaLnUhuXHO19mraIIGSMDwF0T+dZp7QZa+lBTrjbsV7lr2G0r58Kfx3+uVo
	R8QrzsWMFrSBRMKQ+V7d5179gkD6KtzIBDDGAsopqeKSfsFpVNPoJueHtit3tDGN
	106PUWwPxg2C0RJM4pyShW3wAqtf61tvcGRZ1yUg3aMGl3Z3CEpD2Ey6pLXZsFq5
	IjY7j2R4QFs35SYtTi8bYzF3To6hDMsRAz3SkBMVt6p4tzf+6xsyDkaCTqw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95u80yk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 12:21:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so1174992a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jun 2026 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780575672; x=1781180472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1a0zVA1H38h2GIyEe6nGYiHzDUyiFxiJj0Sqb5Bfp0=;
        b=XFcgi+18QGvQUlVSwGKYp4NQNyGstmDzUNwmfTQ+eX1+cOqgALIcHtPbTEb0uFDTX8
         PAPDrGyz0l9UGFF5dI1/wOWWmg2ZPKZMNArEMlCLooHJLg65bdWbhliuAdeYDYk/dAjp
         jZP5mZoRC8/JQtb47redcc4nPID0Uw+PBRCxQ1Nz0mwy0auDWKIMpktpb3SMGCJPNkK1
         1TYF3a3FnLjmmsjuwF4KClAd4h2dPxwQTrgDCyQ7HfI8wBtbeZwWNflx5IyjZ/Yz2FOk
         hb8upKSQy77sgl01iQlLOSmE+VX99eplmWSDtgYY41coDpJeQ7sXRGvchQsqvAcIRuS0
         Os3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575672; x=1781180472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1a0zVA1H38h2GIyEe6nGYiHzDUyiFxiJj0Sqb5Bfp0=;
        b=qQJWV03D7TBiG/mTx/+YlKoe9o5JQ8qmjYIAYiz4G+1sIt7RnRLFmsN14EcaTNVKBm
         SG5qtwjrdBr1GUgEM5PWnXQS8+TPuuMtlKuz94bm+FFNAuNiEjUPYe4QUKF7UW/F4WL1
         QAdI+aCZcrdhw362uMIw7oOjfiKb001/tvsEi38An6AOF/YZa+nPwFRnYZ/uOMxU7/oG
         JnJlCBjoKcUdVeIZ8484t2AKoyG17ksmoBgjgD13QqQ+G8rIqzi4zjq1IzxQKXYtbnp0
         whxI0gobdP1UFHmCjHiiOycw745JSyIFRcyQjKl1x+xsrDWwiuxuS9Upy7V52wfPGL/4
         kRGg==
X-Forwarded-Encrypted: i=1; AFNElJ+x+gTEAAfhpolc2+VcOxfsd9n7L8U0podGCwS7NKnjN+6lFW+bp2hI7zvVSKq1yDsx5AgBhbNTeXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMgVpf+MjiucbhzdnFryOD2gYMrRF1Tg8f/DQvZ62X17PVx2qJ
	A4/7Ur6hsbWXZ4K7NDFhBKgJkVXj+ebV4Biy3cIwerJFwOS2YMaFE9/I0iZkOsK9nQbfGFOZ3JL
	bxuDYWCrhXonUg/HBhI7u/d3UQdOi0tkxK6LVYgYAhRlzyLNQXklHvXy+QqtUSTo=
X-Gm-Gg: Acq92OHXbM21ktU8O2plQbBvUtiqSWTSU0oBvjPwEKYznp5lSojLT4OulNmfetxmm7E
	l4UX0ltyZfrTUecdVykbTjH/gvNwBc+K1aJvRx8CZmwqPM7YLpkoTe9OlBHFukTsYoolo6EYJac
	L8DXIgNY1GqcniF0rRaQqUccRPpdxI/aZ+O71BmE6oEAF15pBx2+yU/PgjLxgsEiZTyyFwR7J/S
	u2Fd70bWIvItPXE9XlFkJoX/N3l2PbOuJd6MdWUKFa0PMdeGJ0ds2VA86kwgTBfAqS5apzW3fJn
	gyAlK/EcUH1eUDPv7/Ids3MgBjVHBzvLkZzeOOU4A6Qu27jm+QmHz8l+henZDGs2k05lWBRJBS+
	4dTcFa5jUm3M3AH98E9jxodgF/URPYCaW+dNUBT86LQGaRDCrtVGa7ILX7Dnd79Pfud8=
X-Received: by 2002:a05:6a21:330e:b0:3b4:931c:3c7c with SMTP id adf61e73a8af0-3b4979857f8mr9268691637.44.1780575671978;
        Thu, 04 Jun 2026 05:21:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:330e:b0:3b4:931c:3c7c with SMTP id adf61e73a8af0-3b4979857f8mr9268652637.44.1780575671523;
        Thu, 04 Jun 2026 05:21:11 -0700 (PDT)
Received: from hu-mchunara-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df045c2csm4796903a12.12.2026.06.04.05.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:21:11 -0700 (PDT)
From: Monish Chunara <monish.chunara@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, Ulf Hansson <ulfh@kernel.org>,
        Kernel Team <kernel@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-mmc@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
        Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Monish Chunara <monish.chunara@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V1 2/2] arm64: dts: qcom: Enable SD card for Shikra EVK
Date: Thu,  4 Jun 2026 17:50:45 +0530
Message-Id: <20260604122045.494712-3-monish.chunara@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
References: <20260604122045.494712-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a216db8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=lMopsKi7mrnni1fC4lMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDExOCBTYWx0ZWRfX8pGgMu/MLAul
 hD8/x1ryvyTqCcBqjLjI3FUoxCtTFkMJECuVNescrtOTjJpRW+lEhGWNYpoEG5pCH3qXBF/FvSq
 6inoh4B7YpfzFh4Olh3EWaU9T9ISXPQvc2nbiiLbd9DtV82TN4dTEJ2N+mNNOjovcvK6bGsTn5y
 QEHv4OlFIiQNqgre+lKk8aixQGCCsis1qyO5pWUv8cLrsNEZd03F1b/HwvF3duv/Bpgb9XjPzjU
 Ac35lapNsWInEhUpxqpdIUKUr8EISPdX4l8c8rmdZitF6SgSEYw4fT266sIDSGom9vF7J3lSOoN
 DuUfDn1Tva+d5KexHQLm6trK4bd8XHhb3CwXhhH//d7b10g2eqxFmPjki52OpGU13GSSkMewPQG
 SIbHH7nHx9fiCUhaa7HmNFMVMfQHi0LrBrjrz3XcGyFP/PA/lHnnwKA5g3lQ/YU3wg1fIeyu69T
 dkjIKmgZ4n2MU1SM31g==
X-Proofpoint-GUID: st6JQJOm9xfF-Sjx6Pdm5uM6m9EyJTli
X-Proofpoint-ORIG-GUID: st6JQJOm9xfF-Sjx6Pdm5uM6m9EyJTli
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040118

Enable SD card for Shikra CQS, CQM and IQS EVK variants. Configure the
vmmc/vqmmc regulators and gpio-based card detection for each board
variant.

Signed-off-by: Monish Chunara <monish.chunara@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index c2ed0396533a..53d8569a7c65 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-cqm-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra CQM EVK";
@@ -15,6 +16,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 		serial1 = &uart8;
 	};
@@ -95,6 +97,22 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index 3bfd0050064f..a461c5a03d63 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-cqm-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra CQS EVK";
@@ -15,6 +16,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 		serial1 = &uart8;
 	};
@@ -95,6 +97,22 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm4125_l21>;
+	vqmmc-supply = <&pm4125_l4>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 95bd797d009d..ede4dca3e7c0 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -7,6 +7,7 @@
 
 #include "shikra-iqs-som.dtsi"
 #include "shikra-evk.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. Shikra IQS EVK";
@@ -15,6 +16,7 @@ / {
 
 	aliases {
 		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
 		serial0 = &uart0;
 		serial1 = &uart8;
 	};
@@ -103,6 +105,22 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&sdhc_2 {
+	vmmc-supply = <&pm8150_l10>;
+	vqmmc-supply = <&pm8150_l2>;
+
+	no-sdio;
+	no-mmc;
+
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+
+	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
 &uart8 {
 	status = "okay";
 
-- 
2.34.1

