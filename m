Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211362FD1A0
	for <linux-mmc@vger.kernel.org>; Wed,  3 Sep 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900073; cv=none; b=S2zu8+wCqAshbuWx/B577V0u0ryRT+2p87di0yc3WVl/dvV6jiaVyHpW1ykWdO4cE+WDIuPxwtA9XyRSYNH8dr+Q2bAJs6Obra1MEMtx5NnWhHFpSLXAngNEmdQZXwdI/du8mJouP73xXk22hxMiK7rWIOZKDrpTwS92QhtX/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900073; c=relaxed/simple;
	bh=OnktyLXlAvw79LU30W2286PIYUB0ZIxd6VhBwuBv3ZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bF9FHJhK0qvnLnivrajamt53fqS0Hoog35q3AmQG34PCGYE4n+PCTXs+LXTDXxk7KooVhwbNDvcCKjTHfJbBXfh3AarwQdY/Kbe+83RxGZ+zGeYmZObN7cEoWQDDGYTuAVpyXUO7v9AiLrTMp783weSkRqI54Iuu56pSU9tYMM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fehguLeU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fehguLeU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BFE6w021456
	for <linux-mmc@vger.kernel.org>; Wed, 3 Sep 2025 11:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RXZGpMX3yOrOQ/k31nwEuT7jwrMYrLpKw0F69FmVEdo=; b=fehguLeU8nl85U4j
	rhXTLdC9xdLtUq8Hg07zOGaP3Ad9x/JL4mbtOcnaFcYxeKRCQMSUIzEzsLpZWGPE
	GoBkvDYOv3kMkp2X5ix42AsoCGdAQgtdxb4QNfwmcDIZPo+yqs2mJO8u+1UoXl3A
	iw20o0Tr8f09+6k2YsCNuAzqfV3+rlLNTj86Dj7lQD5LLkhTz8EpWU+A4KP2QX6S
	2yMn4pAbBXaX4qmkoR8neOp6d+5Y6j2e96SnbcKFPZ4RZd2hdEI7+iu0bO4goShF
	g7V9a3xQNSMoNCF98k0cR9smmH29TzZ9waGzpYwcMLJpj3DY/R8VGADSqj3Saba/
	WPcBdg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk939u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 11:47:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so2008214a12.3
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2025 04:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900070; x=1757504870;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXZGpMX3yOrOQ/k31nwEuT7jwrMYrLpKw0F69FmVEdo=;
        b=xAJ8UTi9c/kvU2V3n31SWBnjachzYGYy8M7854o19S33U1Y+4y1Mbr+iX0fWdFO1yU
         8e0cqFsjwIF+gcZmXxzCwoZy8ci+PP8lL0/hF6xxB9y4BEjaPhVRbqOOHp9Uk45itRTL
         2RbBJgtDa6DbR/lwe7EqG7Trx+1V4VdkJu+jr5Q0sjJJIIUY6pxZcF1eZXcS75tW5thI
         IVVLHv/2k5CnInELUcfNDq6X/kRU3ZVkMfSUj7xx7YbBiPoQ5AAaGqAFjpXCCqpVQntm
         8CrLeDi0Axia4QMNPT+vbshshjI+7YLAVBHwHgBj2R692+bGleJhDtBkTTVSG1J/0zEl
         wfQg==
X-Forwarded-Encrypted: i=1; AJvYcCUfJTKJl1AoTsJVn0X3XNS5PEJVRs3PHsEpAfVTyHTtSDvz4hgKk0ao6g/OEKVJmvFQIJ/Fg1e7bbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMUN6k//ZJ6v16tImHl0gYZVa2Cmc4+eN5XyeXtC3ryY1BDYDR
	q/eWqJMhj604IrnWYlIj1SfW/d00oPjfXUbpXNXS7N9Isu+bbaamaOqrC2FGacsQfM14d9Z2lm5
	AVu+pO2NMSJQdFBS+Yb/o+SE5nOQB87yB1nP+4AzxaBQvd6hhrEbGnyj1pUBT9sE=
X-Gm-Gg: ASbGncsqhSLns83lM+tQTTYc5OvtLqBKf96r1IQtBynWva4L4vNKv4Kv8IP9mS35gKU
	vTGBVVK25vBrRcvaYkncuY03vgfwIgUJ6adGmWAYnlMQUFiFTE4wXCoQ7aZmWjFuTAFA82l7/DY
	AQpSQqH61fOu/bZWoPvSLDIK/GK0BwnPEUhkXVvTgiufea7StrxPh6+PmC93rcDSOQpwjJ11inf
	bsfRK6y9ZhAZ6ag8cOj6Gqle8xoIxzaaANr5U2pu/bkLcVezF8ZBOkS4gVe13JLLzen1OnLYY9v
	wU5KDggFsDjvBC3m/80v9WvgE713RSAxNxyw9EwKWy7G/DGGbHAQemkWSWmluQd8xCcJ
X-Received: by 2002:a05:6a20:7fa8:b0:243:a91c:6564 with SMTP id adf61e73a8af0-243d6f431a3mr19272864637.50.1756900070434;
        Wed, 03 Sep 2025 04:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE+Q7esFWKub9PAlvBnehvvfXsc6KCukl6SiDDF6aya8S/1QEYowQVoz4bs50W6LD49Jov4w==
X-Received: by 2002:a05:6a20:7fa8:b0:243:a91c:6564 with SMTP id adf61e73a8af0-243d6f431a3mr19272834637.50.1756900069926;
        Wed, 03 Sep 2025 04:47:49 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:47:49 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:04 +0530
Subject: [PATCH v2 03/13] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-3-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1237;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=wNPfzyJsHuof8OoLd/8jyZfN9jNfvGHQW02eb1RzEjE=;
 b=0b/LYijs/sr4es5fM86gI5QstjtnDPg6dCaC3GynfKhA8oLib+VAZsHsOmZBI2gUq5fzF3dL0
 K0ocgFnwazdD47ESQZRaghlLahaQT5VBA+vJ72LdfZ4XLgPnl8cC3aE
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: 2oUKUFJiMfnedfUwdPlBMQPMbyASdPEv
X-Proofpoint-ORIG-GUID: 2oUKUFJiMfnedfUwdPlBMQPMbyASdPEv
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b82ae7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=_e_tMwhLnjs0gR3cx5AA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX/glesygkV+YM
 k9umvMmnKtH929l0wmrYwhbPWx/oAq4dhySEmzz2iKDaFaF74i0R8BlxufW1GzpBXRUbjLzrJpU
 KyMICcS7jplSS92aD4HiAcz5j4LT75Ee63Isbi5LcUEZ7ANMc58ZEAkbAvWeesWwzFS0+cLAA93
 lKP4/16ptX8NTE067aZl6bj2lJ03XTOp9iGrwP637jy22pWQiCOQjwi2gc0i0pyL62yP54Cb4F/
 oppWrK+I7nEOJZR+WLRLOnN4lRIBZmnol5Mvkb6pHMC51Exq45MFfuQRET4+LCrN1Lj/l60GczG
 BWUCUiyM35bqiYki4T2P2tIyoOjeLsWr/2DKwOwYlyU/WjyT47Ypwg/EsEsuGU16Dgn0tqCv3aO
 e25rrvwI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>

Integrate the TCA9534 I/O expander via I2C to provide 8 additional
GPIO lines for extended I/O functionality.

Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 9e415012140b..753c5afc3342 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -277,6 +277,38 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&i2c18 {
+	status = "okay";
+
+	expander0: gpio@38 {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x38>;
+	};
+
+	expander1: gpio@39 {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x39>;
+	};
+
+	expander2: gpio@3a {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3a>;
+	};
+
+	expander3: gpio@3b {
+		compatible = "ti,tca9538";
+		#gpio-cells = <2>;
+		gpio-controller;
+		reg = <0x3b>;
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0

